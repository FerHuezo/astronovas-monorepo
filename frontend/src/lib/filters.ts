import { FEATURES, DEFAULT_WEIGHTS, earthProfile, similarity } from "./similarity";
import type { Analog, FeatureKey, Profile, Weights } from "./types";

/** Un filtro por variable: qué valor busco (`target`), cuánto importa (`weight`) y si participa (`enabled`). */
export interface Filter {
  enabled: boolean;
  target: number;
  weight: number;
}
export type Filters = Record<FeatureKey, Filter>;

export const WEIGHT_LEVELS = [
  { label: "Baja", value: 0.5 },
  { label: "Media", value: 1 },
  { label: "Alta", value: 2 },
] as const;

const KEYS = FEATURES.map((f) => f.key);

function build(fn: (key: FeatureKey) => Filter): Filters {
  return Object.fromEntries(KEYS.map((k) => [k, fn(k)])) as Filters;
}

/** Filtros iniciales: un perfil desértico y frío, el más cercano a lo que ofrece Marte. */
export const DEFAULT_FILTERS: Filters = build((k) => {
  const initial: Partial<Record<FeatureKey, number>> = { aridity: 0.9, cold: 0.5, radiation: 0.7 };
  return { enabled: k in initial, target: initial[k] ?? 0.5, weight: 1 };
});

/** Solo las variables indicadas quedan activas; el resto se conserva, desactivado. */
export function filtersFromValues(values: Partial<Profile>, base: Filters = DEFAULT_FILTERS): Filters {
  return build((k) => ({
    enabled: k in values,
    target: values[k] ?? base[k].target,
    weight: 1,
  }));
}

/** Filtros a partir de una especificación: solo las variables listadas quedan activas. */
export function filtersFromSpec(spec: Partial<Record<FeatureKey, { target: number; weight: number }>>): Filters {
  return build((k) => {
    const s = spec[k];
    return s ? { enabled: true, ...s } : { enabled: false, target: 0.5, weight: 1 };
  });
}

/** Copia completa de un perfil (p. ej. el de un sitio de la Luna o Marte) como plantilla de búsqueda. */
export function filtersFromProfile(profile: Profile): Filters {
  return build((k) => ({ enabled: true, target: profile[k], weight: 1 }));
}

export const activeCount = (f: Filters) => KEYS.filter((k) => f[k].enabled).length;

/** Pesos para el motor de similitud: las variables apagadas pesan 0. */
export function toWeights(f: Filters): Weights {
  return activeCount(f) === 0 ? DEFAULT_WEIGHTS : weightsOf(f);
}

function weightsOf(f: Filters): Weights {
  return Object.fromEntries(KEYS.map((k) => [k, f[k].enabled ? f[k].weight : 0])) as Weights;
}

function targetProfile(f: Filters): Profile {
  return Object.fromEntries(KEYS.map((k) => [k, f[k].target])) as Profile;
}

/** Similitud 0-100 entre el perfil de un punto y lo que describen los filtros. */
export function scoreWith(profile: Profile, f: Filters): number {
  return activeCount(f) === 0 ? 0 : similarity(profile, targetProfile(f), weightsOf(f));
}

export interface Scored<T> {
  item: T;
  score: number;
}

/** Puntos de la Tierra ordenados por similitud con los filtros (de mayor a menor). */
export function searchAnalogs(analogs: Analog[], f: Filters): Scored<Analog>[] {
  return analogs
    .map((item) => ({ item, score: scoreWith(earthProfile(item), f) }))
    .sort((a, b) => b.score - a.score || a.item.name.localeCompare(b.item.name));
}

/** Presets: atajos que activan solo las variables que los definen. */
export const PRESETS: { id: string; label: string; hint: string; values: Partial<Profile> }[] = [
  { id: "hyperarid", label: "Desierto hiperárido", hint: "Sin lluvia, mucha radiación", values: { aridity: 0.95, radiation: 0.8, cold: 0.4 } },
  { id: "polar", label: "Polar y permafrost", hint: "Frío extremo con hielo", values: { cold: 0.85, ice: 0.8, aridity: 0.7 } },
  { id: "volcanic", label: "Campo volcánico", hint: "Basalto y terreno áspero", values: { basalt: 0.9, roughness: 0.55, aridity: 0.6 } },
  { id: "rugged", label: "Escarpado y frío", hint: "Relieve fuerte, clima frío", values: { roughness: 0.85, cold: 0.6 } },
];
