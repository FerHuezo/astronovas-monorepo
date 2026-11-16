"use client";

import { useState } from "react";
import { activeCount, PRESETS, WEIGHT_LEVELS, type Filters } from "@/lib/filters";
import { FEATURES } from "@/lib/similarity";
import type { FeatureKey, Profile, RefSite } from "@/lib/types";

interface Props {
  filters: Filters;
  onChange: (f: Filters) => void;
  onPreset: (values: Partial<Profile>) => void;
  onReset: () => void;
  sites: RefSite[];
  templateId: string | null;
  onTemplate: (id: string) => void;
  minScore: number;
  onMinScore: (v: number) => void;
}

export default function FilterPanel({
  filters,
  onChange,
  onPreset,
  onReset,
  sites,
  templateId,
  onTemplate,
  minScore,
  onMinScore,
}: Props) {
  // Una variable abierta a la vez: el resto queda en una sola línea.
  const [open, setOpen] = useState<FeatureKey | null>(null);
  const patch = (key: FeatureKey, p: Partial<Filters[FeatureKey]>) =>
    onChange({ ...filters, [key]: { ...filters[key], ...p } });
  const active = activeCount(filters);

  return (
    <div className="flex h-full flex-col">
      <div className="px-6 pb-4 pt-6">
        <h2 className="text-base font-semibold">Filtros</h2>
        <p className="mt-1 text-xs leading-relaxed text-white/45">Describe el terreno que buscas.</p>
      </div>

      <div className="flex-1 space-y-7 overflow-y-auto px-6 pb-6">
        <section>
          <div className="mb-3 flex items-baseline justify-between">
            <h3 className="text-[11px] font-medium uppercase tracking-widest text-white/40">Variables</h3>
            <span className="text-[11px] text-white/35">
              {active} de {FEATURES.length}
            </span>
          </div>

          <ul className="space-y-2">
            {FEATURES.map((f) => {
              const flt = filters[f.key];
              const isOpen = open === f.key;
              return (
                <li
                  key={f.key}
                  className={`rounded-xl border transition ${
                    isOpen ? "border-white/20 bg-white/[0.05]" : "border-white/10 bg-white/[0.02]"
                  }`}
                >
                  <div className="flex items-center gap-3 px-3.5 py-3">
                    <input
                      type="checkbox"
                      checked={flt.enabled}
                      onChange={(e) => {
                        patch(f.key, { enabled: e.target.checked });
                        if (e.target.checked) setOpen(f.key);
                      }}
                      aria-label={`Usar ${f.label}`}
                      className="size-4 shrink-0 accent-sky-400"
                    />
                    <button
                      onClick={() => setOpen(isOpen ? null : f.key)}
                      aria-expanded={isOpen}
                      className="flex min-w-0 flex-1 items-center justify-between gap-2 text-left"
                    >
                      <span className={`text-sm ${flt.enabled ? "font-medium" : "text-white/40"}`}>{f.label}</span>
                      <span className="flex items-center gap-2">
                        <span className={`text-xs ${flt.enabled ? "text-sky-200" : "text-white/25"}`}>
                          {flt.enabled ? f.format(flt.target) : "Apagado"}
                        </span>
                        <span className={`text-[10px] text-white/30 transition ${isOpen ? "rotate-180" : ""}`}>▾</span>
                      </span>
                    </button>
                  </div>

                  {isOpen && (
                    <div className={`space-y-4 px-3.5 pb-4 ${flt.enabled ? "" : "pointer-events-none opacity-40"}`}>
                      <div>
                        <input
                          type="range"
                          min={0}
                          max={1}
                          step={0.05}
                          value={flt.target}
                          onChange={(e) => patch(f.key, { target: Number(e.target.value) })}
                          aria-label={`Valor buscado de ${f.label}`}
                          className="w-full accent-sky-400"
                        />
                        <div className="mt-1 flex justify-between text-[10px] text-white/35">
                          <span>{f.low}</span>
                          <span>{f.high}</span>
                        </div>
                      </div>

                      <div className="flex items-center justify-between">
                        <span className="text-[11px] text-white/50">Importancia</span>
                        <div className="inline-flex overflow-hidden rounded-full border border-white/15 text-[11px]">
                          {WEIGHT_LEVELS.map((w) => (
                            <button
                              key={w.label}
                              onClick={() => patch(f.key, { weight: w.value })}
                              aria-pressed={flt.weight === w.value}
                              className={`px-3 py-1 transition ${
                                flt.weight === w.value ? "bg-sky-400 text-black" : "text-white/60 hover:bg-white/10"
                              }`}
                            >
                              {w.label}
                            </button>
                          ))}
                        </div>
                      </div>

                      <p className="text-[10px] text-white/30">Dato: {f.live ? f.source : "ilustrativo por ahora"}</p>
                    </div>
                  )}
                </li>
              );
            })}
          </ul>
        </section>

        <details className="group rounded-xl border border-white/10 bg-white/[0.02]">
          <summary className="flex cursor-pointer list-none items-center justify-between px-3.5 py-3 text-sm text-white/75 [&::-webkit-details-marker]:hidden">
            Atajos y plantillas
            <span className="text-[10px] text-white/30 transition group-open:rotate-180">▾</span>
          </summary>
          <div className="space-y-5 px-3.5 pb-4">
            <div>
              <p className="mb-2 text-[11px] text-white/40">Perfiles listos</p>
              <div className="flex flex-wrap gap-2">
                {PRESETS.map((p) => (
                  <button
                    key={p.id}
                    onClick={() => onPreset(p.values)}
                    title={p.hint}
                    className="rounded-full border border-white/15 px-3 py-1.5 text-xs text-white/75 transition hover:border-sky-300/60 hover:bg-sky-300/10 hover:text-white"
                  >
                    {p.label}
                  </button>
                ))}
              </div>
            </div>
            <div>
              <p className="mb-2 text-[11px] text-white/40">Copiar el perfil de un sitio lunar o marciano</p>
              <select
                value={templateId ?? ""}
                onChange={(e) => e.target.value && onTemplate(e.target.value)}
                className="w-full rounded-lg border border-white/15 bg-black/40 px-3 py-2 text-sm text-white outline-none focus:border-sky-300/70"
                aria-label="Usar un sitio de la Luna o Marte como plantilla"
              >
                <option value="">Elige un sitio…</option>
                {(["moon", "mars"] as const).map((body) => (
                  <optgroup key={body} label={body === "moon" ? "Luna" : "Marte"}>
                    {sites
                      .filter((s) => s.body === body)
                      .map((s) => (
                        <option key={s.id} value={s.id}>
                          {s.name}
                        </option>
                      ))}
                  </optgroup>
                ))}
              </select>
            </div>
          </div>
        </details>
      </div>

      <div className="flex items-center gap-4 border-t border-white/10 px-6 py-4">
        <label className="flex-1">
          <span className="flex justify-between text-xs">
            <span className="text-white/60">Similitud mínima</span>
            <span className="text-sky-200">{minScore}%</span>
          </span>
          <input
            type="range"
            min={0}
            max={95}
            step={5}
            value={minScore}
            onChange={(e) => onMinScore(Number(e.target.value))}
            className="mt-1 w-full accent-sky-400"
          />
        </label>
        <button onClick={onReset} className="shrink-0 text-xs text-sky-300 hover:underline">
          Restablecer
        </button>
      </div>
    </div>
  );
}
