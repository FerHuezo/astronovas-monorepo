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

La validación posterior requerirá delimitar regiones de referencia, obtener mediciones comparables y documentar una fórmula de cálculo reproducible.', null, null, null)
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;
