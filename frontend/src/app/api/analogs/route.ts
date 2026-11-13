import { NextResponse } from "next/server";
import { getData } from "@/lib/data";

/** Análogos y sitios de referencia desde Supabase (con respaldo local, ver `src/lib/data.ts`). */
export async function GET() {
  const { analogs, sites, source } = await getData();
  return NextResponse.json({ source, analogs, sites });
}
