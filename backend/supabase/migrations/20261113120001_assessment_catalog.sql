-- Catálogo de variables y escala de similitud para las evaluaciones por sitio y cuerpo.
--
-- Las evaluaciones (migración 20261113120003) puntúan, para cada análogo terrestre y para cada cuerpo
-- (Luna / Marte), un conjunto de variables agrupadas en categorías. Este catálogo es el vocabulario común:
-- el de "Catálogo común de variables" (categorías A–G) más algunas variables que solo aparecen en los
-- informes de un cuerpo. Agregar una variable nueva es insertar una fila en `variables`; no requiere migración.

-- Escala de clasificación de los informes: 90–100 muy alta, 75–<90 alta, 50–<75 moderada, 25–<50 baja, <25 muy baja.
-- «No aplicable» (N/A) es distinto de cero: se guarda como puntaje nulo y se excluye de los cálculos.
create type public.similarity_class as enum ('very_high', 'high', 'moderate', 'low', 'very_low', 'not_applicable');

create function public.similarity_class_of(p_score numeric) returns public.similarity_class
language sql immutable parallel safe set search_path = '' as $$
  select (case
    when p_score is null then 'not_applicable'
    when p_score >= 90 then 'very_high'
    when p_score >= 75 then 'high'
    when p_score >= 50 then 'moderate'
    when p_score >= 25 then 'low'
    else 'very_low'
  end)::public.similarity_class;
$$;

-- --------------------------------------------------------------- categorías
create table public.variable_categories (
  id             text primary key check (id ~ '^[a-z][a-z_]*$'),
  letter         char(1) not null unique check (letter ~ '^[A-Z]$'),
  name           text not null,
  name_en        text not null,
  -- high | conditional (alta según disponibilidad) | complementary | specific (complementaria y específica)
  priority       text not null check (priority in ('high', 'conditional', 'complementary', 'specific')),
  priority_note  text,
  why_it_matters text,
  -- Advertencia metodológica del catálogo (qué no debe confundirse).
  caution        text,
  sort_order     smallint not null
);

-- ---------------------------------------------------------------- variables
create table public.variables (
  -- «categoría.clave», p. ej. topography.slope: es lo que usan las misiones y los filtros.
  id          text primary key,
  category_id text not null references public.variable_categories (id),
  key         text not null check (key ~ '^[a-z][a-z_]*$'),
  name        text not null,
  name_en     text not null,
  -- Qué se investiga (texto del catálogo común).
  description text,
  -- Cuerpos en los que la variable aplica; las extras de Marte solo existen allí.
  bodies      text[] not null default array['moon', 'mars'] check (bodies <@ array['moon', 'mars']::text[] and cardinality(bodies) > 0),
  -- false = variable que aparece en los informes pero no estaba en el catálogo común.
  in_catalog  boolean not null default true,
  sort_order  smallint not null,
  unique (category_id, key),
  constraint variables_id_matches check (id = category_id || '.' || key)
);

create index variables_category_idx on public.variables (category_id, sort_order);

comment on table public.variables is 'Vocabulario común de variables comparables entre sitios; las puntuaciones viven en assessment_variables.';
comment on column public.variables.id is 'Identificador estable categoría.clave (ej. topography.slope).';
