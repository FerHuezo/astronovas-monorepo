import { cacheLife } from "next/cache";
import sitesMock from "@/data/sites.json";
import { FEATURES } from "./similarity";
import { createSupabase } from "./supabase";
import { getAnalogs as getMockAnalogs } from "./nasa";
import type { Analog, FeatureKey, Profile, RefSite } from "./types";

export interface AppData {
  analogs: Analog[];
  sites: RefSite[];
  /** De dónde salieron los datos: la base o el respaldo local */
  source: "supabase" | "fallback";
}

interface SiteRow {
  slug: string;
  body_id: string;
  analog_of: string | null;
  name: string;
  region: string | null;
  terrain_type: string | null;
  description: string | null;
  soil: string | null;
  lat: number;
  lng: number;
  palette: string[] | null;
  site_features: { feature_key: FeatureKey; value: number; raw_value: number | null; is_illustrative: boolean }[];
}

const DEFAULT_PALETTE: [string, string, string] = ["#1e293b", "#334155", "#94a3b8"];

/** Perfil completo (6 variables) de un sitio, o null si le falta alguna: sin ella no se puede comparar. */
function profileOf(row: SiteRow): Profile | null {
  const profile = {} as Profile;
  for (const { key } of FEATURES) {
    const f = row.site_features.find((x) => x.feature_key === key);
    if (!f) return null;
    profile[key] = Number(f.value);
  }
  return profile;
}

function toAnalog(row: SiteRow, profile: Profile): Analog {
  const raw = (key: FeatureKey) => Number(row.site_features.find((x) => x.feature_key === key)?.raw_value ?? 0);
  const live = row.site_features.find((x) => x.feature_key === "aridity")?.is_illustrative === false;
  return {
    id: row.slug,
    name: row.name,
    region: row.region ?? "",
    target: row.analog_of === "moon" ? "Luna" : "Marte",
    lat: row.lat,
    lng: row.lng,
    type: row.terrain_type ?? "",
    description: row.description ?? "",
    metrics: {
      annualRainfallMm: raw("aridity"),
      meanTempC: raw("cold"),
      uvIndex: raw("radiation"),
      soil: row.soil ?? "",
    },
    traits: { roughness: profile.roughness, basalt: profile.basalt, ice: profile.ice },
    dataSource: live ? "nasa-power" : "mock",
    palette: (row.palette as Analog["palette"] | null) ?? DEFAULT_PALETTE,
  };
}

function toRefSite(row: SiteRow, profile: Profile): RefSite {
  return {
    id: row.slug,
    body: row.body_id as RefSite["body"],
    name: row.name,
    lat: row.lat,
    lng: row.lng,
    blurb: row.description ?? "",
    profile,
  };
}

type SupabaseResult = ({ ok: true } & Omit<AppData, "source">) | { ok: false; error: string };

/**
 * Lee los sitios publicados con sus variables desde Supabase.
 * No lanza: Next trata como fatal un error dentro de `use cache` (rompe el build). Un fallo se devuelve
 * como resultado y se cachea solo unos minutos, así que la base se vuelve a consultar enseguida.
 */
async function fetchFromSupabase(): Promise<SupabaseResult> {
  "use cache";

  try {
    const { data, error } = await createSupabase()
      .from("sites")
      .select(
        "slug, body_id, analog_of, name, region, terrain_type, description, soil, lat, lng, palette, site_features(feature_key, value, raw_value, is_illustrative)",
      )
      .eq("status", "published")
      .order("name")
      .overrideTypes<SiteRow[], { merge: false }>();
    if (error) throw error;

    const analogs: Analog[] = [];
    const sites: RefSite[] = [];
    for (const row of data) {
      const profile = profileOf(row);
      if (!profile) continue; // publicado pero aún sin variables: no se puede comparar
      if (row.body_id === "earth") analogs.push(toAnalog(row, profile));
      else sites.push(toRefSite(row, profile));
    }
    if (analogs.length === 0 || sites.length === 0) throw new Error("La base no tiene sitios comparables");
    cacheLife("minutes");
    return { ok: true, analogs, sites };
  } catch (err) {
    cacheLife({ stale: 300, revalidate: 30, expire: 600 }); // fallo: se reintenta pronto sin volverse dinámica
    const e = err as { message?: string; details?: string };
    return { ok: false, error: e.details ?? e.message ?? String(err) };
  }
}

/** Datos de la app: Supabase como fuente principal; JSON local + NASA POWER como respaldo. */
export async function getData(): Promise<AppData> {
  const result = await fetchFromSupabase();
  if (result.ok) return { analogs: result.analogs, sites: result.sites, source: "supabase" };

  console.error("[data] Supabase no disponible, usando respaldo local:", result.error.split("\n")[0]);
  return { analogs: await getMockAnalogs(), sites: sitesMock as unknown as RefSite[], source: "fallback" };
}
