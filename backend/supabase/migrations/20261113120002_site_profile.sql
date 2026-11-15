-- Ficha ampliada de los análogos terrestres: código, país, elevación, clasificación del terreno y
-- ubicaciones de referencia dentro del sitio (p. ej. Mauna Kea y Kīlauea dentro de Hawái).
-- Las columnas nuevas son opcionales: los sitios existentes (y los de la Luna/Marte) siguen siendo válidos.

alter table public.sites
  add column site_code             text unique check (site_code ~ '^TER-[0-9]{2}$'),
  add column country               text,
  add column elevation_min_m       numeric,
  add column elevation_max_m       numeric,
  add column elevation_note        text,
  -- Tipo de análogo, p. ej. «Análogo hidrotermal-volcánico».
  add column analog_class          text,
  add column geological_setting    text,
  add column terrain_classification text,
  -- Descripción completa tal como la redactó el equipo (idioma original).
  add column overview              text,
  add column scientific_relevance  text,
  -- Aclaración sobre la coordenada (p. ej. «representa la región, no un punto de muestreo»).
  add column coordinate_note       text,
  add constraint sites_elevation_order check (elevation_min_m is null or elevation_max_m is null or elevation_min_m <= elevation_max_m);

comment on column public.sites.site_code is 'Identificador del análogo terrestre (TER-01…); las evaluaciones lo extienden con -MOON / -MARS.';

create table public.site_locations (
  id          uuid primary key default gen_random_uuid(),
  site_id     uuid not null references public.sites (id) on delete cascade,
  label       text not null,
  lat         double precision not null check (lat between -90 and 90),
  lng         double precision not null check (lng between -180 and 180),
  elevation_m numeric,
  note        text,
  sort_order  smallint not null default 0,
  unique (site_id, label)
);

create index site_locations_site_idx on public.site_locations (site_id, sort_order);
