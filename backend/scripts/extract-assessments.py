#!/usr/bin/env python3
"""Extrae las fichas de los análogos terrestres (PDF) a backend/data/analog-assessments.json.

    python backend/scripts/extract-assessments.py [carpeta_con_pdfs]

Requiere `pdftotext` (poppler) en el PATH. Es una importación de una sola vez: el JSON resultante es la
fuente de verdad que lee `generate-assessments-seed.mjs`; los PDFs no se versionan.

El script es estricto a propósito: si una variable no está en ALIASES, si falta una categoría o si la
clasificación publicada no coincide con la escala, falla en lugar de adivinar.
"""

import glob
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import unicodedata

PDF_DIR = sys.argv[1] if len(sys.argv) > 1 else os.path.expanduser("~/Downloads")
OUT = os.path.join(os.path.dirname(__file__), "..", "data", "analog-assessments.json")

# --------------------------------------------------------------------------- catálogo y alias
CATEGORIES = ["topography", "thermal", "geology", "water", "atmosphere", "subsurface", "biology"]


def norm(s: str) -> str:
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode().lower()
    return re.sub(r"\s+", " ", s).strip()


# (índice de categoría 1-7) -> variable canónica -> nombres tal como aparecen publicados (EN y ES).
# Una misma etiqueta puede significar cosas distintas según la categoría (p. ej. «Atmospheric pressure»
# en 2 = clima, en 5 = atmósfera de Marte), por eso el alias depende de la categoría.
ALIASES = {
    1: {
        "elevation": ["Elevation", "Elevación"],
        "slope": ["Slope", "Pendiente"],
        "roughness": ["Surface roughness", "Rugosidad"],
        "relief": ["Relief", "Relieve"],
        "craters": ["Craters", "Impact craters", "Cráteres"],
        "obstacles": ["Surface obstacles", "Obstáculos superficiales"],
    },
    2: {
        "surface_temperature": ["Surface temperature", "Temperatura superficial"],
        "temperature_extremes": ["Maximum and minimum temperatures", "Temperaturas máximas y mínimas"],
        "thermal_variation": ["Thermal variation", "Variación térmica"],
        "seasonality": ["Seasonality"],
        "solar_illumination": ["Solar illumination", "Iluminación solar", "Insolación y radiación UV"],
        "atmospheric_conditions": [
            "Atmospheric conditions / exosphere",
            "Atmospheric conditions / vacuum",
            "Atmospheric pressure",
            "Presión atmosférica y vacío",
            "Presión atmosférica",
        ],
        "atmospheric_dryness": ["Atmospheric dryness"],
    },
    3: {
        "rock_type": ["Rock type", "Tipo de roca"],
        "mineral_composition": ["Mineralogical composition", "Composición mineralógica"],
        "chemical_composition": ["Chemical composition", "Composición química", "Química de percloratos y sulfatos"],
        "surface_material": ["Surface material", "Material superficial"],
        "alteration": ["Geological alteration", "Alteración geológica", "Meteorización química hiperárida"],
        "formations": ["Geological formations", "Formaciones geológicas", "Abanicos aluviales y paleolagos"],
    },
    4: {
        "surface_water": ["Surface water", "Agua superficial", "Sequedad y ausencia de agua libre"],
        "surface_ice": ["Surface ice", "Surface or polar ice", "Hielo superficial"],
        "subsurface_ice": ["Subsurface ice", "Subsurface ice and permafrost", "Hielo subterráneo"],
        "permafrost": ["Permafrost"],
        "hydrogen": ["Hydrogen-bearing materials", "Hydrogen", "Hidrógeno", "Hidrógeno equivalente"],
        "mineral_resources": ["Mineral resources", "Minerals and resources", "Recursos minerales", "Recursos de sales y salmueras"],
        "past_water": ["Evidence of past water", "Minerales hidratados y arcillas"],
    },
    5: {
        "atmospheric_pressure": ["Atmospheric pressure"],
        "atmospheric_composition": ["Atmospheric composition"],
        "wind": ["Wind", "Viento", "Régimen eólico y vientos"],
        "dust": ["Abrasive dust", "Dust", "Polvo abrasivo", "Partículas de polvo en suspensión"],
        "dust_storms": ["Dust storms", "Tormentas de polvo locales"],
        "aeolian_erosion": ["Aeolian erosion", "Aeolian erosion and sediments", "Aeolian erosion and yardangs", "Erosión eólica"],
        "sediments": ["Sediments and granular deposits", "Sediments", "Sedimentos y dunas", "Dunas y sedimentos"],
        "aerosols": ["Aerosols", "Volcanic aerosols"],
    },
    6: {
        "caves": ["Caves", "Caves and cavities", "Cuevas y tubos de lava", "Cavidades y tubos"],
        "lava_tubes": ["Lava tubes"],
        "fractures": ["Cavities and fractures", "Fractures and faults", "Fractures and desiccation cracks", "Fracturas tectónicas"],
        "subsurface_structure": ["Subsurface structure", "Estructura estratigráfica", "Estratigrafía sedimentaria"],
        "material_thickness": ["Material thickness", "Espesor de regolito"],
    },
    7: {
        "extremophiles": ["Extremophile organisms", "Microorganismos extremófilos terrestres como modelo"],
        "habitability": ["Habitability conditions", "Límites de habitabilidad"],
        "biosignatures": ["Biosignatures", "Potential biosignatures", "Preservación de biofirmas en sales"],
        "adaptations": ["Biological adaptations"],
        "direct_similarity": ["Direct biological similarity", "Similitud biológica directa"],
    },
}
LOOKUP = {c: {norm(a): key for key, names in m.items() for a in names} for c, m in ALIASES.items()}

CLASS_WORDS = {
    "very high": "very_high", "high": "high", "moderate": "moderate", "low": "low", "very low": "very_low",
    "not applicable": "not_applicable", "muy alta": "very_high", "alta": "high", "moderada": "moderate",
    "baja": "low", "muy baja": "very_low", "no aplicable": "not_applicable",
}


def classify(score):
    if score is None:
        return "not_applicable"
    for floor, name in ((90, "very_high"), (75, "high"), (50, "moderate"), (25, "low")):
        if score >= floor:
            return name
    return "very_low"


# --------------------------------------------------------------------------- metadatos del sitio
# Datos de ficha transcritos de los PDF (coordenadas y rangos de elevación). El texto largo se extrae solo.
SITES = {
    "TER-01": dict(slug="atacama", name="Desierto de Atacama", country="Chile", region="Antofagasta, Tarapacá y Atacama",
        lat=-23.8633, lng=-69.1700, elevation_text="Aproximadamente entre 2,000 y 4,500 m; edificios volcánicos sobre 5,500 m",
        elevation_min_m=2000, elevation_max_m=4500, analog_class="Desierto hiperárido, salino-evaporítico y volcánico",
        geological_setting=None, language="es",
        coordinate_note="Las coordenadas representan aproximadamente la región y no un punto específico de muestreo.",
        locations=[]),
    "TER-02": dict(slug="hawaii", name="Complejo volcánico de Hawái", country="Estados Unidos",
        region="Mauna Kea y Kīlauea · isla de Hawaiʻi", lat=19.62, lng=-155.38,
        elevation_text="Hasta 4,207 m", elevation_min_m=None, elevation_max_m=4207, analog_class="Volcánico / basáltico",
        geological_setting=None, language="en",
        coordinate_note="Coordenada del sitio = punto medio entre Mauna Kea y Kīlauea; ver ubicaciones de referencia.",
        locations=[dict(label="Mauna Kea", lat=19.82, lng=-155.47, elevation_m=4207, note="Cumbre de escudo volcánico; condiciones frías, cenizas y conos de escoria."),
                   dict(label="Kīlauea", lat=19.42, lng=-155.29, elevation_m=None, note="Campos de lava basáltica jóvenes, cráteres, fracturas y tubos de lava.")]),
    "TER-03": dict(slug="islandia", name="Islandia", country="Islandia", region="República de Islandia · Atlántico Norte",
        lat=64.96, lng=-19.02, elevation_text="0–2,110 m", elevation_min_m=0, elevation_max_m=2110,
        analog_class="Volcánico / glacial / periglacial", geological_setting=None, language="en", coordinate_note=None, locations=[]),
    "TER-04": dict(slug="mcmurdo", name="Valles secos de McMurdo", country="Antártida",
        region="Tierra de Victoria · Dependencia de Ross · Antártida", lat=-77.5, lng=162.5,
        elevation_text="0 a más de 2,000 m", elevation_min_m=0, elevation_max_m=2000,
        analog_class="Desierto polar / hiperárido / periglacial", geological_setting=None, language="en", coordinate_note=None, locations=[]),
    "TER-05": dict(slug="haughton", name="Cráter Haughton", country="Canadá",
        region="Isla Devon · Nunavut · Canadá", lat=75.38, lng=-89.67, elevation_text="200–400 m; diámetro del cráter ~23 km",
        elevation_min_m=200, elevation_max_m=400, analog_class="Cráter de impacto polar", geological_setting=None,
        language="en", coordinate_note=None, locations=[]),
    "TER-06": dict(slug="qaidam", name="Cuenca de Qaidam", country="China", region="Provincia de Qinghai · China",
        lat=37.5, lng=95.0, elevation_text="~2,600–3,200 m (fondo de la cuenca)", elevation_min_m=2600, elevation_max_m=3200,
        analog_class="Cuenca hiperárida", geological_setting="Gran cuenca intermontana", language="en", coordinate_note=None, locations=[]),
    "TER-07": dict(slug="danakil", name="Depresión de Danakil / Dallol", country="Etiopía", region="Región de Afar · Etiopía",
        lat=14.24, lng=40.30, elevation_text="Hasta −120 m", elevation_min_m=-120, elevation_max_m=None,
        analog_class="Análogo hidrotermal-volcánico", geological_setting="Rift de Afar activo", language="en",
        coordinate_note="Dallol (hidrotermal) y Erta Ale (volcanismo basáltico) son subregiones distintas y deben evaluarse por separado.",
        locations=[]),
    "TER-08": dict(slug="stillwater", name="Complejo de Anortosita de Stillwater", country="Estados Unidos",
        region="Complejo ígneo de Stillwater · Montana", lat=45.40, lng=-109.90, elevation_text="1,500–3,000 m",
        elevation_min_m=1500, elevation_max_m=3000, analog_class="Análogo mineralógico", geological_setting="Intrusión máfica estratificada",
        language="en", coordinate_note=None, locations=[]),
}

# --------------------------------------------------------------------------- utilidades de texto


def run_pdftotext(path: str, *flags: str) -> str:
    # pdftotext en Windows no abre rutas con caracteres fuera de ANSI (p. ej. «ī»): se lee una copia con nombre ASCII.
    with tempfile.TemporaryDirectory() as tmp:
        copy = os.path.join(tmp, "in.pdf")
        shutil.copyfile(path, copy)
        out = subprocess.run(["pdftotext", "-enc", "UTF-8", *flags, copy, "-"], capture_output=True, check=True)
    return out.stdout.decode("utf-8", "ignore")


def pdftotext(path: str) -> str:
    # ​ (espacio de ancho cero) aparece tras los números de las listas en los PDF.
    return run_pdftotext(path, "-layout").replace("\f", "\n").replace("​", "").replace("\r", "")


def paragraphs(lines):
    """Une las líneas ajustadas por el PDF en párrafos separados por línea en blanco."""
    paras, cur = [], []
    for ln in lines:
        s = ln.strip()
        if s:
            cur.append(s)
        elif cur:
            paras.append(" ".join(cur))
            cur = []
    if cur:
        paras.append(" ".join(cur))
    return paras


def text_of(lines):
    return "\n\n".join(paragraphs(lines)) or None


def num(s):
    return None if s is None or s.upper().startswith("N/A") else float(s)


# --------------------------------------------------------------------------- cabecera de la ficha
HEAD_LABELS = {
    "terrain_classification": ["terrain classification", "main characteristics", "caracteristicas principales:"],
    "description": ["environmental and geological description", "general scientific description", "general description",
                    "descripcion general:"],
    "scientific_relevance": ["primary scientific relevance", "primary scientific applications"],
}
OTHER_LABELS = ["lunar assessment", "martian assessment", "lunar assessment id", "martian assessment id", "geological setting",
                "representative latitude", "representative longitude", "approximate elevation", "elevation range",
                "maximum elevation", "geographic reference points", "environment", "terrain type", "crater diameter",
                "basin-floor elevation", "geographic extent", "identificadores del sistema:", "nota geografica:"]


def parse_header(txt: str):
    head = re.split(r"^\s*PART II\b|^\s*PART III\b|^\*\*Visualizaci", txt, maxsplit=1, flags=re.M)[0]
    fields, cur = {}, None
    for ln in head.split("\n"):
        key = norm(ln)
        found = next((f for f, labs in HEAD_LABELS.items() if key in labs), None)
        if found:
            cur = found
            fields.setdefault(found, [])
        elif key in OTHER_LABELS or re.match(r"^ter-0\d\b", key) or key.startswith("nota geografica"):
            cur = None
        elif cur:
            fields[cur].append(ln)
    out = {}
    for k, v in fields.items():
        # Las listas con viñetas (Atacama, "Main characteristics") se unen con «; ».
        if any(l.strip().startswith(("●", "•")) for l in v):
            out[k] = "; ".join(re.sub(r"^[●•]\s*", "", l.strip()).rstrip(".") for l in v if l.strip()) + "."
        else:
            out[k] = text_of(v)
    return out


def parse_cards(txt: str):
    """Tarjetas generales de la Parte II (descripción + aplicaciones). El cuerpo se decide por contenido,
    porque la etiqueta MARS/MOON del PDF a veces queda pegada a la tarjeta equivocada."""
    m = re.search(r"^\s*PART II\b.*?(?=^\s*PART (?:III|IV)\b)", txt, flags=re.M | re.S)
    if not m:
        return {}
    body = m.group(0).split("\n", 1)[1]
    chunks = re.split(r"^\s*Description(?: of Similarities)?\s*$", body, flags=re.M)[1:]
    cards = {}
    for ch in chunks:
        parts = re.split(r"^\s*Main Scientific Applications\s*$", ch, maxsplit=1, flags=re.M)
        desc, apps = (parts[0], parts[1]) if len(parts) == 2 else (ch, "")
        strip = lambda t: [l for l in t.split("\n") if l.strip().upper() not in ("MARS", "MOON", "LUNAR", "MARTIAN")]
        d, a = text_of(strip(desc)), text_of(strip(apps))
        mars = len(re.findall(r"\bmars\b|martian", (d or "") + (a or ""), flags=re.I))
        moon = len(re.findall(r"\blunar\b|\bmoon\b", (d or "") + (a or ""), flags=re.I))
        body_id = "mars" if mars > moon else "moon"
        assert body_id not in cards, f"tarjeta duplicada para {body_id}"
        cards[body_id] = dict(description=d, applications=a)
    return cards


# --------------------------------------------------------------------------- informe por cuerpo
LABEL_COMPARE = re.compile(r"^(General scientific comparison|General comparison|General description|Descripción general)\s*:\s*", re.I)
LABEL_UTILITY = re.compile(r"^(General scientific utility|Utilidad general|Scientific utility|Utilidad científica)\s*:\s*", re.I)
LABEL_EXPL = re.compile(r"^(Explanation|Explicación)\s*:\s*", re.I)
VAR_LINE = re.compile(r"^(?P<name>[^\n—–]{3,90}?)\s+[—–]\s+(?P<score>N/A|\d+(?:\.\d+)?)\s?%?\s*\.?\s*(?P<rest>.*)$")
CAT_LINE = re.compile(r"^4\.(?P<i>\d)\.?\s+(?P<name>.+?)\s+[—–]\s+(?P<score>N/A|\d+(?:\.\d+)?)\s?%?\s*$")
OVERALL = re.compile(
    r"(?:Estimated Overall Similarity|Overall provisional similarity|Overall Estimated Similarity|Similitud general estimada)"
    r"\s*:?\s*(?P<s>\d+(?:\.\d+)?)\s?%", re.I)


def split_labeled(lines, label_re):
    """Divide un bloque de líneas en (antes, después) de la primera línea que empieza con `label_re`."""
    for i, ln in enumerate(lines):
        if label_re.match(ln.strip()):
            first = label_re.sub("", ln.strip(), count=1)
            return lines[:i], [first] + lines[i + 1:]
    return lines, None


def parse_sections(txt):
    """Secciones 1..9 del informe (encabezados en columna 0, para no confundirlos con listas numeradas)."""
    pos, last = {}, 0
    for n in range(1, 10):
        m = re.compile(rf"^{n}\.\s+(\S.*)$", re.M).search(txt, last)
        if m:
            pos[n] = (m.start(), m.end(), m.group(1).strip())
            last = m.end()
    sec = {}
    order = sorted(pos)
    for k, n in enumerate(order):
        end = pos[order[k + 1]][0] if k + 1 < len(order) else len(txt)
        sec[n] = txt[pos[n][1]:end]
    return sec


def parse_categories(sec4: str, code: str):
    lines = sec4.split("\n")
    heads = [(i, CAT_LINE.match(l.strip())) for i, l in enumerate(lines)]
    heads = [(i, m) for i, m in heads if m]
    cats = []
    for k, (i, m) in enumerate(heads):
        end = heads[k + 1][0] if k + 1 < len(heads) else len(lines)
        idx = int(m.group("i"))
        block = lines[i + 1:end]
        cat = dict(index=idx, category=CATEGORIES[idx - 1], label_reported=m.group("name").strip(),
                   score=num(m.group("score")), variables=[])

        # variables: solo cuentan las líneas cuyo nombre está en ALIASES de esta categoría
        starts = []
        for j, ln in enumerate(block):
            vm = VAR_LINE.match(ln.strip())
            if vm and norm(vm.group("name")) in LOOKUP[idx]:
                starts.append((j, vm))
            elif vm and not ln.startswith((" ", "\t")) and re.search(r"\d\s?%\s*\.?\s*[A-ZÁÉÍÓÚ]", ln):
                raise SystemExit(f"{code} 4.{idx}: variable sin alias → {vm.group('name')!r}")
        pre = block[: starts[0][0]] if starts else block
        compare, util = split_labeled(pre, LABEL_UTILITY)
        compare, _ = split_labeled(compare, LABEL_COMPARE) if compare else (compare, None)
        # quita la etiqueta de la comparación
        cmp_lines = list(compare)
        if cmp_lines:
            cmp_lines[0] = LABEL_COMPARE.sub("", cmp_lines[0].strip())
        cat["comparison"] = text_of(cmp_lines)
        cat["utility"] = text_of(util) if util else None

        for s, (j, vm) in enumerate(starts):
            vend = starts[s + 1][0] if s + 1 < len(starts) else len(block)
            body = [vm.group("rest")] + block[j + 1:vend]
            expl, util_lines = split_labeled(body, LABEL_UTILITY)
            expl = [LABEL_EXPL.sub("", l.strip()) if n == 0 or LABEL_EXPL.match(l.strip()) else l for n, l in enumerate(expl)]
            note = None
            if util_lines:
                paras = paragraphs(util_lines)
                util_txt, extra = (paras[0], paras[1:]) if paras else (None, [])
                if extra and s + 1 == len(starts):
                    note = "\n\n".join(extra)
            else:
                util_txt = None
            key = LOOKUP[idx][norm(vm.group("name"))]
            cat["variables"].append(dict(key=key, label=vm.group("name").strip(), score=num(vm.group("score")),
                                         explanation=text_of(expl), utility=util_txt))
            if note:
                cat["note"] = note
        keys = [v["key"] for v in cat["variables"]]
        assert len(keys) == len(set(keys)), f"{code} 4.{idx}: variable repetida {keys}"
        cats.append(cat)
    return cats


def parse_applications(sec):
    items = []
    for ln in sec.split("\n"):
        m = re.match(r"^\s*(?:\d+\.|[●•\-])\s+(\S.*)$", ln)
        if m:
            items.append(m.group(1).strip())
        elif items and ln.strip() and ln.startswith(("      ", "\t")):
            items[-1] += " " + ln.strip()
    return items


def parse_sources(sec):
    """Fuentes por tipo (terrestre/lunar/marciana). Algunos PDF listan solo el nombre, sin URL."""
    sources, kind, note = [], None, []
    for ln in sec.split("\n"):
        s = ln.strip()
        k = norm(s)
        is_header = bool(s) and len(s) < 70 and not s.startswith(("●", "•")) and not s.endswith(".")
        if is_header and re.match(r"^(terrestrial|fuentes terrestres)", k):
            kind = "terrestrial"
        elif is_header and re.match(r"^(lunar|fuentes lunares)", k):
            kind = "lunar"
        elif is_header and re.match(r"^(martian|mars\b|fuentes marcianas)", k):
            kind = "martian"
        elif is_header and re.match(r"^(relevant (datasets|missions)|misiones e instrumentos)", k):
            kind = "dataset"  # instrumentos y misiones de referencia: nombre + descripción, sin URL
        elif s.startswith(("●", "•")):
            m = re.match(r"^[●•]\s*(?:(.+?):\s*)?(https?://\S+)\s*$", s)
            if m and kind:
                sources.append(dict(kind=kind, label=(m.group(1) or m.group(2)).strip(), url=m.group(2)))
            elif kind:
                sources.append(dict(kind=kind, label=s.lstrip("●• ").strip(), url=None))
        elif s and kind == "dataset" and sources and sources[-1]["kind"] == "dataset":
            sources[-1]["label"] += " " + s  # continuación de una viñeta ajustada por el PDF
        elif s:
            note.append(ln)
    return sources, text_of(note)


def parse_report(txt: str, code: str, lang: str):
    sec = parse_sections(txt)
    om = OVERALL.search(txt)
    overall = float(om.group("s")) if om else None
    cm = re.search(r"Classification\s*:\s*(.+)|Clasificación\s*:\s*(.+)", txt)
    published = None
    if cm:
        published = CLASS_WORDS.get(norm((cm.group(1) or cm.group(2)).strip().rstrip(".")))
    if published is None:
        pm = re.search(r"Overall provisional similarity:.*?[—–]\s*([A-Za-z ]+)\.", txt)
        published = CLASS_WORDS.get(norm(pm.group(1))) if pm else None
    assert overall is not None and published, f"{code}: sin similitud general o clasificación"
    assert classify(overall) == published, f"{code}: {overall} no es {published} según la escala"

    cats = parse_categories(sec[4], code)
    assert [c["index"] for c in cats] == list(range(1, 8)), f"{code}: categorías {[c['index'] for c in cats]}"
    for c in cats:
        if c["score"] is not None:
            assert 0 <= c["score"] <= 100
    apps = parse_applications(sec.get(5, ""))
    if not apps and sec.get(5, "").strip():
        # Algunos informes (p. ej. Hawái, Luna) dan las aplicaciones como un párrafo, no como lista.
        apps = [text_of(sec[5].split("\n"))]
    sources, sources_note = parse_sources(sec.get(8, ""))
    return dict(
        overall_score=overall, published_classification=published,
        objective=text_of(sec.get(1, "").split("\n")), characterization=text_of(sec.get(2, "").split("\n")),
        conclusion=text_of(sec.get(7, "").split("\n")), limitations=text_of(sec.get(6, "").split("\n")),
        methodology=text_of(sec.get(9, "").split("\n")), applications=apps, sources=sources, sources_note=sources_note,
        categories=cats,
    )


def split_reports(txt: str, code: str):
    ms = list(re.finditer(rf"^TER-0\d-(MOON|MARS)\s+[—·]\s+\S|^(?:INFORME CIENTÍFICO.*\n.*\n\s*\n)?Identificador:\s*{code}-(MOON|MARS)",
                          txt, flags=re.M))
    marks = []
    for m in ms:
        body = (m.group(1) or m.group(2)).lower()
        if body not in [b for b, _ in marks]:
            marks.append((body, m.start()))
    assert [b for b, _ in marks] == ["moon", "mars"], f"{code}: informes {marks}"
    return {"moon": txt[marks[0][1]:marks[1][1]], "mars": txt[marks[1][1]:]}


# --------------------------------------------------------------------------- main
def main():
    files = {}
    for p in glob.glob(os.path.join(PDF_DIR, "*.pdf")):
        head = run_pdftotext(p, "-l", "1")
        # El código del sitio (TER-0N) aparece al inicio de la ficha; otros PDFs de Descargas no lo traen.
        m = re.search(r"\b(TER-0\d)\b", head[:800])
        if m and m.group(1) in SITES:
            files[m.group(1)] = p
    missing = sorted(set(SITES) - set(files))
    assert not missing, f"faltan PDF para {missing} en {PDF_DIR}"

    sites = []
    for code in sorted(SITES):
        meta = dict(SITES[code])
        txt = pdftotext(files[code])
        header = parse_header(txt)
        cards = parse_cards(txt)
        reports = split_reports(txt, code)
        assessments = []
        for body in ("moon", "mars"):
            r = parse_report(reports[body], code, meta["language"])
            r.update(code=f"{code}-{body.upper()}", body=body, language=meta["language"],
                     card=cards.get(body) or dict(description=None, applications=None))
            assessments.append(r)
        sites.append(dict(code=code, **meta, **header, source_file=os.path.basename(files[code]), assessments=assessments))

    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(dict(version=1, sites=sites), f, ensure_ascii=False, indent=2)
        f.write("\n")

    # Resumen para revisión humana
    print(f"{'sitio':<12}{'cuerpo':<6}{'global':>7}  clase       categorías (puntaje / n.º variables)")
    for s in sites:
        for a in s["assessments"]:
            cats = " ".join(f"{c['score'] if c['score'] is not None else 'NA'}/{len(c['variables'])}" for c in a["categories"])
            print(f"{s['slug']:<12}{a['body']:<6}{a['overall_score']:>7}  {a['published_classification']:<11} {cats}"
                  f"  apps={len(a['applications'])} src={len(a['sources'])}")
    print("OK →", os.path.relpath(OUT))


if __name__ == "__main__":
    main()
