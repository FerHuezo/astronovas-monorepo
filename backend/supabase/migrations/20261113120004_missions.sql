-- Tipos de misión del Explorador de misión: qué variables importan y cuánto pesan para cada objetivo.
-- Son configuración (se editan con un insert/update), no código: el ranking sale de las puntuaciones reales
-- de assessment_variables (ver rank_sites_for_mission).

create table public.missions (
  id          text primary key check (id ~ '^[a-z][a-z0-9_]*$'),
  label       text not null,
  glyph       text,
  short       text not null,
  description text,
  -- Cuerpos en los que tiene sentido la misión (p. ej. la búsqueda de vida se evalúa solo para Marte).
  bodies      text[] not null check (bodies <@ array['moon', 'mars']::text[] and cardinality(bodies) > 0),
  sort_order  smallint not null default 0
);

create table public.mission_variables (
  mission_id  text not null references public.missions (id) on delete cascade,
  variable_id text not null references public.variables (id),
  weight      numeric not null check (weight > 0),
  primary key (mission_id, variable_id)
);

create index mission_variables_variable_idx on public.mission_variables (variable_id);

comment on table public.mission_variables is 'Peso de cada variable para una misión; los pesos son propuestas ajustables del equipo.';
