insert into public.assessments (code, site_id, body_id, language, overall_score, objective, characterization, conclusion,
  limitations, methodology, card_description, card_applications, sources_note, is_provisional, dataset_id)
select v.code, s.id, v.body_id, v.language, v.overall_score, v.objective, v.characterization, v.conclusion,
  v.limitations, v.methodology, v.card_description, v.card_applications, v.sources_note, true, d.id
from (values
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

The supplied terrestrial research includes several broad institutional references rather than specific publications. Crater age, wind speeds, permafrost depth, buried-ice distribution, and impact-deposit thickness should be verified against site-specific scientific studies before final publication.', 'Haughton Crater combines impact-generated geological structures with polar desert conditions, continuous permafrost, freeze–thaw processes, wind erosion, and limited seasonal liquid water. These characteristics provide useful analogs for selected Martian impact craters, cold desert terrains, ice-bearing subsurface deposits, and environments of astrobiological interest.', 'Martian impact-crater exploration, polar rover testing, subsurface ice investigation, geological mapping, impact-related hydrothermal research, and biosignature detection.', 'Reconnaissance Orbiter (HiRISE, CTX, CRISM, SHARAD), Mars Odyssey (THEMIS and neutron spectroscopy), Curiosity, Phoenix, and Perseverance. These references identify relevant institutions, missions, and data repositories. They do not establish that each individual dataset was downloaded or independently analyzed.')
) as v (slug, code, body_id, language, overall_score, objective, characterization, conclusion, limitations, methodology,
  card_description, card_applications, sources_note)
join public.sites s on s.slug = v.slug
join public.datasets d on d.slug = 'team-assessments-v1'
on conflict (code) do update set language = excluded.language, overall_score = excluded.overall_score,
  objective = excluded.objective, characterization = excluded.characterization, conclusion = excluded.conclusion,
  limitations = excluded.limitations, methodology = excluded.methodology, card_description = excluded.card_description,
  card_applications = excluded.card_applications, sources_note = excluded.sources_note, dataset_id = excluded.dataset_id;
