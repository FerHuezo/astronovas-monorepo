"use client";

import type { AnalogTarget } from "@/lib/types";

export type TargetScope = "all" | AnalogTarget;
export type Mode = "mission" | "explore";

interface Props {
  mode: Mode;
  onMode: (m: Mode) => void;
  scope: TargetScope;
  onScope: (s: TargetScope) => void;
  analogCount: number;
  siteCount: number;
}

const MODES: { value: Mode; label: string }[] = [
  { value: "mission", label: "Explorador de misión" },
  { value: "explore", label: "Exploración libre" },
];

const SCOPES: { value: TargetScope; label: string }[] = [
  { value: "all", label: "Todos" },
  { value: "Luna", label: "Luna" },
  { value: "Marte", label: "Marte" },
];

export default function TopBar({ mode, onMode, scope, onScope, analogCount, siteCount }: Props) {
  return (
    <header className="flex flex-wrap items-center gap-x-6 gap-y-3 border-b border-white/10 bg-black/40 px-5 py-3 backdrop-blur">
      <div>
        <p className="font-mono text-[10px] uppercase tracking-[0.3em] text-sky-300">AstroNovas</p>
        <h1 className="text-lg font-bold leading-none">TerraAnalog</h1>
      </div>

      <nav role="tablist" aria-label="Modo" className="inline-flex rounded-full border border-white/15 p-0.5 text-sm">
        {MODES.map((m) => (
          <button
            key={m.value}
            role="tab"
            aria-selected={mode === m.value}
            onClick={() => onMode(m.value)}
            className={`rounded-full px-4 py-1.5 transition ${
              mode === m.value ? "bg-sky-400 font-medium text-black" : "text-white/65 hover:text-white"
            }`}
          >
            {m.label}
          </button>
        ))}
      </nav>

      {mode === "explore" && (
        <div className="flex items-center gap-2">
          <span className="text-xs text-white/45">Análogos de</span>
          <div role="group" aria-label="Cuerpo objetivo" className="inline-flex overflow-hidden rounded-full border border-white/15 text-xs">
            {SCOPES.map((s) => (
              <button
                key={s.value}
                onClick={() => onScope(s.value)}
                aria-pressed={scope === s.value}
                className={`px-3.5 py-1.5 transition ${
                  scope === s.value ? "bg-white/20 font-medium text-white" : "text-white/60 hover:bg-white/10"
                }`}
              >
                {s.label}
              </button>
            ))}
          </div>
        </div>
      )}

      <p className="ml-auto hidden text-xs text-white/40 xl:block">
        {analogCount} puntos terrestres · {siteCount} sitios de referencia
      </p>
    </header>
  );
}
