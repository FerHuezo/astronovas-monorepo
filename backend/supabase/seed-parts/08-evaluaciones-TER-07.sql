insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
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

Special attention should be given to distinguishing Dallol hydrothermal measurements from observations made elsewhere in the Danakil Depression.', 'Danakil combines basaltic volcanism, hydrothermal alteration, evaporite minerals, acidic brines, and tectonic fractures that provide useful analogs for selected Martian volcanic and ancient water-altered environments.', 'Martian mineral identification, hydrothermal alteration studies, astrobiological investigations, biosignature preservation research, geological mapping, and subsurface reconnaissance.', 'Relevant missions and instruments: Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS), Mars Express (OMEGA), Curiosity, and Perseverance. Relevant research topics: Martian sulfate deposits, hydrothermal alteration, basaltic volcanism, subsurface structures, and astrobiological habitability. The references identify relevant scientific resources but do not establish independent verification of all site-specific terrestrial claims.')
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;
