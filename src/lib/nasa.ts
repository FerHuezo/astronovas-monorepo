import { cacheLife } from "next/cache";
import analogsMock from "@/data/analogs.json";
import type { Analog } from "./types";

const POWER_URL = "https://power.larc.nasa.gov/api/temporal/climatology/point";

interface PowerClimatology {
  uvIndex: number;
  annualRainfallMm: number;
  meanTempC: number;
}

/**
 * Climatología anual (2001-2025) de NASA POWER para un punto. No requiere API key.
 * Si falla lanza: Next no cachea los errores y getAnalogs() cae al valor mock.
 */
async function fetchClimatology(lat: number, lng: number): Promise<PowerClimatology> {
  "use cache";
  cacheLife("days");

  const url = new URL(POWER_URL);
  url.search = new URLSearchParams({
    parameters: "T2M,PRECTOTCORR,ALLSKY_SFC_UV_INDEX",
    community: "RE",
    latitude: String(lat),
    longitude: String(lng),
    format: "JSON",
  }).toString();

  const res = await fetch(url, { signal: AbortSignal.timeout(15000) });
  if (!res.ok) throw new Error(`NASA POWER ${res.status}`);
  const { parameter } = (await res.json()).properties;

  const ann = (key: string): number => {
    const v = parameter[key]?.ANN;
    if (typeof v !== "number" || v === -999) throw new Error(`NASA POWER sin dato para ${key}`);
    return v;
  };

  return {
    uvIndex: ann("ALLSKY_SFC_UV_INDEX"),
    // POWER entrega mm/día: se anualiza.
    annualRainfallMm: Math.round(ann("PRECTOTCORR") * 365 * 10) / 10,
    meanTempC: Math.round(ann("T2M") * 10) / 10,
  };
}

/** Análogos con métricas climáticas reales de NASA POWER (mock como respaldo). */
export async function getAnalogs(): Promise<Analog[]> {
  const base = analogsMock as Analog[];
  return Promise.all(
    base.map(async (a) => {
      try {
        const live = await fetchClimatology(a.lat, a.lng);
        return { ...a, metrics: { ...a.metrics, ...live }, dataSource: "nasa-power" as const };
      } catch (err) {
        console.error(`[nasa] ${a.id}: usando datos mock`, err);
        return { ...a, dataSource: "mock" as const };
      }
    }),
  );
}
