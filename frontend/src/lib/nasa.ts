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
 * No lanza (Next trata como fatal un error dentro de `use cache`): devuelve null si falla, y ese
 * fallo se reintenta a los 30 s; un acierto se cachea un día.
 */
async function fetchClimatology(lat: number, lng: number): Promise<PowerClimatology | null> {
  "use cache";

  try {
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

    const result = {
      uvIndex: ann("ALLSKY_SFC_UV_INDEX"),
      // POWER entrega mm/día: se anualiza.
      annualRainfallMm: Math.round(ann("PRECTOTCORR") * 365 * 10) / 10,
      meanTempC: Math.round(ann("T2M") * 10) / 10,
    };
    cacheLife("days");
    return result;
  } catch {
    cacheLife({ stale: 300, revalidate: 30, expire: 600 }); // fallo: se reintenta pronto sin volverse dinámica
    return null;
  }
}

/** Análogos con métricas climáticas reales de NASA POWER (mock como respaldo). */
export async function getAnalogs(): Promise<Analog[]> {
  const base = analogsMock as unknown as Analog[];
  return Promise.all(
    base.map(async (a) => {
      const live = await fetchClimatology(a.lat, a.lng);
      if (!live) {
        console.error(`[nasa] ${a.id}: NASA POWER no disponible, usando datos mock`);
        return { ...a, dataSource: "mock" as const };
      }
      return { ...a, metrics: { ...a.metrics, ...live }, dataSource: "nasa-power" as const };
    }),
  );
}
