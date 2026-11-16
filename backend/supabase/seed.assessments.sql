-- GENERADO por backend/scripts/generate-assessments-seed.mjs el 2026-11-15T17:42:44.180Z. No editar a mano.
-- Idempotente. Aplicar después de seed.sql y de las migraciones 20261113*.

insert into public.variable_categories (id, letter, name, name_en, priority, priority_note, why_it_matters, caution, sort_order) values
  ('topography', 'A', 'Topografía y geomorfología', 'Topography and Geomorphology', 'high', 'Prioridad alta', 'Permite estudiar terrenos relacionados con el aterrizaje, la navegación, la movilidad de rovers y la planificación de operaciones.', 'No confundas elevación con pendiente: una zona puede estar a gran altura y ser prácticamente plana.', 1),
  ('thermal', 'B', 'Condiciones térmicas y ambientales', 'Thermal and Environmental Conditions', 'high', 'Prioridad alta', 'Estas variables permiten estudiar condiciones ambientales que afectan equipos, materiales, operaciones y futuras instalaciones.', 'No deben comparar directamente la temperatura atmosférica de un lugar terrestre con la temperatura superficial de Marte o la Luna.', 2),
  ('geology', 'C', 'Geología y mineralogía', 'Geology and Mineralogy', 'high', 'Prioridad alta', 'Permite identificar semejanzas geológicas, estudiar procesos planetarios y explorar posibles materiales de interés para futuras misiones.', 'Una semejanza de color o apariencia no demuestra una composición mineralógica semejante.', 3),
  ('water', 'D', 'Agua, hielo y recursos', 'Water, Ice and Resources', 'conditional', 'Prioridad alta, según disponibilidad', 'Estas características pueden ayudar a estudiar recursos, ambientes extremos y condiciones relevantes para futuras bases.', 'Una medición de hidrógeno no equivale automáticamente a una confirmación de agua o hielo.', 4),
  ('atmosphere', 'E', 'Atmósfera, polvo y dinámica superficial', 'Atmosphere, Dust and Surface Dynamics', 'complementary', 'Complementaria', 'Puede ayudar a estudiar condiciones que afectan equipos, visibilidad, desplazamiento y mantenimiento de instalaciones.', 'No es válido asumir que el viento terrestre reproduce el comportamiento del polvo marciano: la presión, densidad y composición atmosférica son diferentes.', 5),
  ('subsurface', 'F', 'Subsuelo y estructuras naturales', 'Subsurface and Natural Structures', 'complementary', 'Complementaria', 'Puede servir para estudiar estructuras que tengan interés como ambientes protegidos, objetivos científicos o lugares para investigar tecnologías de exploración.', null, 6),
  ('biology', 'G', 'Biología y habitabilidad', 'Biology and Habitability', 'specific', 'Complementaria y específica', 'Especialmente para estudiar ambientes terrestres extremos que puedan servir como análogos de determinados procesos o condiciones de interés astrobiológico.', 'Esta categoría no debe confundirse con la búsqueda de vida en la Luna o Marte. Un análogo biológico terrestre no demuestra que exista vida extraterrestre.', 7)
on conflict (id) do update set letter = excluded.letter, name = excluded.name, name_en = excluded.name_en,
  priority = excluded.priority, priority_note = excluded.priority_note, why_it_matters = excluded.why_it_matters,
  caution = excluded.caution, sort_order = excluded.sort_order;

insert into public.variables (id, category_id, key, name, name_en, description, bodies, in_catalog, sort_order) values
  ('topography.elevation', 'topography', 'elevation', 'Elevación', 'Elevation', 'Altura de la superficie respecto a un nivel de referencia.', array['moon', 'mars']::text[], true, 1),
  ('topography.slope', 'topography', 'slope', 'Pendiente', 'Slope', 'Inclinación del terreno.', array['moon', 'mars']::text[], true, 2),
  ('topography.roughness', 'topography', 'roughness', 'Rugosidad', 'Surface roughness', 'Irregularidad de la superficie.', array['moon', 'mars']::text[], true, 3),
  ('topography.relief', 'topography', 'relief', 'Relieve', 'Relief', 'Variaciones de altura y formas del terreno.', array['moon', 'mars']::text[], true, 4),
  ('topography.craters', 'topography', 'craters', 'Cráteres', 'Craters', 'Presencia, distribución, tamaño y características de cráteres.', array['moon', 'mars']::text[], true, 5),
  ('topography.obstacles', 'topography', 'obstacles', 'Obstáculos superficiales', 'Surface obstacles', 'Rocas, bloques, depresiones y otras irregularidades superficiales relevantes.', array['moon', 'mars']::text[], true, 6),
  ('thermal.surface_temperature', 'thermal', 'surface_temperature', 'Temperatura superficial', 'Surface temperature', 'Temperatura de la superficie.', array['moon', 'mars']::text[], true, 7),
  ('thermal.temperature_extremes', 'thermal', 'temperature_extremes', 'Temperaturas máximas y mínimas', 'Maximum and minimum temperatures', 'Extremos térmicos observados o estimados.', array['moon', 'mars']::text[], true, 8),
  ('thermal.thermal_variation', 'thermal', 'thermal_variation', 'Variación térmica', 'Thermal variation', 'Cambios de temperatura durante el día, noche o estaciones.', array['moon', 'mars']::text[], true, 9),
  ('thermal.solar_illumination', 'thermal', 'solar_illumination', 'Iluminación solar', 'Solar illumination', 'Disponibilidad y duración de iluminación, cuando existan datos pertinentes.', array['moon', 'mars']::text[], true, 10),
  ('thermal.atmospheric_conditions', 'thermal', 'atmospheric_conditions', 'Condiciones atmosféricas', 'Atmospheric conditions', 'Presencia y características de la atmósfera, diferenciando las variables terrestres y planetarias.', array['moon', 'mars']::text[], true, 11),
  ('thermal.seasonality', 'thermal', 'seasonality', 'Estacionalidad', 'Seasonality', 'Variación estacional de las condiciones superficiales. Solo aparece en los informes de Marte.', array['mars']::text[], false, 12),
  ('thermal.atmospheric_dryness', 'thermal', 'atmospheric_dryness', 'Sequedad atmosférica', 'Atmospheric dryness', 'Humedad y comportamiento del vapor de agua en la atmósfera. Solo aparece en los informes de Marte.', array['mars']::text[], false, 13),
  ('geology.rock_type', 'geology', 'rock_type', 'Tipo de roca', 'Rock type', 'Basalto, rocas sedimentarias, ígneas, etc.', array['moon', 'mars']::text[], true, 14),
  ('geology.mineral_composition', 'geology', 'mineral_composition', 'Composición mineralógica', 'Mineralogical composition', 'Minerales presentes y sus proporciones, si están disponibles.', array['moon', 'mars']::text[], true, 15),
  ('geology.chemical_composition', 'geology', 'chemical_composition', 'Composición química', 'Chemical composition', 'Elementos y compuestos identificados.', array['moon', 'mars']::text[], true, 16),
  ('geology.surface_material', 'geology', 'surface_material', 'Material superficial', 'Surface material', 'Características del regolito, suelo y fragmentos rocosos.', array['moon', 'mars']::text[], true, 17),
  ('geology.alteration', 'geology', 'alteration', 'Alteración geológica', 'Geological alteration', 'Meteorización, erosión y cambios en los materiales.', array['moon', 'mars']::text[], true, 18),
  ('geology.formations', 'geology', 'formations', 'Formaciones geológicas', 'Geological formations', 'Estructuras y procesos que dieron origen al terreno.', array['moon', 'mars']::text[], true, 19),
  ('water.surface_water', 'water', 'surface_water', 'Agua superficial', 'Surface water', 'Presencia de agua en superficie, cuando corresponda.', array['moon', 'mars']::text[], true, 20),
  ('water.surface_ice', 'water', 'surface_ice', 'Hielo superficial', 'Surface ice', 'Presencia y distribución de hielo.', array['moon', 'mars']::text[], true, 21),
  ('water.subsurface_ice', 'water', 'subsurface_ice', 'Hielo subterráneo', 'Subsurface ice', 'Evidencias o estimaciones de hielo bajo la superficie.', array['moon', 'mars']::text[], true, 22),
  ('water.permafrost', 'water', 'permafrost', 'Permafrost', 'Permafrost', 'Suelos que permanecen congelados durante periodos prolongados.', array['moon', 'mars']::text[], true, 23),
  ('water.hydrogen', 'water', 'hydrogen', 'Hidrógeno', 'Hydrogen-bearing materials', 'Mediciones o indicadores relacionados con su presencia.', array['moon', 'mars']::text[], true, 24),
  ('water.mineral_resources', 'water', 'mineral_resources', 'Recursos minerales', 'Mineral resources', 'Materiales que podrían tener interés científico o práctico.', array['moon', 'mars']::text[], true, 25),
  ('water.past_water', 'water', 'past_water', 'Evidencia de agua pasada', 'Evidence of past water', 'Minerales, formas del terreno y depósitos que indican agua líquida en el pasado. Solo aparece en los informes de Marte.', array['mars']::text[], false, 26),
  ('atmosphere.wind', 'atmosphere', 'wind', 'Viento', 'Wind', 'Velocidad, dirección y comportamiento, si corresponde.', array['moon', 'mars']::text[], true, 27),
  ('atmosphere.dust', 'atmosphere', 'dust', 'Polvo', 'Dust', 'Presencia, distribución y características de partículas.', array['moon', 'mars']::text[], true, 28),
  ('atmosphere.dust_storms', 'atmosphere', 'dust_storms', 'Tormentas de polvo', 'Dust storms', 'Frecuencia, extensión y condiciones asociadas.', array['moon', 'mars']::text[], true, 29),
  ('atmosphere.aeolian_erosion', 'atmosphere', 'aeolian_erosion', 'Erosión eólica', 'Aeolian erosion', 'Cambios del terreno producidos por el viento.', array['moon', 'mars']::text[], true, 30),
  ('atmosphere.sediments', 'atmosphere', 'sediments', 'Sedimentos', 'Sediments', 'Distribución y características de los materiales transportados.', array['moon', 'mars']::text[], true, 31),
  ('atmosphere.aerosols', 'atmosphere', 'aerosols', 'Aerosoles', 'Aerosols', 'Partículas suspendidas en la atmósfera, cuando existan datos.', array['moon', 'mars']::text[], true, 32),
  ('atmosphere.atmospheric_pressure', 'atmosphere', 'atmospheric_pressure', 'Presión atmosférica', 'Atmospheric pressure', 'Presión de la atmósfera en la superficie. Solo aparece en los informes de Marte.', array['mars']::text[], false, 33),
  ('atmosphere.atmospheric_composition', 'atmosphere', 'atmospheric_composition', 'Composición atmosférica', 'Atmospheric composition', 'Gases que componen la atmósfera. Solo aparece en los informes de Marte.', array['mars']::text[], false, 34),
  ('subsurface.caves', 'subsurface', 'caves', 'Cuevas', 'Caves', 'Existencia y características de cavidades.', array['moon', 'mars']::text[], true, 35),
  ('subsurface.lava_tubes', 'subsurface', 'lava_tubes', 'Tubos de lava', 'Lava tubes', 'Estructuras subterráneas de origen volcánico.', array['moon', 'mars']::text[], true, 36),
  ('subsurface.fractures', 'subsurface', 'fractures', 'Cavidades y fracturas', 'Cavities and fractures', 'Geometría y características conocidas.', array['moon', 'mars']::text[], true, 37),
  ('subsurface.subsurface_structure', 'subsurface', 'subsurface_structure', 'Estructura del subsuelo', 'Subsurface structure', 'Capas, materiales y discontinuidades.', array['moon', 'mars']::text[], true, 38),
  ('subsurface.material_thickness', 'subsurface', 'material_thickness', 'Espesor de materiales', 'Material thickness', 'Profundidad o espesor de capas, cuando se conozca.', array['moon', 'mars']::text[], true, 39),
  ('biology.extremophiles', 'biology', 'extremophiles', 'Organismos extremófilos', 'Extremophile organisms', 'Organismos capaces de vivir en condiciones extremas.', array['moon', 'mars']::text[], true, 40),
  ('biology.habitability', 'biology', 'habitability', 'Condiciones de habitabilidad', 'Habitability conditions', 'Temperatura, humedad, química y otras condiciones ambientales.', array['moon', 'mars']::text[], true, 41),
  ('biology.biosignatures', 'biology', 'biosignatures', 'Biosignaturas', 'Biosignatures', 'Evidencias que podrían indicar actividad biológica.', array['moon', 'mars']::text[], true, 42),
  ('biology.adaptations', 'biology', 'adaptations', 'Adaptaciones biológicas', 'Biological adaptations', 'Respuestas de organismos a condiciones extremas.', array['moon', 'mars']::text[], true, 43),
  ('biology.direct_similarity', 'biology', 'direct_similarity', 'Similitud biológica directa', 'Direct biological similarity', 'Comparación biológica directa con el cuerpo objetivo. Solo aparece en algunos informes lunares, siempre como no aplicable.', array['moon']::text[], false, 44)
on conflict (id) do update set category_id = excluded.category_id, name = excluded.name, name_en = excluded.name_en,
  description = excluded.description, bodies = excluded.bodies, in_catalog = excluded.in_catalog, sort_order = excluded.sort_order;

insert into public.missions (id, label, glyph, short, description, bodies, sort_order) values
  ('ice', 'Agua y hielo (ISRU)', '❄', 'Extraer agua del hielo para beber, respirar y fabricar combustible.', 'Premia sitios con hielo superficial y subterráneo y permafrost, donde ensayar perforación, derretido y purificación.', array['moon', 'mars']::text[], 1),
  ('landing', 'Aterrizaje seguro', '⌖', 'Zonas llanas y despejadas donde posar un módulo de descenso.', 'Prioriza pendiente, rugosidad y obstáculos: es lo que decide si un módulo puede posarse con seguridad.', array['moon', 'mars']::text[], 2),
  ('habitat', 'Hábitat y refugio', '⌂', 'Tubos de lava y cuevas que protejan a la tripulación de la radiación.', 'Busca tubos de lava, cuevas y fracturas sobre roca estable, los refugios naturales contra la radiación.', array['moon', 'mars']::text[], 3),
  ('rover', 'Movilidad de rovers', '◈', 'Terreno áspero para probar ruedas, suspensión y navegación autónoma.', 'Combina pendiente, rugosidad y obstáculos con el tipo de roca y el material superficial que enfrentará un rover.', array['moon', 'mars']::text[], 4),
  ('solar', 'Energía solar', '☀', 'Sitios con cielos despejados y mucha irradiancia para paneles.', 'Premia la iluminación solar y penaliza el polvo; la variación térmica indica el estrés sobre los paneles.', array['moon', 'mars']::text[], 5),
  ('astrobio', 'Búsqueda de vida', '✦', 'Ambientes extremos donde la vida resiste y deja huellas.', 'Marte conserva ambientes que pudieron ser habitables. Premia extremófilos, habitabilidad, biosignaturas y evidencia de agua pasada.', array['mars']::text[], 6)
on conflict (id) do update set label = excluded.label, glyph = excluded.glyph, short = excluded.short,
  description = excluded.description, bodies = excluded.bodies, sort_order = excluded.sort_order;

delete from public.mission_variables where mission_id in ('ice', 'landing', 'habitat', 'rover', 'solar', 'astrobio');
insert into public.mission_variables (mission_id, variable_id, weight) values
  ('ice', 'water.surface_ice', 2),
  ('ice', 'water.subsurface_ice', 3),
  ('ice', 'water.permafrost', 2),
  ('ice', 'water.hydrogen', 1),
  ('landing', 'topography.slope', 3),
  ('landing', 'topography.roughness', 3),
  ('landing', 'topography.obstacles', 2),
  ('landing', 'topography.craters', 1),
  ('landing', 'topography.relief', 1),
  ('habitat', 'subsurface.lava_tubes', 3),
  ('habitat', 'subsurface.caves', 2),
  ('habitat', 'subsurface.fractures', 1),
  ('habitat', 'subsurface.subsurface_structure', 1),
  ('habitat', 'geology.rock_type', 1),
  ('rover', 'topography.roughness', 2),
  ('rover', 'topography.slope', 2),
  ('rover', 'topography.obstacles', 2),
  ('rover', 'geology.surface_material', 1),
  ('rover', 'geology.rock_type', 1),
  ('rover', 'atmosphere.dust', 1),
  ('solar', 'thermal.solar_illumination', 3),
  ('solar', 'atmosphere.dust', 1),
  ('solar', 'thermal.thermal_variation', 1),
  ('solar', 'thermal.surface_temperature', 1),
  ('astrobio', 'biology.extremophiles', 2),
  ('astrobio', 'biology.habitability', 2),
  ('astrobio', 'biology.biosignatures', 2),
  ('astrobio', 'water.past_water', 2),
  ('astrobio', 'water.surface_water', 1),
  ('astrobio', 'geology.mineral_composition', 1),
  ('astrobio', 'geology.alteration', 1);

insert into public.datasets (slug, name, provider, body_id, url, license, resolution, temporal_coverage, is_illustrative, retrieved_at, notes) values
  ('team-assessments-v1', 'Evaluaciones cualitativas de análogos (TER-01 a TER-08)', 'Equipo AstroNovas', null, null, null, null, null, true, null::timestamptz,
   'Estimaciones cualitativas provisionales para el prototipo de hackatón. No son mediciones oficiales de la NASA ni el resultado de un algoritmo validado; la similitud global es un juicio independiente, no el promedio de las categorías.')
on conflict (slug) do update set name = excluded.name, provider = excluded.provider, is_illustrative = excluded.is_illustrative, notes = excluded.notes;

insert into public.sites (slug, body_id, analog_of, name, region, terrain_type, description, lat, lng, status, source,
  site_code, country, elevation_min_m, elevation_max_m, elevation_note, analog_class, geological_setting,
  terrain_classification, overview, scientific_relevance, coordinate_note) values
  ('atacama', 'earth', 'mars', 'Desierto de Atacama', 'Antofagasta, Tarapacá y Atacama', 'Desierto hiperárido, salino-evaporítico y volcánico', 'El Desierto de Atacama es una región del norte de Chile caracterizada por condiciones de aridez extrema y una notable diversidad geológica. Contiene planicies desérticas, terrenos volcánicos, cuencas salinas, depósitos sedimentarios y superficies rocosas.', -23.8633, -69.17, 'published', 'curated', 'TER-01', 'Chile', 2000, 4500, 'Aproximadamente entre 2,000 y 4,500 m; edificios volcánicos sobre 5,500 m', 'Desierto hiperárido, salino-evaporítico y volcánico', null, 'Aridez extrema; Superficies rocosas y pedregosas; Cuencas sedimentarias; Depósitos salinos y evaporíticos; Terrenos volcánicos; Procesos eólicos; Microorganismos adaptados a ambientes extremos.', 'El Desierto de Atacama es una región del norte de Chile caracterizada por condiciones de aridez extrema y una notable diversidad geológica. Contiene planicies desérticas, terrenos volcánicos, cuencas salinas, depósitos sedimentarios y superficies rocosas.

Estas características permiten estudiar determinados procesos geológicos y ambientales relacionados con la exploración planetaria, así como desarrollar pruebas de movilidad robótica, reconocimiento del terreno e instrumentos científicos.', null, 'Las coordenadas representan aproximadamente la región y no un punto específico de muestreo.'),
  ('hawaii', 'earth', 'mars', 'Complejo volcánico de Hawái', 'Mauna Kea y Kīlauea · isla de Hawaiʻi', 'Volcánico / basáltico', 'The Hawaii Volcanic Complex encompasses contrasting basaltic environments shaped by shield volcanism. Mauna Kea provides high-altitude volcanic slopes, cinder deposits, and cold summit conditions, while Kīlauea offers relatively young basaltic lava fields, volcanic craters, fractures, and lava-tube systems.', 19.62, -155.38, 'published', 'curated', 'TER-02', 'Estados Unidos', null, 4207, 'Hasta 4,207 m', 'Volcánico / basáltico', null, null, 'The Hawaii Volcanic Complex encompasses contrasting basaltic environments shaped by shield volcanism. Mauna Kea provides high-altitude volcanic slopes, cinder deposits, and cold summit conditions, while Kīlauea offers relatively young basaltic lava fields, volcanic craters, fractures, and lava-tube systems.', 'Planetary rover mobility, volcanic terrain mapping, basaltic mineral identification, subsurface exploration, and testing technologies for lava-tube reconnaissance.', 'Coordenada del sitio = punto medio entre Mauna Kea y Kīlauea; ver ubicaciones de referencia.'),
  ('islandia', 'earth', 'mars', 'Islandia', 'República de Islandia · Atlántico Norte', 'Volcánico / glacial / periglacial', 'Iceland is a geologically active North Atlantic island situated along the Mid-Atlantic Ridge. Its landscape reflects interactions between basaltic volcanism, tectonic extension, glaciers, groundwater, and atmospheric erosion. Subglacial volcanic deposits, extensive lava fields, glacial valleys, and cold highland environments provide several distinct terrestrial analog settings.', 64.96, -19.02, 'published', 'curated', 'TER-03', 'Islandia', 0, 2110, '0–2,110 m', 'Volcánico / glacial / periglacial', null, 'Basaltic lava fields, volcanic fissures, geothermal systems, glaciers, glacial outwash plains, black volcanic sands, lava tubes, and areas of discontinuous mountain permafrost.', 'Iceland is a geologically active North Atlantic island situated along the Mid-Atlantic Ridge. Its landscape reflects interactions between basaltic volcanism, tectonic extension, glaciers, groundwater, and atmospheric erosion. Subglacial volcanic deposits, extensive lava fields, glacial valleys, and cold highland environments provide several distinct terrestrial analog settings.', 'Volcanic geology, cryogenic terrain research, robotic surface mobility, subsurface exploration, sediment transport, geological alteration, and astrobiological field studies.', null),
  ('mcmurdo', 'earth', 'mars', 'Valles secos de McMurdo', 'Tierra de Victoria · Dependencia de Ross · Antártida', 'Desierto polar / hiperárido / periglacial', 'The McMurdo Dry Valleys are among Antarctica’s most extensive ice-free landscapes. Located in the Transantarctic Mountains near McMurdo Sound, they contain cold desert soils, ancient moraines, glaciers, hypersaline lake systems, and extremely dry environments shaped by katabatic winds.', -77.5, 162.5, 'published', 'curated', 'TER-04', 'Antártida', 0, 2000, '0 a más de 2,000 m', 'Desierto polar / hiperárido / periglacial', null, 'Ice-free polar valleys, ancient glacial deposits, hyperarid frozen soils, continuous permafrost, buried ice, ice-covered lakes, salt accumulations, wind-eroded rocks, and cryptoendolithic microbial communities.', 'The McMurdo Dry Valleys are among Antarctica’s most extensive ice-free landscapes. Located in the Transantarctic Mountains near McMurdo Sound, they contain cold desert soils, ancient moraines, glaciers, hypersaline lake systems, and extremely dry environments shaped by katabatic winds.', 'Planetary cryogeology, subsurface ice detection, polar rover navigation, aeolian erosion, long-term geological preservation, environmental monitoring, and astrobiology.', null),
  ('haughton', 'earth', 'mars', 'Cráter Haughton', 'Isla Devon · Nunavut · Canadá', 'Cráter de impacto polar', 'Haughton Crater is a heavily eroded complex impact structure on Devon Island in the Canadian High Arctic. Its landscape contains impact-generated breccias, fractured carbonate rocks, a central structural uplift, polygonal frozen ground, seasonal snow, and localized meltwater systems. The crater provides a valuable natural laboratory for studying impact geology, polar surface operations, geological sampling, and subsurface investigations.', 75.38, -89.67, 'published', 'curated', 'TER-05', 'Canadá', 200, 400, '200–400 m; diámetro del cráter ~23 km', 'Cráter de impacto polar', null, 'Polar impact crater, hyperarid Arctic desert, periglacial terrain, impact-breccia deposits, fractured carbonate bedrock, and continuous permafrost.', 'Haughton Crater is a heavily eroded complex impact structure on Devon Island in the Canadian High Arctic. Its landscape contains impact-generated breccias, fractured carbonate rocks, a central structural uplift, polygonal frozen ground, seasonal snow, and localized meltwater systems. The crater provides a valuable natural laboratory for studying impact geology, polar surface operations, geological sampling, and subsurface investigations.', 'Impact-crater exploration, rover mobility, geological mapping, impact breccia analysis, permafrost investigations, subsurface fracture detection, and astrobiological field research.', null),
  ('qaidam', 'earth', 'mars', 'Cuenca de Qaidam', 'Provincia de Qinghai · China', 'Cuenca hiperárida', 'The Qaidam Basin is a high-altitude, arid sedimentary basin on the northeastern Tibetan Plateau. Its landscape contains extensive dry lakebeds, salt crusts, wind-eroded sedimentary formations, dunes, and ancient lacustrine deposits. Strong evaporation, mineral precipitation, and aeolian erosion have produced distinctive geological structures, including large yardang fields and salt-rich sedimentary surfaces.', 37.5, 95, 'published', 'curated', 'TER-06', 'China', 2600, 3200, '~2,600–3,200 m (fondo de la cuenca)', 'Cuenca hiperárida', 'Gran cuenca intermontana', 'Hyperarid intermontane basin, dry lakebeds, saline playas, evaporite deposits, aeolian yardang fields, alluvial fans, and fine-grained sedimentary plains.', 'The Qaidam Basin is a high-altitude, arid sedimentary basin on the northeastern Tibetan Plateau. Its landscape contains extensive dry lakebeds, salt crusts, wind-eroded sedimentary formations, dunes, and ancient lacustrine deposits. Strong evaporation, mineral precipitation, and aeolian erosion have produced distinctive geological structures, including large yardang fields and salt-rich sedimentary surfaces.', 'Martian aeolian geomorphology, ancient lakebed interpretation, evaporite mineralogy, sedimentary stratigraphy, hypersaline environments, biosignature preservation, and robotic exploration of dry granular terrain.', null),
  ('danakil', 'earth', 'mars', 'Depresión de Danakil / Dallol', 'Región de Afar · Etiopía', 'Análogo hidrotermal-volcánico', 'The Danakil Depression is an extremely hot, low-elevation region within the active Afar Rift system. Its landscape includes extensive evaporite deposits, hydrothermal mineral formations, tectonic fractures, and volcanic terrain. The Dallol hydrothermal area contains acidic and hypersaline fluids, colorful mineral precipitates, and salt structures. The broader Danakil region includes the basaltic volcanic system of Erta Ale.', 14.24, 40.3, 'published', 'curated', 'TER-07', 'Etiopía', -120, null, 'Hasta −120 m', 'Análogo hidrotermal-volcánico', 'Rift de Afar activo', 'Active tectonic depression, hydrothermal salt fields, acidic brine pools, evaporite plains, basaltic volcanic terrain, fault systems, and volcanic fissures.', 'The Danakil Depression is an extremely hot, low-elevation region within the active Afar Rift system. Its landscape includes extensive evaporite deposits, hydrothermal mineral formations, tectonic fractures, and volcanic terrain. The Dallol hydrothermal area contains acidic and hypersaline fluids, colorful mineral precipitates, and salt structures. The broader Danakil region includes the basaltic volcanic system of Erta Ale.', 'Hydrothermal alteration, basaltic volcanism, evaporite mineralogy, tectonic deformation, subsurface structures, environmental habitability limits, and astrobiological instrument testing.', 'Dallol (hidrotermal) y Erta Ale (volcanismo basáltico) son subregiones distintas y deben evaluarse por separado.'),
  ('stillwater', 'earth', 'moon', 'Complejo de Anortosita de Stillwater', 'Complejo ígneo de Stillwater · Montana', 'Análogo mineralógico', 'The Stillwater Complex is a layered igneous intrusion exposed in the mountainous terrain of southern Montana. Its geological formations include plagioclase-rich anorthositic rocks, mafic and ultramafic layers, and economically significant mineral deposits. The surrounding landscape contains rocky ridges, angular talus deposits, forested slopes, and valleys affected by erosion and past glaciation.', 45.4, -109.9, 'published', 'curated', 'TER-08', 'Estados Unidos', 1500, 3000, '1,500–3,000 m', 'Análogo mineralógico', 'Intrusión máfica estratificada', 'Precambrian layered igneous complex, anorthosite-bearing rock exposures, mafic and ultramafic intrusive formations, mountainous slopes, fractured bedrock, and glacially modified valleys.', 'The Stillwater Complex is a layered igneous intrusion exposed in the mountainous terrain of southern Montana. Its geological formations include plagioclase-rich anorthositic rocks, mafic and ultramafic layers, and economically significant mineral deposits. The surrounding landscape contains rocky ridges, angular talus deposits, forested slopes, and valleys affected by erosion and past glaciation.', 'Lunar highland mineralogy, anorthosite identification, plagioclase spectroscopy, igneous differentiation, geological sampling, resource characterization, and robotic exploration of fractured bedrock.', null)
on conflict (slug) do update set region = excluded.region, lat = excluded.lat, lng = excluded.lng,
  site_code = excluded.site_code, country = excluded.country, elevation_min_m = excluded.elevation_min_m,
  elevation_max_m = excluded.elevation_max_m, elevation_note = excluded.elevation_note, analog_class = excluded.analog_class,
  geological_setting = excluded.geological_setting, terrain_classification = excluded.terrain_classification,
  overview = excluded.overview, scientific_relevance = excluded.scientific_relevance, coordinate_note = excluded.coordinate_note;

delete from public.site_locations where site_id in (select id from public.sites where slug in ('hawaii'));
insert into public.site_locations (site_id, label, lat, lng, elevation_m, note, sort_order)
select s.id, v.label, v.lat, v.lng, v.elevation_m, v.note, v.sort_order
from (values
  ('hawaii', 'Mauna Kea', 19.82, -155.47, 4207::numeric, 'Cumbre de escudo volcánico; condiciones frías, cenizas y conos de escoria.', 0),
  ('hawaii', 'Kīlauea', 19.42, -155.29, null::numeric, 'Campos de lava basáltica jóvenes, cráteres, fracturas y tubos de lava.', 1)
) as v (slug, label, lat, lng, elevation_m, note, sort_order)
join public.sites s on s.slug = v.slug;

insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
  ('atacama', 'TER-01-MOON', 'moon', 'es', 31.2::numeric, 'Analizar las características topográficas, térmicas, geológicas, ambientales y subterráneas del Desierto de Atacama para determinar su utilidad como entorno terrestre de pruebas relacionadas con la exploración lunar.

La evaluación considera tanto las semejanzas entre los terrenos como sus diferencias físicas y ambientales.', 'El Desierto de Atacama se encuentra en el norte de Chile y comprende terrenos hiperáridos, cuencas sedimentarias, superficies pedregosas, depósitos salinos, laderas montañosas y sectores volcánicos.

En las pampas interiores existen amplias superficies secas y relativamente planas, mientras que las áreas cordilleranas presentan pendientes abruptas y terrenos más accidentados.

Su diversidad geológica permite desarrollar ensayos de reconocimiento del terreno, movilidad robótica y exploración de estructuras naturales.', 'El Desierto de Atacama obtiene una similitud exploratoria general de 31.2 %, correspondiente a una clasificación baja.

Sus principales oportunidades se encuentran en pruebas operativas relacionadas con topografía, movilidad y reconocimiento de estructuras naturales.

Atacama puede considerarse un análogo lunar parcial para aplicaciones específicas, especialmente cuando se combina con ensayos especializados que reproduzcan las condiciones físicas no presentes en la Tierra.', 'Atacama no reproduce la gravedad lunar, el vacío, la radiación espacial, los ciclos térmicos lunares ni las propiedades completas del regolito lunar.

Por tanto, su utilidad depende de la tecnología o el proceso que se desee estudiar.', 'La evaluación compara características descriptivas del entorno terrestre con variables planetarias de referencia. Los porcentajes corresponden al sistema exploratorio de puntuación utilizado en el prototipo. No son mediciones directas de las misiones citadas ni resultados de una fórmula cuantitativa validada. La escala empleada es:

● Muy alta: 90–100 %. ● Alta: 75–menos de 90 %. ● Moderada: 50–menos de 75 %. ● Baja: 25–menos de 50 %. ● Muy baja: 0–menos de 25 %. ● No aplicable: N/A. Las puntuaciones no aplicables se excluyen de los cálculos. Para validar los resultados en una fase posterior será necesario delimitar sitios específicos, utilizar mediciones comparables y documentar una fórmula reproducible.

MARTE', null, null, 'Misiones e instrumentos de referencia: Lunar Reconnaissance Orbiter, LOLA, LROC, Diviner y otros instrumentos de investigación lunar.'),
  ('atacama', 'TER-01-MARS', 'mars', 'es', 68.4::numeric, 'Analizar las semejanzas geológicas, geomorfológicas, térmicas, ambientales y astrobiológicas entre el Desierto de Atacama y determinados ambientes de Marte.

La evaluación busca identificar aplicaciones científicas y tecnológicas para la exploración planetaria, especialmente reconocimiento geológico, movilidad robótica, análisis de materiales y estudios de habitabilidad.', 'Atacama presenta condiciones de aridez extrema, terrenos volcánicos, depósitos sedimentarios, superficies rocosas, cuencas salinas y comunidades microbianas adaptadas a ambientes difíciles.

Estas características permiten estudiar determinados procesos relacionados con la historia geológica y ambiental de Marte.

La región es heterogénea: las condiciones de las pampas hiperáridas, salares y zonas volcánicas no son idénticas.', 'El Desierto de Atacama obtiene una similitud exploratoria general de 68.4 %, correspondiente a una clasificación moderada.

La categoría de mayor similitud es geología y mineralogía, con 78.4 %, seguida por biología y habitabilidad, con 72.5 %, y atmósfera, polvo y dinámica eólica, con 71.3 %.

Atacama constituye un entorno de interés para investigaciones relacionadas con Marte, especialmente en geoquímica, mineralogía, astrobiología y pruebas de tecnologías de exploración.

Su utilidad científica es mayor cuando se seleccionan sectores específicos del desierto de acuerdo con los objetivos de investigación.', 'Atacama no reproduce completamente:

● La gravedad marciana. ● La baja presión atmosférica. ● La composición atmosférica de Marte. ● Las condiciones térmicas marcianas. ● La radiación espacial. ● La distribución regional del hielo y otros recursos.

Las semejanzas deben interpretarse en relación con procesos o aplicaciones concretas.', 'La evaluación considera siete categorías de comparación y sus subvariables.

Los porcentajes proceden del sistema exploratorio de puntuación utilizado en el prototipo. No son mediciones directas de las misiones citadas ni resultados de una fórmula cuantitativa validada.

La clasificación utilizada es:

● Muy alta: 90–100 %. ● Alta: 75–menos de 90 %. ● Moderada: 50–menos de 75 %. ● Baja: 25–menos de 50 %. ● Muy baja: 0–menos de 25 %.

La validación posterior requerirá delimitar regiones de referencia, obtener mediciones comparables y documentar una fórmula de cálculo reproducible.', null, null, null),
  ('hawaii', 'TER-02-MOON', 'moon', 'en', 55::numeric, 'This assessment examines the suitability of the Mauna Kea–Kīlauea volcanic environments for terrestrial tests relevant to lunar exploration. It emphasizes basaltic geology, surface mobility, volcanic landforms, and subsurface structures.', 'The Hawaiian volcanic complex contains basaltic shield volcanoes, lava fields, cinder deposits, volcanic craters, fractures, and lava tubes. Mauna Kea reaches approximately 4,207 m above sea level and experiences cold summit conditions. Kīlauea includes active volcanic processes and relatively young basaltic surfaces.

The complex is not environmentally uniform. Humid lowland terrain, high-altitude volcanic slopes, and relatively dry lava fields must be evaluated separately when designing experiments.', 'The Hawaii Volcanic Complex receives a provisional lunar similarity score of 55.0%, classified as Moderate.

Its strongest assessed categories are Subsurface and Natural Structures (91.0%), Geology and Mineralogy (87.0%), and Topography and Geomorphology (76.0%).

The most valuable application is the investigation of basaltic volcanic terrain and underground structures potentially relevant to lunar exploration.', 'The Hawaiian environment does not reproduce lunar gravity, near-vacuum conditions, prolonged lunar thermal cycles, space radiation, micrometeorite exposure, or the complete properties of lunar regolith.

Its usefulness is therefore greatest for targeted geological and operational tests rather than full environmental simulation.', 'The assessment uses the supplied terrestrial and lunar research to identify geological, environmental, and operational similarities. The displayed scores are provisional qualitative judgments for the prototype, not direct measurements from the referenced missions or the output of a validated quantitative similarity model.

The classification scale is Very high (90–100%), High (75–less than 90%), Moderate (50–less than 75%), Low (25–less than 50%), Very low (0–less than 25%), and Not applicable (N/A).

A reproducible scientific score would require defined geographic sampling areas, comparable physical measurements, explicit variable weights, and documented normalization procedures.

Complete Martian Scientific Report', 'Hawaii’s basaltic landscapes, rugged volcanic surfaces, craters, and lava tubes share geological and structural characteristics with certain lunar volcanic environments, making them useful for exploration simulations.', 'Lunar rover mobility testing, basaltic mineral analysis, lava-tube exploration, subsurface mapping, and volcanic terrain recognition.', 'Relevant missions and instruments: Lunar Reconnaissance Orbiter (LOLA, LROC, Diviner), Chandrayaan-1 (Moon Mineralogy Mapper), Lunar Prospector, Apollo sample investigations, and GRAIL.'),
  ('hawaii', 'TER-02-MARS', 'mars', 'en', 63.3::numeric, 'This assessment evaluates the suitability of Mauna Kea and Kīlauea as terrestrial analog environments for Martian volcanic terrain, geological exploration, subsurface reconnaissance, and selected astrobiological investigations.', 'The Hawaiian volcanic complex is dominated by basaltic shield volcanism. Its landscapes include lava flows, volcanic craters, cinder deposits, fractures, and lava tubes.

Mauna Kea provides high-altitude volcanic terrain and cold summit conditions. Kīlauea provides active volcanic processes and relatively young basaltic surfaces.

These features offer useful comparisons with Martian volcanic regions, including the large shield volcanoes of Tharsis and other basaltic terrains.

However, Hawaiian atmospheric conditions, biological activity, and water availability differ substantially from present-day Mars.', 'The Hawaii Volcanic Complex receives a provisional Martian similarity score of 63.3%, classified as Moderate.

The highest assessed categories are Subsurface and Natural Structures (87.0%), Geology and Mineralogy (85.0%), and Topography and Geomorphology (82.0%).

Hawaii is especially valuable for testing geological and robotic exploration methods in basaltic volcanic environments. Its suitability for atmospheric, cryogenic, and comprehensive environmental simulations is more limited.', 'Hawaii does not reproduce Martian gravity, atmospheric composition, low atmospheric pressure, widespread cold conditions, space radiation, or the distribution of Martian subsurface ice.

Its humid and biologically active environments also differ from much of the present Martian surface.', 'This evaluation compares the terrestrial characteristics described in the supplied Hawaiian research with global and regional Martian observations.

The prototype percentages represent provisional qualitative similarity judgments. They are not direct NASA measurements or the result of a validated numerical scoring algorithm.

A scientifically reproducible model would require comparable site-specific measurements, explicit scoring rules, and documented variable weighting.

The classification scale is:

Score    Classificatio n

90–100%       Very high

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low

50%

0–less than 25% Very low

N/A  Not applicable

N/A variables must not be treated as zero-valued observations.', 'Hawaii’s shield volcanoes, basaltic lava flows, rocky terrain, and underground cavities resemble features found in Martian volcanic regions. Its volcanic environments also support selected astrobiological studies.', 'Martian rover navigation, volcanic geology research, mineralogical analysis, lava-tube exploration, subsurface reconnaissance, and astrobiological instrument testing.', 'Relevant missions and instruments: Mars Global Surveyor (MOLA, TES), Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS), Curiosity (APXS, CheMin, SAM, REMS), and Perseverance.'),
  ('islandia', 'TER-03-MOON', 'moon', 'en', 54.5::numeric, 'This assessment examines Iceland’s suitability as a terrestrial analog for selected lunar geological environments and exploration operations.

It focuses on basaltic volcanic terrain, surface roughness, natural underground structures, frozen-ground environments, and the practical testing of robotic exploration technologies.', 'Iceland is a volcanic island along the Mid-Atlantic Ridge. Its terrain includes extensive basaltic lava fields, volcanic fissures, calderas, glacial valleys, black volcanic sands, and lava-tube systems.

Its highest point, Hvannadalshnúkur, reaches approximately 2,110 m above sea level. The island also contains major ice caps, including Vatnajökull, Langjökull, and Hofsjökull.

The landscape is shaped by active volcanism, tectonic extension, glacial erosion, hydrothermal alteration, and atmospheric processes.

These conditions make Iceland valuable for specific geological and operational studies, but they also distinguish it from the dry, nearly airless lunar surface.', 'Iceland receives a provisional lunar similarity score of 54.5%, classified as Moderate.

Its strongest assessed categories are Subsurface and Natural Structures (87.0%), Geology and Mineralogy (74.0%), and Topography and Geomorphology (66.0%).

The most valuable lunar analog applications involve lava-tube exploration, basaltic terrain navigation, and geological instrument testing.', 'Iceland does not reproduce lunar gravity, near-vacuum conditions, extreme lunar thermal cycles, space radiation, or the complete mechanical and chemical properties of lunar regolith.

Its glacial erosion, active hydrological systems, and hydrothermal alteration also differ from the dominant geological processes of the present lunar surface.

The site is therefore most useful for targeted volcanic, robotic, and subsurface experiments rather than complete lunar environmental simulation.', 'The assessment compares the Icelandic terrestrial characteristics supplied for the project with lunar geological and environmental reference information.

The percentages are provisional qualitative judgments designed to demonstrate the comparison interface. They are not official NASA measurements or the output of a validated quantitative similarity algorithm.

The scoring scale is:

Percentage Classificatio n

90–100%       Very high

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very low

N/A           Not applicable

N/A values are not equivalent to zero and must not be included as zero-valued observations in calculations.

A reproducible model would require site-specific datasets, consistent measurement scales, documented normalization, and explicit weighting of variables and categories.', 'Iceland’s basaltic lava fields, volcanic craters, fractured surfaces, and lava tubes share geological characteristics with selected lunar volcanic terrains. Its rugged landscapes also support rover navigation and subsurface exploration tests.', 'Lunar rover mobility, basaltic mineral analysis, lava-tube exploration, geological mapping, and subsurface reconnaissance.', 'Relevant missions and instruments: Lunar Reconnaissance Orbiter (LOLA, LROC, Diviner, Mini-RF, LEND), Chandrayaan-1 (Moon Mineralogy Mapper), Kaguya, Lunar Prospector, LCROSS, and Apollo sample investigations. These links identify reference repositories and institutional resources; they are not a claim that every underlying dataset has been individually downloaded and analyzed.'),
  ('islandia', 'TER-03-MARS', 'mars', 'en', 80.6::numeric, 'This assessment evaluates Iceland as a terrestrial analog for selected Martian volcanic, glacial, periglacial, sedimentary, and potentially habitable environments.

The analysis emphasizes basaltic geology, cold-region processes, ice-bearing terrain, wind-driven sediment transport, subsurface structures, and the investigation of microbial survival in extreme terrestrial environments.', 'Iceland is a geologically active volcanic island influenced by the Mid-Atlantic Ridge and interactions between volcanism, glaciers, groundwater, and atmospheric processes.

Its landscapes include basaltic lava fields, volcanic fissures, calderas, glacial valleys, black-sand deserts, geothermal systems, lava tubes, and localized mountain permafrost.

Major glaciers, including Vatnajökull, Langjökull, and Hofsjökull, provide extensive ice-bearing environments. Iceland also contains subglacial volcanic deposits, palagonitic rocks, hydrothermally altered minerals, and microbial communities adapted to cold or geothermal conditions.

These characteristics are relevant to selected Martian volcanic terrains, ancient water-related geological processes, subsurface ice investigations, and astrobiological research.

However, Iceland’s dense atmosphere, abundant liquid water, active terrestrial ecosystems, and relatively mild climate differ substantially from present-day Mars.', 'Iceland receives a provisional Martian similarity score of 80.6%, classified as High.

Its strongest assessed categories are Geology and Mineralogy (88.0%), Subsurface and Natural Structures (88.0%), Atmosphere, Dust and Surface Dynamics (83.0%), and Topography and Geomorphology (80.0%).

The most valuable applications involve basaltic geology, glacial and periglacial processes, dust transport, subsurface exploration, and astrobiological instrument testing.

Iceland provides a diverse collection of terrestrial environments relevant to selected Martian exploration challenges, although the suitability of any individual field site must be assessed separately.', 'Iceland does not reproduce Martian gravity, low atmospheric pressure, carbon dioxide-dominated atmosphere, global thermal conditions, or radiation environment.

Its abundant liquid water, active hydrological cycle, and extensive biological activity differ from the present Martian surface.

Icelandic glaciers and geothermal systems are useful process analogs, but they are not direct physical replicas of Martian ice deposits or ancient hydrothermal environments.

The site should therefore be used for targeted geological, operational, and astrobiological experiments rather than comprehensive environmental simulation.', 'This assessment compares the terrestrial characteristics described in the supplied Icelandic research with the Martian environmental and geological reference information.

The percentages represent provisional qualitative judgments for demonstrating the website’s comparison system. They are not official NASA measurements or the output of a validated numerical scoring algorithm.

The classification scale is:

Percentage    Classificatio n

90–100%       Very high

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very low

N/A           Not applicable

N/A values must remain distinct from zero-valued observations.

A reproducible quantitative assessment would require defined Icelandic study areas, corresponding Martian regions, comparable physical measurements, consistent spatial scales, documented normalization, and explicit weighting of variables and categories.', 'Iceland’s basaltic volcanism, glacial landscapes, cold highlands, black volcanic sediments, and geothermal systems resemble selected geological and environmental features of Mars. Its subglacial volcanic deposits and microbial communities also support studies of ancient Martian water-related processes and habitability.', 'Martian rover navigation, volcanic and glacial geology, ice-related terrain studies, dust transport research, lava-tube exploration, and astrobiological instrument testing.', 'Relevant missions and instruments: Mars Global Surveyor (MOLA, TES), Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD, MARCI, MCS), Mars Odyssey (THEMIS, GRS), Mars Express (OMEGA, MARSIS), Curiosity (CheMin, SAM, REMS), InSight, and Perseverance (MEDA, PIXL, SHERLOC). These sources identify relevant scientific repositories, missions, and institutional resources. Individual datasets should be linked directly when incorporated into the quantitative analysis.'),
  ('mcmurdo', 'TER-04-MOON', 'moon', 'en', 45.3::numeric, 'This assessment evaluates the suitability of the McMurdo Dry Valleys as a terrestrial analog for selected lunar polar and rocky-surface exploration activities.

The investigation focuses on frozen-ground conditions, buried ice, surface roughness, illumination, geological sampling, and robotic operations in remote polar terrain.', 'The McMurdo Dry Valleys form an extensive ice-free polar desert within the Transantarctic Mountains.

The region includes broad glacial valleys, ancient moraines, rocky desert pavements, exposed sedimentary and crystalline rocks, glaciers, permanently ice-covered lakes, and exceptionally cold and dry soils.

The supplied terrestrial research describes valley-floor slopes of approximately 1–5°, steep surrounding rock walls exceeding 40°, winter temperature extremes approaching −50°C, and strong katabatic winds.

The geological assemblage includes Beacon sandstones, Ferrar dolerites, and older granitic and metamorphic rocks.

Continuous permafrost, buried ancient ice, salt accumulation, and thermal-contraction fractures are particularly relevant to polar exploration research.

However, the region retains Earth’s atmosphere, gravity, biological activity, and water-related geological processes. These differences substantially limit its direct lunar similarity.', 'The McMurdo Dry Valleys receive a provisional lunar similarity score of 45.3%, classified as Low.

The strongest assessed categories are Water, Ice and Resources (61.0%) and Topography and Geomorphology (54.0%).

The most relevant applications are buried-ice detection, frozen-ground sampling, polar navigation, and robotic exploration in cold rocky terrain.

The region’s value as a lunar analog is operational and process-specific rather than a direct match to the overall lunar environment.', 'The Dry Valleys do not reproduce lunar gravity, near-vacuum conditions, space radiation, lunar regolith chemistry, or the extreme temperatures of permanently shadowed lunar regions.

Their valleys and sediments are strongly influenced by glaciation, terrestrial winds, and geological processes involving water.

The absence of representative lava tubes and impact-crater terrain also limits their suitability for certain lunar geological investigations.

The region is therefore most useful for specific polar operational and frozen-ground experiments rather than comprehensive lunar environmental simulation.', 'The assessment compares the terrestrial conditions described in the supplied McMurdo Dry Valleys research with lunar geological and environmental reference information.

Scores are provisional qualitative estimates for the comparison prototype. They are not official NASA measurements or the results of a validated mathematical similarity algorithm.

Classification scale:

Percentage  Classificatio n

90–100%     Very high

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very low

N/A           Not applicable

N/A values must remain distinct from zero-valued observations.

The overall score is a separate provisional assessment and should not be presented as a mathematically derived weighted average.

A reproducible assessment requires defined field sites, comparable physical measurements, documented normalization, spatially consistent datasets, and explicit weighting.

The Antarctic research contains broad regional descriptions and reference portals rather than a complete set of site-specific measurements. These limitations must be resolved before scientific validation.', 'The McMurdo Dry Valleys provide cold, dry, rocky landscapes, frozen ground, buried ice, and prolonged seasonal darkness. These conditions offer limited comparisons with selected lunar polar exploration challenges, particularly terrain navigation and ice-related investigations.', 'Polar robotic mobility, frozen-ground sampling, preliminary ice-detection testing, illumination studies, and rocky-terrain navigation.', 'Relevant missions and instruments: Lunar Reconnaissance Orbiter (LOLA, LROC, Diviner, LEND, Mini-RF), Lunar Prospector, Chandrayaan-1 (Moon Mineralogy Mapper), LCROSS, and Apollo sample investigations. These are relevant institutional references and data repositories. Their inclusion does not establish that every underlying dataset was individually downloaded or processed.'),
  ('mcmurdo', 'TER-04-MARS', 'mars', 'en', 82.4::numeric, 'This assessment evaluates the McMurdo Dry Valleys as a terrestrial analog for selected Martian polar, periglacial, hyperarid, and potentially habitable environments.

The investigation emphasizes subsurface ice, continuous permafrost, salt-rich soils, physical weathering, aeolian erosion, geological preservation, and microbial survival in extreme environments.', 'The McMurdo Dry Valleys are among the coldest and driest ice-free regions of Antarctica.

The supplied research describes annual cold conditions of approximately −20°C to −30°C, occasional summer temperatures above freezing, and extreme winter temperatures approaching −50°C.

The region contains continuous permafrost, ancient buried glacial ice, permanently ice-covered lakes, hyperarid desert pavements, moraine deposits, salt accumulations, and extensive wind-eroded rock surfaces.

Strong katabatic winds transport fine mineral particles and shape ventifacts, while thermal contraction and salt crystallization contribute to physical weathering.

The region also supports cryptoendolithic microbial communities, which inhabit protected pore spaces within sandstone and other suitable rocks.

These features provide valuable comparisons with selected Martian periglacial landscapes, subsurface ice deposits, aeolian environments, and hypothetical ancient or protected microbial habitats.

However, the Dry Valleys retain Earth’s dense atmosphere, abundant atmospheric oxygen, terrestrial gravity, and accessible biological ecosystems. Their environmental conditions are therefore not equivalent to those of present-day Mars.', 'The McMurdo Dry Valleys receive a provisional Martian similarity score of 82.4%, classified as High.

The strongest assessed categories are Biology and Habitability (92.0%), Water, Ice and Resources (91.0%), and Atmosphere, Dust and Surface Dynamics (87.0%).

The region is particularly valuable for testing ice-detection technologies, studying permafrost and ancient ice deposits, examining aeolian erosion, and investigating microbial survival in extreme environments.

Its importance as a Martian analog lies in the similarity of selected geological and environmental processes, not in a complete reproduction of present-day Martian conditions.', 'The Dry Valleys do not reproduce Martian gravity, low atmospheric pressure, carbon dioxide-dominated atmosphere, radiation exposure, or the full Martian thermal range.

Although both environments can be extremely dry and cold, Antarctica retains an active terrestrial hydrological system and biological communities.

The region also lacks representative volcanic lava tubes and extensive impact-crater fields.

Its strongest analog applications concern permafrost, buried ice, physical weathering, and astrobiology rather than complete Martian environmental simulation.

Fieldwork in Antarctica is subject to environmental protections, research permits, and applicable Antarctic Treaty requirements.', 'This assessment compares the terrestrial characteristics provided in the McMurdo Dry Valleys research with Martian geological and environmental reference information.

The similarity percentages are provisional qualitative judgments designed for the prototype website. They are not official NASA measurements or the output of a validated quantitative model.

Classification scale:

Percentage Classificatio n

90–100%       Very high

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very low

N/A  Not applicable

N/A is distinct from zero and must not be treated as a zero-valued observation.

The overall score is a separate provisional assessment, not a verified weighted average of category scores.

Scientific validation would require defined field sites, comparable physical measurements, consistent spatial scales, documented normalization, and explicit weighting.

Several terrestrial source entries refer to general research portals or academic search engines rather than specific publications. Those entries require replacement with traceable datasets or individual scientific references before the assessment can be considered reproducible.', 'The McMurdo Dry Valleys contain hyperarid soils, extensive permafrost, buried ice, salt-rich deposits, wind-eroded rocks, and cold-adapted microbial communities. These characteristics resemble selected present-day and ancient Martian polar, periglacial, and potentially habitable environments.', 'Martian ice detection, permafrost exploration, polar rover navigation, aeolian erosion studies, biosignature detection, and astrobiological instrument testing.', 'Relevant missions and instruments: Mars Global Surveyor (MOLA, TES), Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD, MARCI, MCS), Mars Odyssey (THEMIS, GRS), Mars Express (OMEGA, MARSIS), Curiosity (CheMin, SAM, REMS), InSight, and Perseverance (MEDA, PIXL, SHERLOC). The references identify relevant scientific repositories and institutional resources. They do not establish that every individual dataset has been downloaded or analyzed.'),
  ('haughton', 'TER-05-MOON', 'moon', 'en', 58::numeric, 'This assessment examines the suitability of Haughton Impact Crater as a terrestrial analog for lunar impact structures, crater exploration, fractured geological materials, and selected polar field operations.

The investigation emphasizes impact-generated landforms, geological deformation, surface hazards, crater stratigraphy, and subsurface structures.', 'Haughton is a complex impact crater formed by a high-velocity extraterrestrial impact into predominantly Paleozoic carbonate rocks on Devon Island.

The crater is approximately 23 km in diameter. Its geological features include a central structural uplift, impact breccias, highly fractured rocks, displaced geological blocks, and a partially eroded crater depression.

The surrounding environment is a cold Arctic desert characterized by continuous permafrost, polygonal ground, seasonal snow, sparse vegetation, and localized summer meltwater.

The terrestrial research reports elevations of approximately 200–400 m and an annual mean temperature near −15°C.

Important chronological clarification: The supplied terrestrial table lists an impact age of approximately 39 million years. Published geological estimates commonly place the Haughton impact at approximately 23 million years ago. The age must be checked against a specific dated scientific publication before final scientific publication.', 'Haughton Impact Crater receives a provisional lunar similarity estimate of 58.0%, classified as Moderate.

Its strongest categories are Topography and Geomorphology (88.0%) and Subsurface and Natural Structures (77.0%).

The region’s greatest scientific value is its authentic impact-generated geology, which makes it particularly suitable for studying crater structures, breccias, fractures, and exploration hazards.

It should be considered a specialized impact-crater analog rather than a comprehensive simulation of the lunar environment.', 'Haughton does not reproduce lunar gravity, near-vacuum conditions, space radiation, or extreme lunar surface temperatures.

Its carbonate-rich target rocks differ substantially from common lunar crustal materials.

The crater has undergone erosion, weathering, and periglacial modification, whereas lunar craters evolve under very different surface conditions.

Its ice-bearing ground is useful for selected polar investigations but is not a direct physical equivalent of lunar permanently shadowed regolith.

The absence of lava tubes also limits its suitability for lunar volcanic-cavity exploration.', 'This assessment compares the terrestrial Haughton research with the supplied lunar environmental and geological reference dataset.

Similarity percentages are provisional qualitative estimates for a hackathon demonstration. They are not official NASA similarity measurements or outputs of a validated scoring model.

Classification scale:

Percentage    Classificatio n

90–100%       Very high

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very low

N/A           Not applicable

N/A values are distinct from zero.

The overall similarity estimate is independent of the displayed category scores and must not be presented as a calculated weighted average.

Scientific validation requires site-specific measurements, comparable spatial scales, normalized physical variables, traceable scientific references, and a documented weighting algorithm.

Several terrestrial claims, including crater age, permafrost depth, wind speeds, and impact-deposit thicknesses, require verification against specific scientific studies.', 'Haughton Crater provides direct geological comparisons with lunar impact structures through its crater morphology, impact breccias, fractured bedrock, and complex subsurface deformation. Its rocky terrain and impact-generated obstacles also support lunar surface exploration studies. However, the terrestrial crater has experienced extensive erosion, weathering, and periglacial modification that differ from lunar surface evolution.', 'Impact-crater mapping, impact-breccia identification, geological sampling, robotic navigation, crater-wall reconnaissance, and subsurface fracture detection.', 'Relevant lunar datasets and instruments: LOLA elevation and slope products, LROC NAC and WAC imagery, Diviner thermal observations, Moon Mineralogy Mapper data, and lunar impact-crater catalogs. The sources above identify relevant institutions and data repositories; they do not establish that all cited measurements were independently verified.'),
  ('haughton', 'TER-05-MARS', 'mars', 'en', 80.6::numeric, 'This assessment evaluates Haughton Impact Crater as a terrestrial analog for Martian impact structures, polar desert environments, frozen ground, impact-modified geology, and selected astrobiological investigations.

The assessment focuses on impact-crater morphology, surface obstacles, subsurface deformation, permafrost, cold-region geological alteration, and the preservation of potential biological indicators.', 'Haughton is a complex impact structure situated on Devon Island in the Canadian High Arctic.

The crater formed when a high-velocity extraterrestrial object struck predominantly Paleozoic carbonate rocks, producing a large depression, impact breccias, fractured bedrock, and a central structural uplift.

Its approximate diameter is 23 km. The structure has subsequently experienced erosion and periglacial modification.

The surrounding polar desert contains continuous permafrost, patterned ground, sparse vegetation, seasonal snow, localized meltwater, and dry rocky surfaces.

The supplied terrestrial research describes an annual mean temperature near −15°C, short summer temperatures reaching approximately +5°C to +10°C, and extreme winter temperatures approaching −40°C to −50°C.

The region supports cold-adapted microorganisms, including microbial communities associated with rocks and seasonal aquatic environments.

These features provide valuable comparisons with selected Martian impact craters, cold desert landscapes, subsurface ice-bearing environments, and potential past habitable settings.', 'Haughton Impact Crater receives a provisional Martian similarity estimate of 80.6%, classified as High.

The strongest categories are Topography and Geomorphology (91.0%), Water, Ice and Resources (86.0%), and Subsurface and Natural Structures (85.0%).

The site’s principal scientific advantage is its combination of authentic impact-generated geology and cold Arctic desert conditions.

It is particularly valuable for testing exploration strategies within impact craters and investigating frozen subsurface environments.

Its analog value is process-specific and does not imply complete equivalence with Mars.', 'Haughton does not reproduce Martian gravity, low atmospheric pressure, carbon dioxide-dominated atmosphere, or space-radiation environment.

Its carbonate-rich bedrock is not representative of the dominant basaltic geology of Mars.

Terrestrial liquid water, atmospheric oxygen, and microbial ecosystems create major differences from present-day Martian surface conditions.

The crater has also experienced extensive terrestrial erosion and periglacial modification, making its present morphology different from that of a fresh Martian impact crater.

The region is most useful for selected impact-geology, permafrost, rover-mobility, and astrobiology investigations rather than complete Martian environmental simulation.', 'The assessment compares the supplied terrestrial Haughton research with the supplied Martian environmental and geological reference dataset.

The similarity percentages are provisional qualitative estimates intended for a hackathon demonstration. They are not official NASA measurements or outputs of a validated numerical similarity model.

Classification scale:

Percentage Classificatio n

90–100%       Very high

75–less than  High 90%

50–less than  Moderate 75%

25–less than Low 50%

0–less than 25% Very low

N/A           Not applicable

N/A is distinct from zero.

The overall score is a separate provisional assessment and must not be described as a calculated weighted average.

Scientific validation requires comparable measurements, defined geographic sampling areas, consistent spatial scales, traceable datasets, and a reproducible normalization and weighting methodology.

The supplied terrestrial research includes several broad institutional references rather than specific publications. Crater age, wind speeds, permafrost depth, buried-ice distribution, and impact-deposit thickness should be verified against site-specific scientific studies before final publication.', 'Haughton Crater combines impact-generated geological structures with polar desert conditions, continuous permafrost, freeze–thaw processes, wind erosion, and limited seasonal liquid water. These characteristics provide useful analogs for selected Martian impact craters, cold desert terrains, ice-bearing subsurface deposits, and environments of astrobiological interest.', 'Martian impact-crater exploration, polar rover testing, subsurface ice investigation, geological mapping, impact-related hydrothermal research, and biosignature detection.', 'Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS and neutron spectroscopy), Curiosity, Phoenix, and Perseverance. These references identify relevant institutions, missions, and data repositories. They do not establish that each individual dataset was downloaded or independently analyzed.'),
  ('qaidam', 'TER-06-MOON', 'moon', 'en', 30.2::numeric, 'This assessment examines the Qaidam Basin as a terrestrial analog for selected lunar surface exploration tasks, particularly rover navigation across flat plains, obstacle detection, granular-material handling, and remote geological classification.

It also identifies the substantial geological and environmental differences that limit Qaidam’s suitability as a lunar analog.', 'The Qaidam Basin is an extensive intermontane sedimentary basin in northwestern China, characterized by high elevation, extreme aridity, ancient lake deposits, saline playas, evaporite minerals, and large wind-eroded yardang fields.

The supplied terrestrial research reports basin-floor elevations of approximately 2,600–3,200 m, central playa slopes of approximately 0°–3°, summer temperatures reaching around +30°C, and winter minima approaching −25°C to −30°C.

The basin contains halite, gypsum, other sulfates, clays, sandstones, siltstones, and fine-grained wind-transported sediments.

These features make Qaidam a strong terrestrial setting for sedimentological research, but many have no direct geological equivalent on the Moon.', 'Qaidam receives a provisional lunar similarity estimate of 30.2%, classified as Low.

Its strongest lunar category is Topography and Geomorphology (55.0%), principally because of its low-gradient plains and operationally relevant surface obstacles.

The basin should be treated as a limited operational testing environment, not a representative lunar geological or environmental analog.', 'Qaidam does not reproduce lunar gravity, vacuum, radiation exposure, or extreme surface temperatures.

Its geological evolution is dominated by sedimentation, evaporation, and wind erosion rather than lunar impact gardening and volcanism.

Its salt-rich chemistry differs substantially from typical lunar regolith.

The absence of documented lava tubes and major local impact craters limits its suitability for lunar subsurface and crater exploration.', 'This assessment compares the supplied Qaidam terrestrial research with the supplied lunar reference dataset.

The percentages are provisional qualitative estimates rather than measured physical similarity values.

The overall estimate is independent of the category percentages and must not be represented as a calculated weighted average.

Classification scale: Very high (90–100%); High (75–less than 90%); Moderate (50–less than 75%); Low (25–less than 50%); Very low (0–less than 25%); Not applicable (N/A).

N/A values must not be treated as zero.

A validated assessment would require site-specific sampling, normalized variables, comparable spatial scales, traceable datasets, and a documented weighting method.', 'Qaidam’s relatively flat dry lakebeds, granular deposits, and rocky obstacles offer limited operational comparisons with lunar plains. However, its sedimentary geology, salt-rich chemistry, water-related history, and wind-generated landforms differ fundamentally from the impact- and volcanism-dominated lunar surface.', 'Rover navigation across flat and uneven ground, granular-material sampling, remote-sensing classification, and evaluation of dust-sensitive instruments under terrestrial

conditions.', 'Relevant lunar datasets: LOLA elevation and slope products, LROC NAC and WAC imagery, Diviner surface-temperature observations, Moon Mineralogy Mapper mineralogical data, and Lunar Prospector elemental maps. The listed portals are potential source repositories, not evidence that specific site measurements were independently downloaded or verified.'),
  ('qaidam', 'TER-06-MARS', 'mars', 'en', 80.3::numeric, 'This assessment evaluates the Qaidam Basin as a terrestrial analog for selected Martian sedimentary, evaporitic, aeolian, and hyperarid environments.

It focuses on yardang formation, ancient lakebed deposits, mineral precipitation, wind erosion, sedimentary stratigraphy, and potential biosignature preservation in salt-rich geological materials.', 'The Qaidam Basin is a large intermontane sedimentary basin situated on the northeastern Tibetan Plateau.

Its terrain includes extensive saline playas, dry lakebeds, wind-sculpted yardangs, dunes, alluvial fans, and thick sedimentary sequences.

The supplied terrestrial research reports elevations of approximately 2,600–3,200 m, generally low slopes across central playas, summer temperatures near +30°C, winter minima approaching −25°C to −30°C, and substantial daily and seasonal thermal variation.

The basin contains ancient lacustrine sediments, evaporites, halite, gypsum, other sulfate minerals, clays, and fine-grained wind-transported deposits.

Its hyperarid and hypersaline environments support specialized microorganisms that can be investigated as terrestrial models for biosignature preservation.

The basin is particularly useful for comparisons with selected Martian sedimentary plains, ancient lake basins, sulfate-rich deposits, and yardang fields.', 'Qaidam receives a provisional Martian similarity estimate of 80.3%, classified as High.

Its strongest categories are Atmosphere, Dust and Surface Dynamics (91.0%), Geology and Mineralogy (88.0%), and Biology and Habitability (85.0%).

The basin’s greatest scientific value lies in its combination of extensive yardang fields, ancient lake deposits, evaporite mineralogy, and extreme aridity.

It is a strong process-level analog for selected Martian sedimentary and aeolian landscapes, particularly for research involving ancient aqueous environments and potential biosignature preservation.', 'Qaidam does not reproduce Martian gravity, atmospheric pressure, atmospheric composition, or radiation exposure.

Its modern saline lakes and brines are not direct equivalents of present-day Martian surface water conditions.

The basin’s high temperatures during some summer periods differ substantially from much of Mars.

Its central desert plains are not established analogs for Martian subsurface ice or polar permafrost.

Although Qaidam’s yardangs resemble Martian wind-eroded landforms, erosion rates and wind forces cannot be assumed equivalent because atmospheric densities differ.

The basin is most useful for selected sedimentary, evaporitic, aeolian, and astrobiological research rather than complete Martian environmental simulation.', 'This assessment compares the supplied Qaidam terrestrial research with the supplied Martian reference dataset.

The similarity percentages are provisional qualitative estimates for the hackathon demonstration.

They are not official NASA scores or measured correlations.

Classification scale: Very high (90–100%); High (75–less than 90%); Moderate (50–less than 75%); Low (25–less than 50%); Very low (0–less than 25%); Not applicable (N/A).

N/A values are distinct from zero.

The overall score is an independent provisional estimate and must not be described as a calculated weighted average of category scores.

A validated quantitative assessment would require site-specific data, comparable spatial resolutions, normalized variables, traceable scientific publications, and a reproducible weighting algorithm.', 'The Qaidam Basin offers strong process-level comparisons with selected Martian landscapes through its extensive yardang fields, evaporite deposits, ancient lakebeds, fine-grained sediments, and extreme aridity. Its saline environments are also useful for testing techniques that investigate possible biosignature preservation in ancient Martian sedimentary deposits.', 'Martian yardang mapping, aeolian erosion studies, evaporite and sulfate detection, paleolake reconstruction, sedimentary sampling, biosignature preservation research, and rover mobility testing.', 'Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS), Mars Express (OMEGA), Curiosity, and Perseverance. Relevant research topics: Martian yardangs, chloride-bearing deposits, sulfate mineralogy, paleolake sediments, and organic preservation in evaporites. The source list identifies repositories and relevant datasets but does not establish that the Qaidam values have been independently verified against specific peer-reviewed publications.'),
  ('danakil', 'TER-07-MOON', 'moon', 'en', 43::numeric, 'This assessment evaluates the Danakil Depression as a terrestrial analog for selected lunar volcanic landscapes, fractured geological terrains, and subsurface exploration environments.

The investigation focuses on basaltic rocks, surface roughness, tectonic fractures, volcanic formations, and selected operational hazards.

The assessment also identifies major differences in thermal conditions, atmospheric pressure, water availability, and geological alteration that prevent Danakil from functioning as a comprehensive lunar environmental analog.', 'The Danakil Depression lies within the active Afar Rift system in northeastern Ethiopia. It includes low-elevation salt basins, evaporite deposits, fault-controlled depressions, and volcanic and hydrothermal terrain.

Dallol is characterized by hydrothermal mineral precipitation, acidic and hypersaline fluids, salt formations, and chemically altered surfaces.

The broader Danakil region also contains the Erta Ale volcanic system, where basaltic volcanism provides a distinct geological environment.

The supplied terrestrial research describes very high air and ground temperatures, intense solar exposure, abundant evaporite minerals, active tectonic fracturing, and hydrothermal fluids.

These conditions provide selected geological analog opportunities, particularly in volcanic terrain, but differ substantially from the lunar surface.

Geographic limitation: Dallol’s hydrothermal structures and Erta Ale’s basaltic volcanic features occur in different locations. They must be evaluated as separate subregions in any detailed spatial analysis.', 'Danakil receives a provisional lunar similarity estimate of 43.0%, classified as Low.

Its strongest categories are Subsurface and Natural Structures (70.0%) and Geology and Mineralogy (63.0%).

The region’s principal lunar analog value comes from basaltic volcanism, fractured geological terrain, and selected subsurface structures.

Danakil should be considered a specialized volcanic and structural analog rather than a comprehensive lunar surface simulation.', 'Danakil does not reproduce lunar vacuum, gravity, radiation exposure, or prolonged illumination cycles.

Its hydrothermal fluids, evaporite deposits, and acidic alteration processes differ greatly from typical lunar surface geology.

The Dallol hydrothermal area and Erta Ale volcanic system must not be treated as a single homogeneous sampling site.

Specific claims about lava tubes and subsurface cavities require geological verification.

The site is more appropriate for selected volcanic and structural studies than for lunar environmental or polar resource simulation.', 'The assessment compares the supplied Danakil terrestrial research with general lunar geological and environmental characteristics.

The similarity percentages are provisional qualitative estimates intended for a hackathon prototype. They are not official NASA similarity measurements or outputs of a validated scoring algorithm.

Classification scale:

Percentage Classification

90–100%       Very High

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very Low

N/A           Not Applicable

N/A values are distinct from zero.

The overall similarity score is an independent provisional assessment, not a calculated weighted average of the displayed category scores.

Scientific validation would require site-specific measurements, normalized physical variables, traceable datasets, comparable spatial resolutions, and a reproducible scoring method.

The supplied terrestrial claims about extreme temperatures, gas concentrations, cave systems, and lava tubes require verification against location-specific scientific studies.', 'Danakil’s basaltic volcanic terrain, tectonic fractures, rugged rock surfaces, and selected subsurface structures share characteristics with lunar volcanic regions. However, its active hydrothermal environment, extensive salts, and terrestrial atmosphere differ fundamentally from lunar conditions.', 'Basaltic terrain analysis, rover mobility testing, fracture mapping, volcanic structure investigation, and subsurface exploration.', 'Relevant lunar datasets and instruments: LOLA elevation data, LROC imagery, Diviner thermal observations, Moon Mineralogy Mapper mineralogical products, and lunar volcanic terrain maps. The listed sources identify relevant repositories and research resources. They do not establish independent verification of every terrestrial measurement.'),
  ('danakil', 'TER-07-MARS', 'mars', 'en', 61::numeric, 'This assessment evaluates the Danakil Depression as a terrestrial analog for selected Martian volcanic, hydrothermal, evaporitic, and tectonic environments.

The investigation emphasizes basaltic volcanism, mineral alteration, acidic and hypersaline fluids, geological fractures, and the environmental limits of microbial habitability.

The analysis distinguishes process-level geological similarities from direct physical environmental equivalence.', 'The Danakil Depression forms part of the Afar Rift, an active tectonic region in northeastern Ethiopia.

Its landscape includes low-lying evaporite basins, fault systems, volcanic terrain, salt structures, and hydrothermal deposits.

Dallol contains acidic and hypersaline hydrothermal fluids and mineral precipitates. The broader Danakil region includes basaltic volcanic environments associated with Erta Ale.

The supplied terrestrial research describes extreme surface temperatures, intense solar radiation, salt-rich mineral deposits, sulfur-bearing gases, and active hydrothermal alteration.

The region is scientifically relevant because Mars contains widespread basaltic geology, evidence of past water-related mineral alteration, sulfate-rich deposits, and volcanic structures.

Danakil’s extreme environments also provide opportunities to investigate the physical and chemical limits of habitability.

However, its hot terrestrial climate, dense atmosphere, and active liquid-water systems differ substantially from present-day Martian surface conditions.', 'Danakil receives a provisional Martian similarity estimate of 61.0%, classified as Moderate.

Its strongest categories are Geology and Mineralogy (84.0%), Biology and Habitability (79.0%), and Subsurface and Natural Structures (76.0%).

The region’s principal scientific advantage is its combination of basaltic volcanism, extreme hydrothermal alteration, evaporite mineral formation, and unusual environmental chemistry.

It is particularly valuable for investigating ancient Martian water–rock interactions, mineralogical signatures, and the boundaries of microbial habitability.

Its usefulness is process-specific and does not imply complete physical similarity with Mars.', 'Danakil does not reproduce Martian gravity, atmospheric pressure, carbon dioxide-dominated atmosphere, or radiation environment.

Its extremely high temperatures differ from typical present-day Martian surface conditions.

Dallol’s active liquid hydrothermal fluids cannot be treated as equivalent to stable present-day Martian surface water.

The Dallol hydrothermal area and Erta Ale volcanic system are geographically distinct.

Some highly acidic and hypersaline Dallol pools may be uninhabitable. Biological observations from neighboring environments cannot automatically be applied to these pools.

Specific lava-tube and cavity claims require site-specific scientific verification.

The site is most valuable for selected volcanic, hydrothermal, mineralogical, and habitability-limit investigations rather than complete Martian environmental simulation.', 'The assessment compares the supplied Danakil terrestrial research with general Martian geological and environmental characteristics.

All percentages are provisional qualitative estimates for a hackathon prototype. They are not official NASA similarity scores or outputs of a validated numerical model.

Classification scale:

Percentage Classification

90–100%  Very High

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very Low

N/A           Not Applicable

N/A values are distinct from zero.

The overall similarity score is an independent provisional assessment rather than a calculated weighted average.

Scientific validation would require site-specific measurements, comparable spatial resolutions, normalized physical variables, traceable datasets, and a reproducible scoring methodology.

Special attention should be given to distinguishing Dallol hydrothermal measurements from observations made elsewhere in the Danakil Depression.', 'Danakil combines basaltic volcanism, hydrothermal alteration, evaporite minerals, acidic brines, and tectonic fractures that provide useful analogs for selected Martian volcanic and ancient water-altered environments.', 'Martian mineral identification, hydrothermal alteration studies, astrobiological investigations, biosignature preservation research, geological mapping, and subsurface reconnaissance.', 'Relevant missions and instruments: Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS), Mars Express (OMEGA), Curiosity, and Perseverance. Relevant research topics: Martian sulfate deposits, hydrothermal alteration, basaltic volcanism, subsurface structures, and astrobiological habitability. The references identify relevant scientific resources but do not establish independent verification of all site-specific terrestrial claims.'),
  ('stillwater', 'TER-08-MOON', 'moon', 'en', 48.5::numeric, 'This assessment evaluates the Stillwater Igneous Complex as a terrestrial analog for the mineralogical and geological characteristics of the lunar highlands.

The primary focus is the presence of plagioclase-rich anorthositic rocks and their relevance to the feldspathic crust of the Moon.

Additional comparisons include mountainous terrain, fractured bedrock, igneous layering, mineral resources, and geological sampling conditions.

The assessment distinguishes strong lithological similarity from the substantially different environmental and geological processes operating on Earth and the Moon.', 'The Stillwater Complex is a Precambrian layered mafic–ultramafic intrusion exposed in the mountains of southern Montana.

The complex contains differentiated igneous rock units, including plagioclase-rich anorthositic rocks and associated mafic and ultramafic lithologies.

The surrounding terrain includes rocky ridges, steep slopes, angular talus deposits, forested areas, and valleys modified by fluvial and glacial processes.

The supplied terrestrial research describes elevations of approximately 1,500–3,000 m, a temperate-to-cold continental mountain climate, seasonal snow, streams, fractured bedrock, and economically significant mineral deposits.

Its principal lunar relevance comes from the presence of anorthositic rocks dominated by calcium-rich plagioclase.

The lunar highlands contain abundant anorthositic material interpreted as part of the Moon’s ancient feldspathic crust.

However, the Stillwater intrusion and the lunar crust formed under different geological conditions. Similar mineralogy does not establish identical chemical composition, crystallization history, or geological structure.', 'The Stillwater Anorthosite Complex receives a provisional lunar similarity estimate of 48.5%, classified as Low.

Its strongest category is Geology and Mineralogy (94.0%, Very High), reflecting the importance of plagioclase-rich anorthositic rocks for studies of the lunar highlands.

The region also offers useful terrain and subsurface comparisons, but its atmospheric, thermal, hydrological, and biological conditions differ substantially from those of the Moon.

Stillwater should therefore be prioritized as a specialized lunar highland mineralogical and petrological analog, rather than a comprehensive lunar environmental analog.', 'Stillwater does not reproduce lunar vacuum, gravity, radiation exposure, or prolonged lunar day–night cycles.

Its surface contains terrestrial soils, vegetation, water, and chemically weathered rocks.

Its mountainous terrain was shaped partly by tectonic, fluvial, and glacial processes rather than lunar impact bombardment.

The Stillwater intrusion and lunar anorthositic crust formed under different geological conditions.

The mineralogical similarity applies most strongly to selected plagioclase-rich Stillwater rock units, not to every rock within the complex.

Claims of exact chemical equivalence require laboratory confirmation using representative samples and lunar reference materials.

The site does not provide a direct analog for lunar polar ice, lunar dust, or lava tubes.', 'The assessment compares the supplied Stillwater terrestrial research with lunar reference information from orbital observations, geological studies, and returned lunar samples. The individual variable and category scores are provisional qualitative estimates. They are not official NASA similarity measurements. The overall score is the arithmetic mean of the six applicable category scores: (66 + 29 + 94 + 22 + 19 + 61) / 6 = 48.5%. Classification scale:

Percentage Classification

90–100%       Very High

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very Low

N/A           Not Applicable

N/A values are excluded from the overall mean.

Category scores are not calculated from their individual subvariable percentages.

The equal-weight overall mean is a transparent prototype convention rather than a validated scientific weighting model.

Future validation should use georeferenced Stillwater samples, measured mineral abundances, laboratory spectroscopy, normalized geochemical variables, and a reproducible scoring methodology. The exceptionally high geological similarity score should be interpreted as specialized mineralogical relevance, not as proof of exact lunar equivalence.', 'Stillwater’s plagioclase-rich anorthositic rocks provide a strong mineralogical analog for the lunar highlands. Its fractured bedrock and rugged terrain offer additional geological comparisons, although its atmosphere, vegetation, water, and weathering processes differ greatly from lunar conditions.', 'Lunar highland mineral identification, plagioclase spectroscopy, igneous differentiation studies, geological sampling, and aluminum-rich resource characterization.', null),
  ('stillwater', 'TER-08-MARS', 'mars', 'en', 39.7::numeric, 'This assessment evaluates the Stillwater Igneous Complex as a terrestrial analog for selected Martian igneous rocks, crustal differentiation processes, fractured bedrock, and subsurface geological structures. The study focuses on the complex’s layered mafic and ultramafic intrusion, anorthositic units, rocky terrain, and mineral-resource potential. Although Stillwater is particularly relevant to lunar highland geology, its igneous formations can also support selected investigations of Martian crustal materials. The assessment distinguishes these geological similarities from the substantial differences between Stillwater’s terrestrial environment and the present-day Martian surface.', 'The Stillwater Complex is an ancient layered igneous intrusion exposed in southern Montana.

Its rocks include plagioclase-rich anorthositic units, mafic and ultramafic lithologies, and mineralized layers.

The surrounding terrain contains mountainous slopes, fractured rock exposures, angular talus, forested areas, streams, and glacially modified valleys.

The supplied research describes elevations of approximately 1,500–3,000 m and a temperate-to-cold continental mountain climate.

Mars contains widespread basaltic rocks and evidence of diverse igneous and sedimentary processes. Selected Martian crustal regions may also contain feldspar-rich materials.

However, Mars’s dominant surface mineralogy is not uniformly anorthositic, and Stillwater’s intrusive formation history does not reproduce every Martian igneous process.

The site is therefore most useful for selected petrological, structural, and geological exploration studies.', 'The Stillwater Anorthosite Complex receives a provisional Martian similarity estimate of 39.7%, classified as Low.

Its strongest category is Geology and Mineralogy (65.0%), followed by Topography and Geomorphology (58.0%) and Subsurface and Natural Structures (53.0%).

The region’s principal Martian analog value lies in its igneous rock assemblages, layered crustal structures, and exposed fractured bedrock.

Stillwater should be considered a specialized geological analog for selected Martian crustal investigations rather than a comprehensive Martian environmental analog.', 'Stillwater does not reproduce Martian atmospheric pressure, atmospheric composition, gravity, radiation exposure, or typical surface temperatures.

Its forested and water-rich environment differs substantially from present-day Mars.

Its anorthositic units are not representative of the dominant basaltic surface composition across much of Mars.

Its intrusive geological history differs from the formation of many Martian volcanic flows and sedimentary deposits.

The site lacks extensive Martian-style dust deposits, persistent permafrost, and confirmed lava-tube analogs.

The presence of terrestrial mineral deposits does not establish equivalent Martian ore concentrations.

The site’s biological environment is not a direct analog for Martian habitability.', 'The assessment compares the supplied Stillwater terrestrial research with Martian geological and environmental reference information.

Individual variable and category scores are provisional qualitative estimates, not official NASA similarity measurements. The overall score is the arithmetic mean of the seven applicable category scores: (58 + 36 + 65 + 29 + 25 + 53 + 12) / 7 = 39.7%, rounded to one decimal place. Classification scale:

Percentage Classification

90–100%       Very High

75–less than  High 90%

50–less than  Moderate 75%

25–less than  Low 50%

0–less than 25% Very Low

N/A           Not Applicable

Category scores are not calculated from their subvariable percentages.

The equal-weight overall mean is a transparent prototype convention rather than a validated scientific model.

Future validation should use site-specific mineralogical measurements, geochemical analyses, georeferenced sampling locations, normalized planetary reference data, and a reproducible scoring methodology.', 'Stillwater’s mafic igneous rocks, layered formations, fractured bedrock, and rocky slopes provide partial analogs for selected Martian crustal environments. Its anorthosite-rich units are less representative of Mars’s predominantly basaltic surface.', 'Igneous rock classification, mineral spectroscopy, crustal differentiation research, geological mapping, and robotic sampling of exposed bedrock.', null)
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;

delete from public.assessment_categories where assessment_id in (select id from public.assessments where code in ('TER-01-MOON', 'TER-01-MARS', 'TER-02-MOON', 'TER-02-MARS', 'TER-03-MOON', 'TER-03-MARS', 'TER-04-MOON', 'TER-04-MARS', 'TER-05-MOON', 'TER-05-MARS', 'TER-06-MOON', 'TER-06-MARS', 'TER-07-MOON', 'TER-07-MARS', 'TER-08-MOON', 'TER-08-MARS'));
delete from public.assessment_variables where assessment_id in (select id from public.assessments where code in ('TER-01-MOON', 'TER-01-MARS', 'TER-02-MOON', 'TER-02-MARS', 'TER-03-MOON', 'TER-03-MARS', 'TER-04-MOON', 'TER-04-MARS', 'TER-05-MOON', 'TER-05-MARS', 'TER-06-MOON', 'TER-06-MARS', 'TER-07-MOON', 'TER-07-MARS', 'TER-08-MOON', 'TER-08-MARS'));
delete from public.assessment_applications where assessment_id in (select id from public.assessments where code in ('TER-01-MOON', 'TER-01-MARS', 'TER-02-MOON', 'TER-02-MARS', 'TER-03-MOON', 'TER-03-MARS', 'TER-04-MOON', 'TER-04-MARS', 'TER-05-MOON', 'TER-05-MARS', 'TER-06-MOON', 'TER-06-MARS', 'TER-07-MOON', 'TER-07-MARS', 'TER-08-MOON', 'TER-08-MARS'));
delete from public.assessment_sources where assessment_id in (select id from public.assessments where code in ('TER-01-MOON', 'TER-01-MARS', 'TER-02-MOON', 'TER-02-MARS', 'TER-03-MOON', 'TER-03-MARS', 'TER-04-MOON', 'TER-04-MARS', 'TER-05-MOON', 'TER-05-MARS', 'TER-06-MOON', 'TER-06-MARS', 'TER-07-MOON', 'TER-07-MARS', 'TER-08-MOON', 'TER-08-MARS'));

insert into public.assessment_categories (assessment_id, category_id, score, label_reported, comparison, utility, note)
select a.id, v.category_id, v.score, v.label_reported, v.comparison, v.utility, v.note
from (values
  ('TER-01-MOON', 'topography', 43.3::numeric, 'Topografía y geomorfología', null, 'Ensayos de movilidad robótica, navegación autónoma y reconocimiento geomorfológico.', null),
  ('TER-01-MOON', 'thermal', 24::numeric, 'Condiciones térmicas y ambientales', null, 'Pruebas ambientales parciales de equipos, sensores y sistemas ópticos.', null),
  ('TER-01-MOON', 'geology', 39.2::numeric, 'Geología y mineralogía', null, 'Reconocimiento de rocas, análisis de materiales y pruebas de instrumentos.', null),
  ('TER-01-MOON', 'water', 21.7::numeric, 'Agua, hielo y recursos', null, 'Pruebas preliminares de reconocimiento de recursos y análisis de materiales.', null),
  ('TER-01-MOON', 'atmosphere', 28::numeric, 'Atmósfera, polvo y dinámica superficial', null, 'Evaluación de interacción entre equipos y partículas.', null),
  ('TER-01-MOON', 'subsurface', 38::numeric, 'Subsuelo y estructuras naturales', null, 'Exploración robótica de cavidades y reconocimiento de estructuras.', null),
  ('TER-01-MOON', 'biology', null::numeric, 'Biología y habitabilidad', null, null, null),
  ('TER-01-MARS', 'topography', 67.5::numeric, 'Topografía y geomorfología', null, 'Movilidad de rovers, navegación autónoma y reconocimiento geomorfológico.', null),
  ('TER-01-MARS', 'thermal', 58.2::numeric, 'Condiciones térmicas y ambientales', null, 'Pruebas parciales de sensores, materiales y equipos expuestos a condiciones ambientales exigentes.', null),
  ('TER-01-MARS', 'geology', 78.4::numeric, 'Geología y mineralogía', null, 'Investigación mineralógica, geoquímica y pruebas de instrumentos científicos.', null),
  ('TER-01-MARS', 'water', 62::numeric, 'Agua, hielo y recursos', null, 'Investigación de minerales hidratados y técnicas de reconocimiento de recursos.', null),
  ('TER-01-MARS', 'atmosphere', 71.3::numeric, 'Atmósfera, polvo y dinámica eólica', null, 'Estudios de sedimentos, erosión y protección de equipos frente al polvo.', null),
  ('TER-01-MARS', 'subsurface', 69::numeric, 'Subsuelo y estructuras naturales', null, 'Pruebas de sensores de subsuelo, análisis estratigráfico y exploración robótica.', null),
  ('TER-01-MARS', 'biology', 72.5::numeric, 'Biología y habitabilidad', null, 'Investigación astrobiológica y desarrollo de métodos de detección de biofirmas.', 'La investigación astrobiológica utiliza modelos de vida terrestre; no presupone la existencia de organismos marcianos.'),
  ('TER-02-MOON', 'topography', 76::numeric, 'Topography and Geomorphology', null, 'Testing rover mobility, autonomous navigation, obstacle detection, and route planning.', null),
  ('TER-02-MOON', 'thermal', 30::numeric, 'Thermal and Environmental Conditions', null, 'Preliminary environmental testing of sensors and equipment.', null),
  ('TER-02-MOON', 'geology', 87::numeric, 'Geology and Mineralogy', null, 'Mineralogical characterization, geological mapping, and testing planetary instruments.', null),
  ('TER-02-MOON', 'water', 24::numeric, 'Water, Ice and Resources', null, 'Mineral resource assessment and preliminary testing of basalt processing.', null),
  ('TER-02-MOON', 'atmosphere', 22::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Preliminary dust-protection and particle-interaction testing.', null),
  ('TER-02-MOON', 'subsurface', 91::numeric, 'Subsurface and Natural Structures', null, 'Underground robotic exploration, structural mapping, and preliminary habitat-site research.', null),
  ('TER-02-MOON', 'biology', null::numeric, 'Biology and Habitability', null, 'Terrestrial contamination-control research and the study of operational requirements for human exploration.', null),
  ('TER-02-MARS', 'topography', 82::numeric, 'Topography and Geomorphology', null, 'Rover mobility, terrain mapping, volcanic landform identification, and autonomous navigation.', null),
  ('TER-02-MARS', 'thermal', 44::numeric, 'Thermal and Environmental Conditions', null, 'Preliminary environmental instrument testing and thermal-response evaluation.', null),
  ('TER-02-MARS', 'geology', 85::numeric, 'Geology and Mineralogy', null, 'Geological sampling, mineral identification, spectral analysis, and volcanic mapping.', null),
  ('TER-02-MARS', 'water', 35::numeric, 'Water, Ice and Resources', null, 'Mineral analysis, subsurface reconnaissance, and resource-detection method development.', null),
  ('TER-02-MARS', 'atmosphere', 49::numeric, 'Atmosphere, Dust and Aeolian Dynamics', null, 'Dust-sensor testing, particle exposure studies, and environmental monitoring.', null),
  ('TER-02-MARS', 'subsurface', 87::numeric, 'Subsurface and Natural Structures', null, 'Underground robotic exploration, geological imaging, and structural reconnaissance.', null),
  ('TER-02-MARS', 'biology', 61::numeric, 'Biology and Habitability', null, 'Astrobiology, biosignature detection, microbial survival research, and planetary protection.', null),
  ('TER-03-MOON', 'topography', 66::numeric, 'Topography and Geomorphology', null, 'Rover mobility, surface hazard recognition, terrain classification, and volcanic geological mapping.', null),
  ('TER-03-MOON', 'thermal', 32::numeric, 'Thermal and Environmental Conditions', null, 'Preliminary thermal testing, illumination studies, and optical navigation.', null),
  ('TER-03-MOON', 'geology', 74::numeric, 'Geology and Mineralogy', null, 'Basalt identification, spectral instrument testing, geological mapping, and sampling experiments.', null),
  ('TER-03-MOON', 'water', 43::numeric, 'Water, Ice and Resources', null, 'Ice-detection technology, frozen-ground mobility, and volcanic resource studies.', null),
  ('TER-03-MOON', 'atmosphere', 25::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Abrasion testing, particle-handling research, and dust-protection development.', null),
  ('TER-03-MOON', 'subsurface', 87::numeric, 'Subsurface and Natural Structures', null, 'Underground robotic navigation, cave mapping, structural reconnaissance, and subsurface imaging.', null),
  ('TER-03-MOON', 'biology', null::numeric, 'Biology and Habitability', null, 'Biological detection technology and planetary-protection research.', null),
  ('TER-03-MARS', 'topography', 80::numeric, 'Topography and Geomorphology', null, 'Rover mobility, geological mapping, terrain recognition, and exploration hazard assessment.', null),
  ('TER-03-MARS', 'thermal', 69::numeric, 'Thermal and Environmental Conditions', null, 'Cold-weather equipment testing, seasonal environmental monitoring, and optical navigation.', null),
  ('TER-03-MARS', 'geology', 88::numeric, 'Geology and Mineralogy', null, 'Mineralogical analysis, volcanic geology, spectral instrument testing, and investigation of water-related alteration.', null),
  ('TER-03-MARS', 'water', 77::numeric, 'Water, Ice and Resources', null, 'Ice detection, frozen-ground exploration, geological water-history interpretation, and resource reconnaissance.', null),
  ('TER-03-MARS', 'atmosphere', 83::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Dust-sensor testing, sediment-transport research, abrasion studies, and environmental monitoring.', null),
  ('TER-03-MARS', 'subsurface', 88::numeric, 'Subsurface and Natural Structures', null, 'Underground robotic exploration, lava-tube mapping, geological imaging, and structural reconnaissance.', null),
  ('TER-03-MARS', 'biology', 79::numeric, 'Biology and Habitability', null, 'Astrobiology, extremophile research, biosignature detection, and planetary protection.', null),
  ('TER-04-MOON', 'topography', 54::numeric, 'Topography and Geomorphology', null, 'Rover mobility, obstacle detection, slope navigation, and terrain mapping.', null),
  ('TER-04-MOON', 'thermal', 46::numeric, 'Thermal and Environmental Conditions', null, 'Cold-weather equipment testing, polar illumination studies, and environmental monitoring.', null),
  ('TER-04-MOON', 'geology', 35::numeric, 'Geology and Mineralogy', null, 'Rock identification, geological classification, and sampling-system evaluation.', null),
  ('TER-04-MOON', 'water', 61::numeric, 'Water, Ice and Resources', null, 'Ice detection, frozen-ground sampling, and polar subsurface reconnaissance.', null),
  ('TER-04-MOON', 'atmosphere', 29::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Abrasion testing, particle handling, and dust-resistant equipment evaluation.', null),
  ('TER-04-MOON', 'subsurface', 47::numeric, 'Subsurface and Natural Structures', null, 'Subsurface imaging, fracture recognition, and frozen-ground reconnaissance.', null),
  ('TER-04-MOON', 'biology', null::numeric, 'Biology and Habitability', null, 'Biological instrument validation and contamination-control studies.', null),
  ('TER-04-MARS', 'topography', 76::numeric, 'Topography and Geomorphology', null, 'Rover mobility, polar terrain classification, hazard detection, and geological mapping.', null),
  ('TER-04-MARS', 'thermal', 79::numeric, 'Thermal and Environmental Conditions', null, 'Cold-environment instrumentation, seasonal monitoring, and polar robotic operations.', null),
  ('TER-04-MARS', 'geology', 76::numeric, 'Geology and Mineralogy', null, 'Geochemical analysis, salt detection, sediment characterization, and preservation studies.', null),
  ('TER-04-MARS', 'water', 91::numeric, 'Water, Ice and Resources', null, 'Subsurface ice detection, frozen-ground exploration, cryogeological mapping, and reconstruction of ancient aqueous processes.', null),
  ('TER-04-MARS', 'atmosphere', 87::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Dust monitoring, sediment transport, wind erosion studies, and equipment abrasion testing.', null),
  ('TER-04-MARS', 'subsurface', 76::numeric, 'Subsurface and Natural Structures', null, 'Subsurface imaging, ice-rich stratigraphy, fracture mapping, and robotic reconnaissance.', null),
  ('TER-04-MARS', 'biology', 92::numeric, 'Biology and Habitability', null, 'Astrobiology, extremophile research, biosignature preservation, and planetary protection.', null),
  ('TER-05-MOON', 'topography', 88::numeric, 'Topography and Geomorphology', null, 'Impact-crater mapping, rover mobility, geological sampling, and interpretation of impact-generated landforms.', null),
  ('TER-05-MOON', 'thermal', 43::numeric, 'Thermal and Environmental Conditions', null, 'Cold-weather equipment evaluation and polar field-operation planning.', null),
  ('TER-05-MOON', 'geology', 67::numeric, 'Geology and Mineralogy', null, 'Impact-petrology analysis, mineral identification, and geological mapping.', null),
  ('TER-05-MOON', 'water', 48::numeric, 'Water, Ice and Resources', null, 'Frozen-ground sampling and ice-detection instrumentation.', null),
  ('TER-05-MOON', 'atmosphere', 25::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Particle handling, abrasion testing, and geological sediment classification.', null),
  ('TER-05-MOON', 'subsurface', 77::numeric, 'Subsurface and Natural Structures', null, 'Subsurface imaging, fracture mapping, and impact-stratigraphy interpretation.', null),
  ('TER-05-MOON', 'biology', null::numeric, 'Biology and Habitability', null, 'Contamination control and biological instrument validation.', null),
  ('TER-05-MARS', 'topography', 91::numeric, 'Topography and Geomorphology', null, 'Martian crater mapping, rover navigation, impact-geology studies, and exploration hazard assessment.', null),
  ('TER-05-MARS', 'thermal', 77::numeric, 'Thermal and Environmental Conditions', null, 'Thermal instrument testing, polar mission planning, and long-duration environmental monitoring.', null),
  ('TER-05-MARS', 'geology', 72::numeric, 'Geology and Mineralogy', null, 'Impact-petrology research, mineral identification, geological mapping, and sample analysis.', null),
  ('TER-05-MARS', 'water', 86::numeric, 'Water, Ice and Resources', null, 'Ice detection, frozen-ground sampling, cryogeological mapping, and reconstruction of water-related processes.', null),
  ('TER-05-MARS', 'atmosphere', 70::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Dust monitoring, sediment-transport studies, and abrasion testing.', null),
  ('TER-05-MARS', 'subsurface', 85::numeric, 'Subsurface and Natural Structures', null, 'Subsurface radar, fracture detection, geological reconstruction, and ice-bearing ground reconnaissance.', null),
  ('TER-05-MARS', 'biology', 83::numeric, 'Biology and Habitability', null, 'Biosignature detection, extremophile research, microbial preservation studies, and planetary protection.', null),
  ('TER-06-MOON', 'topography', 55::numeric, 'Topography and Geomorphology', null, 'Rover route planning, terrain segmentation, and obstacle detection.', null),
  ('TER-06-MOON', 'thermal', 32::numeric, 'Thermal and Environmental Conditions', null, 'Environmental sensor testing and preliminary thermal monitoring.', null),
  ('TER-06-MOON', 'geology', 24::numeric, 'Geology and Mineralogy', null, 'Testing mineral identification and differentiating terrestrial sedimentary signals from lunar geological signatures.', null),
  ('TER-06-MOON', 'water', 23::numeric, 'Water, Ice and Resources', null, 'Hydrated-mineral sensing and identification of analog limitations.', null),
  ('TER-06-MOON', 'atmosphere', 18::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Mechanical dust testing and differentiation of terrestrial and lunar sediment processes.', null),
  ('TER-06-MOON', 'subsurface', 29::numeric, 'Subsurface and Natural Structures', null, 'Shallow fracture mapping and radar-based layer detection.', null),
  ('TER-06-MOON', 'biology', null::numeric, 'Biology and Habitability', null, 'Biological contamination monitoring and instrument validation.', null),
  ('TER-06-MARS', 'topography', 84::numeric, 'Topography and Geomorphology', null, 'Yardang identification, terrain mapping, rover navigation, and reconstruction of wind-eroded sedimentary landscapes.', null),
  ('TER-06-MARS', 'thermal', 61::numeric, 'Thermal and Environmental Conditions', null, 'Thermal monitoring, environmental instrumentation, and desert field testing.', null),
  ('TER-06-MARS', 'geology', 88::numeric, 'Geology and Mineralogy', null, 'Mineral spectroscopy, sedimentological interpretation, evaporite mapping, and paleolake reconstruction.', null),
  ('TER-06-MARS', 'water', 78::numeric, 'Water, Ice and Resources', null, 'Paleohydrology, hydrated-mineral detection, and sedimentary resource assessment.', null),
  ('TER-06-MARS', 'atmosphere', 91::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Yardang mapping, erosion analysis, dust monitoring, and sediment-transport research.', null),
  ('TER-06-MARS', 'subsurface', 75::numeric, 'Subsurface and Natural Structures', null, 'Subsurface stratigraphy, radar interpretation, and reconstruction of sedimentary environments.', null),
  ('TER-06-MARS', 'biology', 85::numeric, 'Biology and Habitability', null, 'Astrobiological sampling, biosignature preservation studies, and planetary protection.', null),
  ('TER-07-MOON', 'topography', 57::numeric, 'Topography and Geomorphology', null, 'Terrain classification, rover mobility, volcanic mapping, and geological hazard detection.', null),
  ('TER-07-MOON', 'thermal', 20::numeric, 'Thermal and Environmental Conditions', null, 'Thermal instrumentation and high-temperature equipment testing.', null),
  ('TER-07-MOON', 'geology', 63::numeric, 'Geology and Mineralogy', null, 'Basalt recognition, volcanic geology, mineral spectroscopy, and sample analysis.', null),
  ('TER-07-MOON', 'water', 23::numeric, 'Water, Ice and Resources', null, 'Resource characterization and identification of unsuitable lunar volatile analogs.', null),
  ('TER-07-MOON', 'atmosphere', 12::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Particle characterization and dust-related instrument testing.', null),
  ('TER-07-MOON', 'subsurface', 70::numeric, 'Subsurface and Natural Structures', null, 'Fracture mapping, subsurface imaging, and volcanic-cavity investigation.', null),
  ('TER-07-MOON', 'biology', null::numeric, 'Biology and Habitability', null, 'Contamination control and biological instrument validation.', null),
  ('TER-07-MARS', 'topography', 68::numeric, 'Topography and Geomorphology', null, 'Rover navigation, volcanic terrain mapping, and geological hazard assessment.', null),
  ('TER-07-MARS', 'thermal', 26::numeric, 'Thermal and Environmental Conditions', null, 'Thermal instrumentation, material durability, and environmental sensor testing.', null),
  ('TER-07-MARS', 'geology', 84::numeric, 'Geology and Mineralogy', null, 'Mineral spectroscopy, hydrothermal alteration research, and geological sample characterization.', null),
  ('TER-07-MARS', 'water', 56::numeric, 'Water, Ice and Resources', null, 'Brine chemistry, evaporite mineralogy, and reconstruction of water-related geological processes.', null),
  ('TER-07-MARS', 'atmosphere', 37::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Dust monitoring, aerosol characterization, and sediment analysis.', null),
  ('TER-07-MARS', 'subsurface', 76::numeric, 'Subsurface and Natural Structures', null, 'Subsurface radar, fracture mapping, and volcanic geological reconnaissance.', null),
  ('TER-07-MARS', 'biology', 79::numeric, 'Biology and Habitability', null, 'Habitability-limit research, astrobiological instrument testing, and biosignature interpretation.', null),
  ('TER-08-MOON', 'topography', 66::numeric, 'Topography and Geomorphology', null, 'Terrain mapping, rover mobility testing, slope analysis, and rocky obstacle recognition.', null),
  ('TER-08-MOON', 'thermal', 29::numeric, 'Thermal and Environmental Conditions', null, 'Thermal monitoring, solar exposure analysis, and defining environmental simulation requirements.', null),
  ('TER-08-MOON', 'geology', 94::numeric, 'Geology and Mineralogy', null, 'Lunar highland mineral identification, spectral calibration, petrological comparison, igneous differentiation research, and geological sampling.', null),
  ('TER-08-MOON', 'water', 22::numeric, 'Water, Ice and Resources', null, 'Mineral-resource mapping, aluminum-bearing material identification, and evaluating the limits of terrestrial volatile analogs.', null),
  ('TER-08-MOON', 'atmosphere', 19::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Particle characterization, geological sampling, and recognition of nonrepresentative terrestrial surface processes.', null),
  ('TER-08-MOON', 'subsurface', 61::numeric, 'Subsurface and Natural Structures', null, 'Subsurface imaging, fracture detection, geological-layer mapping, and bedrock stability analysis.', null),
  ('TER-08-MOON', 'biology', null::numeric, 'Biology and Habitability', null, 'Biological contamination control and mineralogical sample integrity.', null),
  ('TER-08-MARS', 'topography', 58::numeric, 'Topography and Geomorphology', null, 'Rover mobility, slope analysis, geological mapping, and obstacle detection.', null),
  ('TER-08-MARS', 'thermal', 36::numeric, 'Thermal and Environmental Conditions', null, 'Thermal instrumentation, cold-weather equipment evaluation, and environmental monitoring.', null),
  ('TER-08-MARS', 'geology', 65::numeric, 'Geology and Mineralogy', null, 'Igneous rock classification, mineral spectroscopy, petrological research, and geological sampling.', null),
  ('TER-08-MARS', 'water', 29::numeric, 'Water, Ice and Resources', null, 'Mineral-resource mapping, hydrated-mineral discrimination, and evaluating water-related analog limitations.', null),
  ('TER-08-MARS', 'atmosphere', 25::numeric, 'Atmosphere, Dust and Surface Dynamics', null, 'Environmental instrumentation, limited sediment analysis, and identifying atmospheric simulation requirements.', null),
  ('TER-08-MARS', 'subsurface', 53::numeric, 'Subsurface and Natural Structures', null, 'Subsurface imaging, fracture mapping, and geological stratigraphy.', null),
  ('TER-08-MARS', 'biology', 12::numeric, 'Biology and Habitability', null, 'Contamination control and distinguishing terrestrial biological signals from geological measurements.', null)
) as v (code, category_id, score, label_reported, comparison, utility, note)
join public.assessments a on a.code = v.code;

insert into public.assessment_variables (assessment_id, variable_id, score, label_reported, explanation, utility)
select a.id, v.variable_id, v.score, v.label_reported, v.explanation, v.utility
from (values
  ('TER-01-MOON', 'topography.elevation', 38::numeric, 'Elevación', 'Los terrenos de Atacama alcanzan aproximadamente entre 2,000 y 4,500 metros en los sectores considerados. La Luna presenta elevaciones y depresiones medidas respecto de un sistema de referencia diferente. La analogía se relaciona principalmente con la presencia de terrenos elevados y desniveles, no con la equivalencia directa de altitudes.', 'estudiar operaciones robóticas en terrenos de distinta altitud.'),
  ('TER-01-MOON', 'topography.slope', 62::numeric, 'Pendiente', 'Las planicies aluviales y salares pueden presentar pendientes suaves, mientras que algunas laderas montañosas superan los 30°. Esta variedad permite representar determinados desafíos de desplazamiento sobre superficies inclinadas.', 'probar ascenso, descenso, estabilidad y tracción de rovers.'),
  ('TER-01-MOON', 'topography.roughness', 58::numeric, 'Rugosidad', 'Las costras salinas fracturadas, superficies pedregosas y acumulaciones de fragmentos producen irregularidades que pueden dificultar el movimiento de vehículos.', 'evaluar suspensión, ruedas, tracción y detección de irregularidades.'),
  ('TER-01-MOON', 'topography.relief', 35::numeric, 'Relieve', 'Atacama contiene pampas, abanicos aluviales, cuencas y cordones montañosos. Estas formas no reproducen directamente la diversidad del relieve lunar, donde destacan cráteres de impacto y otras estructuras.', 'desarrollar reconocimiento del terreno y planificación de rutas.'),
  ('TER-01-MOON', 'topography.craters', 12::numeric, 'Cráteres', 'Los cráteres de impacto no constituyen una característica dominante de Atacama. Algunas depresiones salinas o estructuras volcánicas pueden parecerse visualmente a cráteres, pero tienen orígenes distintos.', 'identificar las limitaciones de las simulaciones de terrenos lunares.'),
  ('TER-01-MOON', 'topography.obstacles', 55::numeric, 'Obstáculos superficiales', 'Los bloques rocosos, grietas y costras fracturadas representan obstáculos relevantes para vehículos de exploración.', 'probar detección de obstáculos, evasión y navegación autónoma.'),
  ('TER-01-MOON', 'thermal.surface_temperature', 28::numeric, 'Temperatura superficial', 'En sectores expuestos del desierto, las superficies pueden calentarse intensamente durante el día y enfriarse por la noche. La Luna presenta un régimen térmico mucho más extremo debido a la ausencia de una atmósfera significativa y a sus largos ciclos de iluminación.', 'evaluar parcialmente sensores térmicos.'),
  ('TER-01-MOON', 'thermal.temperature_extremes', 18::numeric, 'Temperaturas máximas y mínimas', 'La investigación terrestre identifica máximas superficiales elevadas y mínimas bajo cero en determinados sectores. Los extremos lunares son mucho más amplios.', 'determinar qué condiciones requieren simuladores térmicos especializados.'),
  ('TER-01-MOON', 'thermal.thermal_variation', 22::numeric, 'Variación térmica', 'La aridez y la baja nubosidad favorecen cambios importantes entre el día y la noche en Atacama. Sin embargo, los ciclos lunares tienen una duración y amplitud distintas.', 'realizar ensayos preliminares de resistencia a variaciones de temperatura.'),
  ('TER-01-MOON', 'thermal.solar_illumination', 32::numeric, 'Iluminación solar', 'Los cielos despejados de Atacama favorecen una elevada exposición solar. La distribución de luz y sombra en la Luna depende de su relieve y de su ciclo de iluminación.', 'probar cámaras, sensores ópticos y sistemas de captación solar.'),
  ('TER-01-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Presión atmosférica y vacío', 'Atacama posee una atmósfera terrestre, mientras que la Luna presenta condiciones próximas al vacío.', 'identificar la necesidad de cámaras de vacío para ensayos ambientales lunares.'),
  ('TER-01-MOON', 'geology.rock_type', 40::numeric, 'Tipo de roca', 'En Atacama se encuentran ignimbritas, andesitas, basaltos y materiales sedimentarios evaporíticos. La Luna presenta principalmente materiales ígneos y depósitos modificados por impactos.', 'ensayar identificación y clasificación de rocas.'),
  ('TER-01-MOON', 'geology.mineral_composition', 35::numeric, 'Composición mineralógica', 'Atacama contiene silicatos, cuarzo, plagioclasas, arcillas y minerales salinos. Existen algunas familias minerales relacionadas con las lunares, pero las asociaciones y abundancias son diferentes.', 'probar instrumentos de reconocimiento mineralógico.'),
  ('TER-01-MOON', 'geology.chemical_composition', 32::numeric, 'Composición química', 'Los materiales terrestres presentan compuestos asociados con agua, oxidación y procesos atmosféricos. La química de los materiales lunares refleja una historia geológica distinta.', 'realizar ensayos preliminares de análisis geoquímico.'),
  ('TER-01-MOON', 'geology.surface_material', 52::numeric, 'Material superficial', 'Las arenas, pavimentos desérticos y fragmentos rocosos permiten estudiar el comportamiento de equipos sobre terrenos granulares. No reproducen completamente el regolito lunar.', 'probar movilidad, excavación y contacto mecánico con el terreno.'),
  ('TER-01-MOON', 'geology.alteration', 20::numeric, 'Alteración geológica', 'Atacama presenta meteorización física, química y eólica. En la Luna predominan procesos asociados con impactos e intemperismo espacial.', 'comparar procesos de modificación superficial y sus efectos sobre los materiales.'),
  ('TER-01-MOON', 'geology.formations', 56::numeric, 'Formaciones geológicas', 'Los edificios volcánicos, coladas y estructuras rocosas de Atacama permiten realizar determinados estudios comparativos con terrenos volcánicos lunares.', 'ensayar reconocimiento de estructuras volcánicas.'),
  ('TER-01-MOON', 'water.surface_water', 15::numeric, 'Agua superficial', 'El núcleo hiperárido de Atacama presenta muy poca agua superficial, aunque existen salares, acuíferos y otros ambientes con agua en la región.', 'estudiar operaciones en terrenos secos.'),
  ('TER-01-MOON', 'water.surface_ice', 25::numeric, 'Hielo superficial', 'El hielo de alta montaña terrestre se encuentra bajo condiciones atmosféricas y térmicas diferentes de las de los depósitos lunares.', 'ensayar técnicas de reconocimiento de hielo.'),
  ('TER-01-MOON', 'water.subsurface_ice', 20::numeric, 'Hielo subterráneo', 'La investigación disponible no establece una correspondencia directa entre los materiales subterráneos de Atacama y los posibles depósitos lunares.', 'evaluar métodos de detección subsuperficial.'),
  ('TER-01-MOON', 'water.permafrost', 25::numeric, 'Permafrost', 'En sectores andinos de gran altitud pueden existir terrenos permanentemente congelados. Su comportamiento difiere de las condiciones criogénicas lunares.', 'realizar pruebas parciales en suelos fríos.'),
  ('TER-01-MOON', 'water.hydrogen', 15::numeric, 'Hidrógeno', 'Algunos minerales terrestres contienen hidrógeno asociado con agua o grupos hidroxilo. Esto no implica equivalencia con las señales de hidrógeno detectadas en la Luna.', 'desarrollar conceptos de reconocimiento de materiales hidratados.'),
  ('TER-01-MOON', 'water.mineral_resources', 30::numeric, 'Recursos minerales', 'Atacama presenta depósitos de litio, nitratos, boratos y otras sales. Los recursos lunares prioritarios y sus métodos de aprovechamiento son diferentes.', 'ensayar clasificación mineral y procedimientos de prospección.'),
  ('TER-01-MOON', 'atmosphere.wind', 0::numeric, 'Viento', 'El viento transporta partículas en Atacama. La Luna no presenta circulación atmosférica equivalente.', 'distinguir los procesos de transporte superficial.'),
  ('TER-01-MOON', 'atmosphere.dust', 55::numeric, 'Polvo abrasivo', 'Los materiales finos y fragmentados de Atacama pueden provocar desgaste mecánico en equipos. El polvo lunar presenta propiedades físicas diferentes.', 'probar medidas preliminares de protección contra partículas.'),
  ('TER-01-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Erosión eólica', 'La erosión por viento modifica las superficies terrestres, pero no constituye un proceso equivalente en la Luna.', 'identificar diferencias geomorfológicas.'),
  ('TER-01-MOON', 'atmosphere.sediments', 35::numeric, 'Sedimentos y dunas', 'Los depósitos granulares de Atacama pueden utilizarse para ensayos mecánicos, aunque su transporte y acumulación ocurren mediante procesos distintos de los lunares.', 'estudiar movilidad y comportamiento de materiales granulares.'),
  ('TER-01-MOON', 'subsurface.caves', 65::numeric, 'Cuevas y tubos de lava', 'La investigación terrestre identifica cavidades salinas y posibles estructuras volcánicas en determinados sectores. Las cavidades lunares presentan condiciones ambientales y geológicas distintas.', 'probar robots, sensores y navegación en espacios confinados.'),
  ('TER-01-MOON', 'subsurface.fractures', 45::numeric, 'Fracturas tectónicas', 'Las fallas y fracturas de Atacama ofrecen oportunidades para ensayar reconocimiento de discontinuidades del terreno.', 'desarrollar técnicas de cartografía estructural.'),
  ('TER-01-MOON', 'subsurface.subsurface_structure', 22::numeric, 'Estructura estratigráfica', 'Las secuencias terrestres contienen depósitos sedimentarios y volcánicos. Los estratos lunares responden a procesos diferentes.', 'probar técnicas de análisis de capas geológicas.'),
  ('TER-01-MOON', 'subsurface.material_thickness', 20::numeric, 'Espesor de regolito', 'Los espesores y propiedades de los materiales superficiales terrestres difieren de los del regolito lunar.', 'evaluar procedimientos de sondeo y exploración superficial.'),
  ('TER-01-MOON', 'biology.direct_similarity', null::numeric, 'Similitud biológica directa', 'La existencia de microorganismos en Atacama no implica una correspondencia con organismos lunares.', 'delimitar las aplicaciones biológicas y estudiar requisitos ambientales de futuras operaciones.'),
  ('TER-01-MARS', 'topography.elevation', 45::numeric, 'Elevación', 'Atacama presenta terrenos elevados y diferencias altitudinales importantes. Marte también posee una gran diversidad topográfica, aunque sus elevaciones se miden respecto de un sistema de referencia planetario diferente.', 'evaluar operaciones en terrenos de diferentes altitudes y desniveles.'),
  ('TER-01-MARS', 'topography.slope', 78::numeric, 'Pendiente', 'Las laderas, abanicos aluviales y superficies inclinadas del desierto permiten estudiar desafíos relacionados con la estabilidad de vehículos.', 'probar ascenso, descenso, tracción y estabilidad de rovers.'),
  ('TER-01-MARS', 'topography.roughness', 82::numeric, 'Rugosidad', 'Las superficies pedregosas, costras fracturadas y depósitos de fragmentos ofrecen obstáculos que pueden utilizarse en ensayos de movilidad.', 'evaluar suspensión, ruedas y navegación autónoma.'),
  ('TER-01-MARS', 'topography.relief', 75::numeric, 'Relieve', 'Atacama presenta cuencas, planicies, terrenos volcánicos y formaciones sedimentarias. Algunas características permiten estudiar procesos geomorfológicos relevantes para Marte.', 'reconocimiento de terrenos y planificación de rutas.'),
  ('TER-01-MARS', 'topography.craters', 35::numeric, 'Cráteres', 'La distribución de cráteres de impacto en Marte es mucho más significativa que en Atacama. Algunas depresiones terrestres presentan formas similares, pero orígenes diferentes.', 'identificar las limitaciones de los ensayos de reconocimiento de cráteres.'),
  ('TER-01-MARS', 'topography.obstacles', 80::numeric, 'Obstáculos superficiales', 'Los bloques rocosos, grietas y depósitos fragmentados permiten representar dificultades operativas que podrían enfrentar vehículos exploradores.', 'probar detección de obstáculos, evasión y prevención de atascamientos.'),
  ('TER-01-MARS', 'thermal.surface_temperature', 55::numeric, 'Temperatura superficial', 'Las superficies de Atacama pueden alcanzar temperaturas elevadas durante el día y descender considerablemente por la noche. Marte registra temperaturas generalmente más bajas.', 'realizar pruebas de sensores térmicos.'),
  ('TER-01-MARS', 'thermal.temperature_extremes', 48::numeric, 'Temperaturas máximas y mínimas', 'Los extremos térmicos de Marte y Atacama difieren en amplitud y distribución regional.', 'estudiar necesidades de protección térmica.'),
  ('TER-01-MARS', 'thermal.thermal_variation', 72::numeric, 'Variación térmica', 'Los cambios diarios de temperatura en ambientes desérticos permiten investigar parcialmente los efectos de ciclos térmicos sobre materiales e instrumentos.', 'ensayar equipos sometidos a calentamiento y enfriamiento.'),
  ('TER-01-MARS', 'thermal.solar_illumination', 82::numeric, 'Insolación y radiación UV', 'La elevada exposición solar de Atacama permite estudiar determinados efectos de la radiación ultravioleta. No reproduce toda la radiación espacial presente en Marte.', 'probar sensores ópticos y materiales expuestos al sol.'),
  ('TER-01-MARS', 'thermal.atmospheric_conditions', 34::numeric, 'Presión atmosférica', 'Marte posee una atmósfera mucho menos densa que la terrestre. Atacama no reproduce directamente estas condiciones de baja presión.', 'determinar qué pruebas requieren cámaras de simulación atmosférica.'),
  ('TER-01-MARS', 'geology.rock_type', 84::numeric, 'Tipo de roca', 'En Atacama se encuentran ignimbritas, andesitas, basaltos y depósitos sedimentarios. Marte también presenta rocas volcánicas y sedimentarias, aunque sus asociaciones geológicas varían regionalmente.', 'probar identificación y clasificación litológica.'),
  ('TER-01-MARS', 'geology.mineral_composition', 82::numeric, 'Composición mineralógica', 'Atacama contiene silicatos, arcillas y depósitos salinos que permiten estudiar determinados materiales de interés para la geología marciana.', 'ensayar espectrometría y reconocimiento mineralógico.'),
  ('TER-01-MARS', 'geology.chemical_composition', 92::numeric, 'Química de percloratos y sulfatos', 'La investigación de Atacama identifica compuestos salinos y oxidados de interés para estudiar procesos geoquímicos relacionados con Marte. Las concentraciones y condiciones de formación deben analizarse por separado.', 'desarrollar pruebas de análisis químico y detección de compuestos.'),
  ('TER-01-MARS', 'geology.surface_material', 80::numeric, 'Material superficial', 'Los pavimentos desérticos, arenas, costras y fragmentos rocosos permiten realizar ensayos sobre terrenos secos y granulares.', 'probar movilidad, excavación y análisis de muestras.'),
  ('TER-01-MARS', 'geology.alteration', 85::numeric, 'Meteorización química hiperárida', 'La escasez de agua favorece determinados procesos de alteración lenta y conservación de materiales. Esto permite investigar fenómenos relacionados con ambientes secos.', 'estudiar evolución geoquímica y modificación de superficies.'),
  ('TER-01-MARS', 'geology.formations', 88::numeric, 'Abanicos aluviales y paleolagos', 'Las formaciones sedimentarias terrestres pueden servir para estudiar la interpretación de depósitos asociados con agua antigua en Marte.', 'reconstruir ambientes sedimentarios y analizar estratigrafía.'),
  ('TER-01-MARS', 'water.surface_water', 94::numeric, 'Sequedad y ausencia de agua libre', 'En el núcleo hiperárido de Atacama existe una disponibilidad extremadamente baja de agua superficial. Esta característica permite estudiar determinados efectos de la escasez de agua.', 'investigar desecación, conservación de materiales y operaciones en terrenos secos.'),
  ('TER-01-MARS', 'water.surface_ice', 45::numeric, 'Hielo superficial', 'Los depósitos de hielo terrestre de alta montaña presentan condiciones distintas de las del hielo marciano.', 'ensayar parcialmente técnicas de reconocimiento de hielo.'),
  ('TER-01-MARS', 'water.subsurface_ice', 52::numeric, 'Hielo subterráneo', 'Los materiales y ambientes fríos terrestres permiten plantear estudios sobre exploración subsuperficial, pero no representan directamente la distribución del hielo marciano.', 'evaluar métodos de prospección del subsuelo.'),
  ('TER-01-MARS', 'water.past_water', 70::numeric, 'Minerales hidratados y arcillas', 'Los minerales terrestres que contienen agua estructural o grupos hidroxilo permiten investigar procesos de hidratación y alteración.', 'probar detección espectral de minerales hidratados.'),
  ('TER-01-MARS', 'water.hydrogen', 51::numeric, 'Hidrógeno equivalente', 'Los materiales hidratados de Atacama permiten plantear estudios relacionados con señales de hidrógeno, aunque no existe equivalencia cuantitativa directa establecida.', 'desarrollar conceptos de reconocimiento de recursos.'),
  ('TER-01-MARS', 'water.mineral_resources', 80::numeric, 'Recursos de sales y salmueras', 'Los depósitos evaporíticos y salmueras de determinados sectores de Atacama ofrecen oportunidades para estudiar procesos relacionados con materiales salinos.', 'investigar depósitos de sales y métodos de análisis geoquímico.'),
  ('TER-01-MARS', 'atmosphere.wind', 82::numeric, 'Régimen eólico y vientos', 'El viento modifica superficies y transporta partículas en Atacama. Marte también presenta actividad eólica, aunque bajo una presión atmosférica mucho menor.', 'estudiar mecanismos de transporte y acumulación de sedimentos.'),
  ('TER-01-MARS', 'atmosphere.dust', 75::numeric, 'Partículas de polvo en suspensión', 'Los eventos de levantamiento de polvo permiten investigar problemas de visibilidad y exposición de equipos a partículas finas.', 'probar sensores y sistemas de protección frente al polvo.'),
  ('TER-01-MARS', 'atmosphere.aeolian_erosion', 86::numeric, 'Erosión eólica', 'En Atacama se observan superficies erosionadas por partículas transportadas por el viento. Marte presenta formas geomorfológicas asociadas con procesos eólicos.', 'interpretar paisajes y procesos de desgaste superficial.'),
  ('TER-01-MARS', 'atmosphere.dust_storms', 70::numeric, 'Tormentas de polvo locales', 'Los eventos terrestres de levantamiento de polvo permiten realizar ensayos operativos parciales. Las tormentas marcianas presentan condiciones físicas diferentes.', 'evaluar detección de polvo y funcionamiento de instrumentos.'),
  ('TER-01-MARS', 'atmosphere.sediments', 85::numeric, 'Dunas y sedimentos', 'Los campos de dunas y depósitos eólicos de Atacama ofrecen materiales y formas útiles para estudios comparativos.', 'analizar dunas y probar movilidad sobre arena.'),
  ('TER-01-MARS', 'subsurface.caves', 72::numeric, 'Cavidades y tubos', 'Determinados sectores volcánicos y salinos presentan cavidades que pueden utilizarse en estudios de exploración de espacios confinados.', 'probar robots, cámaras y sensores destinados a cavidades.'),
  ('TER-01-MARS', 'subsurface.fractures', 68::numeric, 'Fracturas tectónicas', 'Las fallas y fracturas terrestres permiten investigar técnicas de reconocimiento de discontinuidades geológicas.', 'desarrollar cartografía estructural y planificación de exploración.'),
  ('TER-01-MARS', 'subsurface.subsurface_structure', 67::numeric, 'Estratigrafía sedimentaria', 'Las secuencias de sedimentos terrestres permiten estudiar métodos de interpretación de capas y reconstrucción de ambientes antiguos.', 'analizar procesos de depósito y probar instrumentos estratigráficos.'),
  ('TER-01-MARS', 'biology.extremophiles', 85::numeric, 'Microorganismos extremófilos terrestres como modelo', 'Atacama alberga microorganismos adaptados a ambientes secos y salinos, incluidos organismos asociados con rocas y depósitos de sal.', 'investigar estrategias de supervivencia y probar métodos de detección de biomoléculas.'),
  ('TER-01-MARS', 'biology.habitability', 90::numeric, 'Límites de habitabilidad', 'Las condiciones de desecación, salinidad y exposición solar permiten investigar hasta qué punto determinados microorganismos terrestres pueden mantenerse activos o sobrevivir.', 'estudiar habitabilidad y resistencia microbiana.'),
  ('TER-01-MARS', 'biology.biosignatures', 88::numeric, 'Preservación de biofirmas en sales', 'Los depósitos salinos pueden proteger determinadas moléculas y señales relacionadas con actividad biológica terrestre.', 'estudiar conservación de biofirmas y métodos de identificación de señales biológicas.'),
  ('TER-02-MOON', 'topography.elevation', 48::numeric, 'Elevation', 'Mauna Kea reaches 4,207 m above terrestrial sea level, while lunar elevations are referenced to a lunar datum. The elevations are not directly equivalent, but the Hawaiian mountain provides an extensive vertical terrain profile.', 'Evaluating navigation and field operations across large elevation changes.'),
  ('TER-02-MOON', 'topography.slope', 78::numeric, 'Slope', 'Shield volcano summits can contain relatively gentle slopes, while caldera walls and other volcanic structures may be much steeper. Lunar maria also contain relatively level terrain, whereas crater walls can present challenging gradients.', 'Testing rover stability, traction, ascent, and descent.'),
  ('TER-02-MOON', 'topography.roughness', 92::numeric, 'Surface roughness', 'Angular ʻaʻā lava surfaces and fractured basaltic blocks create highly irregular terrain. Pāhoehoe surfaces provide contrasting, often smoother textures. Lunar surfaces also exhibit significant roughness, particularly around rocky impact deposits.', 'Evaluating wheel performance, suspension systems, and autonomous terrain classification.'),
  ('TER-02-MOON', 'topography.relief', 85::numeric, 'Relief', 'Hawaiian shield volcanoes, calderas, cinder cones, and volcanic depressions offer terrain forms relevant to lunar volcanic provinces. However, lunar large-scale relief is strongly influenced by impacts.', 'Testing geomorphological mapping and terrain interpretation.'),
  ('TER-02-MOON', 'topography.craters', 45::numeric, 'Craters', 'Hawaiian volcanic craters and collapse pits may resemble certain lunar depressions geometrically. They differ from impact craters in formation processes, surrounding deposits, and structural characteristics.', 'Training visual recognition systems while distinguishing volcanic and impact features.'),
  ('TER-02-MOON', 'topography.obstacles', 90::numeric, 'Surface obstacles', 'Fractured basaltic blocks, scoria, open fissures, and collapsed lava-tube roofs create significant surface hazards.', 'Testing obstacle avoidance, hazard detection, and safe rover traversal.'),
  ('TER-02-MOON', 'thermal.surface_temperature', 35::numeric, 'Surface temperature', 'The terrestrial dataset describes warm coastal conditions and freezing summit temperatures. These are primarily environmental or air-temperature descriptions rather than standardized measurements of ground-surface temperature. Lunar surface temperatures vary over a much wider range.', 'Preliminary assessment of temperature-sensitive equipment.'),
  ('TER-02-MOON', 'thermal.temperature_extremes', 22::numeric, 'Maximum and minimum temperatures', 'The supplied Hawaiian data describe coastal maxima near 32°C and summit minima around −8°C. Lunar extremes can exceed 120°C in illuminated regions and approach −247°C in exceptionally cold polar locations.', 'Identifying equipment requirements that cannot be tested under ordinary Hawaiian field conditions.'),
  ('TER-02-MOON', 'thermal.thermal_variation', 32::numeric, 'Thermal variation', 'The Hawaiian summit can experience substantial day–night temperature differences, but the lunar surface experiences a much longer illumination cycle and greater thermal amplitudes.', 'Testing preliminary responses to heating and cooling.'),
  ('TER-02-MOON', 'thermal.solar_illumination', 55::numeric, 'Solar illumination', 'High-altitude Hawaiian slopes can receive intense sunlight above cloud layers. Lunar illumination is controlled by a different day–night cycle and by local topography, particularly near the poles.', 'Testing solar-powered instruments and optical sensors.'),
  ('TER-02-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Atmospheric conditions / vacuum', 'Hawaii possesses a substantial terrestrial atmosphere, whereas the Moon has an extremely tenuous exosphere.', 'Establishing which equipment tests require laboratory vacuum chambers.'),
  ('TER-02-MOON', 'geology.rock_type', 94::numeric, 'Rock type', 'Hawaii contains tholeiitic and alkaline basalts, together with related volcanic materials. Lunar maria also contain basaltic rocks, although their chemistry, cooling histories, and eruption environments differ.', 'Testing automated basalt classification and rock-identification instruments.'),
  ('TER-02-MOON', 'geology.mineral_composition', 92::numeric, 'Mineralogical composition', 'Hawaiian volcanic rocks contain olivine, pyroxene, plagioclase, iron-titanium oxides, and volcanic glass. Several of these mineral groups are also important constituents of lunar basalts.', 'Testing spectrometers and mineral-identification algorithms.'),
  ('TER-02-MOON', 'geology.chemical_composition', 84::numeric, 'Chemical composition', 'Hawaiian basalts contain iron, magnesium, silicon, aluminum, and other elements relevant to comparisons with lunar basaltic materials. Elemental proportions and oxidation states are not identical.', 'Evaluating geochemical instruments and elemental classification methods.'),
  ('TER-02-MOON', 'geology.surface_material', 88::numeric, 'Surface material', 'Hawaiian tephra, basaltic fragments, scoria, and volcanic ash can support experiments involving granular and rocky terrain. Lunar regolith additionally contains impact-produced particles and glassy agglutinates.', 'Testing excavation, sampling, and mechanical interaction with granular materials.'),
  ('TER-02-MOON', 'geology.alteration', 60::numeric, 'Geological alteration', 'Hawaiian volcanic rocks undergo alteration through atmospheric exposure and interaction with water. Lunar surface alteration is instead dominated by micrometeorite impacts, solar-wind exposure, and other space-weathering processes.', 'Differentiating primary mineral signatures from alteration effects.'),
  ('TER-02-MOON', 'geology.formations', 94::numeric, 'Geological formations', 'Shield volcanoes, basaltic lava flows, and layered volcanic deposits provide useful structural comparisons with lunar volcanic terrain.', 'Recognizing volcanic landforms and interpreting planetary geological imagery.'),
  ('TER-02-MOON', 'water.surface_water', 5::numeric, 'Surface water', 'Hawaii contains abundant water in many areas, whereas stable liquid water is absent from the present lunar surface.', 'Identifying limitations of terrestrial water-related analog experiments.'),
  ('TER-02-MOON', 'water.surface_ice', 8::numeric, 'Surface ice', 'Mauna Kea may experience temporary snowfall, but the supplied dataset reports no present active glaciers. Lunar polar ice occurs under radically different environmental conditions.', 'Distinguishing transient terrestrial snow from stable lunar cold-trap deposits.'),
  ('TER-02-MOON', 'water.subsurface_ice', 5::numeric, 'Subsurface ice', 'The terrestrial dataset does not identify a confirmed subsurface ice deposit suitable for comparison with lunar polar ice.', 'Determining the need for alternative field sites or controlled ice-bearing simulants.'),
  ('TER-02-MOON', 'water.permafrost', 5::numeric, 'Permafrost', 'The submitted terrestrial research describes permafrost as absent. This statement should be checked against site-specific high-altitude studies before treating it as definitive.', 'Identifying the limits of Hawaii for lunar cryogenic ground studies.'),
  ('TER-02-MOON', 'water.hydrogen', 28::numeric, 'Hydrogen-bearing materials', 'Hawaiian water and hydrated alteration minerals contain hydrogen, but they do not reproduce the processes responsible for lunar hydrogen distributions.', 'Testing preliminary methods for recognizing hydrogen-bearing minerals.'),
  ('TER-02-MOON', 'water.mineral_resources', 70::numeric, 'Mineral resources', 'Hawaiian basalt and volcanic aggregates offer materials for experimental processing. Lunar resource utilization focuses on different environmental and extraction conditions.', 'Investigating basalt-based construction materials and preliminary resource-processing concepts.'),
  ('TER-02-MOON', 'atmosphere.wind', 0::numeric, 'Wind', 'Hawaiian trade winds transport particles through a dense atmosphere. The Moon lacks comparable aerodynamic wind.', 'Separating terrestrial wind-driven effects from lunar particle behavior.'),
  ('TER-02-MOON', 'atmosphere.dust', 62::numeric, 'Abrasive dust', 'Volcanic ash and angular tephra can challenge seals, joints, optical surfaces, and other equipment. Lunar dust differs in composition, electrical behavior, and formation history.', 'Evaluating abrasion resistance and particle-exclusion mechanisms.'),
  ('TER-02-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Aeolian erosion', 'Terrestrial wind erosion has no direct lunar equivalent.', 'Defining the limitations of wind-shaped landforms as lunar analogs.'),
  ('TER-02-MOON', 'atmosphere.dust_storms', null::numeric, 'Dust storms', 'Terrestrial dust or ash storms do not reproduce atmospheric dust storms on the Moon, because the Moon has no substantial atmosphere.', 'Preventing inappropriate transfer of atmospheric test results.'),
  ('TER-02-MOON', 'atmosphere.sediments', 48::numeric, 'Sediments and granular deposits', 'Hawaiian volcanic sands and tephra provide granular materials for experiments, although lunar deposits are predominantly modified by impacts and space weathering.', 'Testing granular mobility and mechanical sampling.'),
  ('TER-02-MOON', 'atmosphere.aerosols', null::numeric, 'Volcanic aerosols', 'Sulfur-bearing volcanic gases and aerosols in Hawaii have no direct counterpart as an ongoing atmospheric process on the present Moon.', 'Distinguishing volcanic gas exposure from lunar environmental hazards.'),
  ('TER-02-MOON', 'subsurface.caves', 90::numeric, 'Caves', 'Hawaiian volcanic terrain contains natural cavities that can be used for navigation and exploration experiments. Their environmental conditions differ from those expected underground on the Moon.', 'Testing autonomous robots in confined underground spaces.'),
  ('TER-02-MOON', 'subsurface.lava_tubes', 97::numeric, 'Lava tubes', 'Hawaiian lava tubes form as fluid lava drains beneath a solidified crust. Similar volcanic mechanisms are considered relevant to possible lunar lava tubes, although the dimensions and stability of lunar structures remain incompletely characterized.', 'Developing techniques for lava-tube mapping and robotic reconnaissance.'),
  ('TER-02-MOON', 'subsurface.fractures', 92::numeric, 'Cavities and fractures', 'Hawaiian rift zones, fissures, and collapsed volcanic cavities provide structural features useful for hazard identification.', 'Testing fracture detection and collapse-risk reconnaissance.'),
  ('TER-02-MOON', 'subsurface.subsurface_structure', 90::numeric, 'Subsurface structure', 'Stacked basaltic lava flows and buried soil horizons produce layered underground structures. Lunar subsurface volcanic deposits can also be layered, but their depositional histories differ.', 'Testing ground-penetrating instruments and stratigraphic interpretation.'),
  ('TER-02-MOON', 'subsurface.material_thickness', 86::numeric, 'Material thickness', 'Hawaiian volcanic edifices contain thick accumulations of lava flows. These are not equivalent to lunar regolith thickness but can provide relevant volcanic structural contexts.', 'Investigating subsurface imaging and geological layer recognition.'),
  ('TER-02-MOON', 'biology.direct_similarity', null::numeric, 'Direct biological similarity', 'No confirmed lunar biological reference population exists.', 'Defining the scientific boundary of direct biological comparison.'),
  ('TER-02-MOON', 'biology.extremophiles', null::numeric, 'Extremophile organisms', 'Hawaiian thermophilic and acidophilic microorganisms are terrestrial organisms, not direct lunar biological analogs.', 'Supporting laboratory studies of terrestrial microbial survival.'),
  ('TER-02-MOON', 'biology.habitability', null::numeric, 'Habitability conditions', 'Hawaii supports terrestrial ecosystems, while the lunar surface lacks conditions necessary for unprotected terrestrial life.', 'Informing habitat-support and environmental-protection planning.'),
  ('TER-02-MOON', 'biology.biosignatures', null::numeric, 'Biosignatures', 'Hawaiian microbial evidence cannot be compared with confirmed indigenous lunar biosignatures.', 'Testing contamination detection and sample-handling methods.'),
  ('TER-02-MOON', 'biology.adaptations', null::numeric, 'Biological adaptations', 'Hawaiian microorganisms exhibit adaptations to terrestrial environmental extremes, but there is no known lunar biology for direct comparison.', 'Supporting research on terrestrial biological resilience.'),
  ('TER-02-MARS', 'topography.elevation', 58::numeric, 'Elevation', 'Mauna Kea rises approximately 4,207 m above terrestrial sea level. Mars contains volcanic edifices reaching far greater elevations, including Olympus Mons. Their elevations use different planetary reference systems.', 'Testing navigation and mapping across volcanic elevation gradients.'),
  ('TER-02-MARS', 'topography.slope', 84::numeric, 'Slope', 'Hawaiian shield volcanoes contain relatively gentle slopes, while caldera walls and volcanic fractures can present steep terrain. Martian volcanic landscapes also contain diverse slope conditions.', 'Evaluating rover stability, traction, and safe route selection.'),
  ('TER-02-MARS', 'topography.roughness', 92::numeric, 'Surface roughness', 'Hawaiian ʻaʻā lava flows contain angular blocks and irregular surfaces, while pāhoehoe flows offer smoother textures. Both provide useful contrasts for robotic mobility testing.', 'Testing suspension systems, terrain classification, and wheel–surface interaction.'),
  ('TER-02-MARS', 'topography.relief', 94::numeric, 'Relief', 'Hawaiian shield volcanoes, calderas, and volcanic cones provide strong morphological comparisons with selected Martian volcanic landforms.', 'Interpreting volcanic landscapes using orbital imagery and terrain models.'),
  ('TER-02-MARS', 'topography.craters', 55::numeric, 'Craters', 'Hawaiian volcanic craters and collapse depressions may resemble certain Martian volcanic features. They do not directly represent Martian impact craters.', 'Distinguishing volcanic collapse structures from impact-generated depressions.'),
  ('TER-02-MARS', 'topography.obstacles', 91::numeric, 'Surface obstacles', 'Fractured basalt, scoria, fissures, and collapsed lava-tube roofs present hazards relevant to planetary exploration.', 'Testing autonomous obstacle recognition and avoidance.'),
  ('TER-02-MARS', 'thermal.surface_temperature', 45::numeric, 'Surface temperature', 'Mauna Kea experiences cold summit conditions, while Kīlauea includes warm lowlands and potentially very hot volcanic surfaces. Martian surface temperatures are generally much colder and depend on location, season, and local time.', 'Evaluating temperature sensors across contrasting terrain conditions.'),
  ('TER-02-MARS', 'thermal.temperature_extremes', 38::numeric, 'Maximum and minimum temperatures', 'Hawaiian temperature extremes do not reproduce the full range of Martian temperatures, particularly the intense cold observed in polar and nighttime environments.', 'Identifying thermal-protection requirements for instruments.'),
  ('TER-02-MARS', 'thermal.thermal_variation', 54::numeric, 'Thermal variation', 'Hawaiian summit conditions can exhibit significant daily temperature changes. Mars also experiences pronounced daily temperature variation, although the atmospheric and surface-energy processes differ.', 'Testing responses to repeated thermal changes.'),
  ('TER-02-MARS', 'thermal.seasonality', 45::numeric, 'Seasonality', 'Hawaii experiences seasonal environmental variations, but Martian seasons depend on different orbital conditions and include major changes in atmospheric carbon dioxide distribution.', 'Testing environmental monitoring across changing conditions.'),
  ('TER-02-MARS', 'thermal.solar_illumination', 60::numeric, 'Solar illumination', 'High-altitude Hawaiian terrain offers strong solar exposure and relatively clear skies in certain locations. Mars receives less solar energy overall and experiences atmospheric dust effects.', 'Testing optical sensors and preliminary solar-energy systems.'),
  ('TER-02-MARS', 'thermal.atmospheric_conditions', 15::numeric, 'Atmospheric pressure', 'Mauna Kea’s summit pressure is lower than sea-level pressure but remains vastly greater than the thin Martian atmosphere, whose global mean is approximately 600 Pa.', 'Identifying the need for specialized low-pressure testing chambers.'),
  ('TER-02-MARS', 'geology.rock_type', 95::numeric, 'Rock type', 'Hawaiian volcanic environments contain basaltic rocks that are broadly relevant to Martian igneous geology. Martian basaltic compositions and geological histories vary between regions.', 'Testing robotic rock recognition and classification.'),
  ('TER-02-MARS', 'geology.mineral_composition', 93::numeric, 'Mineralogical composition', 'Hawaiian basalts commonly contain olivine, pyroxene, plagioclase, and iron-bearing minerals. These mineral groups are also relevant to Martian volcanic rocks.', 'Testing mineralogical instruments and spectral identification algorithms.'),
  ('TER-02-MARS', 'geology.chemical_composition', 85::numeric, 'Chemical composition', 'Hawaiian basalts contain iron, magnesium, silicon, aluminum, and other elements relevant to Martian basalt comparisons. Differences remain in oxidation state, elemental proportions, and alteration products.', 'Evaluating geochemical sensors and analytical procedures.'),
  ('TER-02-MARS', 'geology.surface_material', 90::numeric, 'Surface material', 'Hawaiian lava fragments, volcanic sands, scoria, and ash provide rocky and granular materials relevant to selected Martian surface conditions.', 'Testing rover mobility, sampling tools, and material-handling systems.'),
  ('TER-02-MARS', 'geology.alteration', 64::numeric, 'Geological alteration', 'Hawaiian rocks undergo weathering influenced by water, oxygen, and biological processes. Martian alteration includes evidence of ancient aqueous activity and present-day environmental processes under different conditions.', 'Investigating how alteration affects mineral signatures.'),
  ('TER-02-MARS', 'geology.formations', 94::numeric, 'Geological formations', 'Hawaiian shield volcanoes, lava flows, and layered volcanic deposits offer strong structural comparisons with Martian volcanic provinces.', 'Interpreting volcanic formations and reconstructing geological processes.'),
  ('TER-02-MARS', 'water.surface_water', 18::numeric, 'Surface water', 'Hawaii contains rivers, groundwater, rainfall, and humid environments. Stable liquid water is generally absent from the present Martian surface.', 'Understanding the limits of water-related terrestrial comparisons.'),
  ('TER-02-MARS', 'water.surface_ice', 12::numeric, 'Surface or polar ice', 'The supplied Hawaiian research identifies no present active glaciers. Mars contains substantial polar and subsurface ice deposits.', 'Identifying where ice-bearing test materials or alternative analog sites are required.'),
  ('TER-02-MARS', 'water.subsurface_ice', 5::numeric, 'Subsurface ice and permafrost', 'The submitted terrestrial dataset does not establish a suitable Hawaiian subsurface ice analog. Martian ice-rich ground is documented in several regions.', 'Defining the limitations of Hawaiian field testing for frozen-ground exploration.'),
  ('TER-02-MARS', 'water.hydrogen', 42::numeric, 'Hydrogen', 'Hawaiian groundwater and hydrated minerals contain hydrogen. Martian hydrogen measurements may indicate ice or hydrated minerals, but the geological settings are different.', 'Testing preliminary methods for recognizing hydrogen-bearing materials.'),
  ('TER-02-MARS', 'water.past_water', 38::numeric, 'Evidence of past water', 'Hawaiian volcanic deposits record interactions with water, but their environmental and geological histories differ from ancient Martian fluvial and lacustrine deposits.', 'Studying mineral alteration and recognizing water-related geological features.'),
  ('TER-02-MARS', 'water.mineral_resources', 70::numeric, 'Minerals and resources', 'Hawaiian basaltic materials provide opportunities to study mineral resources and experimental construction materials. Martian resource extraction would require different processing conditions.', 'Testing mineral identification and preliminary resource-processing concepts.'),
  ('TER-02-MARS', 'atmosphere.atmospheric_pressure', 15::numeric, 'Atmospheric pressure', 'Hawaii’s atmosphere remains much denser than the Martian atmosphere, including at high elevations.', 'Identifying atmospheric-pressure differences that affect equipment testing.'),
  ('TER-02-MARS', 'atmosphere.atmospheric_composition', 8::numeric, 'Atmospheric composition', 'Hawaii has an oxygen- and nitrogen-rich terrestrial atmosphere. The Martian atmosphere is dominated by carbon dioxide.', 'Establishing the need for controlled Martian atmospheric simulations.'),
  ('TER-02-MARS', 'atmosphere.wind', 55::numeric, 'Wind', 'Hawaiian trade winds and local slope winds transport particles through the atmosphere. Martian winds operate under much lower atmospheric density.', 'Testing wind sensors and preliminary sediment-transport observations.'),
  ('TER-02-MARS', 'atmosphere.dust', 66::numeric, 'Dust', 'Hawaiian volcanic ash and fine tephra can be used for certain particle-exposure experiments. Martian dust has different mineralogical, atmospheric, and electrostatic characteristics.', 'Evaluating dust resistance, sensor performance, and mechanical contamination.'),
  ('TER-02-MARS', 'atmosphere.dust_storms', 35::numeric, 'Dust storms', 'Local Hawaiian ash or dust events may reduce visibility and expose equipment to particles. They do not reproduce the large-scale behavior of Martian dust storms.', 'Testing visibility sensors and dust-monitoring systems.'),
  ('TER-02-MARS', 'atmosphere.aeolian_erosion', 62::numeric, 'Aeolian erosion and sediments', 'Hawaiian volcanic sands and exposed tephra can undergo wind-driven movement and abrasion. Martian sediment transport occurs under different atmospheric conditions.', 'Investigating sediment movement and granular terrain.'),
  ('TER-02-MARS', 'atmosphere.aerosols', 55::numeric, 'Aerosols', 'Kīlauea can emit volcanic gases and sulfur-bearing aerosols. Mars contains atmospheric dust and aerosols with different sources and chemical characteristics.', 'Testing environmental monitoring instruments and studying aerosol-related sensor interference.'),
  ('TER-02-MARS', 'subsurface.caves', 90::numeric, 'Caves and cavities', 'Hawaii contains volcanic cavities and cave systems that offer accessible environments for underground robotic tests.', 'Testing navigation, imaging, and communication systems in confined spaces.'),
  ('TER-02-MARS', 'subsurface.lava_tubes', 96::numeric, 'Lava tubes', 'Hawaiian lava tubes form through processes associated with basaltic lava flow and drainage. Similar volcanic mechanisms may have produced lava-tube structures on Mars.', 'Developing methods for mapping and exploring potential Martian lava tubes.'),
  ('TER-02-MARS', 'subsurface.subsurface_structure', 88::numeric, 'Subsurface structure', 'Hawaiian volcanic terrain includes fractures, buried lava flows, and layered geological structures. Martian volcanic terrains may contain related structural arrangements.', 'Testing subsurface imaging and geological interpretation techniques.'),
  ('TER-02-MARS', 'subsurface.material_thickness', 78::numeric, 'Material thickness', 'Hawaiian volcanic edifices contain extensive accumulations of basaltic material. These provide a geological comparison for layered volcanic deposits, although Martian thicknesses and subsurface properties vary.', 'Evaluating methods for characterizing layered subsurface materials.'),
  ('TER-02-MARS', 'biology.extremophiles', 78::numeric, 'Extremophile organisms', 'Hawaiian volcanic environments can support thermophilic, acidophilic, and other microorganisms adapted to challenging conditions. Mars has no confirmed indigenous organisms.', 'Investigating terrestrial survival mechanisms and testing biological detection instruments.'),
  ('TER-02-MARS', 'biology.habitability', 48::numeric, 'Habitability conditions', 'Hawaii contains environments ranging from humid tropical areas to cold high-altitude volcanic terrain. Present-day Martian surface conditions are substantially less favorable for known terrestrial life.', 'Studying environmental limits and habitability indicators.'),
  ('TER-02-MARS', 'biology.biosignatures', 65::numeric, 'Potential biosignatures', 'Microbial films and other biological evidence in Hawaiian volcanic settings can provide materials for testing biosignature-recognition techniques.', 'Developing methods to distinguish biological signals from nonbiological geological features.'),
  ('TER-02-MARS', 'biology.adaptations', 72::numeric, 'Biological adaptations', 'Hawaiian microorganisms can use metabolic processes associated with sulfur and iron compounds in volcanic environments. These processes provide terrestrial examples for astrobiological research.', 'Investigating microbial metabolism and potential biological detection strategies.'),
  ('TER-03-MOON', 'topography.elevation', 55::numeric, 'Elevation', 'Iceland ranges from sea level to approximately 2,110 m, while lunar elevations extend across a much larger planetary relief range and are referenced to a lunar datum. Iceland’s mountainous volcanic terrain offers elevation gradients for exploration testing but does not reproduce lunar topography quantitatively.', 'Evaluating navigation and field operations across changing elevations.'),
  ('TER-03-MOON', 'topography.slope', 78::numeric, 'Slope', 'Iceland includes gentle lava plains, steep glacial valley walls, volcanic fissures, and caldera slopes. The Moon also contains relatively flat basaltic maria and steep crater walls, although the landforms have different geological origins.', 'Testing rover traction, stability, and slope-navigation systems.'),
  ('TER-03-MOON', 'topography.roughness', 88::numeric, 'Surface roughness', 'Recent Icelandic lava fields contain fractured basalt, angular blocks, and irregular surfaces. These can reproduce selected mechanical challenges encountered in rocky lunar terrain, although lunar regolith has different particle properties.', 'Evaluating robotic mobility, suspension systems, and terrain-recognition algorithms.'),
  ('TER-03-MOON', 'topography.relief', 72::numeric, 'Relief', 'Iceland contains basaltic plateaus, volcanic mountains, glacial valleys, and calderas. Lunar relief includes volcanic plains and mountains but is strongly dominated by impact processes rather than glaciers or plate tectonics.', 'Testing topographic mapping and geological landform classification.'),
  ('TER-03-MOON', 'topography.craters', 42::numeric, 'Craters', 'Icelandic volcanic craters, calderas, and collapse depressions can resemble lunar depressions in shape. However, most lunar craters originate from impacts, which produce different geological structures and surrounding deposits.', 'Training image-analysis systems to distinguish volcanic and impact-related landforms.'),
  ('TER-03-MOON', 'topography.obstacles', 85::numeric, 'Surface obstacles', 'Icelandic terrain includes basaltic blocks, loose tephra, tectonic fissures, and irregular lava surfaces. Similar physical obstacles may complicate robotic movement on the Moon.', 'Testing autonomous obstacle detection and safe route planning.'),
  ('TER-03-MOON', 'thermal.surface_temperature', 35::numeric, 'Surface temperature', 'Iceland’s supplied climate data describe lowland annual averages around 4–5°C and subfreezing highland conditions. These are not equivalent to standardized lunar ground-surface temperature measurements. Lunar surface temperatures vary far more dramatically.', 'Preliminary testing of instruments in cold terrestrial environments.'),
  ('TER-03-MOON', 'thermal.temperature_extremes', 28::numeric, 'Maximum and minimum temperatures', 'The Icelandic dataset reports local summer maxima around 15–20°C and extreme interior winter minima approaching −25 to −30°C. Lunar temperatures can exceed 120°C in sunlight and approach −247°C in permanently shadowed polar regions.', 'Identifying equipment limitations that require specialized thermal facilities.'),
  ('TER-03-MOON', 'thermal.thermal_variation', 32::numeric, 'Thermal variation', 'Iceland experiences seasonal and daily temperature changes, whereas the Moon has a much longer day–night cycle and extreme thermal variations in many regions.', 'Testing preliminary responses to environmental temperature changes.'),
  ('TER-03-MOON', 'thermal.solar_illumination', 65::numeric, 'Solar illumination', 'Iceland’s high latitude produces very long summer daylight periods and short winter days. These conditions can provide partial operational comparisons with low-angle solar illumination near lunar polar terrain, although the geometry and timing differ.', 'Testing optical navigation and solar-power performance under low-angle illumination.'),
  ('TER-03-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Atmospheric conditions / exosphere', 'Iceland has a substantial terrestrial atmosphere, while the Moon possesses an extremely tenuous exosphere. Icelandic wind, humidity, and atmospheric heat transfer do not reproduce lunar vacuum conditions.', 'Identifying tests that must instead be performed in vacuum chambers.'),
  ('TER-03-MOON', 'geology.rock_type', 85::numeric, 'Rock type', 'Iceland contains tholeiitic and alkaline basalts, together with rhyolites and palagonitic volcanic deposits. Lunar maria are also dominated by basaltic rocks, although lunar highlands are predominantly anorthositic and lunar basalt chemistry differs.', 'Testing robotic rock classification and basalt recognition.'),
  ('TER-03-MOON', 'geology.mineral_composition', 82::numeric, 'Mineralogical composition', 'Icelandic basalts contain plagioclase, pyroxene, and olivine, mineral groups also found in lunar basaltic rocks. Iceland additionally contains hydrated volcanic glass and hydrothermal clays that are not typical of unaltered lunar mare materials.', 'Evaluating mineralogical instruments and spectral classification algorithms.'),
  ('TER-03-MOON', 'geology.chemical_composition', 76::numeric, 'Chemical composition', 'Icelandic basalts contain silicon, iron, magnesium, aluminum, and other elements relevant to lunar basalt comparisons. Their oxidation states, titanium abundances, and alteration histories differ from many lunar materials.', 'Testing elemental analysis and geochemical classification.'),
  ('TER-03-MOON', 'geology.surface_material', 72::numeric, 'Surface material', 'Iceland contains basaltic sands, tephra, fractured volcanic rock, and glacial sediments. Lunar regolith is primarily produced by impact fragmentation and space weathering, creating different grain textures and physical properties.', 'Testing sampling tools and equipment interaction with granular volcanic materials.'),
  ('TER-03-MOON', 'geology.alteration', 28::numeric, 'Geological alteration', 'Icelandic rocks undergo freeze–thaw weathering, oxidation, and hydrothermal alteration. Lunar rocks experience space weathering from micrometeorite impacts, solar-wind particles, and radiation.', 'Developing methods to distinguish primary mineral signatures from alteration products.'),
  ('TER-03-MOON', 'geology.formations', 83::numeric, 'Geological formations', 'Icelandic lava fields, volcanic plateaus, fissures, and layered basaltic deposits offer comparisons with lunar volcanic provinces. Iceland’s active rifting and glacially modified formations have no exact lunar equivalents.', 'Mapping volcanic structures and interpreting geological imagery.'),
  ('TER-03-MOON', 'water.surface_water', 5::numeric, 'Surface water', 'Iceland has rivers, lakes, wetlands, and abundant surface water. The Moon does not support stable liquid water on its exposed surface.', 'Defining the limitations of terrestrial hydrological analogs.'),
  ('TER-03-MOON', 'water.surface_ice', 64::numeric, 'Surface ice', 'Iceland’s large ice caps provide accessible ice-bearing environments. Lunar polar ice is distributed within cold, often permanently shadowed deposits and has different thermal and geological conditions.', 'Testing ice-recognition instruments and sampling procedures.'),
  ('TER-03-MOON', 'water.subsurface_ice', 53::numeric, 'Subsurface ice', 'Iceland includes seasonal ground ice and localized frozen subsurface environments. Lunar subsurface ice is associated with different temperatures, pressure conditions, and volatile stability mechanisms.', 'Preliminary testing of subsurface ice-detection systems.'),
  ('TER-03-MOON', 'water.permafrost', 55::numeric, 'Permafrost', 'Iceland contains discontinuous mountain permafrost in some high-elevation areas. Lunar polar frozen regolith can remain at far lower temperatures and does not experience ordinary terrestrial freeze–thaw cycles.', 'Testing robotic movement and sampling in frozen ground.'),
  ('TER-03-MOON', 'water.hydrogen', 34::numeric, 'Hydrogen-bearing materials', 'Iceland contains abundant hydrogen in water, ice, geothermal steam, and hydrated minerals. Lunar hydrogen may occur in polar ice, hydroxyl-bearing materials, and solar-wind-implanted surface grains.', 'Evaluating methods for detecting hydrogen-bearing substances.'),
  ('TER-03-MOON', 'water.mineral_resources', 70::numeric, 'Mineral resources', 'Iceland offers basaltic aggregates, volcanic glass, pumice, and sulfur-bearing materials. Lunar resource utilization also considers silicate and oxide minerals, although extraction environments differ.', 'Preliminary testing of basalt processing and geological resource identification.'),
  ('TER-03-MOON', 'atmosphere.wind', 0::numeric, 'Wind', 'Iceland experiences strong atmospheric winds, while the Moon lacks a dense atmosphere capable of comparable wind transport.', 'Separating terrestrial wind effects from lunar surface particle behavior.'),
  ('TER-03-MOON', 'atmosphere.dust', 68::numeric, 'Abrasive dust', 'Icelandic basaltic dust and volcanic ash can expose equipment to fine mineral particles. Lunar dust differs in its formation history, surface chemistry, and electrical behavior.', 'Testing seals, joints, optical surfaces, and dust-resistant components.'),
  ('TER-03-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Aeolian erosion', 'Icelandic wind erosion has no direct lunar counterpart because the Moon does not experience conventional atmospheric wind erosion.', 'Identifying the limits of terrestrial aeolian terrain comparisons.'),
  ('TER-03-MOON', 'atmosphere.dust_storms', null::numeric, 'Dust storms', 'Icelandic dust storms depend on atmospheric winds, whereas lunar dust movement is controlled by different mechanisms.', 'Preventing inappropriate interpretation of atmospheric dust-storm tests as direct lunar simulations.'),
  ('TER-03-MOON', 'atmosphere.sediments', 57::numeric, 'Sediments and granular deposits', 'Icelandic black sands and volcanic sediments provide granular surfaces suitable for mechanical testing. Lunar regolith has different particle origins, cohesion, and exposure history.', 'Testing excavation, granular sampling, and mobility systems.'),
  ('TER-03-MOON', 'atmosphere.aerosols', null::numeric, 'Volcanic aerosols', 'Icelandic volcanic aerosols are transported through Earth’s atmosphere. They do not represent an equivalent present-day lunar atmospheric process.', 'Distinguishing terrestrial aerosol exposure from lunar environmental hazards.'),
  ('TER-03-MOON', 'subsurface.caves', 88::numeric, 'Caves', 'Iceland contains basaltic caves and temporary glacial ice caves. Lava caves are particularly relevant to potential lunar volcanic cavities, whereas glacial caves have no direct lunar geological equivalent.', 'Testing robotic exploration in confined underground environments.'),
  ('TER-03-MOON', 'subsurface.lava_tubes', 94::numeric, 'Lava tubes', 'Icelandic lava tubes form through the transport and drainage of lava beneath solidified surfaces. Similar volcanic processes may have produced underground lava-tube structures on the Moon.', 'Developing robotic navigation, mapping, and remote-sensing methods for lava tubes.'),
  ('TER-03-MOON', 'subsurface.fractures', 92::numeric, 'Cavities and fractures', 'Iceland’s tectonic rift zones contain extensive fractures and volcanic fissures. Lunar volcanic terrain may also contain fractures, collapse pits, and underground cavities, although the tectonic mechanisms differ.', 'Testing fracture detection and structural hazard assessment.'),
  ('TER-03-MOON', 'subsurface.subsurface_structure', 84::numeric, 'Subsurface structure', 'Icelandic subsurface formations include alternating basaltic lava flows and subglacial volcanic deposits. Lunar volcanic deposits may also form layered structures, but without the same water-ice interactions.', 'Testing ground-penetrating imaging and geological layer recognition.'),
  ('TER-03-MOON', 'subsurface.material_thickness', 75::numeric, 'Material thickness', 'Iceland’s volcanic crust contains thick accumulations of lava and associated deposits. These can support studies of layered volcanic structures, but they should not be treated as direct equivalents of lunar regolith thickness.', 'Evaluating subsurface mapping and geological thickness estimation.'),
  ('TER-03-MOON', 'biology.direct_similarity', null::numeric, 'Direct biological similarity', 'There is no confirmed indigenous lunar biological population against which Icelandic organisms can be compared.', 'Defining the limits of direct biological similarity assessment.'),
  ('TER-03-MOON', 'biology.extremophiles', null::numeric, 'Extremophile organisms', 'Iceland contains cold-adapted and geothermal microorganisms, but these do not represent known lunar organisms.', 'Testing biological instruments using terrestrial organisms.'),
  ('TER-03-MOON', 'biology.habitability', null::numeric, 'Habitability conditions', 'Iceland contains environments capable of supporting terrestrial life. The exposed lunar surface lacks comparable natural habitability conditions.', 'Informing life-support and environmental-control studies.'),
  ('TER-03-MOON', 'biology.biosignatures', null::numeric, 'Biosignatures', 'Icelandic microbial evidence cannot be compared with confirmed indigenous lunar biosignatures.', 'Developing contamination-detection and sample-analysis procedures.'),
  ('TER-03-MOON', 'biology.adaptations', null::numeric, 'Biological adaptations', 'Icelandic microorganisms exhibit adaptations to cold and geothermal environments, but there is no confirmed lunar biology for direct comparison.', 'Investigating terrestrial microbial resilience.'),
  ('TER-03-MARS', 'topography.elevation', 55::numeric, 'Elevation', 'Iceland extends from sea level to approximately 2,110 m. Mars contains much larger topographic variations, including major volcanic edifices and deep impact basins. The elevation reference systems also differ.', 'Testing navigation and mapping across terrestrial elevation gradients.'),
  ('TER-03-MARS', 'topography.slope', 83::numeric, 'Slope', 'Iceland contains gentle volcanic plains, steep valley walls, caldera slopes, and tectonic fissures. Mars also exhibits varied slopes across volcanic regions, impact craters, and canyon systems.', 'Evaluating rover stability, traction, and slope-navigation algorithms.'),
  ('TER-03-MARS', 'topography.roughness', 90::numeric, 'Surface roughness', 'Icelandic lava fields contain angular basaltic blocks, fractured surfaces, and irregular volcanic deposits. These reproduce selected mechanical challenges associated with rocky Martian terrain.', 'Testing rover suspension, wheel–terrain interaction, and autonomous surface classification.'),
  ('TER-03-MARS', 'topography.relief', 85::numeric, 'Relief', 'Icelandic volcanic plateaus, calderas, glacial valleys, and mountain systems provide diverse terrain forms. Mars contains volcanic, tectonic, impact-related, and ancient water-modified landscapes, although their dimensions and origins differ.', 'Testing digital terrain models and geomorphological interpretation.'),
  ('TER-03-MARS', 'topography.craters', 55::numeric, 'Craters', 'Iceland contains volcanic craters, fissure-crater chains, and collapse calderas. Mars contains both volcanic depressions and impact craters, making geological origin an important distinction.', 'Training instruments and image-analysis systems to distinguish crater types.'),
  ('TER-03-MARS', 'topography.obstacles', 91::numeric, 'Surface obstacles', 'Icelandic terrain contains basaltic blocks, loose tephra, tectonic fractures, and irregular lava fields. These present navigation hazards comparable to some rocky Martian environments.', 'Testing obstacle detection, route planning, and autonomous robotic navigation.'),
  ('TER-03-MARS', 'thermal.surface_temperature', 72::numeric, 'Surface temperature', 'Iceland’s supplied climate data describe annual lowland averages around 4–5°C and subfreezing conditions in highlands and glacial regions. Mars experiences much colder surface conditions overall. The Icelandic figures primarily describe climate rather than standardized ground-surface measurements.', 'Preliminary testing of instruments in cold terrestrial environments.'),
  ('TER-03-MARS', 'thermal.temperature_extremes', 65::numeric, 'Maximum and minimum temperatures', 'Icelandic interior winter temperatures may approach −25 to −30°C, while Martian surface temperatures can fall considerably lower. Iceland therefore offers a partial cold-environment analog but cannot reproduce the full Martian thermal range.', 'Evaluating equipment performance under freezing conditions.'),
  ('TER-03-MARS', 'thermal.thermal_variation', 62::numeric, 'Thermal variation', 'Iceland experiences daily and seasonal temperature changes, particularly in highland environments. Mars also experiences strong thermal variation, although its atmospheric density and surface-energy balance are different.', 'Testing instrument responses to repeated heating and cooling.'),
  ('TER-03-MARS', 'thermal.seasonality', 77::numeric, 'Seasonality', 'Iceland has pronounced seasonal changes in temperature, daylight, snow, and ice conditions. Mars also experiences seasonal variations, including changes in polar carbon dioxide ice and atmospheric pressure.', 'Developing environmental monitoring strategies across changing seasons.'),
  ('TER-03-MARS', 'thermal.solar_illumination', 76::numeric, 'Solar illumination', 'Iceland’s high latitude produces extended summer daylight and short winter days. Martian illumination also varies with latitude and season, although Mars has different orbital characteristics and atmospheric dust effects.', 'Testing optical navigation, illumination-dependent imaging, and solar-power systems.'),
  ('TER-03-MARS', 'thermal.atmospheric_conditions', 12::numeric, 'Atmospheric pressure', 'Iceland has a dense terrestrial atmosphere, even during low-pressure weather systems. The Martian atmosphere has a mean surface pressure of approximately 600 Pa, vastly lower than terrestrial pressure.', 'Identifying equipment tests that require controlled low-pressure chambers.'),
  ('TER-03-MARS', 'geology.rock_type', 94::numeric, 'Rock type', 'Iceland contains tholeiitic and alkaline basalts, rhyolites, and palagonitic volcanic deposits. Basaltic rocks are also widespread on Mars, although Martian lithology varies across regions and geological periods.', 'Testing robotic rock classification and geological sampling systems.'),
  ('TER-03-MARS', 'geology.mineral_composition', 92::numeric, 'Mineralogical composition', 'Icelandic volcanic rocks contain plagioclase, pyroxene, olivine, volcanic glass, and alteration minerals. Several of these mineral groups are also relevant to Martian basaltic and water-altered rocks.', 'Testing mineral spectroscopy and mineral-identification algorithms.'),
  ('TER-03-MARS', 'geology.chemical_composition', 83::numeric, 'Chemical composition', 'Icelandic rocks contain silicon, iron, magnesium, aluminum, and sulfur-bearing compounds. Martian rocks contain comparable major elements, but their proportions and alteration histories vary.', 'Evaluating geochemical instruments and elemental classification techniques.'),
  ('TER-03-MARS', 'geology.surface_material', 90::numeric, 'Surface material', 'Iceland contains basaltic sands, volcanic ash, fractured rock, and glacially transported sediments. These provide useful mechanical and geological comparisons with selected Martian granular and rocky surfaces.', 'Testing sampling systems, rover mobility, and sediment analysis.'),
  ('TER-03-MARS', 'geology.alteration', 88::numeric, 'Geological alteration', 'Iceland’s hydrothermal systems produce hydrated volcanic glass, clay minerals, and other alteration products. Mars contains evidence of ancient aqueous alteration, including clay-bearing and hydrated mineral deposits.', 'Testing instruments designed to identify water-related geological alteration.'),
  ('TER-03-MARS', 'geology.formations', 93::numeric, 'Geological formations', 'Iceland contains shield volcanoes, lava fields, subglacial volcanic deposits, fissures, and layered basaltic formations. Mars contains extensive volcanic provinces and geological evidence of interactions between volcanic materials and water or ice.', 'Interpreting volcanic structures and reconstructing planetary geological processes.'),
  ('TER-03-MARS', 'water.surface_water', 35::numeric, 'Surface water', 'Iceland contains abundant rivers, lakes, wetlands, and glacial meltwater. Stable liquid water is generally absent from the present Martian surface, although Mars preserves extensive evidence of ancient water activity.', 'Studying water-related landforms while recognizing their environmental differences.'),
  ('TER-03-MARS', 'water.surface_ice', 90::numeric, 'Surface ice', 'Iceland contains extensive glaciers and ice caps. Mars contains polar ice deposits and ice-rich terrain, although the thermal conditions, ice composition, and geological settings differ.', 'Testing ice-detection instruments and robotic operations on ice-bearing terrain.'),
  ('TER-03-MARS', 'water.subsurface_ice', 82::numeric, 'Subsurface ice', 'Iceland includes seasonal ground ice and localized frozen subsurface environments. Mars contains substantial subsurface ice deposits in several regions, including buried ice-rich geological units.', 'Testing subsurface ice detection and ground-penetrating instruments.'),
  ('TER-03-MARS', 'water.permafrost', 80::numeric, 'Permafrost', 'Iceland contains discontinuous mountain permafrost in some high-elevation areas. Mars has extensive cold ground conditions favorable to the long-term preservation of subsurface ice.', 'Studying frozen-ground properties and robotic exploration of ice-bearing terrain.'),
  ('TER-03-MARS', 'water.hydrogen', 76::numeric, 'Hydrogen-bearing materials', 'Iceland contains hydrogen in water, ice, geothermal steam, and hydrated minerals. Martian hydrogen measurements can indicate water ice or hydrated minerals, although hydrogen detection alone does not establish the chemical form.', 'Testing instruments designed to recognize hydrogen-bearing geological materials.'),
  ('TER-03-MARS', 'water.past_water', 91::numeric, 'Evidence of past water', 'Iceland’s glacial valleys, volcanic–water interactions, and hydrothermally altered deposits provide examples of geological processes involving liquid water and ice. Mars preserves evidence of ancient rivers, lakes, and water-related mineral alteration.', 'Testing methods for interpreting ancient aqueous geological environments.'),
  ('TER-03-MARS', 'water.mineral_resources', 83::numeric, 'Mineral resources', 'Iceland contains basaltic construction materials, volcanic minerals, sulfur-bearing deposits, and geothermal resources. Mars contains basaltic materials, hydrated minerals, and ice deposits of potential exploration interest, although resource availability and extraction methods differ.', 'Evaluating geological resource detection and preliminary material-processing methods.'),
  ('TER-03-MARS', 'atmosphere.atmospheric_pressure', 12::numeric, 'Atmospheric pressure', 'Iceland’s atmospheric pressure is vastly greater than that of Mars. Terrestrial low-pressure weather systems do not reproduce Martian atmospheric conditions.', 'Identifying the need for controlled low-pressure testing environments.'),
  ('TER-03-MARS', 'atmosphere.atmospheric_composition', 8::numeric, 'Atmospheric composition', 'Iceland has Earth’s nitrogen- and oxygen-rich atmosphere, while Mars has a carbon dioxide-dominated atmosphere.', 'Establishing the limitations of open-air testing for Martian atmospheric instruments.'),
  ('TER-03-MARS', 'atmosphere.wind', 80::numeric, 'Wind', 'Iceland experiences strong winds capable of transporting volcanic dust and sand. Mars also experiences wind-driven sediment transport, but under much lower atmospheric density.', 'Testing wind sensors and observing sediment movement.'),
  ('TER-03-MARS', 'atmosphere.dust', 94::numeric, 'Dust', 'Icelandic black-sand deserts produce fine basaltic dust that can expose equipment to mineral particles. Martian dust differs in chemistry, grain-size distribution, and environmental behavior.', 'Testing dust-resistant components, optical instruments, and particle sensors.'),
  ('TER-03-MARS', 'atmosphere.dust_storms', 93::numeric, 'Dust storms', 'Iceland experiences volcanic dust storms generated by strong winds over exposed sediment deposits. Mars experiences local, regional, and occasionally planet-encircling dust storms. Their atmospheric physics differ substantially.', 'Evaluating dust monitoring, visibility sensors, and equipment exposure.'),
  ('TER-03-MARS', 'atmosphere.aeolian_erosion', 94::numeric, 'Aeolian erosion and sediments', 'Icelandic winds redistribute basaltic sands, volcanic dust, and glacial outwash sediments. Mars contains dunes and other wind-shaped deposits, although the atmospheric transport conditions differ.', 'Investigating sediment transport, erosion, and dune-related geological processes.'),
  ('TER-03-MARS', 'atmosphere.aerosols', 82::numeric, 'Aerosols', 'Iceland contains suspended volcanic particles, sulfate aerosols, and marine aerosols. Mars contains atmospheric dust and other aerosols, but their sources, composition, and atmospheric interactions differ.', 'Testing atmospheric monitoring instruments and studying particle-related sensor interference.'),
  ('TER-03-MARS', 'subsurface.caves', 91::numeric, 'Caves and cavities', 'Iceland contains basaltic caves and glacial ice caves. Its volcanic cavities are especially relevant to potential Martian underground structures, while glacial caves represent different formation processes.', 'Testing robotic navigation, imaging, and communication systems underground.'),
  ('TER-03-MARS', 'subsurface.lava_tubes', 95::numeric, 'Lava tubes', 'Icelandic lava tubes form as flowing lava drains beneath a solidified crust. Similar volcanic processes may have produced lava tubes in Martian volcanic regions.', 'Developing techniques for detecting, mapping, and exploring potential Martian lava tubes.'),
  ('TER-03-MARS', 'subsurface.fractures', 92::numeric, 'Fractures and faults', 'Iceland’s active rift zones contain tectonic fissures and faults. Mars also contains fractures and tectonic structures, although its tectonic history differs from Earth’s plate-boundary processes.', 'Testing fracture recognition and geological hazard assessment.'),
  ('TER-03-MARS', 'subsurface.subsurface_structure', 88::numeric, 'Subsurface structure', 'Icelandic subsurface deposits contain layered basaltic flows and subglacial volcanic materials. Mars contains layered volcanic and sedimentary deposits with different geological histories.', 'Testing subsurface imaging and stratigraphic interpretation.'),
  ('TER-03-MARS', 'subsurface.material_thickness', 74::numeric, 'Material thickness', 'Iceland’s volcanic crust contains thick accumulations of volcanic and sedimentary materials. Martian volcanic deposits can also be extensive, but their thicknesses and physical properties vary by region.', 'Evaluating subsurface geological models and layer-thickness estimation.'),
  ('TER-03-MARS', 'biology.extremophiles', 86::numeric, 'Extremophile organisms', 'Iceland contains microorganisms adapted to cold glaciers, geothermal systems, and chemically challenging volcanic environments. Mars has no confirmed indigenous life, so the comparison concerns terrestrial models of possible survival strategies rather than biological equivalence.', 'Testing biological detection instruments and studying microbial survival mechanisms.'),
  ('TER-03-MARS', 'biology.habitability', 68::numeric, 'Habitability conditions', 'Iceland includes cold highlands, geothermal environments, and water–rock interaction zones. These provide models for investigating some environmental factors relevant to potential past Martian habitability, although Iceland remains substantially more favorable to terrestrial life.', 'Studying environmental limits and potential habitability indicators.'),
  ('TER-03-MARS', 'biology.biosignatures', 81::numeric, 'Potential biosignatures', 'Icelandic microbial communities can produce biological structures and chemical signatures in volcanic and hydrothermal environments. These provide test materials for methods intended to distinguish potential biosignatures from nonbiological geological features.', 'Developing and evaluating biosignature-detection techniques.'),
  ('TER-03-MARS', 'biology.adaptations', 85::numeric, 'Biological adaptations', 'Icelandic microorganisms exhibit cold-adapted enzymes and metabolic processes associated with geothermal and geochemical gradients. These adaptations provide terrestrial examples for investigating possible survival mechanisms under challenging planetary conditions.', 'Studying microbial metabolism, environmental adaptation, and biological detection strategies.'),
  ('TER-04-MOON', 'topography.elevation', 48::numeric, 'Elevation', 'The McMurdo Dry Valleys extend from near sea level to mountain crests exceeding 2,000 m. Lunar topography has a much larger global elevation range, measured relative to a lunar reference surface. Terrestrial and lunar elevation values cannot be compared directly without a common normalization method.', 'Testing topographic navigation and altitude-dependent field planning.'),
  ('TER-04-MOON', 'topography.slope', 68::numeric, 'Slope', 'The supplied research describes relatively flat valley floors with slopes of approximately 1–5° and steep surrounding rock walls exceeding 40°. Lunar maria also contain gently sloping terrain, while crater walls and highland features can be steep.', 'Evaluating rover traction, stability, and slope-recognition systems.'),
  ('TER-04-MOON', 'topography.roughness', 78::numeric, 'Surface roughness', 'Antarctic desert pavements contain angular rocks, glacially transported boulders, and fractured ground. Lunar terrain also contains rocky obstacles, although lunar surface roughness depends on impact history and must be evaluated at comparable spatial scales.', 'Testing suspension systems, obstacle avoidance, and terrain-classification algorithms.'),
  ('TER-04-MOON', 'topography.relief', 62::numeric, 'Relief', 'The region contains broad glacial troughs, steep mountain walls, and ancient moraine systems. The Moon has valleys, mountains, and depressions, but these are predominantly associated with impacts, volcanism, and tectonic deformation rather than glacial excavation.', 'Training robotic systems to interpret complex relief and elevation changes.'),
  ('TER-04-MOON', 'topography.craters', 8::numeric, 'Craters', 'The terrestrial research identifies no prominent recent impact-crater landscape in the region. Small depressions associated with wind deflation or frozen-ground processes do not reproduce the formation mechanisms of lunar impact craters.', 'Distinguishing non-impact depressions from impact-related geological features.'),
  ('TER-04-MOON', 'topography.obstacles', 74::numeric, 'Surface obstacles', 'Glacial erratics, angular blocks, rocky pavements, and ground fractures present obstacles comparable in operational terms to some lunar surface hazards.', 'Testing robotic obstacle detection, route selection, and autonomous navigation.'),
  ('TER-04-MOON', 'thermal.surface_temperature', 54::numeric, 'Surface temperature', 'The supplied research describes extremely cold annual conditions, approximately −20°C to −30°C, although these figures should not automatically be

interpreted as satellite-derived land-surface temperatures. Lunar surface temperatures vary from extremely cold polar shadows to intensely heated sunlit terrain.', 'Testing instrument operation in cold terrestrial environments.'),
  ('TER-04-MOON', 'thermal.temperature_extremes', 45::numeric, 'Maximum and minimum temperatures', 'The terrestrial dataset reports occasional summer conditions near +5°C and winter minima approaching −50°C. Lunar permanently shadowed regions can be far colder, while illuminated lunar surfaces can become much warmer.', 'Identifying thermal equipment limitations and requirements for specialized cryogenic testing.'),
  ('TER-04-MOON', 'thermal.thermal_variation', 48::numeric, 'Thermal variation', 'The Dry Valleys experience strong seasonal thermal changes. The Moon experiences a much longer day–night cycle and, outside some polar settings, much larger surface temperature variations.', 'Testing preliminary thermal monitoring and equipment responses to temperature changes.'),
  ('TER-04-MOON', 'thermal.solar_illumination', 83::numeric, 'Solar illumination', 'The research describes prolonged Antarctic summer daylight and winter darkness. These conditions offer operational comparisons with some lunar polar illumination challenges, although lunar illumination patterns depend strongly on local terrain and the Moon’s axial geometry.', 'Evaluating low-angle solar imaging, illumination-dependent navigation, and polar field planning.'),
  ('TER-04-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Atmospheric conditions / exosphere', 'Antarctica retains Earth’s dense atmosphere, even under cold and dry conditions. The Moon has an extremely tenuous exosphere and essentially no atmospheric heat transfer or conventional wind.', 'Determining which tests require vacuum chambers rather than open-air terrestrial fieldwork.'),
  ('TER-04-MOON', 'geology.rock_type', 30::numeric, 'Rock type', 'The McMurdo Dry Valleys contain Beacon sandstones, Ferrar dolerites, granitic rocks, and metamorphic basement. The Moon contains extensive anorthositic highlands, mare basalts, and impact breccias. Ferrar dolerites provide a limited mafic-rock comparison, but the overall assemblages differ.', 'Testing rock-classification instruments and identifying the limits of terrestrial lithological analogs.'),
  ('TER-04-MOON', 'geology.mineral_composition', 38::numeric, 'Mineralogical composition', 'Some mafic minerals in Ferrar dolerites overlap with mineral groups found in lunar basalts. However, the region also contains quartz-rich sedimentary and granitic rocks and water-related salts that are not representative of typical lunar surface materials.', 'Evaluating mineral-identification systems and spectral discrimination.'),
  ('TER-04-MOON', 'geology.chemical_composition', 35::numeric, 'Chemical composition', 'Antarctic rocks contain common silicate-forming elements, but their chemical abundances and alteration products differ from lunar mare basalts and highland anorthosites.', 'Testing geochemical classification and distinguishing different rock families.'),
  ('TER-04-MOON', 'geology.surface_material', 55::numeric, 'Surface material', 'The Dry Valleys contain dry sediments, angular clasts, moraines, and rocky desert pavements. Lunar regolith is produced mainly by impact fragmentation and space weathering, resulting in different grain textures and mechanical behavior.', 'Testing granular sampling, excavation, and robotic interaction with loose surface materials.'),
  ('TER-04-MOON', 'geology.alteration', 34::numeric, 'Geological alteration', 'Antarctic weathering includes salt crystallization, thermal contraction, and limited water-related alteration. Lunar weathering is dominated by micrometeorite impacts, solar-wind implantation, and irradiation.', 'Developing methods to distinguish terrestrial alteration from lunar space-weathering signatures.'),
  ('TER-04-MOON', 'geology.formations', 18::numeric, 'Geological formations', 'The Dry Valleys are dominated by glacial valleys, moraines, sedimentary sequences, and mountain structures. Lunar formations are primarily associated with impact basins, volcanic plains, and ancient tectonic structures.', 'Training geological mapping systems to distinguish different landform origins.'),
  ('TER-04-MOON', 'water.surface_water', 12::numeric, 'Surface water', 'The region contains lakes and occasional meltwater processes, often beneath persistent lake ice. The exposed lunar surface does not support stable liquid water.', 'Establishing the limits of terrestrial hydrological comparisons.'),
  ('TER-04-MOON', 'water.surface_ice', 77::numeric, 'Surface ice', 'The Dry Valleys contain glaciers and permanently ice-covered lakes. Lunar polar surface ice occurs in much colder, frequently permanently shadowed settings and may be mixed with regolith.', 'Testing ice-recognition instruments and sampling procedures.'),
  ('TER-04-MOON', 'water.subsurface_ice', 88::numeric, 'Subsurface ice', 'Ancient glacial ice can remain buried beneath dry sediment and moraine deposits. Lunar polar ice may also be concealed beneath surface material, although its origin, temperature, and physical distribution differ.', 'Evaluating ground-penetrating sensing and buried-ice detection.'),
  ('TER-04-MOON', 'water.permafrost', 85::numeric, 'Permafrost', 'The Dry Valleys contain extensive frozen ground. Lunar polar regolith can remain at temperatures low enough to preserve ice for extremely long periods, but it lacks ordinary terrestrial freeze–thaw processes.', 'Testing drilling, sampling, and robotic mobility in frozen substrates.'),
  ('TER-04-MOON', 'water.hydrogen', 62::numeric, 'Hydrogen-bearing materials', 'Hydrogen is present in Antarctic ice, lake water, and frozen sediments. Lunar hydrogen may occur in water ice, hydroxyl-bearing materials, or implanted particles. Hydrogen detection does not necessarily identify its chemical form.', 'Testing hydrogen-sensitive instruments and interpreting ice-related measurements.'),
  ('TER-04-MOON', 'water.mineral_resources', 42::numeric, 'Mineral resources', 'The region contains salts and geological materials of scientific interest. Lunar resource studies focus on oxygen-bearing minerals, metals, and polar volatiles. Antarctic materials are protected by environmental and treaty restrictions.', 'Nonextractive mineral characterization and preliminary resource-sensing studies.'),
  ('TER-04-MOON', 'atmosphere.wind', 0::numeric, 'Wind', 'The Dry Valleys experience powerful katabatic winds, with the supplied research reporting speeds of approximately 10–25 m/s. The Moon lacks a dense atmosphere capable of comparable wind.', 'Separating terrestrial atmospheric effects from lunar dust behavior.'),
  ('TER-04-MOON', 'atmosphere.dust', 62::numeric, 'Abrasive dust', 'Dry Antarctic sediments can contain fine mineral particles capable of abrading equipment. Lunar dust differs in its formation, grain morphology, electrostatic properties, and exposure history.', 'Testing seals, joints, optical surfaces, and mechanical components.'),
  ('TER-04-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Aeolian erosion', 'Wind erosion shapes Antarctic ventifacts and sediments. Conventional atmospheric wind erosion does not occur on the present Moon.', 'Preventing inappropriate geological equivalence between terrestrial and lunar erosion.'),
  ('TER-04-MOON', 'atmosphere.dust_storms', null::numeric, 'Dust storms', 'Antarctic dust events are driven by atmospheric winds, whereas lunar dust movement involves different processes.', 'Distinguishing terrestrial dust-storm testing from lunar particle-environment simulation.'),
  ('TER-04-MOON', 'atmosphere.sediments', 55::numeric, 'Sediments and granular deposits', 'Dry moraine sediments, fine mineral deposits, and rocky pavements provide granular test surfaces. Lunar regolith differs in origin, grain properties, and cohesion.', 'Evaluating excavation, granular sampling, and rover–soil interaction.'),
  ('TER-04-MOON', 'atmosphere.aerosols', null::numeric, 'Aerosols', 'Antarctic marine and mineral aerosols exist within Earth’s atmosphere. There is no directly equivalent dense atmospheric aerosol system on the Moon.', 'Identifying environmental testing that cannot be transferred directly to lunar conditions.'),
  ('TER-04-MOON', 'subsurface.caves', 20::numeric, 'Caves', 'The supplied research describes very limited natural cavities, including possible salt-related openings and fractures. These differ from the volcanic cavities potentially present on the Moon.', 'Testing basic cavity detection in limited geological settings.'),
  ('TER-04-MOON', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'The research identifies no lava-tube systems within the selected Dry Valleys geological environment. Lunar lava tubes are associated with ancient basaltic volcanism.', 'Identifying the need for another terrestrial analog when testing lava-tube exploration.'),
  ('TER-04-MOON', 'subsurface.fractures', 65::numeric, 'Cavities and fractures', 'Thermal-contraction cracking and fractures in frozen ground provide structural obstacles. Lunar terrain also contains fractures and collapse-related features, although their origins differ.', 'Testing fracture detection and robotic hazard recognition.'),
  ('TER-04-MOON', 'subsurface.subsurface_structure', 72::numeric, 'Subsurface structure', 'The Dry Valleys contain sedimentary and metamorphic rock sequences overlain by frozen soils and glacial deposits. Lunar subsurface materials include impact-related regolith and volcanic or crustal layers.', 'Evaluating subsurface imaging and stratigraphic interpretation.'),
  ('TER-04-MOON', 'subsurface.material_thickness', 60::numeric, 'Material thickness', 'The supplied research describes variable soil and sediment thicknesses ranging from approximately one meter to several tens of meters. Lunar regolith thickness varies with terrain and geological history.', 'Testing methods for estimating the thickness of overlying material.'),
  ('TER-04-MOON', 'biology.direct_similarity', null::numeric, 'Direct biological similarity', 'No confirmed indigenous lunar life has been identified.', 'Defining the limits of biological analog comparisons.'),
  ('TER-04-MOON', 'biology.extremophiles', null::numeric, 'Extremophile organisms', 'The Dry Valleys contain microbial communities adapted to extreme terrestrial environments, but these cannot be compared with confirmed lunar organisms.', 'Testing terrestrial biological instruments and contamination monitoring.'),
  ('TER-04-MOON', 'biology.habitability', null::numeric, 'Habitability conditions', 'Some protected microenvironments in Antarctica support life. The exposed lunar environment lacks comparable natural biological conditions.', 'Evaluating life-support research and contamination-control procedures.'),
  ('TER-04-MOON', 'biology.biosignatures', null::numeric, 'Biosignatures', 'Antarctic microbial traces cannot be compared with confirmed indigenous lunar biosignatures.', 'Developing methods to identify biological contamination in geological samples.'),
  ('TER-04-MOON', 'biology.adaptations', null::numeric, 'Biological adaptations', 'Antarctic microorganisms possess adaptations to extreme cold and desiccation, but there is no confirmed lunar biology for direct comparison.', 'Studying terrestrial microbial resilience in controlled experiments.'),
  ('TER-04-MARS', 'topography.elevation', 48::numeric, 'Elevation', 'The region extends from near sea level to mountain crests above 2,000 m. Martian topography spans a much larger planetary relief range, including volcanic mountains and impact basins. Elevations are referenced to different planetary datums.', 'Testing elevation-based navigation and geological field planning.'),
  ('TER-04-MARS', 'topography.slope', 80::numeric, 'Slope', 'The supplied research describes relatively flat valley floors with slopes of approximately 1–5° and steep surrounding rock walls exceeding 40°. Mars contains gently sloping plains, steep crater walls, and canyon slopes.', 'Testing rover stability, traction, and slope classification.'),
  ('TER-04-MARS', 'topography.roughness', 86::numeric, 'Surface roughness', 'Antarctic desert pavements contain angular rocks, glacial erratics, and fractured ground. Martian surfaces also contain rocky obstacles and irregular terrain, although the mechanisms producing their roughness may differ.', 'Evaluating rover mobility, suspension systems, and autonomous obstacle avoidance.'),
  ('TER-04-MARS', 'topography.relief', 81::numeric, 'Relief', 'Broad glacial troughs, steep valley walls, and ancient moraines provide examples of cold-region relief. Mars contains valleys and landforms associated with ancient ice-related processes, impacts, volcanism, and erosion.', 'Training terrain-recognition systems and interpreting planetary topography.'),
  ('TER-04-MARS', 'topography.craters', 22::numeric, 'Craters', 'The Dry Valleys are not characterized by extensive impact-crater fields. Small depressions formed by deflation or frozen-ground processes may resemble crater-like shapes but have different origins.', 'Testing geological algorithms that distinguish impact features from other depressions.'),
  ('TER-04-MARS', 'topography.obstacles', 88::numeric, 'Surface obstacles', 'Glacial boulders, angular rocks, ventifacts, and ground fractures create physical hazards similar to some Martian rocky terrains.', 'Testing obstacle detection, autonomous navigation, and route selection.'),
  ('TER-04-MARS', 'thermal.surface_temperature', 84::numeric, 'Surface temperature', 'The supplied terrestrial research describes very cold annual conditions, approximately −20°C to −30°C. These values are not necessarily standardized ground-surface measurements. Martian surface temperatures can fall much lower and vary significantly by season, latitude, and time of day.', 'Preliminary testing of instruments intended for cold planetary environments.'),
  ('TER-04-MARS', 'thermal.temperature_extremes', 78::numeric, 'Maximum and minimum temperatures', 'The Dry Valleys experience occasional summer temperatures above freezing and winter minima approaching −50°C. Mars experiences a broader thermal range, with very cold polar conditions and substantial daily variation.', 'Testing equipment under freezing conditions and identifying requirements for more extreme thermal simulation.'),
  ('TER-04-MARS', 'thermal.thermal_variation', 81::numeric, 'Thermal variation', 'Antarctic polar environments experience pronounced seasonal temperature changes associated with prolonged daylight and darkness. Mars also experiences seasonal thermal variation, although its thin atmosphere and orbital conditions produce different temperature behavior.', 'Testing long-duration environmental monitoring and thermal-response systems.'),
  ('TER-04-MARS', 'thermal.seasonality', 84::numeric, 'Seasonality', 'Antarctic seasons strongly influence daylight, temperature, frozen ground, and ice conditions. Mars also experiences significant seasons, including changes in polar carbon dioxide frost and atmospheric pressure.', 'Designing seasonal observation strategies and long-duration field experiments.'),
  ('TER-04-MARS', 'thermal.solar_illumination', 84::numeric, 'Solar illumination', 'The Dry Valleys experience prolonged summer daylight and winter darkness, with low solar angles. Martian polar regions also undergo extreme seasonal illumination changes, although the orbital and atmospheric conditions differ.', 'Testing optical navigation, low-angle imaging, and solar-energy monitoring.'),
  ('TER-04-MARS', 'thermal.atmospheric_conditions', 12::numeric, 'Atmospheric pressure', 'Antarctica retains Earth’s relatively dense atmosphere, while the mean Martian surface pressure is approximately 600 Pa. Antarctic atmospheric pressure cannot reproduce the low-pressure Martian environment.', 'Identifying the need for controlled low-pressure environmental chambers.'),
  ('TER-04-MARS', 'geology.rock_type', 59::numeric, 'Rock type', 'The Dry Valleys contain Beacon sandstones, Ferrar dolerites, granitic rocks, and metamorphic basement. Mars contains widespread basaltic rocks as well as sedimentary formations. Ferrar dolerites and sedimentary rocks offer partial comparisons, but the overall lithologies differ.', 'Testing geological classification and rock-identification instruments.'),
  ('TER-04-MARS', 'geology.mineral_composition', 73::numeric, 'Mineralogical composition', 'Antarctic rocks contain silicate minerals and soluble salts. Mars also contains silicate minerals, clay-bearing deposits, and salts, although their mineral proportions and geological histories differ.', 'Testing mineral spectroscopy and salt identification.'),
  ('TER-04-MARS', 'geology.chemical_composition', 79::numeric, 'Chemical composition', 'The Dry Valleys accumulate soluble salts under extremely dry conditions. Mars also contains salt-bearing materials and oxidized surface chemistry, including sulfates and oxychlorine compounds in certain regions. Direct chemical equivalence requires mineral-specific measurements.', 'Testing elemental analysis and chemical detection of salts.'),
  ('TER-04-MARS', 'geology.surface_material', 89::numeric, 'Surface material', 'The region contains dry sediments, frozen regolith-like material, rocky pavements, and ancient moraine deposits. Mars contains loose surface materials, dust, and rock fragments, with some regions preserving ice-rich or sedimentary surfaces.', 'Evaluating sampling instruments, rover–soil interactions, and granular-material classification.'),
  ('TER-04-MARS', 'geology.alteration', 91::numeric, 'Geological alteration', 'Antarctic weathering is dominated by physical processes, including salt crystallization and thermal cracking, with limited liquid-water alteration in the driest environments. Some Martian terrains also preserve evidence of prolonged aridity and physical weathering.', 'Studying mineral preservation, salt-related weathering, and geological alteration signatures.'),
  ('TER-04-MARS', 'geology.formations', 78::numeric, 'Geological formations', 'The Dry Valleys contain ancient glacial valleys, moraines, ice-covered lake basins, and layered geological sequences. Mars preserves evidence of ancient water- and ice-related processes, although its landforms have different histories and scales.', 'Interpreting cold-region sedimentary structures and reconstructing geological history.'),
  ('TER-04-MARS', 'water.surface_water', 63::numeric, 'Surface water', 'The Dry Valleys contain lakes that remain covered by ice and may experience localized seasonal meltwater. Present-day Mars generally lacks stable exposed liquid water, but preserves evidence of past aqueous activity.', 'Investigating ice-covered water systems and understanding the limitations of present-day hydrological analogs.'),
  ('TER-04-MARS', 'water.surface_ice', 95::numeric, 'Surface ice', 'Antarctic glaciers and permanently ice-covered lakes provide accessible environments for ice-related field research. Mars contains polar ice deposits and exposed or near-surface ice in selected regions, although their temperatures, compositions, and formation histories differ.', 'Testing ice-recognition instruments and robotic operations near frozen deposits.'),
  ('TER-04-MARS', 'water.subsurface_ice', 97::numeric, 'Subsurface ice', 'Ancient glacial ice remains buried beneath dry sediments and moraine deposits in parts of the Dry Valleys. Mars also contains buried ice-rich deposits, including midlatitude and polar subsurface ice.', 'Testing ground-penetrating radar, buried-ice detection, and subsurface sampling.'),
  ('TER-04-MARS', 'water.permafrost', 98::numeric, 'Permafrost', 'The Dry Valleys contain extensive continuous permafrost. Mars has widespread cold ground conditions favorable to the preservation of subsurface ice, although its temperature, pressure, and ice distribution differ.', 'Studying frozen-ground structure, sampling resistance, and ice-related geological processes.'),
  ('TER-04-MARS', 'water.hydrogen', 94::numeric, 'Hydrogen-bearing materials', 'Antarctic ice and frozen sediments contain hydrogen-bearing water molecules. Martian neutron and gamma-ray observations can identify hydrogen enrichment associated with water ice or hydrated minerals, but do not always establish the precise chemical form.', 'Testing hydrogen-detection instruments and interpreting ice-related remote-sensing data.'),
  ('TER-04-MARS', 'water.past_water', 94::numeric, 'Evidence of past water', 'Ancient moraines, glacial valleys, ice-covered lakes, and sedimentary deposits preserve evidence of long-term ice and water-related processes. Mars also preserves geological evidence of ancient rivers, lakes, glaciers, and ice-rich deposits.', 'Testing methods for reconstructing ancient hydrological and cryogenic environments.'),
  ('TER-04-MARS', 'water.mineral_resources', 77::numeric, 'Mineral resources', 'The Dry Valleys contain salts and geological materials of scientific interest. Martian exploration considers water ice and selected mineral deposits as potential resources. Antarctic environmental protections prohibit treating the region as a resource-extraction test site without appropriate authorization.', 'Nonextractive resource identification, mineral mapping, and ice-resource reconnaissance.'),
  ('TER-04-MARS', 'atmosphere.atmospheric_pressure', 12::numeric, 'Atmospheric pressure', 'Antarctic atmospheric pressure is vastly greater than the mean Martian surface pressure. The cold and dry Antarctic atmosphere is not equivalent to the thin Martian atmosphere.', 'Establishing which atmospheric tests require low-pressure facilities.'),
  ('TER-04-MARS', 'atmosphere.atmospheric_composition', 8::numeric, 'Atmospheric composition', 'Antarctica has Earth’s nitrogen- and oxygen-rich atmosphere. Mars has a carbon dioxide-dominated atmosphere with different trace gases and aerosol conditions.', 'Defining limitations of open-air atmospheric instrument testing.'),
  ('TER-04-MARS', 'atmosphere.wind', 91::numeric, 'Wind', 'The supplied research describes katabatic winds reaching approximately 10–25 m/s. Martian winds also transport dust and sand, although the lower atmospheric density produces different forces on particles and equipment.', 'Testing wind sensors and investigating wind-driven sediment movement.'),
  ('TER-04-MARS', 'atmosphere.dust', 91::numeric, 'Dust', 'Fine mineral particles can be lifted from exposed Antarctic sediments by strong winds. Mars also contains extensive fine dust, although Martian particle chemistry and atmospheric transport differ.', 'Testing dust sensors, optical systems, and protective equipment.'),
  ('TER-04-MARS', 'atmosphere.dust_storms', 85::numeric, 'Dust storms', 'The Dry Valleys experience localized wind-driven dust events. Mars experiences dust storms at multiple spatial scales, including planet-encircling events. Their atmospheric physics and geographic extent differ.', 'Evaluating dust monitoring, sensor visibility, and equipment exposure.'),
  ('TER-04-MARS', 'atmosphere.aeolian_erosion', 96::numeric, 'Aeolian erosion and sediments', 'Katabatic winds shape ventifacts and redistribute fine sediments. Mars contains extensive wind-eroded rocks, dunes, and sediment deposits. Both environments demonstrate how moving particles can modify exposed geological surfaces.', 'Studying ventifact formation, sediment transport, and wind-driven erosion.'),
  ('TER-04-MARS', 'atmosphere.aerosols', 74::numeric, 'Aerosols', 'Antarctic air contains suspended mineral particles and marine aerosols. Mars contains mineral dust and other atmospheric aerosols, but their composition and behavior differ.', 'Testing particle-monitoring instruments and studying aerosol-related interference.'),
  ('TER-04-MARS', 'subsurface.caves', 28::numeric, 'Caves and cavities', 'The supplied research describes limited natural cavities, including possible salt-related openings and thermal fractures. These do not reproduce the full diversity of potential Martian volcanic cavities.', 'Testing limited cavity-detection and structural imaging techniques.'),
  ('TER-04-MARS', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'The selected Dry Valleys environment does not contain the lava-tube systems required for a direct Martian lava-tube comparison.', 'Identifying the need for a separate volcanic analog site.'),
  ('TER-04-MARS', 'subsurface.fractures', 90::numeric, 'Fractures and faults', 'Thermal contraction produces polygonal cracking in frozen ground, while older geological structures include fractures and faults. Mars also contains polygonal ground and tectonic fractures.', 'Testing fracture detection and identifying potential ground hazards.'),
  ('TER-04-MARS', 'subsurface.subsurface_structure', 91::numeric, 'Subsurface structure', 'The Dry Valleys contain frozen soils, buried ice, sedimentary layers, and underlying rock sequences. Mars contains layered sedimentary and volcanic materials and ice-rich subsurface deposits.', 'Testing ground-penetrating radar and subsurface geological interpretation.'),
  ('TER-04-MARS', 'subsurface.material_thickness', 83::numeric, 'Material thickness', 'The supplied terrestrial research describes sediment and soil layers ranging from approximately one meter to several tens of meters. Martian subsurface deposits vary greatly in thickness and require site-specific comparison.', 'Evaluating subsurface layer-thickness estimation and stratigraphic models.'),
  ('TER-04-MARS', 'biology.extremophiles', 95::numeric, 'Extremophile organisms', 'The Dry Valleys contain microorganisms that inhabit protected pore spaces within rocks, including cryptoendolithic microbial communities. Mars has no confirmed indigenous life, but protected subsurface microenvironments are relevant to hypotheses about potential past or present habitability.', 'Testing biological detection instruments and investigating microbial survival strategies.'),
  ('TER-04-MARS', 'biology.habitability', 89::numeric, 'Habitability conditions', 'The Dry Valleys combine persistent cold, severe desiccation, limited nutrients, and high ultraviolet exposure. These stresses overlap with some challenges associated with Martian environments, although Antarctic habitats remain considerably more favorable to terrestrial life.', 'Studying environmental limits for microbial survival and potential habitability indicators.'),
  ('TER-04-MARS', 'biology.biosignatures', 93::numeric, 'Potential biosignatures', 'Microbial communities can leave pigments, organic molecules, and other biological traces within rocks and frozen sediments. These provide test materials for instruments intended to identify potential biosignatures in Martian geological samples.', 'Evaluating biosignature detection and distinguishing biological from nonbiological signals.'),
  ('TER-04-MARS', 'biology.adaptations', 91::numeric, 'Biological adaptations', 'Antarctic microorganisms may survive through slow metabolism, desiccation tolerance, and exploitation of protected rock microenvironments. These adaptations provide terrestrial models for exploring possible biological survival strategies under extreme conditions.', 'Studying microbial adaptation, preservation, and environmental tolerance.'),
  ('TER-05-MOON', 'topography.elevation', 48::numeric, 'Elevation', 'Haughton lies approximately 200–400 m above sea level on Devon Island’s Arctic plateau. Lunar elevations span a much larger planetary range, approximately −9.1 to

+10.8 km relative to the lunar reference sphere in the supplied lunar dataset. These values use different reference surfaces and cannot be compared directly without normalization.', 'Evaluating elevation-based navigation and local topographic reconstruction.'),
  ('TER-05-MOON', 'topography.slope', 75::numeric, 'Slope', 'The crater has moderately eroded walls and relatively gentle slopes within parts of its interior. Lunar complex craters may have substantially steeper inner walls, terraces, and central peaks. Erosion has reduced the resemblance between Haughton’s present slopes and those of fresh lunar craters.', 'Testing rover traction, route planning, and crater-wall reconnaissance.'),
  ('TER-05-MOON', 'topography.roughness', 88::numeric, 'Surface roughness', 'Haughton’s impact breccias, fractured blocks, and irregular rocky deposits produce substantial local roughness. Lunar crater floors, rims, and ejecta deposits also contain fragmented materials and rough terrain, although the detailed surface textures depend on impact age and subsequent space weathering.', 'Evaluating rover suspension, obstacle avoidance, and terrain classification.'),
  ('TER-05-MOON', 'topography.relief', 90::numeric, 'Relief', 'Haughton contains a complex impact depression and central structural uplift. Lunar complex craters also develop central uplifts and other structures during impact modification. Their present relief differs because Haughton has undergone terrestrial erosion.', 'Identifying impact-generated relief and reconstructing crater morphology.'),
  ('TER-05-MOON', 'topography.craters', 98::numeric, 'Impact craters', 'Haughton is a genuine hypervelocity impact structure. The Moon contains numerous simple and complex impact craters, including examples of central uplifts and extensive impact brecciation. The formation mechanism is directly comparable, although the target lithology, gravity, atmosphere, and subsequent erosion differ.', 'Studying impact geology, crater evolution, and geological sampling strategies.'),
  ('TER-05-MOON', 'topography.obstacles', 90::numeric, 'Surface obstacles', 'Large angular impact blocks, carbonate fragments, fractured bedrock, and polygonal frozen ground create hazards for surface exploration. Lunar crater terrains also contain ejecta blocks, fractured rocks, and irregular ground.', 'Testing autonomous navigation and robotic obstacle detection.'),
  ('TER-05-MOON', 'thermal.surface_temperature', 43::numeric, 'Surface temperature', 'The terrestrial research reports an annual mean temperature near −15°C. This is a climatic temperature estimate, not necessarily a direct land-surface temperature measurement. Lunar surface temperatures vary enormously, from extremely cold permanently shadowed regions to strongly heated sunlit terrain.', 'Preliminary testing of instruments under cold terrestrial conditions.'),
  ('TER-05-MOON', 'thermal.temperature_extremes', 39::numeric, 'Maximum and minimum temperatures', 'The supplied research describes brief summer maxima of approximately +5°C to +10°C and winter minima approaching −40°C to −50°C. Lunar temperatures can range from approximately −247°C in exceptionally cold polar shadows to above +100°C in sunlit low-latitude terrain.', 'Identifying equipment that requires additional thermal-vacuum qualification.'),
  ('TER-05-MOON', 'thermal.thermal_variation', 38::numeric, 'Thermal variation', 'Haughton’s climate is strongly seasonal, with prolonged Arctic winters and short summers. The lunar day–night cycle lasts approximately 29.5 Earth days, and lunar surface temperature variations depend strongly on latitude and illumination.', 'Testing thermal monitoring systems while identifying differences in thermal cycling.'),
  ('TER-05-MOON', 'thermal.solar_illumination', 78::numeric, 'Solar illumination', 'Devon Island experiences prolonged summer daylight and winter darkness. Lunar polar terrain can also experience extended illumination or shadow, although its illumination geometry differs because the Moon has a much smaller axial tilt.', 'Testing low-angle illumination imaging and polar mission-planning methods.'),
  ('TER-05-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Atmospheric conditions / exosphere', 'Haughton is exposed to Earth’s nitrogen- and oxygen-rich atmosphere. The Moon has an extremely tenuous exosphere, with no comparable atmospheric pressure or aerodynamic wind.', 'Establishing the need for controlled vacuum testing.'),
  ('TER-05-MOON', 'geology.rock_type', 63::numeric, 'Rock type', 'Haughton’s target rocks include Paleozoic limestone and dolostone, with impact breccias and local igneous material. Lunar impact structures predominantly involve basaltic, anorthositic, and other silicate-rich crustal materials. Impact fragmentation is comparable, but the starting lithologies differ.', 'Distinguishing impact-generated textures from original rock composition.'),
  ('TER-05-MOON', 'geology.mineral_composition', 47::numeric, 'Mineralogical composition', 'Haughton contains calcite, dolomite, quartz, feldspars, and alteration minerals. Lunar materials are dominated by plagioclase, pyroxene, olivine, and related minerals. Shock features can be studied in both settings, but mineralogical equivalence is limited.', 'Testing mineral spectroscopy and shock-feature identification.'),
  ('TER-05-MOON', 'geology.chemical_composition', 39::numeric, 'Chemical composition', 'Haughton’s carbonate rocks are enriched in calcium- and magnesium-bearing carbonate minerals. Lunar highlands and maria have different oxide compositions, and extensive carbonate sedimentary deposits are not characteristic of the Moon.', 'Testing geochemical discrimination between impact processes and target-rock chemistry.'),
  ('TER-05-MOON', 'geology.surface_material', 78::numeric, 'Surface material', 'Haughton contains impact-generated rock fragments, breccia blocks, and loose sediments. Lunar regolith also contains impact-fragmented material, but lunar grains may include agglutinates, impact glass, and space-weathered particles absent from ordinary terrestrial sediments.', 'Evaluating excavation, sampling, and rock-fragment classification.'),
  ('TER-05-MOON', 'geology.alteration', 55::numeric, 'Geological alteration', 'Haughton has experienced physical weathering, periglacial modification, and water-related chemical alteration. Lunar impact materials undergo space weathering and micrometeorite bombardment without comparable atmospheric or aqueous processes.', 'Distinguishing primary impact features from later geological modification.'),
  ('TER-05-MOON', 'geology.formations', 96::numeric, 'Geological formations', 'Haughton’s complex impact structure, central uplift, fractured rocks, and breccia deposits have strong structural counterparts in lunar complex craters. Differences arise from subsequent erosion and the properties of the impacted target rocks.', 'Reconstructing impact-crater formation and interpreting crater stratigraphy.'),
  ('TER-05-MOON', 'water.surface_water', 8::numeric, 'Surface water', 'Haughton may contain seasonal meltwater ponds and streams. Stable exposed liquid water is not supported on the lunar surface.', 'Identifying the limits of terrestrial hydrological comparisons.'),
  ('TER-05-MOON', 'water.surface_ice', 51::numeric, 'Surface ice', 'Devon Island contains seasonal snow and nearby ice-covered terrain. Lunar polar ice is associated primarily with extremely cold traps, including permanently shadowed regions.', 'Preliminary ice-identification and polar sampling tests.'),
  ('TER-05-MOON', 'water.subsurface_ice', 72::numeric, 'Subsurface ice', 'The terrestrial research describes buried ice lenses and ice-rich frozen ground. Lunar polar subsurface ice may also occur beneath regolith, but its distribution, formation, and stability differ.', 'Testing subsurface ice detection and frozen-material sampling.'),
  ('TER-05-MOON', 'water.permafrost', 67::numeric, 'Permafrost', 'Haughton has continuous terrestrial permafrost. Lunar polar ground can remain permanently cold, but does not experience the same active-layer freeze–thaw cycle.', 'Evaluating drilling and robotic movement in frozen ground.'),
  ('TER-05-MOON', 'water.hydrogen', 54::numeric, 'Hydrogen-bearing materials', 'Hydrogen is present in water ice and water-bearing materials at Haughton. Lunar hydrogen can occur in ice, hydroxyl-bearing materials, and solar-wind-implanted particles.', 'Testing hydrogen-sensitive instruments while distinguishing chemical forms.'),
  ('TER-05-MOON', 'water.mineral_resources', 36::numeric, 'Mineral resources', 'Haughton’s fractured carbonate rocks and geological deposits are useful research materials. Lunar resource investigations focus on oxygen-bearing silicates, metals, and polar volatiles.', 'Testing nonextractive mineral characterization and resource-identification methods.'),
  ('TER-05-MOON', 'atmosphere.wind', 0::numeric, 'Wind', 'Haughton experiences Arctic winds, while the Moon lacks a sufficiently dense atmosphere to support conventional wind.', 'Identifying processes that require lunar-specific simulation rather than terrestrial field testing.'),
  ('TER-05-MOON', 'atmosphere.dust', 56::numeric, 'Abrasive dust', 'Wind can mobilize fine mineral particles from dry crater sediments. Lunar dust is also abrasive but differs in grain origin, electrical behavior, and exposure history.', 'Testing dust-resistant equipment and particle-sensitive instruments.'),
  ('TER-05-MOON', 'atmosphere.dust_storms', null::numeric, 'Dust storms', 'Terrestrial dust events require atmospheric transport. Lunar dust disturbances arise through different mechanisms, including impacts and spacecraft operations.', 'Preventing inappropriate comparison of unrelated particle-transport processes.'),
  ('TER-05-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Aeolian erosion', 'Wind-driven abrasion modifies Haughton’s exposed rocks. Lunar surface modification is dominated by impact gardening and space weathering rather than wind erosion.', 'Distinguishing impact-related surface alteration from atmospheric erosion.'),
  ('TER-05-MOON', 'atmosphere.sediments', 55::numeric, 'Sediments and granular deposits', 'Haughton contains impact debris, periglacial sediments, and locally wind-transported fine materials. Lunar granular deposits are dominated by impact fragmentation and volcanic processes.', 'Testing sampling mechanisms and granular-material classification.'),
  ('TER-05-MOON', 'atmosphere.aerosols', null::numeric, 'Aerosols', 'Haughton contains atmospheric mineral and marine aerosols. The Moon does not possess a comparable atmospheric aerosol system.', 'Identifying atmospheric testing limitations.'),
  ('TER-05-MOON', 'subsurface.caves', 30::numeric, 'Caves', 'The supplied terrestrial research describes fractures and possible thermokarst-related cavities. These should not be interpreted as evidence of extensive mapped cave systems. Lunar cavities may occur through volcanic or collapse processes.', 'Testing limited cavity-detection methods.'),
  ('TER-05-MOON', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'No lava-tube system is documented in the selected Haughton impact environment. Lunar lava tubes are associated with ancient volcanic activity.', 'Identifying when a volcanic terrestrial analog is required instead.'),
  ('TER-05-MOON', 'subsurface.fractures', 94::numeric, 'Cavities and fractures', 'Impact deformation produced extensive fractures, faults, and brecciated rock. Lunar impact structures also contain intensely fractured material and displaced blocks.', 'Testing fracture detection and geological hazard assessment.'),
  ('TER-05-MOON', 'subsurface.subsurface_structure', 92::numeric, 'Subsurface structure', 'Haughton contains a complex impact-modified subsurface, including megabreccia and displaced carbonate strata. Lunar impact structures also produce fractured and redistributed subsurface materials.', 'Evaluating ground-penetrating imaging and impact-structure reconstruction.'),
  ('TER-05-MOON', 'subsurface.material_thickness', 81::numeric, 'Material thickness', 'The terrestrial research describes impact-related deposits and fill materials ranging from meters to potentially much greater thicknesses in the structure. Lunar impact deposits also vary in thickness, depending on crater size and location.', 'Testing stratigraphic reconstruction and overburden-thickness estimation.'),
  ('TER-05-MOON', 'biology.extremophiles', null::numeric, 'Extremophile organisms', 'Arctic microorganisms cannot be compared with confirmed lunar organisms because none have been identified.', 'Testing biological instruments and contamination-monitoring procedures.'),
  ('TER-05-MOON', 'biology.habitability', null::numeric, 'Habitability conditions', 'Haughton contains terrestrial environments that can support microbial activity. The exposed lunar environment lacks comparable confirmed natural habitats.', 'Supporting planetary protection and controlled biological experiments.'),
  ('TER-05-MOON', 'biology.biosignatures', null::numeric, 'Biosignatures', 'Biological traces at Haughton have no confirmed indigenous lunar biosignature counterpart.', 'Distinguishing terrestrial biological contamination from geological signals.'),
  ('TER-05-MOON', 'biology.adaptations', null::numeric, 'Biological adaptations', 'Cold-adapted terrestrial organisms have no confirmed lunar biological equivalents.', 'Studying terrestrial microbial survival without implying lunar habitability.'),
  ('TER-05-MARS', 'topography.elevation', 51::numeric, 'Elevation', 'Haughton lies approximately 200–400 m above sea level. Martian elevations are referenced to the areoid, and planetary relief spans a much greater range. Elevation must be compared using locally normalized terrain models rather than raw absolute values.', 'Testing elevation-based terrain interpretation and mission-route planning.'),
  ('TER-05-MARS', 'topography.slope', 82::numeric, 'Slope', 'Haughton contains moderately eroded crater walls, gentle interior slopes, and locally steeper fractured terrain. Martian impact craters exhibit similarly varied slopes, including steep walls, terraces, and relatively flat crater floors.', 'Testing rover stability and slope-dependent navigation.'),
  ('TER-05-MARS', 'topography.roughness', 90::numeric, 'Surface roughness', 'Impact breccias, angular blocks, and fractured bedrock produce highly irregular surfaces. Martian impact-crater floors and ejecta deposits also contain rocky obstacles and variable roughness.', 'Evaluating rover suspension, obstacle avoidance, and terrain-classification systems.'),
  ('TER-05-MARS', 'topography.relief', 94::numeric, 'Relief', 'Haughton’s central uplift and surrounding impact depression are characteristic of complex impact structures. Comparable relief occurs in Martian complex craters, although the exact dimensions and preservation states differ.', 'Reconstructing impact morphology and identifying structural features from topographic data.'),
  ('TER-05-MARS', 'topography.craters', 98::numeric, 'Impact craters', 'Haughton formed through hypervelocity impact, the same fundamental process responsible for Martian impact craters. Differences arise from gravity, atmosphere, target material, erosion, and geological age.', 'Testing crater-recognition algorithms and studying impact-generated geology.'),
  ('TER-05-MARS', 'topography.obstacles', 93::numeric, 'Surface obstacles', 'Haughton contains large angular blocks, fractured carbonate rocks, breccia deposits, and patterned frozen ground. These resemble operational hazards found in some Martian rocky crater environments.', 'Testing autonomous navigation and geological sampling near obstacles.'),
  ('TER-05-MARS', 'thermal.surface_temperature', 77::numeric, 'Surface temperature', 'The supplied terrestrial research reports a mean annual temperature near −15°C. This climatic figure is not directly equivalent to a measured surface temperature. Mars exhibits much colder surface conditions in many locations, with strong daily and seasonal variation.', 'Testing instruments under cold terrestrial field conditions.'),
  ('TER-05-MARS', 'thermal.temperature_extremes', 79::numeric, 'Maximum and minimum temperatures', 'Haughton’s short summer maxima and severe winter minima overlap with part of the Martian thermal range. Mars can experience much lower temperatures, especially in polar regions.', 'Evaluating cold-weather equipment and identifying additional thermal qualification requirements.'),
  ('TER-05-MARS', 'thermal.thermal_variation', 78::numeric, 'Thermal variation', 'Haughton experiences substantial seasonal thermal variation. Mars also undergoes seasonal changes, but its thin atmosphere produces different heat-transfer and diurnal temperature behavior.', 'Testing thermal monitoring and seasonal field instrumentation.'),
  ('TER-05-MARS', 'thermal.seasonality', 85::numeric, 'Seasonality', 'Devon Island experiences long Arctic winters and brief summers. Mars has significant seasons because of its axial tilt, including seasonal changes in polar frost and atmospheric pressure.', 'Planning seasonal observation campaigns and polar exploration schedules.'),
  ('TER-05-MARS', 'thermal.solar_illumination', 83::numeric, 'Solar illumination', 'Devon Island experiences midnight sun during summer and prolonged darkness during winter. Martian high latitudes also undergo substantial seasonal illumination changes.', 'Testing low-angle optical imaging, navigation, and solar-power monitoring.'),
  ('TER-05-MARS', 'thermal.atmospheric_conditions', 12::numeric, 'Atmospheric pressure', 'Haughton retains Earth’s relatively dense atmosphere, while the mean Martian surface pressure is approximately 600 Pa. These conditions are not physically equivalent.', 'Establishing the need for low-pressure chambers during Mars-specific equipment qualification.'),
  ('TER-05-MARS', 'geology.rock_type', 60::numeric, 'Rock type', 'Haughton is dominated by impact-modified limestone, dolostone, and related sedimentary rocks. Mars contains widespread basaltic materials and sedimentary rocks. The impact-generated textures are comparable, but the starting rock assemblages differ.', 'Testing lithological classification and distinguishing target-rock composition from impact processes.'),
  ('TER-05-MARS', 'geology.mineral_composition', 65::numeric, 'Mineralogical composition', 'Haughton contains calcite, dolomite, quartz, feldspar, and alteration minerals. Mars contains silicates, clays, sulfates, and other minerals associated with different geological environments. The mineralogical overlap is partial and site-dependent.', 'Evaluating mineral spectroscopy and identifying alteration signatures.'),
  ('TER-05-MARS', 'geology.chemical_composition', 59::numeric, 'Chemical composition', 'Haughton’s carbonate-rich rocks contain substantial calcium and magnesium carbonates. Carbonate minerals have also been identified in some Martian settings, but Mars is not dominated by carbonate bedrock.', 'Investigating carbonate detection and impact-related geochemical changes.'),
  ('TER-05-MARS', 'geology.surface_material', 83::numeric, 'Surface material', 'Impact breccias, fragmented rocks, dry sediments, and periglacial deposits create varied surface materials. Mars contains similarly heterogeneous rocky and granular terrains, particularly within impact craters.', 'Testing sampling instruments and geological surface classification.'),
  ('TER-05-MARS', 'geology.alteration', 78::numeric, 'Geological alteration', 'Haughton’s rocks have undergone impact shock, fracturing, physical weathering, and localized water-related alteration. Martian rocks also preserve impact and aqueous alteration signatures, although their environmental histories differ.', 'Studying mineral alteration and identifying geological processes from rock textures.'),
  ('TER-05-MARS', 'geology.formations', 95::numeric, 'Geological formations', 'Haughton’s complex impact structure, central uplift, breccias, and fractured strata have strong counterparts in Martian complex craters. Later terrestrial erosion changes their present-day expression.', 'Reconstructing impact structures and interpreting crater-related geological sequences.'),
  ('TER-05-MARS', 'water.surface_water', 38::numeric, 'Surface water', 'Haughton can contain temporary summer ponds and meltwater streams. Present-day Mars generally does not support stable exposed liquid water under its low atmospheric pressure.', 'Investigating water-related geological processes while distinguishing modern terrestrial hydrology from Martian conditions.'),
  ('TER-05-MARS', 'water.surface_ice', 79::numeric, 'Surface ice', 'Devon Island contains seasonal snow and nearby ice-covered terrain. Mars contains polar ice deposits and seasonal frost, including carbon dioxide frost.', 'Testing surface-ice recognition and polar environmental monitoring.'),
  ('TER-05-MARS', 'water.subsurface_ice', 94::numeric, 'Subsurface ice', 'The supplied research describes buried ice lenses and frozen-ground ice. Mars contains ice-rich subsurface deposits in selected midlatitude and polar regions.', 'Testing ground-penetrating radar and buried-ice detection.'),
  ('TER-05-MARS', 'water.permafrost', 96::numeric, 'Permafrost', 'Haughton has continuous terrestrial permafrost. Much of the Martian subsurface remains permanently cold, and ice may persist beneath protective surface materials. Terrestrial freeze–thaw cycles, however, are not equivalent to Martian ice stability.', 'Testing frozen-ground sampling, subsurface imaging, and cryogeological interpretation.'),
  ('TER-05-MARS', 'water.hydrogen', 88::numeric, 'Hydrogen-bearing materials', 'Water ice and water-bearing materials contain hydrogen at Haughton. Martian orbital neutron instruments identify hydrogen enrichment associated with ice or hydrated minerals, but hydrogen detection alone does not prove the presence of ice.', 'Testing hydrogen-sensitive instruments and interpreting subsurface volatile measurements.'),
  ('TER-05-MARS', 'water.past_water', 82::numeric, 'Evidence of past water', 'Haughton’s landscape preserves water-related alteration, seasonal meltwater effects, and periglacial features. Mars preserves evidence of ancient water-related processes in selected crater and sedimentary environments.', 'Reconstructing geological histories involving ice and water.'),
  ('TER-05-MARS', 'water.mineral_resources', 68::numeric, 'Mineral resources', 'Haughton’s carbonate rocks and impact materials are useful for geological research. Martian resource studies emphasize water ice and selected mineral deposits. Resource accessibility and extraction feasibility were not evaluated.', 'Testing nonextractive mineral identification and subsurface resource reconnaissance.'),
  ('TER-05-MARS', 'atmosphere.atmospheric_pressure', 12::numeric, 'Atmospheric pressure', 'Haughton has Earth’s relatively dense atmosphere. Mars has a thin atmosphere with a mean surface pressure near 600 Pa.', 'Identifying atmospheric tests that require controlled simulation.'),
  ('TER-05-MARS', 'atmosphere.atmospheric_composition', 8::numeric, 'Atmospheric composition', 'Earth’s atmosphere is dominated by nitrogen and oxygen. The Martian atmosphere is dominated by carbon dioxide.', 'Defining limitations for open-air testing of Martian atmospheric instruments.'),
  ('TER-05-MARS', 'atmosphere.wind', 78::numeric, 'Wind', 'The supplied terrestrial research reports Arctic winds of approximately 8–18 m/s, although these figures require site-specific verification. Martian winds also transport particles, but the much lower atmospheric density changes the forces involved.', 'Testing wind sensors and investigating particle transport under terrestrial conditions.'),
  ('TER-05-MARS', 'atmosphere.dust', 79::numeric, 'Dust', 'Fine mineral particles can be mobilized from dry Arctic soils. Mars also contains widespread mineral dust, but its composition, particle properties, and transport conditions differ.', 'Evaluating dust detection, optical interference, and equipment protection.'),
  ('TER-05-MARS', 'atmosphere.dust_storms', 62::numeric, 'Dust storms', 'Haughton experiences localized blowing snow and potentially wind-driven mineral dust. Mars experiences dust storms on much larger scales, including planet-encircling events.', 'Testing visibility sensors and equipment exposure to airborne particles.'),
  ('TER-05-MARS', 'atmosphere.aeolian_erosion', 86::numeric, 'Aeolian erosion and sediments', 'Wind-driven particles abrade exposed rocks and redistribute sediments around Haughton. Martian winds also modify rock surfaces and transport sediments.', 'Studying erosion signatures, sediment transport, and wind-modified terrain.'),
  ('TER-05-MARS', 'atmosphere.aerosols', 58::numeric, 'Aerosols', 'Arctic air can contain marine and mineral aerosols. Martian aerosols are dominated by different particle populations, including suspended mineral dust.', 'Testing particle-monitoring instruments and aerosol detection.'),
  ('TER-05-MARS', 'subsurface.caves', 52::numeric, 'Caves and cavities', 'The supplied research describes extensive fractures and possible thermokarst-related cavities. These are not evidence of a fully mapped cave network. Martian subsurface cavities may originate through volcanic or collapse processes.', 'Testing cavity detection and geological interpretation.'),
  ('TER-05-MARS', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'No lava-tube systems are documented in the selected Haughton impact environment. Martian lava tubes are associated with volcanic terrains.', 'Identifying the need for volcanic analog sites when investigating lava tubes.'),
  ('TER-05-MARS', 'subsurface.fractures', 97::numeric, 'Fractures and faults', 'Haughton contains extensive radial and concentric fractures associated with impact deformation. Martian impact craters also contain fractured and faulted rock.', 'Testing structural mapping, fracture recognition, and hazard assessment.'),
  ('TER-05-MARS', 'subsurface.subsurface_structure', 96::numeric, 'Subsurface structure', 'Haughton contains complex impact megabreccia, displaced geological blocks, fractured carbonate strata, and permafrost. Martian impact structures can also contain fractured bedrock, breccias, and impact-modified subsurface layers.', 'Testing radar interpretation and impact-structure reconstruction.'),
  ('TER-05-MARS', 'subsurface.material_thickness', 88::numeric, 'Material thickness', 'The supplied terrestrial research describes impact deposits and crater-fill materials with highly variable thicknesses. Martian crater deposits also vary according to crater size, target properties, and subsequent sedimentation.', 'Evaluating subsurface layer-thickness estimation and geological stratigraphy.'),
  ('TER-05-MARS', 'biology.extremophiles', 86::numeric, 'Extremophile organisms', 'The terrestrial research describes cold-adapted microorganisms, cyanobacteria, and lichens. These organisms demonstrate survival strategies in cold and dry environments, but they do not establish that equivalent life exists on Mars.', 'Testing biological detection systems and investigating microbial survival.'),
  ('TER-05-MARS', 'biology.habitability', 82::numeric, 'Habitability conditions', 'Haughton combines low temperatures, aridity, frozen ground, and brief seasonal opportunities for biological activity. These conditions provide partial analogs for investigating potential ancient or protected Martian habitats.', 'Studying environmental limits for microbial activity and habitability assessment.'),
  ('TER-05-MARS', 'biology.biosignatures', 86::numeric, 'Potential biosignatures', 'Microbial communities and biological films may leave organic or mineral-associated traces. These can be used as terrestrial test materials for instruments intended to investigate possible Martian biosignatures.', 'Testing biosignature detection and distinguishing biological signals from geological backgrounds.'),
  ('TER-05-MARS', 'biology.adaptations', 80::numeric, 'Biological adaptations', 'Arctic microorganisms exhibit adaptations to cold, desiccation, ultraviolet exposure, and short periods of favorable conditions. These provide models for studying possible survival strategies under extreme environments.', 'Investigating microbial adaptation, biological preservation, and planetary protection.'),
  ('TER-06-MOON', 'topography.elevation', 48::numeric, 'Elevation', 'The Qaidam basin floor lies approximately 2,600–3,200 m above terrestrial sea level. Lunar elevations range across approximately 20 km relative to a lunar reference sphere. The absolute numbers are not physically comparable without using normalized local relief.', 'Testing digital elevation model processing and relative-elevation mapping.'),
  ('TER-06-MOON', 'topography.slope', 84::numeric, 'Slope', 'Central saline plains have reported slopes of approximately 0°–3%, expressed in the supplied research as 0°–3°; the intended unit should be checked. In angular terms, slopes of 0°–3° overlap with the Moon’s relatively flat mare plains, often characterized by slopes of approximately 0°–5°.', 'Testing rover mobility, route selection, and slope estimation.'),
  ('TER-06-MOON', 'topography.roughness', 60::numeric, 'Surface roughness', 'Qaidam’s yardang ridges and salt crusts create variable roughness. Lunar terrain can also be rough, especially near impact ejecta, but lunar roughness arises from different geological processes and must be compared at consistent spatial scales.', 'Evaluating terrain-classification algorithms and wheel–surface interactions.'),
  ('TER-06-MOON', 'topography.relief', 44::numeric, 'Relief', 'Qaidam is an intermontane depression bounded by major mountain ranges. Lunar basins and plains are generally impact-generated or volcanic rather than products of terrestrial-style tectonic basin evolution.', 'Training landform segmentation while testing the distinction between superficially similar relief forms.'),
  ('TER-06-MOON', 'topography.craters', 5::numeric, 'Impact craters', 'The supplied research identifies no significant recent impact craters within the selected Qaidam setting. Impact cratering is a dominant lunar geological process.', 'Establishing that Qaidam is unsuitable for direct impact-crater morphology studies.'),
  ('TER-06-MOON', 'topography.obstacles', 69::numeric, 'Surface obstacles', 'Yardang crests, salt crusts, sand dunes, and desiccated sediment blocks create navigation hazards. Lunar obstacles include angular impact blocks, regolith deposits, and collapse pits, which differ in origin and material behavior.', 'Testing obstacle detection, autonomous path planning, and rover navigation.'),
  ('TER-06-MOON', 'thermal.surface_temperature', 35::numeric, 'Surface temperature', 'Qaidam’s ground can become cold during winter and warm during summer. The supplied research does not provide a verified annual land-surface temperature series. Lunar surface temperatures vary far more strongly because of the absence of a substantial atmosphere and the long lunar day.', 'Testing surface-temperature sensors under variable terrestrial conditions.'),
  ('TER-06-MOON', 'thermal.temperature_extremes', 27::numeric, 'Maximum and minimum temperatures', 'Qaidam’s reported summer maxima of approximately +30°C and winter minima of −25°C to −30°C are much less extreme than the Moon’s approximately +123°C maximum and −247°C minimum.', 'Determining which thermal tests require specialized chambers.'),
  ('TER-06-MOON', 'thermal.thermal_variation', 42::numeric, 'Thermal variation', 'The basin experiences pronounced daily and seasonal thermal changes. Lunar surface thermal cycles can reach approximately 280–300 K in amplitude at some low-latitude locations, far exceeding ordinary terrestrial variation.', 'Testing temperature logging and preliminary thermal-cycling procedures.'),
  ('TER-06-MOON', 'thermal.solar_illumination', 48::numeric, 'Solar illumination', 'Qaidam receives strong solar radiation under generally clear skies. Lunar illumination occurs without substantial atmospheric scattering, and its day–night cycle lasts approximately 29.5 Earth days.', 'Testing solar exposure monitoring and optical imaging under bright conditions.'),
  ('TER-06-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Atmospheric conditions / exosphere', 'Qaidam has a terrestrial atmosphere, although its elevation reduces ambient pressure. The Moon has an extremely tenuous exosphere and no comparable atmospheric pressure.', 'Identifying the need for vacuum-chamber qualification.'),
  ('TER-06-MOON', 'geology.rock_type', 12::numeric, 'Rock type', 'Qaidam contains lacustrine sediments, sandstones, siltstones, and evaporites. Lunar bedrock is dominated by igneous and impact-related lithologies.', 'Testing lithological classification and detecting nonanalog rock types.'),
  ('TER-06-MOON', 'geology.mineral_composition', 18::numeric, 'Mineralogical composition', 'Qaidam contains quartz, feldspars, clay minerals, halite, gypsum, and other evaporites. Lunar materials are dominated by plagioclase, pyroxene, olivine, and impact glass.', 'Evaluating spectral mineral identification and classification errors.'),
  ('TER-06-MOON', 'geology.chemical_composition', 15::numeric, 'Chemical composition', 'Qaidam’s salt-rich deposits contain abundant sodium, chlorine, magnesium, and sulfate-bearing phases. Lunar regolith chemistry is dominated by silicate and oxide minerals with different relative abundances.', 'Testing geochemical instruments and identifying chemically dissimilar materials.'),
  ('TER-06-MOON', 'geology.surface_material', 55::numeric, 'Surface material', 'Qaidam’s loose silts, sands, and granular deposits may offer partial mechanical analogs for regolith handling. Lunar regolith differs in grain shape, cohesion, impact-glass content, and electrostatic behavior.', 'Preliminary excavation and granular-sampling tests.'),
  ('TER-06-MOON', 'geology.alteration', 5::numeric, 'Geological alteration', 'Qaidam is strongly modified by wind abrasion, evaporation, and salt precipitation. Lunar space weathering is dominated by micrometeorite bombardment, solar-wind implantation, and radiation.', 'Distinguishing terrestrial weathering products from lunar space-weathering signatures.'),
  ('TER-06-MOON', 'geology.formations', 16::numeric, 'Geological formations', 'Yardangs, lacustrine deposits, playas, and alluvial fans have no close process-level counterparts in the modern lunar landscape.', 'Testing geological feature recognition and rejecting inappropriate lunar analog classifications.'),
  ('TER-06-MOON', 'water.surface_water', 5::numeric, 'Surface water', 'Qaidam contains residual saline lakes and intermittent watercourses. Stable exposed liquid water is absent from the lunar surface.', 'Identifying terrestrial hydrological processes that cannot be transferred to lunar models.'),
  ('TER-06-MOON', 'water.surface_ice', 10::numeric, 'Surface ice', 'The central basin is not characterized by persistent surface ice. Lunar polar ice can occur in permanently shadowed cold traps.', 'Excluding the central basin from primary lunar surface-ice analog testing.'),
  ('TER-06-MOON', 'water.subsurface_ice', null::numeric, 'Subsurface ice', 'The supplied research does not document subsurface ice in the central desert plains. This absence of evidence does not establish a measured ice concentration of zero.', 'Prioritizing field verification before attempting ice-related comparisons.'),
  ('TER-06-MOON', 'water.permafrost', 15::numeric, 'Permafrost', 'Discontinuous mountain permafrost occurs around the basin, but it should not be assigned to the central playa terrain without local evidence. Lunar polar regolith can remain permanently cold under fundamentally different conditions.', 'Separating basin-floor and surrounding mountain environments in resource assessments.'),
  ('TER-06-MOON', 'water.hydrogen', 48::numeric, 'Hydrogen-bearing materials', 'Hydrated clays and subsurface brines contain hydrogen-bearing compounds. Lunar hydrogen may occur in water ice, hydroxyl-bearing materials, or solar-wind-implanted hydrogen.', 'Testing hydrogen-sensitive instruments while distinguishing different hydrogen reservoirs.'),
  ('TER-06-MOON', 'water.mineral_resources', 52::numeric, 'Mineral resources', 'Qaidam contains economically significant salt and evaporite deposits. Lunar resource priorities include oxygen-bearing silicates, metals, and polar volatiles rather than terrestrial-style evaporite deposits.', 'Testing resource mapping workflows and mineral identification.'),
  ('TER-06-MOON', 'atmosphere.wind', 0::numeric, 'Wind', 'Qaidam experiences strong regional winds, while the Moon has no dense atmosphere capable of generating aerodynamic winds.', 'Establishing limits for lunar environmental simulation.'),
  ('TER-06-MOON', 'atmosphere.dust', 50::numeric, 'Abrasive dust', 'Fine Qaidam sediments can be abrasive, but lunar dust is produced primarily through impacts and can have distinctive angular, glass-rich, and electrostatic properties.', 'Preliminary dust-ingress and mechanical abrasion tests.'),
  ('TER-06-MOON', 'atmosphere.dust_storms', null::numeric, 'Dust storms', 'Atmospheric dust storms have no direct lunar equivalent. Lunar particle transport is associated with impacts, spacecraft disturbances, and potentially electrostatic processes.', 'Preventing physically invalid comparisons.'),
  ('TER-06-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Aeolian erosion', 'Qaidam’s yardangs are sculpted by wind abrasion and deflation. Lunar terrain is not shaped by atmospheric wind erosion.', 'Differentiating aeolian morphology from impact-generated lunar landforms.'),
  ('TER-06-MOON', 'atmosphere.sediments', 42::numeric, 'Sediments and granular deposits', 'Qaidam contains loess-like silts, sands, and lacustrine clays. Lunar granular deposits consist largely of impact-generated regolith and volcanic material.', 'Evaluating granular sampling systems while accounting for different sediment origins.'),
  ('TER-06-MOON', 'atmosphere.aerosols', null::numeric, 'Aerosols', 'Qaidam’s mineral aerosols require an atmosphere. The Moon does not have an equivalent atmospheric aerosol system.', 'Defining instrument-testing limitations.'),
  ('TER-06-MOON', 'subsurface.caves', 0::numeric, 'Caves', 'The supplied research does not identify significant caves in the selected sedimentary basin environment. Lunar collapse pits and possible subsurface cavities are associated with different geological processes.', 'Excluding Qaidam from primary lunar cave analog selection.'),
  ('TER-06-MOON', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'No lava tubes are documented in the selected Qaidam sedimentary terrain. Lunar lava tubes originate through ancient volcanic activity.', 'Identifying the need for volcanic analog locations.'),
  ('TER-06-MOON', 'subsurface.fractures', 45::numeric, 'Cavities and fractures', 'Qaidam contains desiccation cracks and salt-related contraction fractures. Lunar fractures can form through impacts, tectonic stresses, and volcanic processes.', 'Testing fracture-detection algorithms and shallow subsurface imaging.'),
  ('TER-06-MOON', 'subsurface.subsurface_structure', 35::numeric, 'Subsurface structure', 'Qaidam’s subsurface contains alternating lacustrine, evaporitic, and alluvial layers. Lunar subsurface layers commonly reflect impact deposition and volcanic activity.', 'Testing stratigraphic interpretation while distinguishing different depositional processes.'),
  ('TER-06-MOON', 'subsurface.material_thickness', 40::numeric, 'Material thickness', 'Qaidam contains sedimentary basin fill reaching kilometer-scale thicknesses. Lunar regolith and impact deposits have different thickness distributions and formation histories.', 'Testing radar-based layer-thickness estimation.'),
  ('TER-06-MOON', 'biology.extremophiles', null::numeric, 'Extremophile organisms', 'Qaidam contains terrestrial microorganisms, but there are no confirmed lunar organisms.', 'Testing biological contamination detection.'),
  ('TER-06-MOON', 'biology.habitability', null::numeric, 'Habitability conditions', 'Qaidam’s terrestrial microbial habitats do not establish equivalent lunar habitats.', 'Supporting controlled biological instrument tests.'),
  ('TER-06-MOON', 'biology.biosignatures', null::numeric, 'Biosignatures', 'Terrestrial biosignatures have no confirmed indigenous lunar counterpart.', 'Differentiating biological contamination from nonbiological signals.'),
  ('TER-06-MOON', 'biology.adaptations', null::numeric, 'Biological adaptations', 'Terrestrial microbial adaptations cannot be directly compared with unknown lunar biological systems.', 'Evaluating terrestrial biological responses without implying lunar life.'),
  ('TER-06-MARS', 'topography.elevation', 48::numeric, 'Elevation', 'Qaidam’s basin floor lies approximately 2,600–3,200 m above terrestrial sea level. Martian elevations are measured relative to the areoid. Direct comparison of absolute elevation values is not meaningful without normalization to local terrain.', 'Testing elevation-model processing and local topographic comparisons.'),
  ('TER-06-MARS', 'topography.slope', 88::numeric, 'Slope', 'The supplied research describes central playa slopes of approximately 0°–3°, with steeper surrounding mountain margins. Selected Martian sedimentary plains and basin floors also have low gradients.', 'Rover route planning and slope-based terrain classification.'),
  ('TER-06-MARS', 'topography.roughness', 90::numeric, 'Surface roughness', 'Yardang ridges, salt crusts, and eroded sediment blocks produce strong local variations in roughness. Martian yardang fields and wind-eroded sedimentary outcrops show comparable landform-scale roughness.', 'Testing autonomous obstacle recognition and terrain mapping.'),
  ('TER-06-MARS', 'topography.relief', 79::numeric, 'Relief', 'Qaidam is an intermontane basin bounded by major mountain ranges. Mars contains numerous basins and sedimentary depressions, although their origins may involve impacts, volcanism, tectonics, or erosion.', 'Evaluating basin morphology and sedimentary terrain reconstruction.'),
  ('TER-06-MARS', 'topography.craters', 5::numeric, 'Impact craters', 'The supplied research does not identify significant recent impact craters within the selected basin terrain. Impact craters are abundant on Mars, so Qaidam is unsuitable for direct crater-morphology comparison.', 'Distinguishing aeolian landforms from impact-generated structures.'),
  ('TER-06-MARS', 'topography.obstacles', 93::numeric, 'Surface obstacles', 'Yardang crests, desiccated sediment blocks, salt crusts, and dunes create terrain hazards similar in operational terms to obstacles encountered in some Martian sedimentary environments.', 'Testing rover mobility, autonomous path planning, and obstacle avoidance.'),
  ('TER-06-MARS', 'thermal.surface_temperature', 48::numeric, 'Surface temperature', 'Qaidam experiences large seasonal changes, but the supplied research does not provide a verified land-surface temperature time series. Mars has a much lower global mean surface temperature and pronounced regional variation.', 'Testing ground-temperature measurement systems and thermal data collection.'),
  ('TER-06-MARS', 'thermal.temperature_extremes', 59::numeric, 'Maximum and minimum temperatures', 'The supplied research reports summer maxima near +30°C and winter minima around −25°C to −30°C. Some Martian equatorial surfaces can become relatively warm during daylight, but Martian nighttime and polar temperatures are often much lower.', 'Preliminary thermal testing and identification of temperature-range limitations.'),
  ('TER-06-MARS', 'thermal.thermal_variation', 81::numeric, 'Thermal variation', 'Qaidam’s low humidity and continental climate produce strong daily and seasonal thermal variations. Mars also exhibits substantial surface-temperature variation, although its thin atmosphere and soil thermal inertia change the magnitude and timing.', 'Testing thermal sensors and temperature-dependent instrument performance.'),
  ('TER-06-MARS', 'thermal.solar_illumination', 78::numeric, 'Solar illumination', 'Qaidam experiences high annual insolation and frequent clear skies. Mars receives less solar radiation because of its greater distance from the Sun, and atmospheric dust modifies illumination.', 'Evaluating solar-powered field instruments and optical sensors under bright desert conditions.'),
  ('TER-06-MARS', 'thermal.atmospheric_conditions', 18::numeric, 'Atmospheric pressure', 'Qaidam’s high elevation lowers terrestrial atmospheric pressure, but it remains vastly greater than the typical Martian surface pressure of approximately 600 Pa.', 'Defining the need for low-pressure environmental testing.'),
  ('TER-06-MARS', 'thermal.atmospheric_dryness', 82::numeric, 'Atmospheric dryness', 'The basin’s extreme aridity limits moisture availability and favors salt accumulation and surface desiccation. Mars is also extremely dry at the surface, although its atmospheric humidity and water-vapor behavior differ.', 'Testing instruments in low-moisture environments and studying desiccation-related processes.'),
  ('TER-06-MARS', 'geology.rock_type', 79::numeric, 'Rock type', 'Qaidam contains sandstones, siltstones, lacustrine sediments, and evaporitic rocks. Mars also contains sedimentary rocks, including deposits interpreted as products of ancient rivers, lakes, and wind-driven sedimentation.', 'Testing sedimentary-rock recognition and geological classification.'),
  ('TER-06-MARS', 'geology.mineral_composition', 91::numeric, 'Mineralogical composition', 'Qaidam contains quartz, feldspars, clays, halite, gypsum, and other evaporites. Mars has documented clay minerals, sulfates, chlorides, and other aqueous alteration products, although mineral assemblages vary by location.', 'Testing mineral spectroscopy and identifying aqueous alteration signatures.'),
  ('TER-06-MARS', 'geology.chemical_composition', 87::numeric, 'Chemical composition', 'Qaidam’s saline sediments are enriched in sodium, chlorine, magnesium, and sulfate-bearing compounds. Comparable chemical classes occur in selected Martian evaporitic and sedimentary environments, but their concentrations and formation pathways are not necessarily identical.', 'Evaluating elemental analysis and salt-rich deposit classification.'),
  ('TER-06-MARS', 'geology.surface_material', 92::numeric, 'Surface material', 'Fine silts, clay-rich sediments, loose sands, and salt crusts resemble the diversity of granular and indurated materials encountered in selected Martian sedimentary regions.', 'Testing sampling instruments, sediment classification, and rover–soil interactions.'),
  ('TER-06-MARS', 'geology.alteration', 90::numeric, 'Geological alteration', 'Qaidam’s sediments are modified by evaporation, salt precipitation, desiccation, and wind erosion. Mars preserves evidence of evaporitic mineral formation, sedimentary alteration, and extensive aeolian modification.', 'Reconstructing aqueous alteration and postdepositional environmental change.'),
  ('TER-06-MARS', 'geology.formations', 93::numeric, 'Geological formations', 'Ancient lakebeds, playas, yardangs, and alluvial fans have geological counterparts in selected Martian terrains. The strongest comparisons concern landform processes rather than exact geographic dimensions.', 'Mapping paleolakes, interpreting sedimentary environments, and detecting yardang fields.'),
  ('TER-06-MARS', 'water.surface_water', 35::numeric, 'Surface water', 'Qaidam retains residual saline lakes and intermittent watercourses. Present-day Mars generally cannot sustain stable exposed liquid water because of its low atmospheric pressure and cold conditions.', 'Studying sedimentary consequences of water activity while distinguishing present-day environments.'),
  ('TER-06-MARS', 'water.surface_ice', 12::numeric, 'Surface ice', 'Persistent ice is not characteristic of the central basin floor. Mars contains polar water ice and seasonal frost.', 'Identifying the basin’s limitations for polar ice studies.'),
  ('TER-06-MARS', 'water.subsurface_ice', null::numeric, 'Subsurface ice', 'The supplied research does not document subsurface ice in the selected central basin plains. This variable requires site-specific measurements before a defensible comparison can be made.', 'Identifying data gaps in subsurface resource assessments.'),
  ('TER-06-MARS', 'water.permafrost', 28::numeric, 'Permafrost', 'Permafrost is associated with higher surrounding mountain terrain, not necessarily the central playa environment. Mars has widespread permanently cold subsurface conditions and locally abundant buried ice.', 'Distinguishing geographic subregions when selecting frozen-ground analogs.'),
  ('TER-06-MARS', 'water.hydrogen', 83::numeric, 'Hydrogen-bearing materials', 'Hydrated clays and subsurface brines contain hydrogen-bearing compounds. Mars also contains hydrated minerals and water-related deposits, although hydrogen detection does not uniquely identify liquid water or ice.', 'Testing hydrated-mineral sensing and volatile interpretation.'),
  ('TER-06-MARS', 'water.past_water', 96::numeric, 'Evidence of past water', 'Qaidam’s ancient lacustrine sediments, evaporites, and desiccated lakebeds preserve a record of former water bodies. Mars also contains geological evidence of ancient lakes, sedimentation, and aqueous alteration.', 'Reconstructing paleolakes, identifying former shorelines, and interpreting sedimentary histories.'),
  ('TER-06-MARS', 'water.mineral_resources', 92::numeric, 'Mineral resources', 'Qaidam contains substantial potash, magnesium salt, lithium-bearing brines, and other evaporite resources. Martian sulfate- and chloride-bearing deposits are scientifically relevant, but their industrial extractability has not been established by this comparison.', 'Testing mineral-resource mapping and geochemical characterization.'),
  ('TER-06-MARS', 'atmosphere.atmospheric_pressure', 18::numeric, 'Atmospheric pressure', 'Qaidam has a terrestrial atmosphere at high elevation, while Mars has a much thinner atmosphere.', 'Identifying the need for controlled low-pressure testing.'),
  ('TER-06-MARS', 'atmosphere.atmospheric_composition', 8::numeric, 'Atmospheric composition', 'Earth’s atmosphere is nitrogen- and oxygen-rich, whereas Mars has a carbon dioxide-dominated atmosphere.', 'Separating landform comparisons from atmospheric-composition equivalence.'),
  ('TER-06-MARS', 'atmosphere.wind', 83::numeric, 'Wind', 'The supplied research describes seasonal regional winds of approximately 8–15 m/s, although this range requires verification against site-specific meteorological observations. Wind also drives sediment movement on Mars, but atmospheric density strongly affects the physical forces involved.', 'Testing wind monitoring and investigating sediment movement.'),
  ('TER-06-MARS', 'atmosphere.dust', 94::numeric, 'Dust', 'Qaidam contains fine silts and clays that can become airborne over dry lakebeds. Mars also has abundant fine mineral dust capable of atmospheric transport.', 'Evaluating dust sensors, optical interference, and dust-resistant instrument design.'),
  ('TER-06-MARS', 'atmosphere.dust_storms', 91::numeric, 'Dust storms', 'Qaidam experiences regional dust events and reduced visibility during strong winds. Mars experiences dust storms ranging from local to planet-encircling scales. Their physical intensity and atmospheric dynamics differ.', 'Testing airborne-particle monitoring and dust-exposure procedures.'),
  ('TER-06-MARS', 'atmosphere.aeolian_erosion', 98::numeric, 'Aeolian erosion and yardangs', 'Qaidam’s extensive yardang fields are formed by prolonged wind erosion of relatively soft sedimentary deposits. Yardang-like landforms have also been identified on Mars, including in sedimentary terrains shaped by persistent wind activity.', 'Reconstructing wind directions, erosion histories, and sedimentary landscape evolution.'),
  ('TER-06-MARS', 'atmosphere.sediments', 95::numeric, 'Sediments', 'Qaidam contains wind-transported silts, sands, dunes, and ancient lacustrine clays. Mars also contains dunes, sedimentary layers, and wind-modified deposits.', 'Testing sediment classification, stratigraphic interpretation, and sampling procedures.'),
  ('TER-06-MARS', 'atmosphere.aerosols', 85::numeric, 'Aerosols', 'Qaidam’s atmosphere can carry mineral aerosols from exposed sediment surfaces. Martian atmospheric dust is also important for visibility, solar energy, and atmospheric heating, although particle concentrations and transport mechanisms differ.', 'Testing aerosol detection and monitoring of airborne mineral particles.'),
  ('TER-06-MARS', 'subsurface.caves', 0::numeric, 'Caves and cavities', 'The supplied research does not document significant cave systems in the selected sedimentary basin terrain. Mars contains candidate subsurface cavities and collapse features, especially in volcanic regions.', 'Excluding Qaidam from cave-focused analog selection.'),
  ('TER-06-MARS', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'Lava tubes are not documented in the selected sedimentary-evaporitic environment. Martian lava-tube candidates are associated with volcanic terrains.', 'Identifying when volcanic analogs are more appropriate.'),
  ('TER-06-MARS', 'subsurface.fractures', 84::numeric, 'Fractures and desiccation cracks', 'Qaidam contains desiccation cracks and salt-related contraction fractures. Mars preserves polygonal cracks and other sedimentary features interpreted as products of desiccation or related processes in selected environments.', 'Identifying paleohydrological indicators and mapping fracture patterns.'),
  ('TER-06-MARS', 'subsurface.subsurface_structure', 92::numeric, 'Subsurface structure', 'Qaidam contains alternating lacustrine sediments, evaporites, and alluvial deposits. Selected Martian basins also preserve layered sedimentary sequences that record changing environmental conditions.', 'Testing subsurface imaging and interpreting sedimentary stratigraphy.'),
  ('TER-06-MARS', 'subsurface.material_thickness', 94::numeric, 'Material thickness', 'The basin contains sedimentary fill extending to kilometer-scale depths. Mars also contains thick sedimentary accumulations in selected basins, although their depositional histories and internal structures differ.', 'Evaluating layer-thickness estimation and sedimentary basin reconstruction.'),
  ('TER-06-MARS', 'biology.extremophiles', 88::numeric, 'Extremophile organisms', 'The supplied research describes halophilic bacteria, archaea, and other microorganisms adapted to high salinity. Such organisms provide terrestrial models for studying possible life-supporting conditions in ancient Martian brines.', 'Testing microbial detection systems and studying survival under high salinity.'),
  ('TER-06-MARS', 'biology.habitability', 85::numeric, 'Habitability conditions', 'Qaidam’s extreme aridity, ultraviolet exposure, and salt concentrations constrain biological activity. Similar environmental stresses are relevant when investigating whether selected ancient Martian environments could have supported life.', 'Evaluating environmental limits of habitability.'),
  ('TER-06-MARS', 'biology.biosignatures', 92::numeric, 'Potential biosignatures', 'Organic compounds and microbial traces may be preserved in evaporitic sediments. Such materials are useful analog targets for instruments investigating possible biosignatures in Martian sedimentary deposits.', 'Testing organic-molecule detection, mineral-associated preservation, and sampling strategies.'),
  ('TER-06-MARS', 'biology.adaptations', 84::numeric, 'Biological adaptations', 'Salt-tolerant microorganisms can use osmoregulation, protective compounds, and dormancy to survive harsh conditions. These adaptations provide research models, not evidence of equivalent Martian organisms.', 'Studying microbial survival, preservation, and biological detection under environmental stress.'),
  ('TER-07-MOON', 'topography.elevation', 35::numeric, 'Elevation', 'Parts of Danakil lie approximately 120 m below terrestrial sea level. Lunar elevation is measured relative to a lunar reference sphere, making direct comparison of absolute elevation values inappropriate. Local relief is more useful than absolute elevation for assessing exploration difficulty.', 'Testing digital elevation models, relative-height analysis, and terrain visualization.'),
  ('TER-07-MOON', 'topography.slope', 72::numeric, 'Slope', 'Danakil combines relatively flat salt plains with steep volcanic slopes and fault escarpments. Lunar volcanic regions can also contain flat lava plains and localized steep terrain. However, the origins and mechanical properties of these surfaces differ.', 'Evaluating rover traction, slope-dependent route planning, and terrain accessibility.'),
  ('TER-07-MOON', 'topography.roughness', 74::numeric, 'Surface roughness', 'Basaltic blocks, volcanic scoria, fissures, and irregular rock surfaces produce substantial local roughness. Lunar mare terrain can contain rocky ejecta, fractured surfaces, and volcanic formations, although salt chimneys are not representative lunar obstacles.', 'Testing robotic suspension, obstacle detection, and rough-terrain classification.'),
  ('TER-07-MOON', 'topography.relief', 64::numeric, 'Relief', 'Danakil’s relief reflects active continental rifting, volcanic construction, and sedimentary subsidence. The Moon contains volcanic edifices, tectonic scarps, and basins, but the dominant processes and tectonic setting are different.', 'Comparing volcanic and tectonic landforms using topographic datasets.'),
  ('TER-07-MOON', 'topography.craters', 32::numeric, 'Craters', 'Dallol’s hydrothermal depressions and Erta Ale’s volcanic craters differ from the impact craters that dominate lunar landscapes. Some lunar volcanic features, including collapse depressions, may have superficially similar forms.', 'Training geological image-analysis systems to distinguish volcanic depressions from impact craters.'),
  ('TER-07-MOON', 'topography.obstacles', 65::numeric, 'Surface obstacles', 'Basaltic blocks, fractures, unstable salt formations, and irregular terrain create obstacles for surface exploration. Lunar obstacles include impact blocks, regolith deposits, and fractured bedrock. Similar navigation challenges do not imply equivalent material behavior.', 'Testing autonomous navigation, obstacle recognition, and route planning.'),
  ('TER-07-MOON', 'thermal.surface_temperature', 32::numeric, 'Surface temperature', 'The supplied research reports locally very hot ground, potentially exceeding 60–70°C. These values should not be interpreted as uniform basin-wide surface temperatures. Sunlit lunar surfaces can also become hot, but heat transfer in vacuum differs substantially from terrestrial conditions.', 'Evaluating thermal sensors and selected heat-resistant components.'),
  ('TER-07-MOON', 'thermal.temperature_extremes', 28::numeric, 'Maximum and minimum temperatures', 'The supplied research describes exceptionally high daytime temperatures and warm nights. The Moon experiences much greater thermal extremes, including very low temperatures during darkness and in permanently shadowed polar regions.', 'Testing high-temperature performance while identifying the need for additional cold and vacuum qualification.'),
  ('TER-07-MOON', 'thermal.thermal_variation', 12::numeric, 'Thermal variation', 'Danakil follows Earth’s daily heating cycle and experiences atmospheric heat exchange. The Moon’s approximately 29.5-Earth-day illumination cycle produces fundamentally different surface-temperature behavior.', 'Comparing thermal response under terrestrial conditions and defining simulation limitations.'),
  ('TER-07-MOON', 'thermal.solar_illumination', 48::numeric, 'Solar illumination', 'Danakil receives intense solar radiation under frequently clear skies. The Moon receives sunlight without substantial atmospheric scattering, and its illumination geometry and duration differ.', 'Testing solar monitoring instruments and optical systems under intense terrestrial sunlight.'),
  ('TER-07-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Atmospheric conditions / exosphere', 'Danakil has a dense terrestrial atmosphere containing nitrogen, oxygen, and locally elevated volcanic or hydrothermal gases. The Moon has an extremely tenuous exosphere and no comparable atmospheric pressure.', 'Establishing the need for thermal-vacuum chambers and lunar-specific environmental testing.'),
  ('TER-07-MOON', 'geology.rock_type', 82::numeric, 'Rock type', 'Basaltic rocks associated with Erta Ale and the Afar Rift provide a useful lithological comparison with lunar mare basalts. Lunar basalts differ in chemical composition, formation environment, and exposure history.', 'Testing basalt identification and geological sampling instruments.'),
  ('TER-07-MOON', 'geology.mineral_composition', 62::numeric, 'Mineralogical composition', 'Basaltic silicate minerals can overlap with lunar volcanic mineral assemblages. However, Dallol’s halite, potash salts, sulfur minerals, and hydrothermal alteration products are not typical lunar surface materials.', 'Testing mineral spectroscopy and separating primary volcanic minerals from secondary terrestrial deposits.'),
  ('TER-07-MOON', 'geology.chemical_composition', 60::numeric, 'Chemical composition', 'Danakil’s basaltic rocks share broad silicate chemistry with lunar volcanic rocks, while its sulfur-, chlorine-, and potassium-rich evaporite deposits create substantial chemical differences.', 'Evaluating elemental analysis and distinguishing basaltic materials from hydrothermal salts.'),
  ('TER-07-MOON', 'geology.surface_material', 65::numeric, 'Surface material', 'Volcanic fragments, basaltic blocks, and scoria provide partial mechanical and geological analogs. Hydrothermal muds and salt crusts do not reproduce the properties of impact-generated lunar regolith.', 'Testing surface sampling, rock classification, and material-handling equipment.'),
  ('TER-07-MOON', 'geology.alteration', 22::numeric, 'Geological alteration', 'Danakil experiences active chemical alteration by acidic fluids, salts, and hydrothermal gases. Lunar rocks are modified primarily by impacts, solar-wind exposure, radiation, and space weathering rather than active aqueous hydrothermal processes.', 'Distinguishing primary volcanic signatures from secondary alteration.'),
  ('TER-07-MOON', 'geology.formations', 78::numeric, 'Geological formations', 'Basaltic volcanic fields, fissures, and lava-related structures in the broader Afar region offer comparisons with lunar volcanic terrains. Dallol’s salt domes and hydrothermal pools are not equivalent to lunar volcanic structures.', 'Mapping volcanic formations and interpreting geological structures.'),
  ('TER-07-MOON', 'water.surface_water', 5::numeric, 'Surface water', 'Dallol contains hypersaline hydrothermal fluids, whereas stable exposed liquid water does not exist on the lunar surface.', 'Identifying terrestrial processes that cannot be directly transferred to lunar environmental models.'),
  ('TER-07-MOON', 'water.surface_ice', 0::numeric, 'Surface ice', 'Persistent surface ice is absent from the selected hot lowland environment. Lunar polar regions contain extremely cold locations where water ice may remain stable.', 'Excluding Danakil from primary lunar surface-ice analog testing.'),
  ('TER-07-MOON', 'water.subsurface_ice', 0::numeric, 'Subsurface ice', 'The selected hot hydrothermal setting is not representative of buried frozen-ground environments. Lunar polar subsurface ice occurs under very different thermal conditions.', 'Identifying the need for cold-region analog sites when evaluating lunar ice exploration.'),
  ('TER-07-MOON', 'water.permafrost', 0::numeric, 'Permafrost', 'Danakil’s lowland thermal conditions do not support the continuous frozen-ground environment associated with terrestrial permafrost. Permanently cold lunar polar regolith is physically different from terrestrial permafrost.', 'Preventing inappropriate comparisons with lunar frozen-ground environments.'),
  ('TER-07-MOON', 'water.hydrogen', 28::numeric, 'Hydrogen-bearing materials', 'Hydrogen is present in Danakil’s water-bearing hydrothermal fluids and hydrated minerals. Lunar hydrogen may occur in water ice, hydroxyl-bearing materials, and solar-wind-implanted particles.', 'Testing hydrogen-sensitive detection instruments while distinguishing different chemical reservoirs.'),
  ('TER-07-MOON', 'water.mineral_resources', 52::numeric, 'Mineral resources', 'Danakil contains extensive potash and other evaporite deposits, while lunar resource studies emphasize oxygen-bearing silicates, metals, and polar volatiles.', 'Evaluating mineral identification and resource-mapping workflows.'),
  ('TER-07-MOON', 'atmosphere.wind', 0::numeric, 'Wind', 'Danakil experiences terrestrial atmospheric winds. The Moon lacks a sufficiently dense atmosphere to support conventional aerodynamic winds.', 'Establishing the limits of terrestrial wind testing for lunar exploration.'),
  ('TER-07-MOON', 'atmosphere.dust', 24::numeric, 'Abrasive dust', 'Volcanic ash and fine evaporite particles can create abrasive conditions, but lunar dust differs in composition, grain formation, surface chemistry, and electrostatic behavior.', 'Preliminary particle-ingress and abrasion testing.'),
  ('TER-07-MOON', 'atmosphere.dust_storms', null::numeric, 'Dust storms', 'Atmospheric dust storms have no direct lunar counterpart because the Moon lacks a substantial atmosphere.', 'Preventing inappropriate atmospheric-process comparisons.'),
  ('TER-07-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Aeolian erosion', 'Danakil’s wind-driven erosion depends on terrestrial atmospheric conditions. Lunar erosion and surface modification are dominated by impacts and space weathering.', 'Distinguishing atmospheric erosion from lunar geological processes.'),
  ('TER-07-MOON', 'atmosphere.sediments', 30::numeric, 'Sediments and granular deposits', 'Danakil contains evaporite particles, volcanic ash, and wind-transported sediments. Lunar granular deposits are dominated by impact-generated regolith and volcanic materials.', 'Testing granular-material handling while accounting for differences in particle origin.'),
  ('TER-07-MOON', 'atmosphere.aerosols', null::numeric, 'Aerosols', 'Hydrothermal and volcanic aerosols are suspended in Earth’s atmosphere. The Moon has no comparable atmospheric aerosol environment.', 'Defining limitations of atmospheric instrument tests.'),
  ('TER-07-MOON', 'subsurface.caves', 56::numeric, 'Caves', 'The supplied research describes dissolution cavities and possible collapse structures in salt-bearing terrain. These differ from lunar volcanic cavities and require site-specific verification.', 'Testing cavity-detection methods and subsurface mapping.'),
  ('TER-07-MOON', 'subsurface.lava_tubes', 78::numeric, 'Lava tubes', 'The supplied research associates lava tubes with volcanic terrain around Erta Ale. Basaltic lava-tube formation can provide a process-level comparison with lunar volcanic conduits, but the presence and geometry of specific accessible tubes have not been verified here.', 'Investigating volcanic subsurface structures and testing cavity-imaging instruments.'),
  ('TER-07-MOON', 'subsurface.fractures', 82::numeric, 'Cavities and fractures', 'Active rifting produces faults, fissures, and fractured rock. Lunar volcanic and tectonic terrains also contain fractures, although their tectonic environments and stress histories differ.', 'Testing fracture recognition, geological hazard mapping, and robotic reconnaissance.'),
  ('TER-07-MOON', 'subsurface.subsurface_structure', 72::numeric, 'Subsurface structure', 'Danakil contains evaporite sequences, basaltic layers, and intrusive structures. Lunar subsurface geology can include lava flows, fractured crust, and regolith layers, but does not reproduce the same evaporite-rich stratigraphy.', 'Testing ground-penetrating radar and geological-layer interpretation.'),
  ('TER-07-MOON', 'subsurface.material_thickness', 62::numeric, 'Material thickness', 'Danakil contains substantial basin-fill deposits and volcanic sequences. Lunar subsurface deposits also vary in thickness, but their origins and mechanical properties differ.', 'Evaluating layer-thickness estimation and subsurface imaging.'),
  ('TER-07-MOON', 'biology.extremophiles', null::numeric, 'Extremophile organisms', 'Terrestrial microorganisms associated with selected Danakil environments have no confirmed lunar biological equivalents.', 'Testing biological contamination detection.'),
  ('TER-07-MOON', 'biology.habitability', null::numeric, 'Habitability conditions', 'The existence of terrestrial hydrothermal environments does not establish naturally habitable lunar environments.', 'Supporting planetary protection and controlled biological experiments.'),
  ('TER-07-MOON', 'biology.biosignatures', null::numeric, 'Biosignatures', 'Terrestrial biological traces cannot be directly compared with confirmed indigenous lunar biosignatures because none have been identified.', 'Distinguishing terrestrial biological contamination from geological signals.'),
  ('TER-07-MOON', 'biology.adaptations', null::numeric, 'Biological adaptations', 'Terrestrial extremophile adaptations have no confirmed lunar biological counterpart.', 'Studying terrestrial microbial survival without implying lunar habitability.'),
  ('TER-07-MARS', 'topography.elevation', 42::numeric, 'Elevation', 'Danakil contains low-lying terrain approximately 120 m below terrestrial sea level. Martian elevations are referenced to the areoid and cannot be compared directly with Earth sea-level elevations. Relative topography provides a more meaningful basis for comparison.', 'Testing elevation-model processing and topographic normalization.'),
  ('TER-07-MARS', 'topography.slope', 76::numeric, 'Slope', 'The region combines relatively flat evaporite plains with steep volcanic slopes and fault escarpments. Mars contains volcanic plains, escarpments, and locally steep terrain with comparable slope patterns.', 'Testing slope-dependent rover navigation and route accessibility.'),
  ('TER-07-MARS', 'topography.roughness', 75::numeric, 'Surface roughness', 'Basaltic blocks, scoria, fractures, and mineral formations produce variable terrain roughness. Martian volcanic landscapes also contain rough lava surfaces, fractured rocks, and irregular obstacles.', 'Evaluating autonomous obstacle detection and rough-terrain classification.'),
  ('TER-07-MARS', 'topography.relief', 80::numeric, 'Relief', 'Danakil is an active tectonic depression with volcanic edifices and fault-related relief. Mars contains large volcanic provinces, extensional structures, and topographic depressions, although their tectonic histories differ.', 'Interpreting volcanic and tectonic landforms using orbital topographic data.'),
  ('TER-07-MARS', 'topography.craters', 48::numeric, 'Craters', 'Dallol’s hydrothermal explosion depressions and Erta Ale’s volcanic craters share some morphological characteristics with Martian volcanic depressions. However, they are not equivalent to impact craters.', 'Distinguishing volcanic collapse features from impact structures in planetary imagery.'),
  ('TER-07-MARS', 'topography.obstacles', 77::numeric, 'Surface obstacles', 'Basaltic blocks, fissures, unstable salt crusts, and rough volcanic terrain create navigation hazards. Martian volcanic surfaces may contain similar classes of rocky obstacles and fractures.', 'Rover path planning, hazard mapping, and terrain segmentation.'),
  ('TER-07-MARS', 'thermal.surface_temperature', 12::numeric, 'Surface temperature', 'Danakil is among Earth’s hottest terrestrial environments, and some hydrothermal surfaces become exceptionally hot. Mars is generally much colder, although localized daytime heating and past geothermal activity are relevant to certain investigations.', 'Testing thermal sensors and studying temperature-dependent instrument performance.'),
  ('TER-07-MARS', 'thermal.temperature_extremes', 10::numeric, 'Maximum and minimum temperatures', 'The supplied research reports very high daytime temperatures and warm nighttime conditions. Mars experiences much lower average temperatures and can undergo extreme nighttime cooling.', 'Identifying environmental differences and defining thermal-chamber requirements.'),
  ('TER-07-MARS', 'thermal.thermal_variation', 28::numeric, 'Thermal variation', 'Danakil’s daily temperature variation is affected by terrestrial atmospheric heat exchange and local geothermal conditions. Martian temperature cycles are strongly influenced by low atmospheric pressure, dust, and surface thermal inertia.', 'Testing temperature-monitoring equipment while accounting for nonrepresentative thermal dynamics.'),
  ('TER-07-MARS', 'thermal.seasonality', 25::numeric, 'Seasonality', 'Danakil experiences terrestrial seasonal changes, but these do not reproduce the Martian seasonal cycle associated with its orbital period, axial tilt, and seasonal atmospheric behavior.', 'Evaluating environmental monitoring methods across different terrestrial conditions.'),
  ('TER-07-MARS', 'thermal.solar_illumination', 35::numeric, 'Solar illumination', 'Danakil receives intense sunlight, while Mars receives less solar energy because of its greater distance from the Sun. Martian dust further modifies the solar radiation reaching the surface.', 'Testing solar exposure sensors and identifying differences in planetary illumination.'),
  ('TER-07-MARS', 'thermal.atmospheric_conditions', 8::numeric, 'Atmospheric pressure', 'Danakil’s below-sea-level elevation corresponds to relatively high terrestrial atmospheric pressure, whereas typical Martian surface pressure is approximately 600 Pa.', 'Establishing the need for low-pressure simulation during Mars equipment qualification.'),
  ('TER-07-MARS', 'geology.rock_type', 88::numeric, 'Rock type', 'Basaltic volcanic rocks associated with the Afar Rift are relevant to Mars, where basaltic materials are widespread. However, Dallol’s evaporite-rich hydrothermal deposits represent a distinct geological setting.', 'Testing basalt identification and geological classification instruments.'),
  ('TER-07-MARS', 'geology.mineral_composition', 85::numeric, 'Mineralogical composition', 'Danakil contains sulfur-bearing minerals, evaporites, iron oxides, and basalt-associated silicates. Mars contains basaltic minerals, sulfates, iron oxides, and evidence of aqueous mineral alteration in selected regions.', 'Testing mineral spectroscopy and recognizing alteration products.'),
  ('TER-07-MARS', 'geology.chemical_composition', 83::numeric, 'Chemical composition', 'Danakil’s hydrothermal and evaporitic deposits can contain sulfur, chlorine, potassium, iron, and other elements associated with mineral precipitation. Comparable chemical classes occur in selected Martian geological environments, although exact abundances differ.', 'Evaluating elemental analysis and chemical characterization of altered rocks.'),
  ('TER-07-MARS', 'geology.surface_material', 81::numeric, 'Surface material', 'Danakil contains salt crusts, altered hydrothermal sediments, volcanic ash, and basaltic fragments. Mars contains volcanic rocks, fine-grained deposits, sulfate-rich materials, and chemically altered sedimentary surfaces.', 'Testing geological sampling and surface-material recognition.'),
  ('TER-07-MARS', 'geology.alteration', 91::numeric, 'Geological alteration', 'Dallol experiences intense hydrothermal and acid-driven mineral alteration. Mars preserves evidence of ancient hydrothermal and aqueous alteration processes, although the activity, duration, and environmental conditions differ.', 'Reconstructing ancient water–rock interactions and interpreting alteration minerals.'),
  ('TER-07-MARS', 'geology.formations', 76::numeric, 'Geological formations', 'Danakil’s volcanic fissures, basaltic formations, salt deposits, and hydrothermal structures provide process-level comparisons with selected Martian volcanic and mineralized terrains. Active terrestrial rifting is not equivalent to Martian tectonic history.', 'Mapping volcanic and hydrothermal formations using remote sensing.'),
  ('TER-07-MARS', 'water.surface_water', 62::numeric, 'Surface water', 'Dallol contains liquid hydrothermal fluids and hypersaline brines. Present-day Mars generally cannot maintain stable exposed liquid water, but ancient Martian environments may have supported water–rock interactions and saline fluids.', 'Investigating brine chemistry and mineral precipitation relevant to ancient Martian environments.'),
  ('TER-07-MARS', 'water.surface_ice', 0::numeric, 'Surface ice', 'Persistent surface ice is absent from the selected hot Danakil lowlands. Mars contains polar ice and seasonal frost.', 'Excluding Danakil from primary Martian surface-ice analog studies.'),
  ('TER-07-MARS', 'water.subsurface_ice', 0::numeric, 'Subsurface ice', 'The hot hydrothermal environment is not representative of frozen Martian subsurface deposits. Mars contains buried ice in selected midlatitude and polar regions.', 'Identifying when cold-region analog sites are required.'),
  ('TER-07-MARS', 'water.permafrost', 0::numeric, 'Permafrost', 'Danakil’s lowland environment lacks permafrost. Mars contains extensive permanently cold subsurface terrain and locally ice-rich ground.', 'Preventing inappropriate comparison with Martian cryogeology.'),
  ('TER-07-MARS', 'water.hydrogen', 65::numeric, 'Hydrogen-bearing materials', 'Water-bearing hydrothermal fluids and hydrated minerals contain hydrogen. Mars also contains hydrogen-bearing minerals and ice-related deposits, but the forms and stability conditions differ.', 'Testing hydrated-mineral detection and hydrogen-sensitive instruments.'),
  ('TER-07-MARS', 'water.past_water', 88::numeric, 'Evidence of past water', 'Danakil’s evaporites and hydrothermal alteration products record interactions between fluids and geological materials. Mars contains sulfate-rich deposits and altered rocks that provide evidence of past aqueous processes.', 'Reconstructing water-related geological histories and identifying possible ancient hydrothermal environments.'),
  ('TER-07-MARS', 'water.mineral_resources', 78::numeric, 'Mineral resources', 'Danakil contains extensive evaporite and potash deposits. Mars contains scientifically important mineral deposits, including sulfates and other alteration products, but resource extraction feasibility cannot be inferred from the terrestrial comparison.', 'Testing mineral-resource identification and geological prospecting techniques.'),
  ('TER-07-MARS', 'atmosphere.atmospheric_pressure', 8::numeric, 'Atmospheric pressure', 'Danakil has a dense terrestrial atmosphere, while Mars has very low surface atmospheric pressure.', 'Identifying limitations of open-air atmospheric testing.'),
  ('TER-07-MARS', 'atmosphere.atmospheric_composition', 12::numeric, 'Atmospheric composition', 'Earth’s atmosphere is dominated by nitrogen and oxygen, while Mars has a carbon dioxide-dominated atmosphere. Local sulfur-bearing gases in Danakil do not make the overall atmospheric composition Martian.', 'Separating local gas-detection experiments from full atmospheric simulation.'),
  ('TER-07-MARS', 'atmosphere.wind', 45::numeric, 'Wind', 'Danakil experiences local atmospheric circulation and wind-driven particle movement. Mars also has winds, but its low atmospheric density changes the forces required to transport particles.', 'Testing wind monitoring and preliminary sediment-transport observations.'),
  ('TER-07-MARS', 'atmosphere.dust', 55::numeric, 'Dust', 'Fine mineral salts, volcanic ash, and other particles may be mobilized in Danakil. Mars contains widespread fine mineral dust with different composition and physical properties.', 'Testing particle sensors, dust-resistant equipment, and optical instruments.'),
  ('TER-07-MARS', 'atmosphere.dust_storms', 42::numeric, 'Dust storms', 'Local airborne dust events can occur in arid terrestrial environments, but their intensity and scale differ from Martian dust storms, which may become regional or planet-encircling.', 'Testing dust monitoring and visibility instrumentation.'),
  ('TER-07-MARS', 'atmosphere.aeolian_erosion', 52::numeric, 'Aeolian erosion and sediments', 'Danakil contains wind-affected sedimentary surfaces and evaporite deposits. Mars also exhibits aeolian erosion and sediment transport, although the environmental conditions and material properties differ.', 'Investigating sediment redistribution and surface modification.'),
  ('TER-07-MARS', 'atmosphere.aerosols', 35::numeric, 'Aerosols', 'Danakil can contain sulfur-bearing gases and volcanic or mineral aerosols. Martian aerosols are dominated by suspended dust and other atmospheric particles under very different pressure and chemical conditions.', 'Testing aerosol detection and identifying limitations of terrestrial atmospheric analogs.'),
  ('TER-07-MARS', 'subsurface.caves', 64::numeric, 'Caves and cavities', 'The supplied research describes salt-related cavities and possible volcanic voids in the broader region. Martian subsurface cavities may form through volcanic or collapse processes, but specific Danakil cavity systems require verification.', 'Testing cavity detection and subsurface geological interpretation.'),
  ('TER-07-MARS', 'subsurface.lava_tubes', 82::numeric, 'Lava tubes', 'The supplied research associates lava tubes with basaltic volcanic terrain around Erta Ale. Mars contains candidate lava-tube systems associated with volcanic provinces. The presence, location, and geometry of specific Danakil tubes must be confirmed before detailed comparison.', 'Investigating volcanic cavities and testing subsurface exploration instruments.'),
  ('TER-07-MARS', 'subsurface.fractures', 88::numeric, 'Fractures and faults', 'Active tectonic extension produces extensive faults and fissures in Danakil. Mars contains extensional faults, fractures, and graben structures associated with volcanic and tectonic processes.', 'Mapping fractures, identifying geological hazards, and reconstructing tectonic deformation.'),
  ('TER-07-MARS', 'subsurface.subsurface_structure', 80::numeric, 'Subsurface structure', 'Danakil contains evaporite sequences, basaltic flows, intrusive rocks, and tectonically modified strata. Martian subsurface structures can include volcanic layers, fractured crust, and sedimentary deposits.', 'Testing subsurface imaging and geological-layer interpretation.'),
  ('TER-07-MARS', 'subsurface.material_thickness', 66::numeric, 'Material thickness', 'Danakil contains substantial basin-fill deposits and volcanic sequences. Martian geological deposits also vary in thickness, but their origins and mechanical properties differ.', 'Evaluating radar-based layer-thickness estimation and geological stratigraphy.'),
  ('TER-07-MARS', 'biology.extremophiles', 82::numeric, 'Extremophile organisms', 'Microorganisms adapted to extreme salinity, acidity, or temperature occur in some environments of the broader Danakil region. Their distribution is highly dependent on local conditions, and the most extreme Dallol fluids may be uninhabitable.', 'Testing microbial detection instruments and investigating the environmental boundaries of life.'),
  ('TER-07-MARS', 'biology.habitability', 90::numeric, 'Habitability conditions', 'Dallol combines extreme acidity, high salinity, elevated temperatures, and unusual chemical conditions. These stresses provide a valuable experimental setting for determining when environments become incompatible with known life.', 'Establishing habitability thresholds and evaluating possible ancient Martian environments.'),
  ('TER-07-MARS', 'biology.biosignatures', 78::numeric, 'Potential biosignatures', 'Biological traces may occur in inhabited neighboring environments, while abiotic mineral structures in Dallol can resemble biological features. This distinction is especially important when interpreting possible Martian biosignatures.', 'Testing biosignature-detection methods and distinguishing biological signals from abiotic mineral formations.'),
  ('TER-07-MARS', 'biology.adaptations', 66::numeric, 'Biological adaptations', 'Some microorganisms in the broader region possess adaptations to heat, salinity, or acidity. However, simultaneous exposure to extreme conditions may exceed the tolerance of known life, and not all environments contain living organisms.', 'Studying extremophile physiology, microbial survival limits, and contamination control.'),
  ('TER-08-MOON', 'topography.elevation', 62::numeric, 'Elevation', 'Stillwater’s mountainous terrain reaches elevations of approximately 1,500–3,000 m above terrestrial sea level. Lunar highlands can also occur at positive elevations relative to the lunar reference sphere. However, the two elevation datums are fundamentally different, so numerical altitude alone does not establish similarity.', 'Evaluating relative-elevation models, digital terrain analysis, and topographic visualization.'),
  ('TER-08-MOON', 'topography.slope', 76::numeric, 'Slope', 'Stillwater contains moderate to steep slopes associated with mountain ridges, exposed intrusive rocks, and valleys. Lunar highlands also contain significant slopes, including crater walls and rugged highland terrain. The slope-generating processes differ, but comparable gradients can create similar exploration challenges.', 'Testing rover slope navigation, route planning, and terrain accessibility models.'),
  ('TER-08-MOON', 'topography.roughness', 80::numeric, 'Surface roughness', 'Angular talus, fractured anorthositic bedrock, and rocky ridges produce substantial surface roughness. Lunar highlands are also rough because of impact ejecta,

fractured crust, and accumulated rocky debris. Roughness must be compared at equivalent spatial scales.', 'Testing obstacle detection, robotic suspension, and high-resolution roughness mapping.'),
  ('TER-08-MOON', 'topography.relief', 70::numeric, 'Relief', 'Stillwater’s mountainous relief reflects tectonic uplift, erosion, and exposure of ancient intrusive rocks. Lunar highland relief is strongly influenced by impact basins, craters, and ancient crustal processes. Although both contain rugged elevated terrain, their geological histories differ.', 'Comparing landform morphology and interpreting planetary topographic data.'),
  ('TER-08-MOON', 'topography.craters', 0::numeric, 'Craters', 'The supplied terrestrial research identifies no significant recent impact craters at the selected site. Lunar highlands are extensively cratered, making impact structures a defining geomorphological feature absent from Stillwater.', 'Demonstrating why mineralogical similarity cannot be used as a substitute for impact-crater morphology.'),
  ('TER-08-MOON', 'topography.obstacles', 79::numeric, 'Surface obstacles', 'Fractured anorthosite blocks, angular talus, and stable rocky outcrops create obstacles similar in general form to some lunar highland boulders. Lunar rocks and regolith differ in cohesion, exposure history, and gravitational behavior.', 'Testing autonomous obstacle recognition, sampling approaches, and rocky-terrain mobility.'),
  ('TER-08-MOON', 'thermal.surface_temperature', 35::numeric, 'Surface temperature', 'Stillwater has a temperate-to-cold mountain climate with seasonally variable ground temperatures. Lunar surface temperatures can range from extremely hot sunlit conditions to exceptionally cold shadowed environments. The terrestrial atmosphere moderates temperature changes and produces different heat-transfer behavior.', 'Testing surface-temperature sensors under variable terrestrial conditions.'),
  ('TER-08-MOON', 'thermal.temperature_extremes', 37::numeric, 'Maximum and minimum temperatures', 'The supplied research describes summer temperatures near 25°C and winter minimum temperatures below −20°C. Lunar equatorial surfaces can reach approximately 123°C during the day, while permanently shadowed polar regions can fall below −200°C.', 'Evaluating selected cold-weather instrumentation while identifying the need for more extreme thermal qualification.'),
  ('TER-08-MOON', 'thermal.thermal_variation', 25::numeric, 'Thermal variation', 'Stillwater experiences a terrestrial day–night cycle and seasonal temperature variation. The lunar synodic day lasts approximately 29.5 Earth days, creating much longer periods of heating and cooling.', 'Testing temperature logging and thermal-response models, with explicit limits on lunar equivalence.'),
  ('TER-08-MOON', 'thermal.solar_illumination', 48::numeric, 'Solar illumination', 'Mountain slopes and ridges create shadows that can be studied through terrain-based illumination modeling. Lunar polar exploration also depends on local topographic shading, although the Moon’s solar geometry and atmospheric conditions differ.', 'Testing horizon calculations, slope illumination models, and solar-exposure mapping.'),
  ('TER-08-MOON', 'thermal.atmospheric_conditions', 0::numeric, 'Atmospheric conditions / exosphere', 'Stillwater has a dense terrestrial atmosphere containing nitrogen, oxygen, water vapor, and other gases. The Moon has an extremely tenuous exosphere and no comparable atmospheric pressure.', 'Establishing the need for vacuum-based equipment testing and lunar-specific environmental simulation.'),
  ('TER-08-MOON', 'geology.rock_type', 97::numeric, 'Rock type', 'Stillwater contains anorthositic rocks dominated by plagioclase feldspar. Lunar highlands are rich in anorthositic crustal materials, including ferroan anorthosites associated with early lunar crust formation. Both rock groups share a defining feldspathic character, although their petrogenesis and accessory mineral assemblages differ.', 'Creating and testing reference libraries for lunar anorthosite identification.'),
  ('TER-08-MOON', 'geology.mineral_composition', 98::numeric, 'Mineralogical composition', 'Calcium-rich plagioclase is a major constituent of Stillwater anorthositic units and lunar highland anorthosites. Associated minerals such as pyroxene and olivine can also occur in both geological settings. Exact modal abundances and mineral compositions must be confirmed for individual samples.', 'Calibrating visible, near-infrared, and other mineralogical instruments for plagioclase-rich rocks.'),
  ('TER-08-MOON', 'geology.chemical_composition', 93::numeric, 'Chemical composition', 'Anorthositic rocks are commonly enriched in aluminum, calcium, and silicon relative to many mafic rock types. Lunar highland anorthosites also contain elevated Al₂O₃ and CaO. However, matching major-element chemistry does not imply identical trace-element abundances, oxidation states, or isotopic compositions.', 'Testing elemental analysis, geochemical classification, and aluminum-rich material identification.'),
  ('TER-08-MOON', 'geology.surface_material', 75::numeric, 'Surface material', 'Stillwater contains exposed anorthositic bedrock and angular rock fragments, providing access to relevant source lithologies. However, its soils include products of terrestrial chemical weathering and organic activity. Lunar regolith is produced mainly by impact fragmentation and space weathering.', 'Testing rock sampling, fragment classification, and mineral identification in mixed surface materials.'),
  ('TER-08-MOON', 'geology.alteration', 32::numeric, 'Geological alteration', 'Stillwater rocks experience terrestrial weathering involving water, oxygen, freeze–thaw processes, and biological activity. Lunar highland materials are modified mainly by micrometeorite impacts, solar-wind exposure, and radiation-driven space weathering.', 'Distinguishing primary anorthosite mineral signatures from weathering-related spectral changes.'),
  ('TER-08-MOON', 'geology.formations', 91::numeric, 'Geological formations', 'Stillwater preserves a layered igneous intrusion with plagioclase-rich units produced by magmatic differentiation. Lunar anorthosites are associated with early crustal

differentiation, commonly interpreted through lunar magma-ocean models. Both involve igneous differentiation, but Stillwater is a terrestrial intrusive complex rather than a direct miniature of the lunar crust.', 'Investigating crystal accumulation, magmatic differentiation, and the interpretation of ancient planetary crusts.'),
  ('TER-08-MOON', 'water.surface_water', 0::numeric, 'Surface water', 'The supplied research describes streams, springs, and water from seasonal snowmelt. Stable liquid water is absent from the lunar surface under natural present-day conditions.', 'Identifying environmental differences that must be excluded from lunar surface simulations.'),
  ('TER-08-MOON', 'water.surface_ice', 20::numeric, 'Surface ice', 'Stillwater experiences seasonal snow and frozen surface conditions, but these deposits are temporary and formed under terrestrial atmospheric conditions. Lunar polar ice occurs in extremely cold environments with different stability mechanisms.', 'Limited testing of snow and ice detection while distinguishing terrestrial seasonal deposits from lunar cold-trap ice.'),
  ('TER-08-MOON', 'water.subsurface_ice', 0::numeric, 'Subsurface ice', 'The supplied research does not identify persistent subsurface ice in the selected complex. Lunar polar regions may contain buried ice deposits.', 'Excluding the site from primary lunar subsurface-ice analog investigations.'),
  ('TER-08-MOON', 'water.permafrost', 0::numeric, 'Permafrost', 'Permafrost is not documented for the selected exposed Stillwater setting. Permanently cold lunar polar regolith differs fundamentally from ordinary terrestrial seasonal freezing.', 'Identifying the need for specialized cryogenic analog sites.'),
  ('TER-08-MOON', 'water.hydrogen', 28::numeric, 'Hydrogen-bearing materials', 'Stillwater contains hydrogen in water, organic material, and weathering products. Lunar hydrogen can occur in polar volatiles, hydroxyl-bearing surface materials, and solar-wind-related reservoirs.', 'Testing hydrogen detection while distinguishing chemically different sources.'),
  ('TER-08-MOON', 'water.mineral_resources', 84::numeric, 'Mineral resources', 'Stillwater contains plagioclase-rich rocks with significant aluminum, calcium, silicon, and oxygen-bearing minerals. Lunar highland anorthosites are also relevant to possible in-situ resource utilization, particularly extraction of oxygen and other elements from mineral structures. Stillwater’s platinum-group deposits are not evidence of equivalent lunar ore deposits.', 'Investigating aluminum-rich rock characterization, mineral extraction concepts, and lunar resource prospecting.'),
  ('TER-08-MOON', 'atmosphere.wind', 0::numeric, 'Wind', 'Stillwater experiences terrestrial mountain winds, while the Moon lacks an atmosphere capable of sustaining conventional aerodynamic wind.', 'Distinguishing terrestrial wind-driven processes from lunar surface dynamics.'),
  ('TER-08-MOON', 'atmosphere.dust', 20::numeric, 'Abrasive dust', 'Fine mineral particles may occur in exposed rock areas, but Stillwater generally lacks extensive dry, impact-generated lunar-style dust deposits. Lunar dust is highly angular, abrasive, and affected by electrostatic charging.', 'Preliminary particle-abrasion tests with clear material limitations.'),
  ('TER-08-MOON', 'atmosphere.dust_storms', null::numeric, 'Dust storms', 'Atmospheric dust storms have no direct lunar counterpart.', 'Preventing inappropriate comparisons with lunar environmental conditions.'),
  ('TER-08-MOON', 'atmosphere.aeolian_erosion', null::numeric, 'Aeolian erosion', 'Terrestrial wind erosion is not a direct lunar geological process. The Moon’s surface is modified primarily by impacts and space weathering.', 'Distinguishing atmospheric erosion from impact-driven regolith evolution.'),
  ('TER-08-MOON', 'atmosphere.sediments', 35::numeric, 'Sediments and granular deposits', 'Stillwater contains talus, alluvial sediments, and older glacial deposits. Lunar granular materials originate primarily from impacts and volcanic activity rather than rivers and glaciers.', 'Testing rock-fragment sorting, granular sampling, and surface-material classification.'),
  ('TER-08-MOON', 'atmosphere.aerosols', null::numeric, 'Aerosols', 'Stillwater’s atmospheric aerosols have no direct equivalent in the lunar exosphere.', 'Defining limitations for atmospheric sensor testing.'),
  ('TER-08-MOON', 'subsurface.caves', 28::numeric, 'Caves', 'The supplied research mentions small caves and possible minor tectonic or karstic cavities in associated formations. Their presence, exact location, and geological origin require verification. Lunar cavities may form through volcanic or collapse processes.', 'Preliminary cavity-detection testing where verified cavities exist.'),
  ('TER-08-MOON', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'The Stillwater Complex formed through the crystallization of magma beneath Earth’s surface. It is not an extrusive lava-flow system and does not provide a direct lava-tube analog.', 'Distinguishing intrusive geological structures from volcanic conduits.'),
  ('TER-08-MOON', 'subsurface.fractures', 78::numeric, 'Cavities and fractures', 'The complex contains tectonic fractures and joints within competent igneous rocks. Lunar highland bedrock may also contain fractures associated with impacts and tectonic deformation, although the stress histories differ.', 'Testing fracture mapping, geological hazard assessment, and structural reconnaissance.'),
  ('TER-08-MOON', 'subsurface.subsurface_structure', 88::numeric, 'Subsurface structure', 'Stillwater preserves distinct layered igneous units, including anorthositic and mafic–ultramafic rocks. The lunar crust also contains differentiated igneous materials, although its stratigraphy and formation history are different.', 'Testing geological-layer interpretation, radar imaging, and crustal structure models.'),
  ('TER-08-MOON', 'subsurface.material_thickness', 83::numeric, 'Material thickness', 'Stillwater exposes substantial igneous rock sequences with variable layer thicknesses. Lunar crustal units and subsurface rock bodies also have measurable thicknesses, but their geometry and origin cannot be inferred directly from terrestrial intrusive layering.', 'Evaluating stratigraphic thickness estimation and subsurface geological modeling.'),
  ('TER-08-MOON', 'biology.extremophiles', null::numeric, 'Extremophile organisms', 'The supplied research does not identify a specialized extremophile environment relevant to lunar biology, and no indigenous lunar organisms have been confirmed.', 'Testing contamination monitoring during sample collection.'),
  ('TER-08-MOON', 'biology.habitability', null::numeric, 'Habitability conditions', 'Stillwater’s terrestrial conditions support ordinary biological activity, whereas the lunar surface lacks comparable natural environmental conditions.', 'Distinguishing terrestrial habitability from lunar environmental requirements.'),
  ('TER-08-MOON', 'biology.biosignatures', null::numeric, 'Biosignatures', 'Organic material from terrestrial vegetation and soils has no confirmed indigenous lunar biological counterpart.', 'Preventing biological contamination from affecting mineralogical interpretations.'),
  ('TER-08-MOON', 'biology.adaptations', null::numeric, 'Biological adaptations', 'Terrestrial mountain organisms do not provide a direct comparison with confirmed lunar biological adaptations.', 'Establishing appropriate biological controls for geological field experiments.'),
  ('TER-08-MARS', 'topography.elevation', 45::numeric, 'Elevation', 'Stillwater’s elevations range approximately from 1,500 to 3,000 m above terrestrial sea level. Martian elevation is measured relative to the areoid. The values cannot be directly compared without accounting for different planetary reference surfaces.', 'Testing digital elevation processing and terrain normalization.'),
  ('TER-08-MARS', 'topography.slope', 72::numeric, 'Slope', 'Stillwater includes moderate and steep slopes associated with mountain ridges and exposed intrusive formations. Martian highlands and volcanic terrains also contain substantial local gradients. However, the origin and mechanical stability of these slopes can differ.', 'Testing slope-dependent rover route planning and terrain accessibility.'),
  ('TER-08-MARS', 'topography.roughness', 72::numeric, 'Surface roughness', 'Fractured bedrock, angular talus, and rocky exposures create locally rough terrain. Martian surfaces can contain boulders, fractured outcrops, and rough volcanic materials. Comparisons require consistent spatial resolution.', 'Evaluating autonomous navigation, obstacle detection, and terrain roughness classification.'),
  ('TER-08-MARS', 'topography.relief', 64::numeric, 'Relief', 'Stillwater’s mountainous relief reflects tectonic deformation and erosion. Martian relief includes impact basins, volcanic edifices, tectonic structures, and erosion-related landforms.', 'Comparing topographic morphology and mapping geological terrain units.'),
  ('TER-08-MARS', 'topography.craters', 0::numeric, 'Craters', 'The supplied research does not identify significant recent impact craters at Stillwater. Impact craters are widespread on Mars and are central to understanding its surface history.', 'Identifying the limits of using Stillwater as a Martian impact-landscape analog.'),
  ('TER-08-MARS', 'topography.obstacles', 75::numeric, 'Surface obstacles', 'Angular blocks, fractured rock, and uneven outcrops create navigation hazards that resemble some obstacles encountered by Martian rovers. Material behavior differs because of gravity, atmospheric conditions, and surface weathering.', 'Testing robotic path planning, obstacle avoidance, and sampling-site selection.'),
  ('TER-08-MARS', 'thermal.surface_temperature', 42::numeric, 'Surface temperature', 'Stillwater experiences seasonally cold ground conditions. Mars is generally much colder, and its surface temperature depends strongly on local time, latitude, season, dust, and surface thermal properties.', 'Testing surface-temperature sensors under selected cold terrestrial conditions.'),
  ('TER-08-MARS', 'thermal.temperature_extremes', 50::numeric, 'Maximum and minimum temperatures', 'The supplied research describes summer temperatures near 25°C and winter minimum temperatures below −20°C. Some Martian daytime temperatures may approach or exceed 0°C, but nighttime temperatures commonly fall much lower.', 'Evaluating equipment response to temperature changes while identifying the need for more extreme testing.'),
  ('TER-08-MARS', 'thermal.thermal_variation', 44::numeric, 'Thermal variation', 'Stillwater experiences daily and seasonal temperature cycles. Mars also has substantial thermal variation, but its thin atmosphere and surface thermal inertia produce different heating and cooling behavior.', 'Testing thermal monitoring systems and comparing temperature-cycle models.'),
  ('TER-08-MARS', 'thermal.seasonality', 42::numeric, 'Seasonality', 'Stillwater has pronounced terrestrial seasons, including winter snow accumulation. Mars also has seasons because of its axial tilt, but its orbital period and seasonal atmospheric processes differ.', 'Evaluating seasonal environmental monitoring methods.'),
  ('TER-08-MARS', 'thermal.solar_illumination', 40::numeric, 'Solar illumination', 'Stillwater’s northern latitude and mountainous terrain produce changing illumination and topographic shadows. Martian solar illumination differs because Mars receives less solar energy and atmospheric dust modifies surface radiation.', 'Testing terrain-shadow modeling and solar-exposure analysis.'),
  ('TER-08-MARS', 'thermal.atmospheric_conditions', 8::numeric, 'Atmospheric pressure', 'Stillwater’s mountain elevation reduces atmospheric pressure relative to sea level, but it remains vastly higher than typical Martian surface pressure, approximately 600 Pa.', 'Establishing the need for low-pressure chambers during Martian equipment qualification.'),
  ('TER-08-MARS', 'geology.rock_type', 76::numeric, 'Rock type', 'Stillwater contains mafic and ultramafic igneous rocks, including mineral assemblages relevant to basaltic and related planetary materials. Mars contains widespread basaltic rocks, but a layered plutonic intrusion differs from many exposed Martian lava flows and sedimentary units.', 'Testing classification methods for igneous rock types.'),
  ('TER-08-MARS', 'geology.mineral_composition', 72::numeric, 'Mineralogical composition', 'Stillwater contains plagioclase, pyroxene, olivine, and other minerals associated with igneous differentiation. These mineral groups are relevant to Martian igneous geology, although their proportions and compositions vary.', 'Testing mineral spectroscopy and mineral-abundance estimation.'),
  ('TER-08-MARS', 'geology.chemical_composition', 66::numeric, 'Chemical composition', 'Stillwater’s mafic rocks contain major silicate-forming elements relevant to Martian igneous materials. However, its anorthositic layers may be more enriched in aluminum and calcium than many common Martian basaltic rocks.', 'Evaluating elemental analysis and identifying differentiated igneous compositions.'),
  ('TER-08-MARS', 'geology.surface_material', 57::numeric, 'Surface material', 'Stillwater contains exposed rock, talus, and weathered soil. Mars contains bedrock, regolith, dust, and sedimentary deposits. The site’s exposed igneous rocks are more useful analogs than its vegetated and organic-rich soils.', 'Testing rock sampling and distinguishing bedrock from loose surface material.'),
  ('TER-08-MARS', 'geology.alteration', 42::numeric, 'Geological alteration', 'Stillwater undergoes terrestrial chemical weathering, oxidation, and freeze–thaw processes. Martian rocks can preserve evidence of aqueous alteration, oxidation, and other surface modifications, but the environmental conditions and timescales differ.', 'Distinguishing primary igneous minerals from secondary alteration products.'),
  ('TER-08-MARS', 'geology.formations', 77::numeric, 'Geological formations', 'Stillwater’s layered intrusion records magmatic differentiation and crystal accumulation. Martian crustal evolution also involved igneous differentiation, although the structures and formation environments are not identical.', 'Investigating planetary crustal evolution and igneous stratigraphy.'),
  ('TER-08-MARS', 'water.surface_water', 8::numeric, 'Surface water', 'Stillwater contains streams, springs, and seasonal runoff. Stable exposed liquid water is generally absent from present-day Mars. Ancient Martian environments contained water-related geological systems, but Stillwater’s modern streams are not a direct environmental equivalent.', 'Distinguishing present-day terrestrial hydrology from ancient Martian aqueous processes.'),
  ('TER-08-MARS', 'water.surface_ice', 26::numeric, 'Surface ice', 'Stillwater experiences seasonal snow and surface freezing. Mars contains polar ice, seasonal frost, and other ice-related deposits. The persistence, composition, and formation mechanisms differ.', 'Limited testing of surface frost and snow detection.'),
  ('TER-08-MARS', 'water.subsurface_ice', 0::numeric, 'Subsurface ice', 'The supplied research does not document persistent subsurface ice within the selected Stillwater setting. Mars contains extensive buried ice in certain regions.', 'Identifying the need for specialized frozen-ground analog sites.'),
  ('TER-08-MARS', 'water.permafrost', 0::numeric, 'Permafrost', 'The supplied research identifies no permafrost in the selected exposed complex. Mars has permanently cold subsurface environments, including ice-rich ground.', 'Excluding Stillwater from primary Martian permafrost investigations.'),
  ('TER-08-MARS', 'water.hydrogen', 34::numeric, 'Hydrogen-bearing materials', 'Hydrogen occurs in terrestrial water, vegetation, soils, and weathering minerals. Mars contains hydrogen-bearing minerals and ice deposits, but the chemical reservoirs and environmental conditions differ.', 'Testing hydrogen-sensitive instruments and differentiating mineral-bound hydrogen from water-related signals.'),
  ('TER-08-MARS', 'water.past_water', 32::numeric, 'Evidence of past water', 'Stillwater’s landscape contains evidence of terrestrial fluvial and glacial modification. Mars also preserves evidence of ancient water-related processes, but the geological environments and preservation mechanisms differ.', 'Training geological interpretation systems to distinguish water-related landforms from igneous structures.'),
  ('TER-08-MARS', 'water.mineral_resources', 73::numeric, 'Mineral resources', 'Stillwater contains economically significant platinum-group, chromium, and nickel mineralization, as well as aluminum- and calcium-rich rocks. Mars contains mineral resources of scientific interest, but equivalent economic concentrations cannot be assumed.', 'Testing mineral-resource identification and evaluating igneous mineral assemblages.'),
  ('TER-08-MARS', 'atmosphere.atmospheric_pressure', 8::numeric, 'Atmospheric pressure', 'Stillwater has a dense terrestrial atmosphere compared with the very low pressure of Mars.', 'Defining the need for low-pressure atmospheric testing.'),
  ('TER-08-MARS', 'atmosphere.atmospheric_composition', 12::numeric, 'Atmospheric composition', 'Earth’s atmosphere is dominated by nitrogen and oxygen, whereas the Martian atmosphere is dominated by carbon dioxide.', 'Identifying limitations of terrestrial atmospheric sensor testing.'),
  ('TER-08-MARS', 'atmosphere.wind', 37::numeric, 'Wind', 'Stillwater experiences mountain winds and regional weather systems. Mars also has winds, but atmospheric density and particle-transport thresholds differ greatly.', 'Preliminary testing of wind monitoring instruments.'),
  ('TER-08-MARS', 'atmosphere.dust', 25::numeric, 'Dust', 'Stillwater generally contains limited airborne mineral dust because of vegetation and moisture. Mars has extensive fine mineral dust deposits and atmospheric dust transport.', 'Testing particle detection under limited terrestrial conditions.'),
  ('TER-08-MARS', 'atmosphere.dust_storms', 0::numeric, 'Dust storms', 'The supplied research does not identify dust storms as a characteristic feature of the selected mountainous environment. Martian dust storms are an important atmospheric process.', 'Excluding Stillwater from primary Martian dust-storm analog studies.'),
  ('TER-08-MARS', 'atmosphere.aeolian_erosion', 33::numeric, 'Aeolian erosion and sediments', 'Wind contributes to some terrestrial sediment movement, but water, gravity, glaciation, and mechanical weathering are more important at Stillwater. Martian aeolian processes have shaped dunes and other sedimentary features.', 'Distinguishing different sediment-transport mechanisms.'),
  ('TER-08-MARS', 'atmosphere.aerosols', 24::numeric, 'Aerosols', 'Stillwater contains ordinary terrestrial atmospheric aerosols, including particles from vegetation and regional atmospheric sources. Martian aerosols are dominated by mineral dust and other particles under different atmospheric conditions.', 'Evaluating sensor response to terrestrial aerosols while recognizing differences from Mars.'),
  ('TER-08-MARS', 'subsurface.caves', 25::numeric, 'Caves and cavities', 'The supplied research mentions small caves and minor cavities in associated geological formations. Their precise location and characteristics are not established. Martian caves and collapse pits may have different volcanic or structural origins.', 'Limited testing of cavity detection where site-specific structures are confirmed.'),
  ('TER-08-MARS', 'subsurface.lava_tubes', 0::numeric, 'Lava tubes', 'Stillwater is a plutonic intrusion that crystallized beneath the surface. It is not a lava-flow system and does not provide a direct analog for Martian lava tubes.', 'Distinguishing intrusive rocks from extrusive volcanic conduits.'),
  ('TER-08-MARS', 'subsurface.fractures', 79::numeric, 'Fractures and faults', 'Stillwater contains joints and tectonic fractures within competent igneous rock. Mars also contains fractures, faults, and extensional structures.', 'Testing fracture recognition and geological hazard mapping.'),
  ('TER-08-MARS', 'subsurface.subsurface_structure', 86::numeric, 'Subsurface structure', 'Stillwater preserves layered igneous rocks with differing mineral compositions. Martian crustal investigations also seek to identify geological layering and igneous structures, although their formation histories may differ.', 'Testing subsurface radar interpretation and geological-layer classification.'),
  ('TER-08-MARS', 'subsurface.material_thickness', 80::numeric, 'Material thickness', 'Stillwater exposes substantial intrusive rock sequences with varying layer thicknesses. Martian crustal units also have measurable thicknesses, but direct comparison requires geophysical and geological data at comparable scales.', 'Evaluating geological thickness estimation and subsurface modeling.'),
  ('TER-08-MARS', 'biology.extremophiles', 5::numeric, 'Extremophile organisms', 'The supplied research does not identify a specialized extremophile community relevant to Martian environmental limits. Ordinary terrestrial biological activity does not establish similarity with potential Martian life.', 'Establishing biological contamination controls.'),
  ('TER-08-MARS', 'biology.habitability', 8::numeric, 'Habitability conditions', 'Stillwater has accessible liquid water, a dense atmosphere, and relatively moderate temperatures. Present-day Mars is cold, dry, and exposed to much harsher surface conditions.', 'Identifying differences between terrestrial habitability and Martian environmental constraints.'),
  ('TER-08-MARS', 'biology.biosignatures', 12::numeric, 'Potential biosignatures', 'Stillwater contains abundant terrestrial organic material from vegetation and soils. Mars has no confirmed indigenous biosignatures, and organic detection alone does not establish biological origin.', 'Testing contamination monitoring and distinguishing biological material from mineralogical signals.'),
  ('TER-08-MARS', 'biology.adaptations', 15::numeric, 'Biological adaptations', 'Stillwater supports organisms adapted to a terrestrial mountain environment, but these adaptations are not directly representative of the combined stresses associated with the Martian surface.', 'Evaluating biological contamination and instrument selectivity.')
) as v (code, variable_id, score, label_reported, explanation, utility)
join public.assessments a on a.code = v.code;

insert into public.assessment_applications (assessment_id, position, body)
select a.id, v.position, v.body
from (values
  ('TER-01-MOON', 1, 'Ensayos de movilidad de rovers.'),
  ('TER-01-MOON', 2, 'Navegación autónoma sobre terrenos pedregosos.'),
  ('TER-01-MOON', 3, 'Detección y evasión de obstáculos.'),
  ('TER-01-MOON', 4, 'Reconocimiento de estructuras geológicas.'),
  ('TER-01-MOON', 5, 'Exploración robótica de cavidades.'),
  ('TER-01-MOON', 6, 'Pruebas preliminares de instrumentos científicos.'),
  ('TER-01-MARS', 1, 'Investigación mineralógica y geoquímica.'),
  ('TER-01-MARS', 2, 'Estudio de depósitos salinos.'),
  ('TER-01-MARS', 3, 'Análisis de procesos sedimentarios.'),
  ('TER-01-MARS', 4, 'Investigación de microorganismos extremófilos.'),
  ('TER-01-MARS', 5, 'Conservación y detección de biofirmas.'),
  ('TER-01-MARS', 6, 'Pruebas de instrumentos científicos.'),
  ('TER-01-MARS', 7, 'Movilidad y navegación robótica.'),
  ('TER-01-MARS', 8, 'Estudios de erosión y transporte de sedimentos.'),
  ('TER-02-MOON', 1, 'Hawaii is particularly useful for volcanic terrain mapping, rover mobility, basaltic mineral identification, subsurface robotic navigation, and experimental reconnaissance of lava-tube structures.'),
  ('TER-02-MARS', 1, 'Martian volcanic terrain interpretation.'),
  ('TER-02-MARS', 2, 'Rover mobility on rough basaltic surfaces.'),
  ('TER-02-MARS', 3, 'Mineralogical and geochemical instrument testing.'),
  ('TER-02-MARS', 4, 'Lava-tube exploration technologies.'),
  ('TER-02-MARS', 5, 'Subsurface geological reconnaissance.'),
  ('TER-02-MARS', 6, 'Astrobiological instrument development.'),
  ('TER-02-MARS', 7, 'Testing methods for recognizing volcanic alteration and microbial signatures.'),
  ('TER-03-MOON', 1, 'Lava-tube exploration: Testing underground navigation and mapping technologies.'),
  ('TER-03-MOON', 2, 'Rover mobility: Evaluating robotic movement across rough basaltic terrain.'),
  ('TER-03-MOON', 3, 'Volcanic geological mapping: Recognizing basaltic formations and structural features.'),
  ('TER-03-MOON', 4, 'Mineralogical instrument testing: Identifying volcanic minerals using remote-sensing and field instruments.'),
  ('TER-03-MOON', 5, 'Preliminary ice-related testing: Evaluating detection and sampling technologies in accessible terrestrial ice environments.'),
  ('TER-03-MOON', 6, 'Subsurface reconnaissance: Investigating fractures, cavities, and layered volcanic deposits.'),
  ('TER-03-MARS', 1, 'Volcanic geology: Investigating basaltic rocks, volcanic formations, and geological evolution.'),
  ('TER-03-MARS', 2, 'Glacial and periglacial research: Studying ice-bearing terrain, frozen ground, and interactions between ice and volcanic materials.'),
  ('TER-03-MARS', 3, 'Rover mobility: Testing navigation across fractured lava, black sands, and irregular volcanic surfaces.'),
  ('TER-03-MARS', 4, 'Dust transport studies: Evaluating particle sensors, dust exposure, and wind-driven sediment movement.'),
  ('TER-03-MARS', 5, 'Hydrothermal alteration research: Identifying minerals and geological signatures associated with water–rock interactions.'),
  ('TER-03-MARS', 6, 'Lava-tube exploration: Developing robotic methods for underground reconnaissance.'),
  ('TER-03-MARS', 7, 'Astrobiology: Testing biosignature detection and investigating terrestrial extremophile communities.'),
  ('TER-04-MOON', 1, 'Polar ice detection: Testing instruments intended to identify buried ice beneath dry surface material.'),
  ('TER-04-MOON', 2, 'Frozen-ground exploration: Evaluating sampling and robotic mobility in permanently frozen soils.'),
  ('TER-04-MOON', 3, 'Polar illumination: Testing imaging and navigation under extended daylight or darkness.'),
  ('TER-04-MOON', 4, 'Surface mobility: Investigating rover movement across rocky desert pavements and glacial blocks.'),
  ('TER-04-MOON', 5, 'Subsurface imaging: Evaluating instruments for detecting frozen layers and fractures.'),
  ('TER-04-MOON', 6, 'Contamination control: Testing procedures for preventing biological contamination during field sampling.'),
  ('TER-04-MARS', 1, 'Subsurface ice detection: Testing instruments designed to locate buried ice beneath dry sediments.'),
  ('TER-04-MARS', 2, 'Permafrost exploration: Investigating frozen-ground properties and robotic sampling.'),
  ('TER-04-MARS', 3, 'Astrobiology: Studying cryptoendolithic microorganisms and potential biosignature preservation.'),
  ('TER-04-MARS', 4, 'Aeolian erosion: Examining ventifact formation and wind-driven sediment transport.'),
  ('TER-04-MARS', 5, 'Polar rover navigation: Testing robotic mobility across rocky and frozen terrain.'),
  ('TER-04-MARS', 6, 'Cryogeological reconstruction: Interpreting ancient glacial deposits and ice-related landforms.'),
  ('TER-04-MARS', 7, 'Geochemical analysis: Studying salt accumulation and mineral preservation in hyperarid environments.'),
  ('TER-05-MOON', 1, 'Impact-crater geology: Investigating central uplifts, impact breccias, and structural deformation.'),
  ('TER-05-MOON', 2, 'Robotic navigation: Testing rover movement across fractured crater terrain.'),
  ('TER-05-MOON', 3, 'Geological sampling: Developing strategies for collecting and classifying impact-generated rocks.'),
  ('TER-05-MOON', 4, 'Subsurface investigation: Evaluating fracture-detection and geological imaging instruments.'),
  ('TER-05-MOON', 5, 'Crater mapping: Training geological mapping and landform-recognition systems.'),
  ('TER-05-MOON', 6, 'Polar field operations: Testing instruments and procedures under cold, remote conditions.'),
  ('TER-05-MARS', 1, 'Martian impact-crater exploration: Studying crater morphology, central uplifts, and impact breccias.'),
  ('TER-05-MARS', 2, 'Subsurface structure detection: Investigating impact fractures and displaced geological layers.'),
  ('TER-05-MARS', 3, 'Permafrost exploration: Testing instruments for frozen-ground mapping and sampling.'),
  ('TER-05-MARS', 4, 'Rover navigation: Evaluating mobility across fractured rocky terrain.'),
  ('TER-05-MARS', 5, 'Geological sampling: Developing procedures for impact-related rock collection and classification.'),
  ('TER-05-MARS', 6, 'Astrobiology: Testing biosignature-detection methods in cold and dry environments.'),
  ('TER-05-MARS', 7, 'Aeolian process studies: Investigating wind erosion and sediment redistribution.'),
  ('TER-06-MOON', 1, 'Rover navigation across low-gradient plains and locally rough terrain.'),
  ('TER-06-MOON', 2, 'Automated recognition of surface obstacles and granular deposits.'),
  ('TER-06-MOON', 3, 'Preliminary dust-ingress and abrasion testing.'),
  ('TER-06-MOON', 4, 'Remote geological classification and mineral spectroscopy.'),
  ('TER-06-MOON', 5, 'Shallow fracture mapping and subsurface instrument evaluation.'),
  ('TER-06-MOON', 6, 'Validation of algorithms that distinguish lunar-compatible landforms from terrestrial sedimentary features.'),
  ('TER-06-MARS', 1, 'Martian yardang research: Mapping wind-eroded ridges and reconstructing long-term aeolian processes.'),
  ('TER-06-MARS', 2, 'Paleolake reconstruction: Interpreting ancient lakebeds, evaporites, and sedimentary sequences.'),
  ('TER-06-MARS', 3, 'Mineralogical analysis: Testing detection of sulfates, clays, chlorides, and hydrated minerals.'),
  ('TER-06-MARS', 4, 'Sedimentary sampling: Evaluating robotic collection of fine-grained and salt-rich materials.'),
  ('TER-06-MARS', 5, 'Astrobiology: Investigating microbial survival and potential biosignature preservation in evaporites.'),
  ('TER-06-MARS', 6, 'Rover navigation: Testing autonomous movement across yardang fields, crusted surfaces, and dunes.'),
  ('TER-06-MARS', 7, 'Subsurface stratigraphy: Evaluating instruments that detect layered sedimentary deposits.'),
  ('TER-07-MOON', 1, 'Basaltic rock identification and volcanic terrain mapping.'),
  ('TER-07-MOON', 2, 'Rover mobility testing across fractured and rocky surfaces.'),
  ('TER-07-MOON', 3, 'Geological sampling of basaltic volcanic materials.'),
  ('TER-07-MOON', 4, 'Fracture and fault recognition using remote-sensing data.'),
  ('TER-07-MOON', 5, 'Subsurface imaging and investigation of possible volcanic cavities.'),
  ('TER-07-MOON', 6, 'Evaluation of thermal instruments under high-temperature terrestrial conditions.'),
  ('TER-07-MOON', 7, 'Testing geological classification systems that distinguish volcanic materials from hydrothermal alteration products.'),
  ('TER-07-MARS', 1, 'Hydrothermal alteration: Investigating mineral formation and chemical changes caused by water–rock interactions.'),
  ('TER-07-MARS', 2, 'Martian volcanic geology: Studying basaltic volcanic rocks and tectonic structures.'),
  ('TER-07-MARS', 3, 'Evaporite mineralogy: Testing detection of sulfate-, chloride-, and potassium-bearing minerals.'),
  ('TER-07-MARS', 4, 'Astrobiological investigations: Studying the limits of habitability under combined environmental stresses.'),
  ('TER-07-MARS', 5, 'Biosignature interpretation: Distinguishing biological traces from abiotic mineral structures.'),
  ('TER-07-MARS', 6, 'Subsurface reconnaissance: Investigating fractures, geological layers, and possible volcanic cavities.'),
  ('TER-07-MARS', 7, 'Robotic exploration: Testing navigation and geological sampling in fractured volcanic terrain.'),
  ('TER-08-MOON', 1, 'Lunar highland mineral identification: Testing the recognition of plagioclase-rich anorthositic rocks.'),
  ('TER-08-MOON', 2, 'Spectroscopic calibration: Evaluating mineral detection methods using terrestrial anorthosite samples.'),
  ('TER-08-MOON', 3, 'Crustal differentiation research: Investigating magmatic processes that concentrate plagioclase-rich materials.'),
  ('TER-08-MOON', 4, 'Geological sampling: Testing robotic and manual sampling methods on anorthositic bedrock.'),
  ('TER-08-MOON', 5, 'Lunar resource studies: Characterizing aluminum-, calcium-, silicon-, and oxygen-bearing minerals.'),
  ('TER-08-MOON', 6, 'Highland rover navigation: Testing mobility on fractured rock surfaces and angular talus.'),
  ('TER-08-MOON', 7, 'Subsurface geological interpretation: Mapping layered igneous rocks and fractures.'),
  ('TER-08-MARS', 1, 'Igneous rock classification: Identifying mafic, ultramafic, and plagioclase-rich materials.'),
  ('TER-08-MARS', 2, 'Mineral spectroscopy: Testing instruments that distinguish feldspar, pyroxene, olivine, and associated minerals.'),
  ('TER-08-MARS', 3, 'Crustal differentiation research: Investigating the formation of layered igneous bodies.'),
  ('TER-08-MARS', 4, 'Robotic geological sampling: Testing sampling methods on exposed hard rock and angular fragments.'),
  ('TER-08-MARS', 5, 'Subsurface geological interpretation: Mapping fractures and layered intrusive structures.'),
  ('TER-08-MARS', 6, 'Terrain navigation: Evaluating robotic mobility across rocky slopes and fractured bedrock.'),
  ('TER-08-MARS', 7, 'Mineral-resource characterization: Investigating the detection of economically and scientifically relevant mineral assemblages.')
) as v (code, position, body)
join public.assessments a on a.code = v.code;

insert into public.reference_sources (kind, label, url) values
  ('terrestrial', 'NASA Earthdata', 'https://search.earthdata.nasa.gov/'),
  ('terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'),
  ('terrestrial', 'USGS', 'https://www.usgs.gov/'),
  ('terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'),
  ('lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'),
  ('lunar', 'PDS Geosciences', 'https://pds-geosciences.wustl.edu/'),
  ('lunar', 'Lunar Reconnaissance Orbiter Camera', 'https://wms.lroc.asu.edu/lroc'),
  ('martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'),
  ('martian', 'PDS Geosciences', 'https://pds-geosciences.wustl.edu/'),
  ('martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'),
  ('martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'),
  ('dataset', 'Mars Global Surveyor / MOLA.', null),
  ('dataset', 'Mars Reconnaissance Orbiter / HiRISE y CRISM.', null),
  ('dataset', 'Mars Odyssey / THEMIS.', null),
  ('dataset', 'Curiosity / REMS, SAM, CheMin y APXS.', null),
  ('dataset', 'Otros instrumentos y productos de exploración marciana incluidos en los repositorios científicos.', null),
  ('terrestrial', 'USGS Hawaiian Volcano Observatory', null),
  ('terrestrial', 'NASA Earthdata Search', null),
  ('terrestrial', 'NASA Worldview', null),
  ('terrestrial', 'NOAA National Centers for Environmental Information', null),
  ('lunar', 'NASA PDS Geosciences Node', null),
  ('lunar', 'NASA Moon Science', null),
  ('lunar', 'Lunar Reconnaissance Orbiter Camera', null),
  ('lunar', 'NASA Lunar Rocks', null),
  ('terrestrial', 'NOAA Environmental Data', null),
  ('terrestrial', 'Copernicus Data Space', null),
  ('martian', 'NASA Planetary Data System', null),
  ('martian', 'PDS Geosciences Node', null),
  ('martian', 'Mars Orbital Data Explorer', null),
  ('martian', 'USGS Astrogeology Science Center', null),
  ('terrestrial', 'Icelandic Meteorological Office', 'https://en.vedur.is/'),
  ('terrestrial', 'Iceland GeoSurvey (ÍSOR)', 'https://www.isor.is/'),
  ('terrestrial', 'National Land Survey of Iceland', 'https://www.lmi.is/'),
  ('terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'),
  ('lunar', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'),
  ('lunar', 'NASA Moon Science', 'https://science.nasa.gov/moon/'),
  ('lunar', 'LROC Data Portal', 'https://wms.lroc.asu.edu/lroc'),
  ('lunar', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'),
  ('terrestrial', 'University of Iceland Earth Sciences', 'https://earthice.hi.is/'),
  ('martian', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'),
  ('martian', 'NASA Mars Science', 'https://science.nasa.gov/mars/'),
  ('terrestrial', 'McMurdo Dry Valleys Long-Term Ecological Research', 'https://mcm.lternet.edu/'),
  ('terrestrial', 'United States Antarctic Program', 'https://www.usap.gov/'),
  ('terrestrial', 'Geological and Nuclear Sciences, New Zealand', 'https://www.gns.cri.nz/'),
  ('terrestrial', 'Natural Resources Canada', 'https://natural-resources.canada.ca/'),
  ('terrestrial', 'Geological Survey of Canada', 'https://natural-resources.canada.ca/'),
  ('terrestrial', 'Lunar and Planetary Institute', 'https://www.lpi.usra.edu/'),
  ('terrestrial', 'Earth Impact Database', 'http://www.passc.net/EarthImpactDatabase/'),
  ('terrestrial', 'Environment and Climate Change Canada', 'https://weather.gc.ca/'),
  ('terrestrial', 'NASA POWER', 'https://power.larc.nasa.gov/'),
  ('terrestrial', 'USGS EarthExplorer', 'https://earthexplorer.usgs.gov/'),
  ('terrestrial', 'USGS Publications', 'https://www.usgs.gov/'),
  ('terrestrial', 'USGS Publications Warehouse', 'https://pubs.usgs.gov/'),
  ('terrestrial', 'NOAA Climate Data', 'https://www.ncei.noaa.gov/'),
  ('terrestrial', 'USGS Water Resources', 'https://www.usgs.gov/'),
  ('lunar', 'NASA Lunar Rocks', 'https://science.nasa.gov/moon/lunar-rocks/'),
  ('lunar', 'NASA Lunar Regolith', 'https://science.nasa.gov/moon/lunar-regolith/'),
  ('lunar', 'NASA Moon Water and Ices', 'https://science.nasa.gov/moon/moon-water-and-ices/'),
  ('dataset', 'Lunar Orbiter Laser Altimeter (LOLA): lunar elevation, slopes, and topographic roughness.', null),
  ('dataset', 'Lunar Reconnaissance Orbiter Camera (LROC): lunar highland imagery, rocky surfaces, and geological features.', null),
  ('dataset', 'Moon Mineralogy Mapper (M³): mineralogical reflectance and plagioclase-related spectral studies.', null),
  ('dataset', 'Diviner Lunar Radiometer: lunar thermal observations and silicate mineralogical information.', null),
  ('dataset', 'Apollo lunar samples: laboratory comparisons of anorthositic highland materials.', null),
  ('dataset', 'Lunar Prospector Gamma Ray Spectrometer: regional elemental abundance maps. The terrestrial sources listed above are repository-level references. They do not independently verify every site-specific value supplied for Stillwater.', null),
  ('dataset', 'MOLA: Martian elevation and topographic data.', null),
  ('dataset', 'HiRISE and CTX: High-resolution terrain imagery and digital terrain models.', null),
  ('dataset', 'CRISM and OMEGA: Mineralogical observations.', null),
  ('dataset', 'THEMIS and TES: Surface thermal properties and mineralogical information.', null),
  ('dataset', 'APXS, CheMin, ChemCam, and PIXL: In-situ rock and elemental characterization.', null),
  ('dataset', 'SHARAD: Subsurface radar observations. The listed sources identify relevant scientific repositories. They do not independently verify all Stillwater site-specific measurements.', null)
on conflict (kind, label, coalesce(url, '')) do nothing;

insert into public.assessment_sources (assessment_id, source_id, position)
select a.id, rs.id, v.position
from (values
  ('TER-01-MOON', 'terrestrial', 'NASA Earthdata', 'https://search.earthdata.nasa.gov/'::text, 1),
  ('TER-01-MOON', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 2),
  ('TER-01-MOON', 'terrestrial', 'USGS', 'https://www.usgs.gov/'::text, 3),
  ('TER-01-MOON', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 4),
  ('TER-01-MOON', 'lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 5),
  ('TER-01-MOON', 'lunar', 'PDS Geosciences', 'https://pds-geosciences.wustl.edu/'::text, 6),
  ('TER-01-MOON', 'lunar', 'Lunar Reconnaissance Orbiter Camera', 'https://wms.lroc.asu.edu/lroc'::text, 7),
  ('TER-01-MARS', 'terrestrial', 'NASA Earthdata', 'https://search.earthdata.nasa.gov/'::text, 1),
  ('TER-01-MARS', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 2),
  ('TER-01-MARS', 'terrestrial', 'USGS', 'https://www.usgs.gov/'::text, 3),
  ('TER-01-MARS', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 4),
  ('TER-01-MARS', 'martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 5),
  ('TER-01-MARS', 'martian', 'PDS Geosciences', 'https://pds-geosciences.wustl.edu/'::text, 6),
  ('TER-01-MARS', 'martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'::text, 7),
  ('TER-01-MARS', 'martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 8),
  ('TER-01-MARS', 'dataset', 'Mars Global Surveyor / MOLA.', null::text, 9),
  ('TER-01-MARS', 'dataset', 'Mars Reconnaissance Orbiter / HiRISE y CRISM.', null::text, 10),
  ('TER-01-MARS', 'dataset', 'Mars Odyssey / THEMIS.', null::text, 11),
  ('TER-01-MARS', 'dataset', 'Curiosity / REMS, SAM, CheMin y APXS.', null::text, 12),
  ('TER-01-MARS', 'dataset', 'Otros instrumentos y productos de exploración marciana incluidos en los repositorios científicos.', null::text, 13),
  ('TER-02-MOON', 'terrestrial', 'USGS Hawaiian Volcano Observatory', null::text, 1),
  ('TER-02-MOON', 'terrestrial', 'NASA Earthdata Search', null::text, 2),
  ('TER-02-MOON', 'terrestrial', 'NASA Worldview', null::text, 3),
  ('TER-02-MOON', 'terrestrial', 'NOAA National Centers for Environmental Information', null::text, 4),
  ('TER-02-MOON', 'lunar', 'NASA PDS Geosciences Node', null::text, 5),
  ('TER-02-MOON', 'lunar', 'NASA Moon Science', null::text, 6),
  ('TER-02-MOON', 'lunar', 'Lunar Reconnaissance Orbiter Camera', null::text, 7),
  ('TER-02-MOON', 'lunar', 'NASA Lunar Rocks', null::text, 8),
  ('TER-02-MARS', 'terrestrial', 'USGS Hawaiian Volcano Observatory', null::text, 1),
  ('TER-02-MARS', 'terrestrial', 'NASA Earthdata Search', null::text, 2),
  ('TER-02-MARS', 'terrestrial', 'NOAA Environmental Data', null::text, 3),
  ('TER-02-MARS', 'terrestrial', 'Copernicus Data Space', null::text, 4),
  ('TER-02-MARS', 'martian', 'NASA Planetary Data System', null::text, 5),
  ('TER-02-MARS', 'martian', 'PDS Geosciences Node', null::text, 6),
  ('TER-02-MARS', 'martian', 'Mars Orbital Data Explorer', null::text, 7),
  ('TER-02-MARS', 'martian', 'USGS Astrogeology Science Center', null::text, 8),
  ('TER-03-MOON', 'terrestrial', 'Icelandic Meteorological Office', 'https://en.vedur.is/'::text, 1),
  ('TER-03-MOON', 'terrestrial', 'Iceland GeoSurvey (ÍSOR)', 'https://www.isor.is/'::text, 2),
  ('TER-03-MOON', 'terrestrial', 'National Land Survey of Iceland', 'https://www.lmi.is/'::text, 3),
  ('TER-03-MOON', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 4),
  ('TER-03-MOON', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 5),
  ('TER-03-MOON', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 6),
  ('TER-03-MOON', 'lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 7),
  ('TER-03-MOON', 'lunar', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 8),
  ('TER-03-MOON', 'lunar', 'NASA Moon Science', 'https://science.nasa.gov/moon/'::text, 9),
  ('TER-03-MOON', 'lunar', 'LROC Data Portal', 'https://wms.lroc.asu.edu/lroc'::text, 10),
  ('TER-03-MOON', 'lunar', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 11),
  ('TER-03-MARS', 'terrestrial', 'Icelandic Meteorological Office', 'https://en.vedur.is/'::text, 1),
  ('TER-03-MARS', 'terrestrial', 'Iceland GeoSurvey (ÍSOR)', 'https://www.isor.is/'::text, 2),
  ('TER-03-MARS', 'terrestrial', 'National Land Survey of Iceland', 'https://www.lmi.is/'::text, 3),
  ('TER-03-MARS', 'terrestrial', 'University of Iceland Earth Sciences', 'https://earthice.hi.is/'::text, 4),
  ('TER-03-MARS', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 5),
  ('TER-03-MARS', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 6),
  ('TER-03-MARS', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 7),
  ('TER-03-MARS', 'martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 8),
  ('TER-03-MARS', 'martian', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 9),
  ('TER-03-MARS', 'martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'::text, 10),
  ('TER-03-MARS', 'martian', 'NASA Mars Science', 'https://science.nasa.gov/mars/'::text, 11),
  ('TER-03-MARS', 'martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 12),
  ('TER-04-MOON', 'terrestrial', 'McMurdo Dry Valleys Long-Term Ecological Research', 'https://mcm.lternet.edu/'::text, 1),
  ('TER-04-MOON', 'terrestrial', 'United States Antarctic Program', 'https://www.usap.gov/'::text, 2),
  ('TER-04-MOON', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 3),
  ('TER-04-MOON', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 4),
  ('TER-04-MOON', 'terrestrial', 'USGS', 'https://www.usgs.gov/'::text, 5),
  ('TER-04-MOON', 'terrestrial', 'Geological and Nuclear Sciences, New Zealand', 'https://www.gns.cri.nz/'::text, 6),
  ('TER-04-MOON', 'lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 7),
  ('TER-04-MOON', 'lunar', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 8),
  ('TER-04-MOON', 'lunar', 'NASA Moon Science', 'https://science.nasa.gov/moon/'::text, 9),
  ('TER-04-MOON', 'lunar', 'LROC Data Portal', 'https://wms.lroc.asu.edu/lroc'::text, 10),
  ('TER-04-MOON', 'lunar', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 11),
  ('TER-04-MARS', 'terrestrial', 'McMurdo Dry Valleys Long-Term Ecological Research', 'https://mcm.lternet.edu/'::text, 1),
  ('TER-04-MARS', 'terrestrial', 'United States Antarctic Program', 'https://www.usap.gov/'::text, 2),
  ('TER-04-MARS', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 3),
  ('TER-04-MARS', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 4),
  ('TER-04-MARS', 'terrestrial', 'USGS', 'https://www.usgs.gov/'::text, 5),
  ('TER-04-MARS', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 6),
  ('TER-04-MARS', 'martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 7),
  ('TER-04-MARS', 'martian', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 8),
  ('TER-04-MARS', 'martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'::text, 9),
  ('TER-04-MARS', 'martian', 'NASA Mars Science', 'https://science.nasa.gov/mars/'::text, 10),
  ('TER-04-MARS', 'martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 11),
  ('TER-05-MOON', 'terrestrial', 'Natural Resources Canada', 'https://natural-resources.canada.ca/'::text, 1),
  ('TER-05-MOON', 'terrestrial', 'Geological Survey of Canada', 'https://natural-resources.canada.ca/'::text, 2),
  ('TER-05-MOON', 'terrestrial', 'Lunar and Planetary Institute', 'https://www.lpi.usra.edu/'::text, 3),
  ('TER-05-MOON', 'terrestrial', 'Earth Impact Database', 'http://www.passc.net/EarthImpactDatabase/'::text, 4),
  ('TER-05-MOON', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 5),
  ('TER-05-MOON', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 6),
  ('TER-05-MOON', 'lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 7),
  ('TER-05-MOON', 'lunar', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 8),
  ('TER-05-MOON', 'lunar', 'NASA Moon Science', 'https://science.nasa.gov/moon/'::text, 9),
  ('TER-05-MOON', 'lunar', 'LROC Data Portal', 'https://wms.lroc.asu.edu/lroc'::text, 10),
  ('TER-05-MOON', 'lunar', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 11),
  ('TER-05-MARS', 'terrestrial', 'Natural Resources Canada', 'https://natural-resources.canada.ca/'::text, 1),
  ('TER-05-MARS', 'terrestrial', 'Geological Survey of Canada', 'https://natural-resources.canada.ca/'::text, 2),
  ('TER-05-MARS', 'terrestrial', 'Lunar and Planetary Institute', 'https://www.lpi.usra.edu/'::text, 3),
  ('TER-05-MARS', 'terrestrial', 'Earth Impact Database', 'http://www.passc.net/EarthImpactDatabase/'::text, 4),
  ('TER-05-MARS', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 5),
  ('TER-05-MARS', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 6),
  ('TER-05-MARS', 'terrestrial', 'Environment and Climate Change Canada', 'https://weather.gc.ca/'::text, 7),
  ('TER-05-MARS', 'martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 8),
  ('TER-05-MARS', 'martian', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 9),
  ('TER-05-MARS', 'martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'::text, 10),
  ('TER-05-MARS', 'martian', 'NASA Mars Science', 'https://science.nasa.gov/mars/'::text, 11),
  ('TER-05-MARS', 'martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 12),
  ('TER-06-MOON', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 1),
  ('TER-06-MOON', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 2),
  ('TER-06-MOON', 'terrestrial', 'NASA POWER', 'https://power.larc.nasa.gov/'::text, 3),
  ('TER-06-MOON', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 4),
  ('TER-06-MOON', 'lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 5),
  ('TER-06-MOON', 'lunar', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 6),
  ('TER-06-MOON', 'lunar', 'NASA Moon Science', 'https://science.nasa.gov/moon/'::text, 7),
  ('TER-06-MOON', 'lunar', 'LROC Data Portal', 'https://wms.lroc.asu.edu/lroc'::text, 8),
  ('TER-06-MOON', 'lunar', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 9),
  ('TER-06-MARS', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 1),
  ('TER-06-MARS', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 2),
  ('TER-06-MARS', 'terrestrial', 'NASA POWER', 'https://power.larc.nasa.gov/'::text, 3),
  ('TER-06-MARS', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 4),
  ('TER-06-MARS', 'martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 5),
  ('TER-06-MARS', 'martian', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 6),
  ('TER-06-MARS', 'martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'::text, 7),
  ('TER-06-MARS', 'martian', 'NASA Mars Science', 'https://science.nasa.gov/mars/'::text, 8),
  ('TER-06-MARS', 'martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 9),
  ('TER-07-MOON', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 1),
  ('TER-07-MOON', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 2),
  ('TER-07-MOON', 'terrestrial', 'NASA POWER', 'https://power.larc.nasa.gov/'::text, 3),
  ('TER-07-MOON', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 4),
  ('TER-07-MOON', 'terrestrial', 'USGS EarthExplorer', 'https://earthexplorer.usgs.gov/'::text, 5),
  ('TER-07-MOON', 'lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 6),
  ('TER-07-MOON', 'lunar', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 7),
  ('TER-07-MOON', 'lunar', 'NASA Moon Science', 'https://science.nasa.gov/moon/'::text, 8),
  ('TER-07-MOON', 'lunar', 'LROC Data Portal', 'https://wms.lroc.asu.edu/lroc'::text, 9),
  ('TER-07-MOON', 'lunar', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 10),
  ('TER-07-MARS', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 1),
  ('TER-07-MARS', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 2),
  ('TER-07-MARS', 'terrestrial', 'NASA POWER', 'https://power.larc.nasa.gov/'::text, 3),
  ('TER-07-MARS', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 4),
  ('TER-07-MARS', 'terrestrial', 'USGS EarthExplorer', 'https://earthexplorer.usgs.gov/'::text, 5),
  ('TER-07-MARS', 'martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 6),
  ('TER-07-MARS', 'martian', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 7),
  ('TER-07-MARS', 'martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'::text, 8),
  ('TER-07-MARS', 'martian', 'NASA Mars Science', 'https://science.nasa.gov/mars/'::text, 9),
  ('TER-07-MARS', 'martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 10),
  ('TER-08-MOON', 'terrestrial', 'USGS Publications', 'https://www.usgs.gov/'::text, 1),
  ('TER-08-MOON', 'terrestrial', 'USGS Publications Warehouse', 'https://pubs.usgs.gov/'::text, 2),
  ('TER-08-MOON', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 3),
  ('TER-08-MOON', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 4),
  ('TER-08-MOON', 'terrestrial', 'NOAA Climate Data', 'https://www.ncei.noaa.gov/'::text, 5),
  ('TER-08-MOON', 'terrestrial', 'USGS Water Resources', 'https://www.usgs.gov/'::text, 6),
  ('TER-08-MOON', 'lunar', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 7),
  ('TER-08-MOON', 'lunar', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 8),
  ('TER-08-MOON', 'lunar', 'NASA Lunar Rocks', 'https://science.nasa.gov/moon/lunar-rocks/'::text, 9),
  ('TER-08-MOON', 'lunar', 'NASA Lunar Regolith', 'https://science.nasa.gov/moon/lunar-regolith/'::text, 10),
  ('TER-08-MOON', 'lunar', 'NASA Moon Water and Ices', 'https://science.nasa.gov/moon/moon-water-and-ices/'::text, 11),
  ('TER-08-MOON', 'lunar', 'LROC Data Portal', 'https://wms.lroc.asu.edu/lroc'::text, 12),
  ('TER-08-MOON', 'dataset', 'Lunar Orbiter Laser Altimeter (LOLA): lunar elevation, slopes, and topographic roughness.', null::text, 13),
  ('TER-08-MOON', 'dataset', 'Lunar Reconnaissance Orbiter Camera (LROC): lunar highland imagery, rocky surfaces, and geological features.', null::text, 14),
  ('TER-08-MOON', 'dataset', 'Moon Mineralogy Mapper (M³): mineralogical reflectance and plagioclase-related spectral studies.', null::text, 15),
  ('TER-08-MOON', 'dataset', 'Diviner Lunar Radiometer: lunar thermal observations and silicate mineralogical information.', null::text, 16),
  ('TER-08-MOON', 'dataset', 'Apollo lunar samples: laboratory comparisons of anorthositic highland materials.', null::text, 17),
  ('TER-08-MOON', 'dataset', 'Lunar Prospector Gamma Ray Spectrometer: regional elemental abundance maps. The terrestrial sources listed above are repository-level references. They do not independently verify every site-specific value supplied for Stillwater.', null::text, 18),
  ('TER-08-MARS', 'terrestrial', 'USGS Publications', 'https://www.usgs.gov/'::text, 1),
  ('TER-08-MARS', 'terrestrial', 'USGS Publications Warehouse', 'https://pubs.usgs.gov/'::text, 2),
  ('TER-08-MARS', 'terrestrial', 'NASA Earthdata Search', 'https://search.earthdata.nasa.gov/'::text, 3),
  ('TER-08-MARS', 'terrestrial', 'NASA Worldview', 'https://worldview.earthdata.nasa.gov/'::text, 4),
  ('TER-08-MARS', 'terrestrial', 'NOAA Climate Data', 'https://www.ncei.noaa.gov/'::text, 5),
  ('TER-08-MARS', 'terrestrial', 'Copernicus Data Space', 'https://dataspace.copernicus.eu/'::text, 6),
  ('TER-08-MARS', 'martian', 'NASA Planetary Data System', 'https://pds.nasa.gov/'::text, 7),
  ('TER-08-MARS', 'martian', 'PDS Geosciences Node', 'https://pds-geosciences.wustl.edu/'::text, 8),
  ('TER-08-MARS', 'martian', 'Mars Orbital Data Explorer', 'https://ode.rsl.wustl.edu/mars'::text, 9),
  ('TER-08-MARS', 'martian', 'NASA Mars Science', 'https://science.nasa.gov/mars/'::text, 10),
  ('TER-08-MARS', 'martian', 'USGS Astrogeology', 'https://www.usgs.gov/centers/astrogeology-science-center'::text, 11),
  ('TER-08-MARS', 'dataset', 'MOLA: Martian elevation and topographic data.', null::text, 12),
  ('TER-08-MARS', 'dataset', 'HiRISE and CTX: High-resolution terrain imagery and digital terrain models.', null::text, 13),
  ('TER-08-MARS', 'dataset', 'CRISM and OMEGA: Mineralogical observations.', null::text, 14),
  ('TER-08-MARS', 'dataset', 'THEMIS and TES: Surface thermal properties and mineralogical information.', null::text, 15),
  ('TER-08-MARS', 'dataset', 'APXS, CheMin, ChemCam, and PIXL: In-situ rock and elemental characterization.', null::text, 16),
  ('TER-08-MARS', 'dataset', 'SHARAD: Subsurface radar observations. The listed sources identify relevant scientific repositories. They do not independently verify all Stillwater site-specific measurements.', null::text, 17)
) as v (code, kind, label, url, position)
join public.assessments a on a.code = v.code
join public.reference_sources rs on rs.kind = v.kind and rs.label = v.label and coalesce(rs.url, '') = coalesce(v.url, '')
on conflict (assessment_id, source_id) do nothing;
