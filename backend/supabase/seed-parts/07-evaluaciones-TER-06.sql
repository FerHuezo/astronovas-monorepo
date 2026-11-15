insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
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

A validated quantitative assessment would require site-specific data, comparable spatial resolutions, normalized variables, traceable scientific publications, and a reproducible weighting algorithm.', 'The Qaidam Basin offers strong process-level comparisons with selected Martian landscapes through its extensive yardang fields, evaporite deposits, ancient lakebeds, fine-grained sediments, and extreme aridity. Its saline environments are also useful for testing techniques that investigate possible biosignature preservation in ancient Martian sedimentary deposits.', 'Martian yardang mapping, aeolian erosion studies, evaporite and sulfate detection, paleolake reconstruction, sedimentary sampling, biosignature preservation research, and rover mobility testing.', 'Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS), Mars Express (OMEGA), Curiosity, and Perseverance. Relevant research topics: Martian yardangs, chloride-bearing deposits, sulfate mineralogy, paleolake sediments, and organic preservation in evaporites. The source list identifies repositories and relevant datasets but does not establish that the Qaidam values have been independently verified against specific peer-reviewed publications.')
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;
