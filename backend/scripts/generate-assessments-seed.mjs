// Genera backend/supabase/seed.assessments.sql a partir de los JSON de backend/data/.
//
//   npm run db:seed:assessments        (desde la raíz del repo)
//
// Entradas:  data/variable-catalog.json   catálogo de variables (A–G + extras)
//            data/missions.json           tipos de misión y pesos
//            data/analog-assessments.json sitios y evaluaciones (salida de extract-assessments.py)
// Salida:    supabase/seed.assessments.sql (idempotente; se aplica DESPUÉS de seed.sql)
//
// Semántica: el seed es la fuente de verdad de lo que importa. Re-ejecutarlo reemplaza por completo las filas hijas
// (categorías, variables, aplicaciones, fuentes) de las evaluaciones que trae; no toca nada más.

import { readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const backendDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const dataDir = path.join(backendDir, "data");
const outFile = path.join(backendDir, "supabase", "seed.assessments.sql");

const read = async (f) => JSON.parse(await readFile(path.join(dataDir, f), "utf8"));
const catalog = await read("variable-catalog.json");
const { missions } = await read("missions.json");
const { sites } = await read("analog-assessments.json");

const q = (s) => (s == null ? "null" : `'${String(s).replaceAll("'", "''")}'`);
const n = (v) => (v == null ? "null" : String(v));
const rows = (items, fn) => items.map((it) => `  (${fn(it).join(", ")})`).join(",\n");

// ------------------------------------------------------------------ validación
const fail = (msg) => {
  throw new Error(`Datos inconsistentes: ${msg}`);
};
const categoryIds = new Set(catalog.categories.map((c) => c.id));
const variables = catalog.variables.map((v, i) => ({
  ...v,
  id: `${v.category}.${v.key}`,
  bodies: v.bodies ?? ["moon", "mars"],
  sort: i + 1,
}));
const variableById = new Map(variables.map((v) => [v.id, v]));
for (const v of variables) if (!categoryIds.has(v.category)) fail(`variable ${v.id} con categoría desconocida`);
for (const m of missions) {
  for (const id of Object.keys(m.variables)) if (!variableById.has(id)) fail(`misión ${m.id} usa la variable inexistente ${id}`);
}

const SCALE = [[90, "very_high"], [75, "high"], [50, "moderate"], [25, "low"]];
const classOf = (s) => (s == null ? "not_applicable" : (SCALE.find(([min]) => s >= min)?.[1] ?? "very_low"));

const assessments = sites.flatMap((s) => s.assessments.map((a) => ({ ...a, site: s })));
for (const a of assessments) {
  if (classOf(a.overall_score) !== a.published_classification) fail(`${a.code}: ${a.overall_score} no es ${a.published_classification}`);
  if (a.categories.length !== catalog.categories.length) fail(`${a.code}: ${a.categories.length} categorías`);
  for (const c of a.categories) {
    for (const v of c.variables) {
      const def = variableById.get(`${c.category}.${v.key}`);
      if (!def) fail(`${a.code}: variable ${c.category}.${v.key} fuera del catálogo`);
      if (!def.bodies.includes(a.body)) fail(`${a.code}: ${def.id} no aplica a ${a.body}`);
    }
  }
}

// Cuerpo del que cada sitio es «principal» análogo (el de mayor similitud global); sites.analog_of lo exige.
const primaryBody = (s) => s.assessments.reduce((best, a) => (a.overall_score > best.overall_score ? a : best)).body;
const firstParagraph = (t) => (t ? t.split("\n\n")[0] : null);

// ------------------------------------------------------------------------ SQL
const out = [];
const push = (...lines) => out.push(...lines, "");

push(
  `-- GENERADO por backend/scripts/generate-assessments-seed.mjs el ${new Date().toISOString()}. No editar a mano.`,
  "-- Idempotente. Aplicar después de seed.sql y de las migraciones 20261113*.",
);

// Catálogo
push(
  "insert into public.variable_categories (id, letter, name, name_en, priority, priority_note, why_it_matters, caution, sort_order) values",
  rows(catalog.categories, (c, i = catalog.categories.indexOf(c)) => [
    q(c.id), q(c.letter), q(c.name), q(c.name_en), q(c.priority), q(c.priority_note), q(c.why_it_matters), q(c.caution), i + 1,
  ]),
  "on conflict (id) do update set letter = excluded.letter, name = excluded.name, name_en = excluded.name_en,",
  "  priority = excluded.priority, priority_note = excluded.priority_note, why_it_matters = excluded.why_it_matters,",
  "  caution = excluded.caution, sort_order = excluded.sort_order;",
);
push(
  "insert into public.variables (id, category_id, key, name, name_en, description, bodies, in_catalog, sort_order) values",
  rows(variables, (v) => [
    q(v.id), q(v.category), q(v.key), q(v.name), q(v.name_en), q(v.description),
    `array[${v.bodies.map(q).join(", ")}]::text[]`, v.in_catalog, v.sort,
  ]),
  "on conflict (id) do update set category_id = excluded.category_id, name = excluded.name, name_en = excluded.name_en,",
  "  description = excluded.description, bodies = excluded.bodies, in_catalog = excluded.in_catalog, sort_order = excluded.sort_order;",
);

// Misiones
push(
  "insert into public.missions (id, label, glyph, short, description, bodies, sort_order) values",
  rows(missions, (m) => [q(m.id), q(m.label), q(m.glyph), q(m.short), q(m.description), `array[${m.bodies.map(q).join(", ")}]::text[]`, missions.indexOf(m) + 1]),
  "on conflict (id) do update set label = excluded.label, glyph = excluded.glyph, short = excluded.short,",
  "  description = excluded.description, bodies = excluded.bodies, sort_order = excluded.sort_order;",
);
const missionVars = missions.flatMap((m) => Object.entries(m.variables).map(([variable, weight]) => ({ mission: m.id, variable, weight })));
push(
  `delete from public.mission_variables where mission_id in (${missions.map((m) => q(m.id)).join(", ")});`,
  "insert into public.mission_variables (mission_id, variable_id, weight) values",
  rows(missionVars, (r) => [q(r.mission), q(r.variable), r.weight]) + ";",
);

// Procedencia
push(
  "insert into public.datasets (slug, name, provider, body_id, url, license, resolution, temporal_coverage, is_illustrative, retrieved_at, notes) values",
  "  ('team-assessments-v1', 'Evaluaciones cualitativas de análogos (TER-01 a TER-08)', 'Equipo AstroNovas', null, null, null, null, null, true, null::timestamptz,",
  "   'Estimaciones cualitativas provisionales para el prototipo de hackatón. No son mediciones oficiales de la NASA ni el resultado de un algoritmo validado; la similitud global es un juicio independiente, no el promedio de las categorías.')",
  "on conflict (slug) do update set name = excluded.name, provider = excluded.provider, is_illustrative = excluded.is_illustrative, notes = excluded.notes;",
);

// Sitios: los existentes (atacama, mcmurdo) conservan su ficha del prototipo; aquí solo se completan los datos nuevos.
push(
  "insert into public.sites (slug, body_id, analog_of, name, region, terrain_type, description, lat, lng, status, source,",
  "  site_code, country, elevation_min_m, elevation_max_m, elevation_note, analog_class, geological_setting,",
  "  terrain_classification, overview, scientific_relevance, coordinate_note) values",
  rows(sites, (s) => [
    q(s.slug), "'earth'", q(primaryBody(s)), q(s.name), q(s.region), q(s.analog_class), q(firstParagraph(s.description)),
    n(s.lat), n(s.lng), "'published'", "'curated'",
    q(s.code), q(s.country), n(s.elevation_min_m), n(s.elevation_max_m), q(s.elevation_text), q(s.analog_class),
    q(s.geological_setting), q(s.terrain_classification), q(s.description), q(s.scientific_relevance), q(s.coordinate_note),
  ]),
  "on conflict (slug) do update set region = excluded.region, lat = excluded.lat, lng = excluded.lng,",
  "  site_code = excluded.site_code, country = excluded.country, elevation_min_m = excluded.elevation_min_m,",
  "  elevation_max_m = excluded.elevation_max_m, elevation_note = excluded.elevation_note, analog_class = excluded.analog_class,",
  "  geological_setting = excluded.geological_setting, terrain_classification = excluded.terrain_classification,",
  "  overview = excluded.overview, scientific_relevance = excluded.scientific_relevance, coordinate_note = excluded.coordinate_note;",
);

const withLocations = sites.filter((s) => s.locations.length);
push(
  `delete from public.site_locations where site_id in (select id from public.sites where slug in (${withLocations.map((s) => q(s.slug)).join(", ")}));`,
  "insert into public.site_locations (site_id, label, lat, lng, elevation_m, note, sort_order)",
  "select s.id, v.label, v.lat, v.lng, v.elevation_m, v.note, v.sort_order",
  "from (values",
  rows(
    withLocations.flatMap((s) => s.locations.map((l, i) => ({ slug: s.slug, ...l, i }))),
    (l) => [q(l.slug), q(l.label), n(l.lat), n(l.lng), `${n(l.elevation_m)}::numeric`, q(l.note), l.i],
  ),
  ") as v (slug, label, lat, lng, elevation_m, note, sort_order)",
  "join public.sites s on s.slug = v.slug;",
);

// Evaluaciones
push(
  "insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,",
  "  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)",
  "select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,",
  "  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id",
  "from (values",
  rows(assessments, (a) => [
    q(a.site.slug), q(a.code), q(a.body), q(a.language), `${n(a.overall_score)}::numeric`, q(a.objective), q(a.characterization),
    q(a.conclusion), q(a.limitations), q(a.methodology), q(a.card.description), q(a.card.applications), q(a.sources_note),
  ]),
  ") as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,",
  "  card_description, card_applications, sources_note)",
  "join public.sites s on s.slug = v.slug",
  "join public.datasets d on d.slug = 'team-assessments-v1'",
  "on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,",
  "  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,",
  "  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,",
  "  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;",
);

const codes = assessments.map((a) => q(a.code)).join(", ");
const ofAssessment = `select id from public.assessments where code in (${codes})`;
push(
  `delete from public.assessment_categories where assessment_id in (${ofAssessment});`,
  `delete from public.assessment_variables where assessment_id in (${ofAssessment});`,
  `delete from public.assessment_applications where assessment_id in (${ofAssessment});`,
  `delete from public.assessment_sources where assessment_id in (${ofAssessment});`,
);

const catRows = assessments.flatMap((a) => a.categories.map((c) => ({ code: a.code, ...c })));
push(
  "insert into public.assessment_categories (assessment_id, category_id, score, label_reported, comparison, utility, note)",
  "select a.id, v.category_id, v.score, v.label_reported, v.comparison, v.utility, v.note",
  "from (values",
  rows(catRows, (c) => [q(c.code), q(c.category), `${n(c.score)}::numeric`, q(c.label_reported), q(c.comparison), q(c.utility), q(c.note)]),
  ") as v (code, category_id, score, label_reported, comparison, utility, note)",
  "join public.assessments a on a.code = v.code;",
);

const varRows = assessments.flatMap((a) =>
  a.categories.flatMap((c) => c.variables.map((v) => ({ code: a.code, id: `${c.category}.${v.key}`, ...v }))),
);
push(
  "insert into public.assessment_variables (assessment_id, variable_id, score, label_reported, explanation, utility)",
  "select a.id, v.variable_id, v.score, v.label_reported, v.explanation, v.utility",
  "from (values",
  rows(varRows, (v) => [q(v.code), q(v.id), `${n(v.score)}::numeric`, q(v.label), q(v.explanation), q(v.utility)]),
  ") as v (code, variable_id, score, label_reported, explanation, utility)",
  "join public.assessments a on a.code = v.code;",
);

const appRows = assessments.flatMap((a) => a.applications.map((body, i) => ({ code: a.code, position: i + 1, body })));
push(
  "insert into public.assessment_applications (assessment_id, position, body)",
  "select a.id, v.position, v.body",
  "from (values",
  rows(appRows, (r) => [q(r.code), r.position, q(r.body)]),
  ") as v (code, position, body)",
  "join public.assessments a on a.code = v.code;",
);

// Fuentes: se deduplican entre evaluaciones (mismo tipo, etiqueta y URL).
const srcKey = (s) => `${s.kind}|${s.label}|${s.url ?? ""}`;
const uniqueSources = [...new Map(assessments.flatMap((a) => a.sources).map((s) => [srcKey(s), s])).values()];
push(
  "insert into public.reference_sources (kind, label, url) values",
  rows(uniqueSources, (s) => [q(s.kind), q(s.label), q(s.url)]),
  "on conflict (kind, label, coalesce(url, '')) do nothing;",
);
const linkRows = assessments.flatMap((a) => a.sources.map((s, i) => ({ code: a.code, ...s, position: i + 1 })));
push(
  "insert into public.assessment_sources (assessment_id, source_id, position)",
  "select a.id, rs.id, v.position",
  "from (values",
  rows(linkRows, (r) => [q(r.code), q(r.kind), q(r.label), `${q(r.url)}::text`, r.position]),
  ") as v (code, kind, label, url, position)",
  "join public.assessments a on a.code = v.code",
  "join public.reference_sources rs on rs.kind = v.kind and rs.label = v.label and coalesce(rs.url, '') = coalesce(v.url, '')",
  "on conflict (assessment_id, source_id) do nothing;",
);

const sql = out.join("\n");
await writeFile(outFile, sql, "utf8");
console.log(
  `Listo: ${path.relative(process.cwd(), outFile)} (${(Buffer.byteLength(sql) / 1024).toFixed(0)} KB) — ` +
    `${catalog.categories.length} categorías, ${variables.length} variables, ${missions.length} misiones, ` +
    `${sites.length} sitios, ${assessments.length} evaluaciones, ${varRows.length} puntajes de variable, ${uniqueSources.length} fuentes.`,
);
