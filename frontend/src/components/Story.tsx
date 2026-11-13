"use client";

import { useEffect, useRef } from "react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { rankSites } from "@/lib/similarity";
import type { Analog, RefSite, Weights } from "@/lib/types";

gsap.registerPlugin(ScrollTrigger);

interface Props {
  analogs: Analog[];
  sites: RefSite[];
  weights: Weights;
  onActivate: (id: string) => void;
}

export default function Story({ analogs, sites, weights, onActivate }: Props) {
  const rootRef = useRef<HTMLDivElement>(null);
  const onActivateRef = useRef(onActivate);
  useEffect(() => {
    onActivateRef.current = onActivate;
  }, [onActivate]);

  useEffect(() => {
    const ctx = gsap.context(() => {
      gsap.utils.toArray<HTMLElement>("[data-analog]").forEach((section) => {
        const id = section.dataset.analog!;

        // Parallax: cada capa se desplaza a distinta velocidad.
        gsap.utils.toArray<HTMLElement>("[data-speed]", section).forEach((layer) => {
          const speed = Number(layer.dataset.speed);
          gsap.fromTo(
            layer,
            { yPercent: -speed * 15 },
            {
              yPercent: speed * 15,
              ease: "none",
              scrollTrigger: { trigger: section, start: "top bottom", end: "bottom top", scrub: true },
            },
          );
        });

        // Aparición escalonada de las tarjetas de métricas.
        gsap.from(section.querySelectorAll("[data-card]"), {
          y: 40,
          opacity: 0,
          stagger: 0.12,
          duration: 0.7,
          ease: "power3.out",
          scrollTrigger: { trigger: section, start: "top 60%" },
        });

        // Scroll -> globo: al centrarse la sección, la cámara viaja a ese punto.
        ScrollTrigger.create({
          trigger: section,
          start: "top 50%",
          end: "bottom 50%",
          onToggle: (self) => self.isActive && onActivateRef.current(id),
        });
      });
    }, rootRef);
    return () => ctx.revert();
  }, [analogs]);

  return (
    <div ref={rootRef}>
      {analogs.map((a) => (
        <section
          key={a.id}
          id={`analog-${a.id}`}
          data-analog={a.id}
          className="relative flex min-h-screen items-center overflow-hidden px-6 py-24 md:px-12"
        >
          {/* Capas parallax (placeholder hasta tener imágenes reales) */}
          <div
            data-speed="1"
            className="absolute inset-0 -z-10 opacity-40"
            style={{ background: `linear-gradient(160deg, ${a.palette[0]}, ${a.palette[1]})` }}
          />
          <div
            data-speed="2.5"
            className="absolute -right-20 top-1/4 -z-10 h-72 w-72 rounded-full blur-3xl opacity-40"
            style={{ background: a.palette[2] }}
          />

          <div className="max-w-xl">
            <p className="font-mono text-xs uppercase tracking-widest text-sky-300">
              Análogo de {a.target} · {a.region}
            </p>
            <h2 className="mt-2 text-4xl font-bold md:text-5xl">{a.name}</h2>
            <p className="mt-1 text-sm text-white/60">{a.type}</p>
            <p className="mt-5 leading-relaxed text-white/80">{a.description}</p>

            <div className="mt-8 grid grid-cols-2 gap-3">
              <Card label={`Similitud con ${a.target}`} value={`${best(a, sites, weights).score}%`} note={best(a, sites, weights).item.name} accent />
              <Card label="Índice UV medio" value={a.metrics.uvIndex.toFixed(1)} />
              <Card label="Lluvia anual" value={`${a.metrics.annualRainfallMm} mm`} />
              <Card label="Temp. media" value={`${a.metrics.meanTempC} °C`} />
              <div data-card className="col-span-2 rounded-xl border border-white/10 bg-white/5 p-4 backdrop-blur">
                <p className="text-xs uppercase tracking-wider text-white/50">Suelo</p>
                <p className="mt-1">{a.metrics.soil}</p>
              </div>
            </div>
            <p className="mt-3 text-xs text-white/40">
              {a.dataSource === "nasa-power"
                ? "Clima: NASA POWER, climatología 2001–2025. Similitud y suelo: valores ilustrativos."
                : "Valores ilustrativos · NASA POWER no disponible."}
            </p>
          </div>
        </section>
      ))}
    </div>
  );
}

/** Sitio de la Luna o Marte (según el objetivo del análogo) que mejor coincide, con su puntaje. */
function best(a: Analog, sites: RefSite[], weights: Weights) {
  return rankSites(a, sites, a.target === "Luna" ? "moon" : "mars", weights)[0];
}

function Card({
  label,
  value,
  note,
  accent,
}: {
  label: string;
  value: string;
  note?: string;
  accent?: boolean;
}) {
  return (
    <div data-card className="rounded-xl border border-white/10 bg-white/5 p-4 backdrop-blur">
      <p className="text-xs uppercase tracking-wider text-white/50">{label}</p>
      <p className={`mt-1 text-2xl font-semibold ${accent ? "text-orange-300" : ""}`}>{value}</p>
      {note && <p className="mt-0.5 truncate text-xs text-white/50">{note}</p>}
    </div>
  );
}
