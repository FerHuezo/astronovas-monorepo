"use client";

import dynamic from "next/dynamic";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import gsap from "gsap";
import { ScrollToPlugin } from "gsap/ScrollToPlugin";
import { DEFAULT_WEIGHTS, rankAnalogs, rankSites, type Match } from "@/lib/similarity";
import type { Analog, Body, RefSite, Weights } from "@/lib/types";
import Dock from "./Dock";
import LinkOverlay from "./LinkOverlay";
import Story from "./Story";

gsap.registerPlugin(ScrollToPlugin);

// WebGL no existe en el servidor: se carga solo en cliente.
const Globe = dynamic(() => import("./Globe"), {
  ssr: false,
  loading: () => <div className="grid h-full place-items-center text-white/40">Cargando globo…</div>,
});

/** Sitio de la Luna o Marte elegido por el usuario; vale mientras el análogo terrestre asociado siga activo. */
interface Pin {
  body: Body;
  siteId: string;
  earthId: string;
}

export default function Explorer({ analogs, sites }: { analogs: Analog[]; sites: RefSite[] }) {
  const [activeId, setActiveId] = useState<string | null>(null);
  const [weights, setWeights] = useState<Weights>(DEFAULT_WEIGHTS);
  const [pin, setPin] = useState<Pin | null>(null);
  const scrollingRef = useRef(false);
  const headerRef = useRef<HTMLElement>(null);

  // Globo -> scroll: clic en un marcador baja suavemente a su sección.
  const handleGlobeSelect = useCallback((id: string) => {
    setActiveId(id);
    scrollingRef.current = true;
    gsap.to(window, {
      duration: 1.2,
      ease: "power2.inOut",
      scrollTo: { y: `#analog-${id}`, autoKill: false },
      onComplete: () => {
        scrollingRef.current = false;
      },
    });
  }, []);

  // Scroll -> globo (se ignora mientras dura el scroll automático).
  const handleScrollActivate = useCallback((id: string) => {
    if (!scrollingRef.current) setActiveId(id);
  }, []);

  // Luna/Marte -> Tierra: el análogo terrestre más parecido al sitio elegido se activa.
  const handleSitePick = useCallback(
    (site: RefSite) => {
      const best = rankAnalogs(site, analogs, weights)[0];
      if (!best) return;
      setPin({ body: site.body, siteId: site.id, earthId: best.item.id });
      handleGlobeSelect(best.item.id);
    },
    [analogs, weights, handleGlobeSelect],
  );

  // Tierra -> Luna/Marte: el gemelo más parecido de cada cuerpo, salvo el sitio fijado por el usuario.
  const matches = useMemo(() => {
    const out: Record<Body, Match<RefSite> | null> = { moon: null, mars: null };
    const earth = analogs.find((a) => a.id === activeId);
    if (!earth) return out;
    for (const body of ["moon", "mars"] as const) {
      const ranking = rankSites(earth, sites, body, weights);
      const pinned = pin && pin.earthId === earth.id && pin.body === body;
      out[body] = (pinned && ranking.find((r) => r.item.id === pin.siteId)) || ranking[0] || null;
    }
    return out;
  }, [analogs, sites, activeId, weights, pin]);

  // Scroll de regreso al encabezado: se desactiva el análogo y el globo vuelve a su vista inicial.
  useEffect(() => {
    const header = headerRef.current;
    if (!header) return;
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting && !scrollingRef.current) setActiveId(null);
      },
      { threshold: 0.6 },
    );
    observer.observe(header);
    return () => observer.disconnect();
  }, []);

  return (
    <main className="flex flex-col md:grid md:grid-cols-[minmax(0,1fr)_minmax(0,1fr)]">
      <div className="order-2 md:order-1">
        <header ref={headerRef} className="flex min-h-screen flex-col justify-center px-6 md:px-12">
          <p className="font-mono text-xs uppercase tracking-widest text-sky-300">AstroNovas</p>
          <h1 className="mt-3 text-5xl font-bold leading-tight md:text-6xl">TerraAnalog</h1>
          <p className="mt-5 max-w-md text-lg text-white/70">
            La Tierra como laboratorio: lugares que ya se parecen a la Luna y a Marte. Explora el globo o
            haz scroll.
          </p>
          <p className="mt-10 text-sm text-white/40">↓ Desplázate</p>
        </header>
        <Story analogs={analogs} sites={sites} weights={weights} onActivate={handleScrollActivate} />
      </div>

      <div className="sticky top-0 z-0 order-1 h-[50vh] md:order-2 md:h-screen">
        <Globe analogs={analogs} activeId={activeId} onSelect={handleGlobeSelect} />
        <LinkOverlay activeId={activeId} />
        <Dock
          sites={sites}
          matches={matches}
          weights={weights}
          onWeights={setWeights}
          onPick={handleSitePick}
        />
      </div>
    </main>
  );
}
