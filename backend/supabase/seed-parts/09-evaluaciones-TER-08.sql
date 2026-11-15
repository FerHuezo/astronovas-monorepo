insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
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
