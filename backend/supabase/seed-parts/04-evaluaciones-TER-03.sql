insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
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

A reproducible quantitative assessment would require defined Icelandic study areas, corresponding Martian regions, comparable physical measurements, consistent spatial scales, documented normalization, and explicit weighting of variables and categories.', 'Iceland’s basaltic volcanism, glacial landscapes, cold highlands, black volcanic sediments, and geothermal systems resemble selected geological and environmental features of Mars. Its subglacial volcanic deposits and microbial communities also support studies of ancient Martian water-related processes and habitability.', 'Martian rover navigation, volcanic and glacial geology, ice-related terrain studies, dust transport research, lava-tube exploration, and astrobiological instrument testing.', 'Relevant missions and instruments: Mars Global Surveyor (MOLA, TES), Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD, MARCI, MCS), Mars Odyssey (THEMIS, GRS), Mars Express (OMEGA, MARSIS), Curiosity (CheMin, SAM, REMS), InSight, and Perseverance (MEDA, PIXL, SHERLOC). These sources identify relevant scientific repositories, missions, and institutional resources. Individual datasets should be linked directly when incorporated into the quantitative analysis.')
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;
