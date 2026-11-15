"use client";

import { FEATURES } from "@/lib/similarity";
import { BODY_LABEL, MISSIONS, type MissionDef } from "@/lib/missions";
import type { Body } from "@/lib/types";

interface Props {
  body: Body | null;
  onBody: (b: Body) => void;
  missionId: string | null;
  onMission: (id: string) => void;
  onSearch: () => void;
  searched: boolean;
}

const BODY_STYLE: Record<Body, { color: string; blurb: string }> = {
  moon: { color: "#93c5fd", blurb: "Sin atmósfera, regolito y polos con hielo" },
  mars: { color: "#fb923c", blurb: "Desierto frío con atmósfera tenue" },
};

export default function MissionPanel({ body, onBody, missionId, onMission, onSearch, searched }: Props) {
  const available = MISSIONS.filter((m) => body && m.bodies.includes(body));
  const mission = MISSIONS.find((m) => m.id === missionId) ?? null;

  return (
    <div className="flex h-full flex-col">
      <div className="border-b border-white/10 px-5 py-4">
        <h2 className="text-base font-semibold">Planifica tu misión</h2>
        <p className="mt-1 text-xs leading-relaxed text-white/50">
          Elige el mundo y el objetivo. Te mostramos dónde en la Tierra ensayarla, con solo los datos que importan.
        </p>
      </div>

      <div className="flex-1 space-y-6 overflow-y-auto px-5 py-5">
        <section>
          <StepTitle n={1} title="Mundo objetivo" />
          <div className="grid grid-cols-2 gap-2">
            {(["moon", "mars"] as const).map((b) => {
              const s = BODY_STYLE[b];
              const on = body === b;
              return (
                <button
                  key={b}
                  onClick={() => onBody(b)}
                  aria-pressed={on}
                  className={`rounded-xl border p-3 text-left transition ${
                    on ? "bg-white/10" : "border-white/10 bg-white/[0.03] hover:bg-white/[0.07]"
                  }`}
                  style={on ? { borderColor: s.color } : undefined}
                >
                  <p className="font-semibold" style={{ color: s.color }}>
                    {BODY_LABEL[b]}
                  </p>
                  <p className="mt-1 text-[11px] leading-snug text-white/50">{s.blurb}</p>
                </button>
              );
            })}
          </div>
        </section>

        <section className={body ? "" : "pointer-events-none opacity-40"}>
          <StepTitle n={2} title="Tipo de misión" />
          {!body && <p className="mb-2 text-[11px] text-white/40">Primero elige un mundo.</p>}
          <ul className="space-y-2">
            {(body ? available : MISSIONS).map((m) => (
              <li key={m.id}>
                <MissionOption m={m} on={m.id === missionId} onClick={() => onMission(m.id)} />
              </li>
            ))}
          </ul>
        </section>

        {mission && (
          <section className="rounded-xl border border-white/10 bg-white/[0.04] p-4">
            <p className="text-[11px] font-medium uppercase tracking-widest text-white/40">Qué se evalúa</p>
            <p className="mt-2 text-xs leading-relaxed text-white/70">{mission.description}</p>
            <div className="mt-3 flex flex-wrap gap-1.5">
              {FEATURES.filter((f) => mission.vars[f.key]).map((f) => (
                <span key={f.key} className="rounded-full bg-sky-300/10 px-2.5 py-1 text-[11px] text-sky-200">
                  {f.label}
                  {(mission.vars[f.key]?.weight ?? 1) >= 2 && " ★"}
                </span>
              ))}
            </div>
            <p className="mt-2 text-[10px] text-white/35">★ pesa el doble en la puntuación</p>
          </section>
        )}
      </div>

      <div className="border-t border-white/10 px-5 py-4">
        <button
          onClick={onSearch}
          disabled={!body || !mission}
          className="w-full rounded-full bg-sky-400 py-2.5 text-sm font-semibold text-black transition hover:bg-sky-300 disabled:cursor-not-allowed disabled:bg-white/10 disabled:text-white/35"
        >
          {searched ? "Actualizar búsqueda" : "Buscar sitios"}
        </button>
      </div>
    </div>
  );
}

function StepTitle({ n, title }: { n: number; title: string }) {
  return (
    <h3 className="mb-2.5 flex items-center gap-2 text-[11px] font-medium uppercase tracking-widest text-white/40">
      <span className="grid size-5 place-items-center rounded-full bg-white/10 text-[10px] text-white/70">{n}</span>
      {title}
    </h3>
  );
}

function MissionOption({ m, on, onClick }: { m: MissionDef; on: boolean; onClick: () => void }) {
  return (
    <button
      onClick={onClick}
      aria-pressed={on}
      className={`flex w-full items-start gap-3 rounded-xl border p-3 text-left transition ${
        on ? "border-sky-300/60 bg-sky-300/10" : "border-white/10 bg-white/[0.03] hover:bg-white/[0.07]"
      }`}
    >
      <span className="mt-0.5 grid size-8 shrink-0 place-items-center rounded-lg bg-white/10 text-base">{m.glyph}</span>
      <span className="min-w-0">
        <span className="block text-sm font-medium">{m.label}</span>
        <span className="mt-0.5 block text-[11px] leading-snug text-white/50">{m.short}</span>
      </span>
    </button>
  );
}
