-- Evaluaciones: qué tan buen análogo es un sitio terrestre para la Luna o para Marte.
--
--   assessments                una por (sitio, cuerpo)        → TER-07-MOON, TER-07-MARS
--   assessment_categories      una por categoría (7)          → puntaje, comparación, utilidad
--   assessment_variables       una por variable               → puntaje, explicación, utilidad
--   assessment_applications    aplicaciones prioritarias      → lista ordenada
--   reference_sources / assessment_sources                    → fuentes citadas
--
-- Los puntajes son estimaciones cualitativas provisionales (0–100), no mediciones; la similitud global NO es el
-- promedio de las categorías, ni la categoría el promedio de sus variables. Un puntaje nulo es «no aplicable» (N/A),
-- distinto de cero. La clasificación es una columna generada, así que nunca se desalinea de la escala.

-- ------------------------------------------------------------- evaluaciones
create table public.assessments (
  id             uuid primary key default gen_random_uuid(),
  code           text not null unique check (code ~ '^TER-[0-9]{2}-(MOON|MARS)$'),
  site_id        uuid not null references public.sites (id) on delete cascade,
  body_id        text not null references public.bodies (id) check (body_id in ('moon', 'mars')),
  -- Idioma del texto de la evaluación (los informes del equipo no están todos en el mismo idioma).
  language       text not null check (language in ('es', 'en')),
  overall_score  numeric(4, 1) check (overall_score between 0 and 100),
  classification public.similarity_class generated always as (public.similarity_class_of(overall_score)) stored,
  objective      text,
  characterization text,
  conclusion     text,
  -- Diferencias y limitaciones respecto al cuerpo objetivo.
  limitations    text,
  methodology    text,
  -- Tarjeta general (descripción y aplicaciones principales) para listados.
  card_description  text,
  card_applications text,
  sources_note   text,
  is_provisional boolean not null default true,
  dataset_id     uuid references public.datasets (id),
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now(),
  unique (site_id, body_id),
  constraint assessments_code_matches_body check (code like ('%-' || upper(body_id)))
);

create index assessments_body_score_idx on public.assessments (body_id, overall_score desc);

create trigger assessments_set_updated_at
  before update on public.assessments
  for each row execute function public.set_updated_at();

-- Las evaluaciones solo cuelgan de sitios terrestres.
create function public.check_assessment_site() returns trigger
language plpgsql set search_path = '' as $$
begin
  if not exists (select 1 from public.sites s where s.id = new.site_id and s.body_id = 'earth') then
    raise exception 'La evaluación % debe pertenecer a un sitio terrestre', new.code using errcode = '23514';
  end if;
  return new;
end $$;

create trigger assessments_check_site
  before insert or update of site_id on public.assessments
  for each row execute function public.check_assessment_site();

-- --------------------------------------------------------------- categorías
create table public.assessment_categories (
  assessment_id  uuid not null references public.assessments (id) on delete cascade,
  category_id    text not null references public.variable_categories (id),
  score          numeric(4, 1) check (score between 0 and 100),
  classification public.similarity_class generated always as (public.similarity_class_of(score)) stored,
  -- Nombre de la categoría tal como aparece en el informe.
  label_reported text,
  comparison     text,
  utility        text,
  -- Nota al pie de la categoría, si el informe la trae.
  note           text,
  primary key (assessment_id, category_id)
);

-- ---------------------------------------------------------------- variables
create table public.assessment_variables (
  assessment_id  uuid not null references public.assessments (id) on delete cascade,
  variable_id    text not null references public.variables (id),
  score          numeric(4, 1) check (score between 0 and 100),
  classification public.similarity_class generated always as (public.similarity_class_of(score)) stored,
  -- Nombre de la variable tal como se publicó (p. ej. «Química de percloratos y sulfatos» → composición química).
  label_reported text not null,
  explanation    text,
  utility        text,
  primary key (assessment_id, variable_id)
);

create index assessment_variables_variable_idx on public.assessment_variables (variable_id, score desc);

-- La variable debe aplicar al cuerpo de la evaluación (p. ej. «evidencia de agua pasada» solo existe para Marte).
create function public.check_assessment_variable() returns trigger
language plpgsql set search_path = '' as $$
declare
  v_body text;
begin
  select a.body_id into v_body from public.assessments a where a.id = new.assessment_id;
  if not exists (select 1 from public.variables v where v.id = new.variable_id and v_body = any (v.bodies)) then
    raise exception 'La variable % no aplica al cuerpo %', new.variable_id, v_body using errcode = '23514';
  end if;
  return new;
end $$;

create trigger assessment_variables_check
  before insert or update of assessment_id, variable_id on public.assessment_variables
  for each row execute function public.check_assessment_variable();

-- ------------------------------------------------------------- aplicaciones
create table public.assessment_applications (
  assessment_id uuid not null references public.assessments (id) on delete cascade,
  position      smallint not null check (position > 0),
  body          text not null,
  primary key (assessment_id, position)
);

-- ------------------------------------------------------------------ fuentes
create table public.reference_sources (
  id    uuid primary key default gen_random_uuid(),
  -- terrestrial | lunar | martian | dataset (misiones e instrumentos de referencia)
  kind  text not null check (kind in ('terrestrial', 'lunar', 'martian', 'dataset')),
  label text not null,
  url   text check (url is null or url ~ '^https?://')
);

create unique index reference_sources_unique_idx on public.reference_sources (kind, label, coalesce(url, ''));

create table public.assessment_sources (
  assessment_id uuid not null references public.assessments (id) on delete cascade,
  source_id     uuid not null references public.reference_sources (id) on delete cascade,
  position      smallint not null default 0,
  primary key (assessment_id, source_id)
);

create index assessment_sources_source_idx on public.assessment_sources (source_id);

-- ------------------------------------------------------------ vista resumen
-- Una fila por evaluación con las categorías pivotadas: lista para tarjetas y rankings.
create view public.assessment_summary with (security_invoker = true) as
select
  a.id            as assessment_id,
  a.code,
  s.id            as site_id,
  s.slug,
  s.site_code,
  s.name          as site_name,
  s.country,
  s.region,
  s.lat,
  s.lng,
  a.body_id,
  a.overall_score,
  a.classification,
  a.language,
  a.is_provisional,
  (select jsonb_object_agg(c.category_id, c.score) from public.assessment_categories c where c.assessment_id = a.id) as categories
from public.assessments a
join public.sites s on s.id = a.site_id;

comment on table public.assessments is 'Estimación cualitativa provisional de qué tan buen análogo es un sitio para la Luna o Marte.';
comment on column public.assessments.overall_score is 'Juicio global independiente; no es el promedio de las categorías. Nulo = no aplicable.';
