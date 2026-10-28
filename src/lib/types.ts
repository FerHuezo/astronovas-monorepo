export type AnalogTarget = "Luna" | "Marte";

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
  /** Índice de similitud 0-100 con el cuerpo objetivo (valor mock) */
  similarity: number;
  metrics: {
    uvIndex: number;
    /** Precipitación anual en mm */
    annualRainfallMm: number;
    /** Temperatura media anual en °C */
    meanTempC: number;
    soil: string;
  };
  /** Origen de `metrics` climáticas; ausente en el JSON estático */
  dataSource?: "nasa-power" | "mock";
  /** Gradiente CSS usado como placeholder hasta tener imágenes reales */
  palette: [string, string, string];
}
