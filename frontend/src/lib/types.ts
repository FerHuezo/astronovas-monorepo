export type AnalogTarget = "Luna" | "Marte";

export type Body = "moon" | "mars";

/** Variables comparables entre la Tierra, la Luna y Marte (todas normalizadas 0-1). */
export type FeatureKey = "aridity" | "cold" | "radiation" | "roughness" | "basalt" | "ice";
export type Profile = Record<FeatureKey, number>;
export type Weights = Record<FeatureKey, number>;

/** Sitio de referencia en la Luna o en Marte */
export interface RefSite {
  id: string;
  body: Body;
  name: string;
  lat: number;
  lng: number;
  blurb: string;
  /** Valores ilustrativos hasta integrar los datos globales de la NASA */
  profile: Profile;
}

export interface Analog {
  id: string;
  name: string;
  region: string;
  target: AnalogTarget;
  lat: number;
  lng: number;
  /** Tipo de terreno, ej. "Desierto hiperárido" */
  type: string;
  description: string;
  metrics: {
    uvIndex: number;
    /** Precipitación anual en mm */
    annualRainfallMm: number;
    /** Temperatura media anual en °C */
    meanTempC: number;
    soil: string;
  };
  /** Rasgos no climáticos (0-1), ilustrativos hasta tener datos de terreno */
  traits: { roughness: number; basalt: number; ice: number };
  /** Origen de `metrics` climáticas; ausente en el JSON estático */
  dataSource?: "nasa-power" | "mock";
  /** Gradiente CSS usado como placeholder hasta tener imágenes reales */
  palette: [string, string, string];
}
