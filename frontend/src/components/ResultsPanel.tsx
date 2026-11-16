"use client";

import type { Scored } from "@/lib/filters";
import type { Analog } from "@/lib/types";

interface Props {
  results: Scored<Analog>[];
  total: number;
  minScore: number;
  hasFilters: boolean;
  selectedId: string | null;
  onSelect: (id: string) => void;
  onHover: (id: string | null) => void;
  onLowerThreshold: () => void;
}

const TARGET_COLOR = { Luna: "#93c5fd", Marte: "#fb923c" } as const;

export default function ResultsPanel({
  results,
  total,
  minScore,
  hasFilters,
  selectedId,
  onSelect,
  onHover,
  onLowerThreshold,
}: Props) {
  return (
    <div className="flex h-full flex-col">
      <div className="flex items-baseline justify-between px-6 pb-3 pt-6">
        <div>
          <h2 className="text-base font-semibold">Resultados</h2>
          <p className="mt-1 text-xs text-white/45">Por similitud con tus filtros</p>
        </div>
        <span className="text-xs text-white/50">
          {results.length} de {total}
        </span>
      </div>

      {!hasFilters && (
        <p className="mx-4 mt-4 rounded-lg border border-amber-300/30 bg-amber-300/10 px-3 py-2 text-xs text-amber-100">
          Activa al menos una variable para calcular la similitud.
        </p>
      )}

      {results.length === 0 ? (
        <div className="m-5 rounded-xl border border-dashed border-white/15 p-5 text-center text-sm text-white/60">
          <p>Ningún punto llega al {minScore}% de similitud.</p>
          {minScore > 0 && (
            <button onClick={onLowerThreshold} className="mt-3 text-sky-300 hover:underline">
              Mostrar todos los puntos
            </button>
          )}
        </div>
      ) : (
        <ol className="flex-1 space-y-1 overflow-y-auto px-3 pb-6">
          {results.map(({ item, score }) => {
            const color = TARGET_COLOR[item.target];
            const selected = item.id === selectedId;
            return (
              <li key={item.id}>
                <button
                  onClick={() => onSelect(item.id)}
                  onMouseEnter={() => onHover(item.id)}
                  onMouseLeave={() => onHover(null)}
                  onFocus={() => onHover(item.id)}
                  onBlur={() => onHover(null)}
                  aria-current={selected}
                  className={`flex w-full items-center gap-4 rounded-xl px-4 py-3.5 text-left transition ${
                    selected ? "bg-sky-300/10" : "hover:bg-white/[0.06]"
                  }`}
                >
                  <div className="min-w-0 flex-1">
                    <p className="truncate text-sm font-medium">{item.name}</p>
                    <p className="mt-1 truncate text-xs text-white/45">
                      {item.region} · <span style={{ color }}>{item.target}</span>
                    </p>
                  </div>
                  <span className="text-lg font-semibold tabular-nums" style={{ color }}>
                    {score}%
                  </span>
                </button>
              </li>
            );
          })}
        </ol>
      )}
    </div>
  );
}
