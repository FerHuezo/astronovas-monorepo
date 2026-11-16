insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
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

Several terrestrial source entries refer to general research portals or academic search engines rather than specific publications. Those entries require replacement with traceable datasets or individual scientific references before the assessment can be considered reproducible.', 'The McMurdo Dry Valleys contain hyperarid soils, extensive permafrost, buried ice, salt-rich deposits, wind-eroded rocks, and cold-adapted microbial communities. These characteristics resemble selected present-day and ancient Martian polar, periglacial, and potentially habitable environments.', 'Martian ice detection, permafrost exploration, polar rover navigation, aeolian erosion studies, biosignature detection, and astrobiological instrument testing.', 'Relevant missions and instruments: Mars Global Surveyor (MOLA, TES), Mars Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD, MARCI, MCS), Mars Odyssey (THEMIS, GRS), Mars Express (OMEGA, MARSIS), Curiosity (CheMin, SAM, REMS), InSight, and Perseverance (MEDA, PIXL, SHERLOC). The references identify relevant scientific repositories and institutional resources. They do not establish that every individual dataset has been downloaded or analyzed.')
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;
