// Parte seed.assessments.sql en archivos pequeños (supabase/seed-parts/) para pegarlos uno a uno en el SQL Editor.
import fs from "node:fs";
const dir = "supabase/seed-parts";
const src = fs.readFileSync("supabase/seed.assessments.sql", "utf8");
const stmts = []; let cur = "", inS = false, inC = false;
for (let i = 0; i < src.length; i++) {
  const c = src[i]; cur += c;
  if (inC) { if (c === "\n") inC = false; continue; }
  if (inS) { if (c === "'") { if (src[i + 1] === "'") { cur += "'"; i++; } else inS = false; } continue; }
  if (c === "'") { inS = true; continue; }
  if (c === "-" && src[i + 1] === "-") { inC = true; continue; }
  if (c === ";") { stmts.push(cur.trim()); cur = ""; }
}
const find = (re) => stmts.findIndex((s) => re.test(s));
const iEval = find(/^insert into public\.assessments /m), iVar = find(/^insert into public\.assessment_variables /m);
const files = [];
files.push(["catalogo-y-sitios", stmts.slice(0, iEval).join("\n\n")]);
// una por sitio: cada fila de VALUES empieza por ('slug', 'TER-..
const splitRows = (stmt, firstRe, keyOf) => {
  const lines = stmt.split("\n"); const start = lines.findIndex((l) => firstRe.test(l));
  const end = lines.findLastIndex((l) => /^\) as v/.test(l));
  const head = lines.slice(0, start).join("\n") + "\n", tail = lines.slice(end).join("\n");
  const rows = []; let r = null;
  for (let i = start; i < end; i++) { if (firstRe.test(lines[i])) { r = []; rows.push(r); } r.push(lines[i]); }
  const groups = new Map();
  for (const row of rows) { const k = keyOf(row[0]); (groups.get(k) ?? groups.set(k, []).get(k)).push(row.join("\n").replace(/,\s*$/, "")); }
  return [...groups].map(([k, rs]) => [k, head + rs.join(",\n") + "\n" + tail]);
};
for (const [k, t] of splitRows(stmts[iEval], /^  \('[a-z]+', 'TER-/, (l) => l.match(/'(TER-\d\d)/)[1])) files.push([`evaluaciones-${k}`, t]);
files.push(["categorias", stmts.slice(iEval + 1, iVar).join("\n\n")]);
for (const [k, t] of splitRows(stmts[iVar], /^  \('TER-/, (l) => l.match(/'(TER-\d\d)/)[1])) files.push([`variables-${k}`, t]);
files.push(["aplicaciones-y-fuentes", stmts.slice(iVar + 1).join("\n\n")]);
fs.mkdirSync(dir, { recursive: true });
for (const f of fs.readdirSync(dir)) fs.unlinkSync(`${dir}/${f}`);
files.forEach(([n, t], i) => { const f = `${String(i + 1).padStart(2, "0")}-${n}.sql`; fs.writeFileSync(`${dir}/${f}`, t.trim() + "\n"); console.log(f, (t.length / 1024).toFixed(0) + " KB"); });
