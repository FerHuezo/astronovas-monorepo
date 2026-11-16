"use client";

import { useState } from "react";
import type { Filters } from "@/lib/filters";
import { earthProfile, FEATURES } from "@/lib/similarity";
import type { DockMatch } from "./Dock";
import type { Analog, Body } from "@/lib/types";

interface Props {
  analog: Analog;
  score: number;
  filters: Filters;
  twins: Record<Body, DockMatch | null>;
  onClose: () => void;
}

const TARGET_COLOR = { Luna: "#93c5fd", Marte: "#fb923c" } as const;

type Tab = "perfil" | "gemelos" | "datos";
const TABS: { id: Tab; label: string }[] = [
  { id: "perfil", label: "Perfil" },
  { id: "gemelos", label: "Gemelos" },
  { id: "datos", label: "Datos" },
];

export default function AnalogDetail({ analog, score, filters, twins, onClose }: Props) {
  const [tab, setTab] = useState<Tab>("perfil");
  const profile = earthProfile(analog);
  const color = TARGET_COLOR[analog.target];
  // Solo las variables que el usuario está filtrando; el resto no aporta a esta comparación.
  const rows = FEATURES.filter((f) => filters[f.key].enabled);

  return (
    <div className="flex h-full flex-col">
      <div className="px-6 pt-5">
        <button onClick={onClose} className="text-xs text-sky-300 hover:underline">
          ← Resultados
        </button>
      </div>

      <header className="px-6 pb-5 pt-4">
        <p className="font-mono text-[11px] uppercase tracking-widest" style={{ color }}>
          Análogo de {analog.target}
        </p>
        <h2 className="mt-1.5 text-2xl font-bold leading-tight">{analog.name}</h2>
        <p className="mt-1 text-sm text-white/50">
          {analog.region} · {analog.type}
        </p>
        <p className="mt-4 text-sm leading-relaxed text-white/70">{analog.description}</p>
        <p className="mt-5 flex items-end gap-2">
          <span className="text-5xl font-semibold tabular-nums" style={{ color }}>
            {score}%
          </span>
          <span className="pb-1.5 text-sm text-white/45">similitud con tus filtros</span>
        </p>
      </header>

      <div role="tablist" className="mx-6 flex gap-5 border-b border-white/10">
        {TABS.map((t) => (
          <button
            key={t.id}
            role="tab"
            aria-selected={tab === t.id}
            onClick={() => setTab(t.id)}
            className={`-mb-px border-b-2 pb-2.5 text-sm transition ${
              tab === t.id ? "border-sky-400 text-white" : "border-transparent text-white/45 hover:text-white/75"
            }`}
          >
            {t.label}
          </button>
        ))}
      </div>

      <div className="flex-1 overflow-y-auto px-6 py-6">
        {tab === "perfil" && (
          <>
            {rows.length === 0 ? (
              <p className="text-sm text-white/50">Activa una variable en los filtros para compararla aquí.</p>
            ) : (
              <ul className="space-y-5">
                {rows.map((f) => {
                  const value = profile[f.key];
                  const target = filters[f.key].target;
                  const diff = Math.abs(value - target);
                  const verdict = diff < 0.12 ? "coincide" : diff < 0.3 ? "cercano" : "difiere";
                  return (
                    <li key={f.key}>
                      <div className="flex items-baseline justify-between text-sm">
                        <span>{f.label}</span>
                        <span className="text-white/55">{f.format(value)}</span>
                      </div>
                      <div className="relative mt-2 h-2 rounded-full bg-white/10">
                        <div className="h-full rounded-full" style={{ width: `${value * 100}%`, background: color }} />
                        <span
                          className="absolute top-1/2 h-4 w-0.5 -translate-y-1/2 rounded bg-white"
                          style={{ left: `${target * 100}%` }}
                          title={`Buscado: ${f.format(target)}`}
                        />
                      </div>
                      <p className="mt-1.5 text-xs text-white/40">
                        Buscas {f.format(target)} · {verdict}
                      </p>
                    </li>
                  );
                })}
              </ul>
            )}
          </>
        )}

        {tab === "gemelos" && (
          <div className="space-y-3">
            {(["moon", "mars"] as const).map((body) => {
              const t = twins[body];
              const c = body === "moon" ? "#93c5fd" : "#fb923c";
              return (
                <div key={body} className="flex items-center justify-between gap-4 rounded-xl border border-white/10 bg-white/[0.03] p-4">
                  <div className="min-w-0">
                    <p className="font-mono text-[10px] uppercase tracking-widest" style={{ color: c }}>
                      {body === "moon" ? "Luna" : "Marte"}
                    </p>
                    <p className="mt-1 text-sm leading-snug text-white/85">{t?.item.name ?? "—"}</p>
                  </div>
                  {t?.score != null && (
                    <p className="text-2xl font-semibold tabular-nums" style={{ color: c }}>
                      {t.score}%
                    </p>
                  )}
                </div>
              );
            })}
          </div>
        )}

        {tab === "datos" && (
          <>
            <dl className="divide-y divide-white/10 text-sm">
              <Fact label="Índice UV medio" value={analog.metrics.uvIndex.toFixed(1)} />
              <Fact label="Lluvia anual" value={`${analog.metrics.annualRainfallMm} mm`} />
              <Fact label="Temperatura media" value={`${analog.metrics.meanTempC} °C`} />
              <Fact label="Suelo" value={analog.metrics.soil} />
            </dl>
            <p className="mt-5 text-xs leading-relaxed text-white/35">
              {analog.dataSource === "nasa-power"
                ? "Clima: NASA POWER, climatología 2001–2025. Rugosidad, basalto y hielo: valores ilustrativos."
                : "Valores ilustrativos · NASA POWER no disponible."}
            </p>
          </>
        )}
      </div>
    </div>
  );
}

function Fact({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex justify-between gap-6 py-3">
      <dt className="text-white/50">{label}</dt>
      <dd className="text-right">{value}</dd>
    </div>
  );
}
