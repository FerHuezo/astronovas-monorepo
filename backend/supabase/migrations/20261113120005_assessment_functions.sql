-- Búsquedas sobre las evaluaciones. Ambas son `security invoker`: respetan RLS y solo ven sitios publicados.
--
-- Puntaje = promedio ponderado de los puntajes de variable de la evaluación, ignorando los N/A.
-- `coverage` (0–1) dice qué fracción del peso aplicable tenía dato: un 90 con cobertura 0.3 pesa menos que uno con 1.0.
-- Las variables que no aplican al cuerpo (p. ej. «agua pasada» en la Luna) no cuentan ni como faltantes.

-- ------------------------------------------------- ranking por tipo de misión
--   select * from rank_sites_for_mission('landing', 'moon');
--   select * from rank_sites_for_mission('habitat');          -- ambos cuerpos
create function public.rank_sites_for_mission(
  p_mission      text,
  p_body         text default null,
  p_limit        integer default 20,
  p_min_coverage numeric default 0.5
)
returns table (
  site_id         uuid,
  slug            text,
  site_name       text,
  region          text,
  body_id         text,
  assessment_code text,
  score           numeric,
  coverage        numeric,
  overall_score   numeric,
  classification  public.similarity_class
)
language sql stable security invoker set search_path = '' as $$
  with agg as (
    select
      a.id as assessment_id,
      sum(mv.weight)                                                   as applicable_w,
      sum(mv.weight) filter (where av.score is not null)               as scored_w,
      sum(mv.weight * av.score) filter (where av.score is not null)    as weighted
    from public.assessments a
    join public.missions mi on mi.id = p_mission and a.body_id = any (mi.bodies)
    join public.mission_variables mv on mv.mission_id = mi.id
    join public.variables v on v.id = mv.variable_id and a.body_id = any (v.bodies)
    left join public.assessment_variables av on av.assessment_id = a.id and av.variable_id = mv.variable_id
    where p_body is null or a.body_id = p_body
    group by a.id
  )
  select
    s.id, s.slug, s.name, s.region, a.body_id, a.code,
    round(agg.weighted / agg.scored_w, 1),
    round(agg.scored_w / agg.applicable_w, 2),
    a.overall_score, a.classification
  from agg
  join public.assessments a on a.id = agg.assessment_id
  join public.sites s on s.id = a.site_id
  where s.status = 'published'
    and agg.scored_w > 0
    and agg.scored_w / agg.applicable_w >= p_min_coverage
  order by 7 desc, 8 desc, s.name
  limit greatest(p_limit, 1);
$$;

-- ----------------------------------------------- búsqueda por filtros libres
-- p_weights: variable → peso (obligatorio, no vacío). p_min: variable → puntaje mínimo exigido (opcional);
-- una evaluación sin dato (N/A) en una variable con mínimo no cumple el filtro.
--
--   select * from search_assessments('mars', '{"water.subsurface_ice": 2, "topography.slope": 1}', '{"water.subsurface_ice": 60}');
create function public.search_assessments(
  p_body         text,
  p_weights      jsonb,
  p_min          jsonb default '{}'::jsonb,
  p_limit        integer default 20,
  p_min_coverage numeric default 0.5
)
returns table (
  site_id         uuid,
  slug            text,
  site_name       text,
  region          text,
  body_id         text,
  assessment_code text,
  score           numeric,
  coverage        numeric,
  overall_score   numeric,
  classification  public.similarity_class
)
language sql stable security invoker set search_path = '' as $$
  with w as (
    select e.key as variable_id, e.value::numeric as weight
    from jsonb_each_text(coalesce(p_weights, '{}'::jsonb)) e
    where e.value::numeric > 0
  ),
  agg as (
    select
      a.id as assessment_id,
      sum(w.weight)                                                  as applicable_w,
      sum(w.weight) filter (where av.score is not null)              as scored_w,
      sum(w.weight * av.score) filter (where av.score is not null)   as weighted
    from public.assessments a
    join w on true
    join public.variables v on v.id = w.variable_id and a.body_id = any (v.bodies)
    left join public.assessment_variables av on av.assessment_id = a.id and av.variable_id = w.variable_id
    where a.body_id = p_body
    group by a.id
  )
  select
    s.id, s.slug, s.name, s.region, a.body_id, a.code,
    round(agg.weighted / agg.scored_w, 1),
    round(agg.scored_w / agg.applicable_w, 2),
    a.overall_score, a.classification
  from agg
  join public.assessments a on a.id = agg.assessment_id
  join public.sites s on s.id = a.site_id
  where s.status = 'published'
    and agg.scored_w > 0
    and agg.scored_w / agg.applicable_w >= p_min_coverage
    and not exists (
      select 1
      from jsonb_each_text(coalesce(p_min, '{}'::jsonb)) m
      left join public.assessment_variables av2 on av2.assessment_id = a.id and av2.variable_id = m.key
      where coalesce(av2.score, -1) < m.value::numeric
    )
  order by 7 desc, 8 desc, s.name
  limit greatest(p_limit, 1);
$$;
