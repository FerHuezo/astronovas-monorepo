"use client";

import { useState } from "react";
import { DEFAULT_WEIGHTS, FEATURES, type Match } from "@/lib/similarity";
import type { Body, RefSite, Weights } from "@/lib/types";
import MiniGlobe from "./MiniGlobe";

interface Props {
  sites: RefSite[];
  matches: Record<Body, Match<RefSite> | null>;
  weights: Weights;
  onWeights: (w: Weights) => void;
  onPick: (site: RefSite) => void;
}

const BODIES: { body: Body; label: string; color: string }[] = [
  { body: "moon", label: "Luna", color: "#93c5fd" },
  { body: "mars", label: "Marte", color: "#fb923c" },
];

export default function Dock({ sites, matches, weights, onWeights, onPick }: Props) {
  const [open, setOpen] = useState(false);

  return (
    <>
      {/* Panel de pesos del motor de similitud */}
      <div className="absolute right-3 top-3 z-20 text-sm">
        <button
          onClick={() => setOpen((o) => !o)}
          className="rounded-full border border-white/15 bg-black/50 px-3 py-1.5 text-xs backdrop-blur hover:bg-black/70"
          aria-expanded={open}
        >
          ⚙ Pesos de similitud
        </button>
        {open && (
          <div className="mt-2 w-64 rounded-xl border border-white/15 bg-black/70 p-4 backdrop-blur">
            <p className="mb-3 text-xs text-white/50">¿Qué variables importan más? El ranking se recalcula al instante.</p>
            {FEATURES.map(({ key, label, source }) => (
              <label key={key} className="mb-2 block">
                <span className="flex justify-between text-xs">
                  <span>{label}</span>
                  <span className="text-white/40">{source}</span>
                </span>
                <input
                  type="range"
                  min={0}
                  max={3}
                  step={0.25}
                  value={weights[key]}
                  onChange={(e) => onWeights({ ...weights, [key]: Number(e.target.value) })}
                  className="w-full accent-sky-400"
                />
              </label>
            ))}
            <button onClick={() => onWeights(DEFAULT_WEIGHTS)} className="text-xs text-sky-300 hover:underline">
              Restablecer
            </button>
          </div>
        )}
      </div>

      {/* Globos de la Luna y Marte */}
      <div className="absolute inset-x-3 bottom-3 z-10 grid grid-cols-2 gap-2">
        {BODIES.map(({ body, label, color }) => {
          const match = matches[body];
          return (
            <div
              key={body}
              className="flex items-center gap-2 rounded-2xl border border-white/10 bg-black/45 p-2 backdrop-blur"
            >
              <div data-dock-anchor={body} className="size-20 shrink-0 md:size-28">
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
                      <span className="text-2xl font-semibold" style={{ color }}>
                        {match.score}%
                      </span>{" "}
                      <span className="text-white/50">similitud</span>
                    </p>
                  </>
                ) : (
                  <p className="mt-0.5 leading-tight text-white/50">Elige un sitio o un análogo terrestre.</p>
                )}
              </div>
            </div>
          );
        })}
      </div>
    </>
  );
}
