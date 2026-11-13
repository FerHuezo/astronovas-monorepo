import { createClient } from "@supabase/supabase-js";

/**
 * Cliente de Supabase con la clave publishable: segura para el navegador porque la seguridad la
 * aplican las políticas RLS de la base. La clave secret nunca entra al frontend.
 */
export function createSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  if (!url || !key) {
    throw new Error("Faltan NEXT_PUBLIC_SUPABASE_URL o NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY en frontend/.env.local");
  }
  return createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } });
}
