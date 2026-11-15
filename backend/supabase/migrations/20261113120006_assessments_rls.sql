-- RLS y permisos de las tablas de evaluaciones, catálogo y misiones.
--
-- Modelo (igual que site_features):
--   * Catálogo, misiones y fuentes: lectura pública; solo el service role escribe (no hay política de escritura).
--   * Evaluaciones y sus tablas hijas: visibles cuando el sitio es visible para quien consulta; las escriben
--     revisores y admins (las redacta el equipo, no el público).
--   * site_locations: igual que la evaluación, siguen la visibilidad del sitio.

alter table public.variable_categories    enable row level security;
alter table public.variables              enable row level security;
alter table public.missions               enable row level security;
alter table public.mission_variables      enable row level security;
alter table public.reference_sources      enable row level security;
alter table public.site_locations         enable row level security;
alter table public.assessments            enable row level security;
alter table public.assessment_categories  enable row level security;
alter table public.assessment_variables   enable row level security;
alter table public.assessment_applications enable row level security;
alter table public.assessment_sources     enable row level security;

grant select on
  public.variable_categories, public.variables, public.missions, public.mission_variables,
  public.reference_sources, public.site_locations, public.assessments, public.assessment_categories,
  public.assessment_variables, public.assessment_applications, public.assessment_sources,
  public.assessment_summary
to anon, authenticated;

grant insert, update, delete on
  public.site_locations, public.assessments, public.assessment_categories, public.assessment_variables,
  public.assessment_applications, public.assessment_sources
to authenticated;

-- ---------------------------------------------------------------- catálogos
create policy "variable_categories_read" on public.variable_categories for select using (true);
create policy "variables_read"           on public.variables           for select using (true);
create policy "missions_read"            on public.missions            for select using (true);
create policy "mission_variables_read"   on public.mission_variables   for select using (true);
create policy "reference_sources_read"   on public.reference_sources   for select using (true);

-- --------------------------------------------------------- ubicaciones de sitio
create policy "site_locations_read" on public.site_locations for select using (
  exists (select 1 from public.sites s where s.id = site_id)
);
create policy "site_locations_write_reviewer" on public.site_locations for all to authenticated
  using (public.is_reviewer()) with check (public.is_reviewer());

-- ------------------------------------------------------------- evaluaciones
create policy "assessments_read" on public.assessments for select using (
  exists (select 1 from public.sites s where s.id = site_id)
);
create policy "assessments_write_reviewer" on public.assessments for all to authenticated
  using (public.is_reviewer()) with check (public.is_reviewer());

-- Tablas hijas: heredan la visibilidad de la evaluación (la subconsulta ya aplica RLS).
create policy "assessment_categories_read" on public.assessment_categories for select using (
  exists (select 1 from public.assessments a where a.id = assessment_id)
);
create policy "assessment_categories_write_reviewer" on public.assessment_categories for all to authenticated
  using (public.is_reviewer()) with check (public.is_reviewer());

create policy "assessment_variables_read" on public.assessment_variables for select using (
  exists (select 1 from public.assessments a where a.id = assessment_id)
);
create policy "assessment_variables_write_reviewer" on public.assessment_variables for all to authenticated
  using (public.is_reviewer()) with check (public.is_reviewer());

create policy "assessment_applications_read" on public.assessment_applications for select using (
  exists (select 1 from public.assessments a where a.id = assessment_id)
);
create policy "assessment_applications_write_reviewer" on public.assessment_applications for all to authenticated
  using (public.is_reviewer()) with check (public.is_reviewer());

create policy "assessment_sources_read" on public.assessment_sources for select using (
  exists (select 1 from public.assessments a where a.id = assessment_id)
);
create policy "assessment_sources_write_reviewer" on public.assessment_sources for all to authenticated
  using (public.is_reviewer()) with check (public.is_reviewer());
