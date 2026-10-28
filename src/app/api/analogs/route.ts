import { NextResponse } from "next/server";
import { getAnalogs } from "@/lib/nasa";

/** Análogos enriquecidos con NASA POWER (ver `src/lib/nasa.ts`). */
export async function GET() {
  return NextResponse.json(await getAnalogs());
}
