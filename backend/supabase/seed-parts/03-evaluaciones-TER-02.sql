insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
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

N/A variables must not be treated as zero-valued observations.', 'Hawaii’s shield volcanoes, basaltic lava flows, rocky terrain, and underground cavities resemble features found in Martian volcanic regions. Its volcanic environments also support selected astrobiological studies.', 'Martian rover navigation, volcanic geology research, mineralogical analysis, lava-tube exploration, subsurface reconnaissance, and astrobiological instrument testing.', 'Relevant missions and instruments: Mars Global Surveyor (MOLA, TES), Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS), Curiosity (APXS, CheMin, SAM, REMS), and Perseverance.')
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;
