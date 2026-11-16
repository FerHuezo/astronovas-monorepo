"use client";

import { evaluate, BODY_LABEL, type Evaluation, type MissionDef, type Tone } from "@/lib/missions";
import type { Scored } from "@/lib/filters";
import type { Analog, Body } from "@/lib/types";

interface Props {
  mission: MissionDef | null;
  body: Body | null;
  /** null = todavía no se ha buscado */
  results: Scored<Analog>[] | null;
  selectedId: string | null;
  onSelect: (id: string | null) => void;
  onHover: (id: string | null) => void;
}

const TONE: Record<Tone, { text: string; bg: string; bar: string }> = {
  good: { text: "text-emerald-300", bg: "bg-emerald-400/15", bar: "#34d399" },
  ok: { text: "text-sky-300", bg: "bg-sky-400/15", bar: "#38bdf8" },
  warn: { text: "text-amber-300", bg: "bg-amber-400/15", bar: "#fbbf24" },
  bad: { text: "text-rose-300", bg: "bg-rose-400/15", bar: "#fb7185" },
};

const FIT_COLOR = { good: "#34d399", close: "#fbbf24", far: "#fb7185" } as const;

export default function MissionResults({ mission, body, results, selectedId, onSelect, onHover }: Props) {
  if (!results || !mission || !body) {
    return (
      <div className="grid h-full place-items-center p-8 text-center">
        <div className="max-w-xs">
          <p className="text-3xl text-white/25">⌖</p>
          <p className="mt-3 text-sm text-white/65">Elige un mundo y un tipo de misión, y pulsa «Buscar sitios».</p>
          <p className="mt-2 text-xs text-white/40">
            Recibirás fichas con una puntuación de recomendación, fortalezas y limitaciones de cada lugar.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex h-full flex-col">
      <div className="border-b border-white/10 px-5 py-4">
        <p className="font-mono text-[10px] uppercase tracking-widest text-sky-300">
          {BODY_LABEL[body]} · {mission.label}
        </p>
        <h2 className="mt-1 text-base font-semibold">
          {results.length} {results.length === 1 ? "sitio recomendado" : "sitios recomendados"}
        </h2>
        <p className="mt-1 text-xs text-white/50">Ordenados de mayor a menor puntuación para esta misión.</p>
      </div>

      <ol className="flex-1 space-y-3 overflow-y-auto px-4 py-4">
        {results.map(({ item }, i) => (
          <li key={item.id}>
            <Ficha
              rank={i + 1}
              analog={item}
              ev={evaluate(item, mission)}
              selected={item.id === selectedId}
              onToggle={() => onSelect(item.id === selectedId ? null : item.id)}
              onHover={onHover}
            />
          </li>
        ))}
      </ol>
    </div>
  );
}

function Ficha({
  rank,
  analog,
  ev,
  selected,
  onToggle,
  onHover,
}: {
  rank: number;
  analog: Analog;
  ev: Evaluation;
  selected: boolean;
  onToggle: () => void;
  onHover: (id: string | null) => void;
}) {
  const tone = TONE[ev.verdict.tone];
  return (
    <article
      onMouseEnter={() => onHover(analog.id)}
      onMouseLeave={() => onHover(null)}
      className={`rounded-2xl border transition ${
        selected ? "border-sky-300/60 bg-sky-300/[0.07]" : "border-white/10 bg-white/[0.03]"
      }`}
    >
      <button onClick={onToggle} aria-expanded={selected} className="flex w-full items-start gap-3 p-4 text-left">
        <span className="mt-1 w-4 shrink-0 text-center font-mono text-xs text-white/40">{rank}</span>
        <div className="min-w-0 flex-1">
          <h3 className="text-sm font-semibold leading-snug">{analog.name}</h3>
          <p className="mt-0.5 text-xs text-white/50">
            {analog.region} · {analog.type}
          </p>
          <span className={`mt-2 inline-block rounded-full px-2.5 py-0.5 text-[11px] font-medium ${tone.bg} ${tone.text}`}>
            {ev.verdict.label}
          </span>
        </div>
        <div className="text-right">
          <p className={`text-3xl font-semibold leading-none tabular-nums ${tone.text}`}>{ev.score}</p>
          <p className="mt-1 text-[10px] uppercase tracking-wider text-white/40">de 100</p>
        </div>
      </button>

      <div className="mx-4 h-1 overflow-hidden rounded-full bg-white/10">
        <div className="h-full rounded-full" style={{ width: `${ev.score}%`, background: tone.bar }} />
      </div>

      <div className="space-y-4 p-4 pt-3">
        <p className={`text-xs leading-relaxed text-white/70 ${selected ? "" : "line-clamp-2"}`}>{analog.description}</p>

        {/* Solo las variables de esta misión */}
        <ul className="space-y-2.5">
          {ev.rows.map((r) => (
            <li key={r.key}>
              <div className="flex items-baseline justify-between text-[11px]">
                <span className="text-white/80">
                  {r.label}
                  {r.weight >= 2 && <span className="ml-1 text-sky-300">★</span>}
                </span>
                <span className="text-white/55">{r.valueText}</span>
              </div>
              <div className="relative mt-1 h-1.5 rounded-full bg-white/10">
                <div className="h-full rounded-full" style={{ width: `${r.value * 100}%`, background: FIT_COLOR[r.fit] }} />
                <span
                  className="absolute top-1/2 h-3 w-0.5 -translate-y-1/2 rounded bg-white"
                  style={{ left: `${r.target * 100}%` }}
                  title={`Ideal: ${r.targetText}`}
                />
              </div>
            </li>
          ))}
        </ul>

        {selected && (
          <div className="space-y-3">
            <Bullets title="Fortalezas" items={ev.strengths} color="text-emerald-300" mark="+" />
            <Bullets title="Limitaciones" items={ev.limitations} color="text-amber-300" mark="!" />
          </div>
        )}
        {!selected && (
          <button onClick={onToggle} className="text-[11px] text-sky-300 hover:underline">
            Ver fortalezas y limitaciones
          </button>
        )}
      </div>
    </article>
  );
}

function Bullets({ title, items, color, mark }: { title: string; items: string[]; color: string; mark: string }) {
  return (
    <div>
      <p className={`text-[11px] font-medium uppercase tracking-widest ${color}`}>{title}</p>
      <ul className="mt-1.5 space-y-1.5">
        {items.map((t) => (
          <li key={t} className="flex gap-2 text-xs leading-snug text-white/70">
            <span className={`mt-px font-mono ${color}`}>{mark}</span>
            <span>{t}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
