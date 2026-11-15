"use client";

import type { Body, RefSite } from "@/lib/types";
import MiniGlobe from "./MiniGlobe";

export interface DockMatch {
  item: RefSite;
  /** Similitud con el punto terrestre seleccionado; null si el sitio es la plantilla de búsqueda */
  score: number | null;
}

interface Props {
  sites: RefSite[];
  matches: Record<Body, DockMatch | null>;
  onPick: (site: RefSite) => void;
}

const BODIES: { body: Body; label: string; color: string }[] = [
  { body: "moon", label: "Luna", color: "#93c5fd" },
  { body: "mars", label: "Marte", color: "#fb923c" },
];

/** Globos de la Luna y Marte: elegir un sitio lo convierte en plantilla de búsqueda. */
export default function Dock({ sites, matches, onPick }: Props) {
  return (
    <div className="@container absolute inset-x-3 bottom-3 z-10 grid grid-cols-2 gap-2">
      {BODIES.map(({ body, label, color }) => {
        const match = matches[body];
        return (
          <div
            key={body}
            className="flex items-center gap-2 rounded-2xl border border-white/10 bg-black/50 p-2 backdrop-blur @max-[480px]:flex-col @max-[480px]:text-center"
          >
            <div data-dock-anchor={body} className="size-20 shrink-0 md:size-24">
              <MiniGlobe
                body={body}
                sites={sites.filter((s) => s.body === body)}
                highlightId={match?.item.id ?? null}
                onSelect={onPick}
              />
            </div>
            <div className="min-w-0 text-xs">
              <p className="font-mono uppercase tracking-widest" style={{ color }}>
                {label}
              </p>
              {match ? (
                <>
                  <p className="mt-0.5 line-clamp-2 leading-tight text-white/90">{match.item.name}</p>
                  <p className="mt-1">
                    {match.score === null ? (
                      <span className="rounded-full border border-white/20 px-2 py-0.5 text-[10px] uppercase tracking-wider text-white/70">
                        Plantilla activa
                      </span>
                    ) : (
                      <>
                        <span className="text-2xl font-semibold" style={{ color }}>
                          {match.score}%
                        </span>{" "}
                        <span className="text-white/50">gemelo</span>
                      </>
                    )}
                  </p>
                </>
              ) : (
                <p className="mt-0.5 leading-tight text-white/50">
                  Toca un sitio para usarlo como plantilla de búsqueda.
                </p>
              )}
            </div>
          </div>
        );
      })}
    </div>
  );
}
