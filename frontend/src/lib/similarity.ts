import type { Analog, Body, FeatureKey, Profile, RefSite, Weights } from "./types";

/** Catálogo de variables comparables. Agregar una variable nueva empieza aquí (y en `FeatureKey`). */
export interface FeatureDef {
  key: FeatureKey;
  label: string;
  /** Origen del dato: `live` = viene de NASA POWER; el resto es ilustrativo hasta migrar los datos nuevos */
  source: string;
  live: boolean;
  /** Etiquetas de los extremos 0 y 1 del control */
  low: string;
  high: string;
  /** Traduce el valor normalizado (0-1) a una magnitud legible */
  format: (v: number) => string;
}

const level = (v: number) => (v < 0.34 ? "baja" : v < 0.67 ? "media" : "alta");

export const FEATURES: FeatureDef[] = [
  {
    key: "aridity",
    label: "Aridez",
    source: "NASA POWER · lluvia",
    live: true,
    low: "Húmedo",
    high: "Hiperárido",
    format: (v) => `≈ ${Math.round((1 - v) * 900)} mm/año`,
  },
  {
    key: "cold",
    label: "Frío",
    source: "NASA POWER · temperatura",
    live: true,
    low: "Cálido",
    high: "Glacial",
    format: (v) => `≈ ${Math.round(20 - v * 45)} °C`,
  },
  {
    key: "radiation",
    label: "Radiación UV",
    source: "NASA POWER · UV",
    live: true,
    low: "Baja",
    high: "Intensa",
    format: (v) => `UV ≈ ${(v * 3).toFixed(1)}`,
  },
  {
    key: "roughness",
    label: "Rugosidad",
    source: "Ilustrativo",
    live: false,
    low: "Llano",
    high: "Escarpado",
    format: (v) => `Rugosidad ${level(v)}`,
  },
  {
    key: "basalt",
    label: "Roca basáltica",
    source: "Ilustrativo",
    live: false,
    low: "Poca",
    high: "Dominante",
    format: (v) => `${Math.round(v * 100)} % basalto`,
  },
  {
    key: "ice",
    label: "Hielo / permafrost",
    source: "Ilustrativo",
    live: false,
    low: "Sin hielo",
    high: "Permafrost",
    format: (v) => `Hielo ${level(v)}`,
  },
];

export const DEFAULT_WEIGHTS: Weights = {
  aridity: 1,
  cold: 1,
  radiation: 1,
  roughness: 1,
  basalt: 1,
  ice: 1,
};

const clamp01 = (v: number) => Math.min(1, Math.max(0, v));

/** Perfil de un análogo terrestre: clima desde NASA POWER, el resto desde `traits`. */
export function earthProfile(a: Analog): Profile {
  return {
    aridity: clamp01(1 - a.metrics.annualRainfallMm / 900),
    cold: clamp01((20 - a.metrics.meanTempC) / 45),
    radiation: clamp01(a.metrics.uvIndex / 3),
    ...a.traits,
  };
}

/** Similitud 0-100: 1 - distancia euclidiana ponderada y normalizada. */
export function similarity(a: Profile, b: Profile, weights: Weights = DEFAULT_WEIGHTS): number {
  let sum = 0;
  let total = 0;
  for (const { key } of FEATURES) {
    const w = weights[key];
    sum += w * (a[key] - b[key]) ** 2;
    total += w;
  }
  if (total === 0) return 0;
  return Math.round(100 * (1 - Math.sqrt(sum / total)));
}

export interface Match<T> {
  item: T;
  score: number;
}

/** Sitio de la Luna o Marte más parecido a un análogo terrestre, y el ranking completo. */
export function rankSites(earth: Analog, sites: RefSite[], body: Body, weights: Weights): Match<RefSite>[] {
  const p = earthProfile(earth);
  return sites
    .filter((s) => s.body === body)
    .map((item) => ({ item, score: similarity(p, item.profile, weights) }))
    .sort((x, y) => y.score - x.score);
}

/** Análogo terrestre más parecido a un sitio de referencia, y el ranking completo. */
export function rankAnalogs(site: RefSite, analogs: Analog[], weights: Weights): Match<Analog>[] {
  return analogs
    .map((item) => ({ item, score: similarity(earthProfile(item), site.profile, weights) }))
    .sort((x, y) => y.score - x.score);
}
