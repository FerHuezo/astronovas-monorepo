"use client";

import dynamic from "next/dynamic";
import { useCallback, useEffect, useRef, useState } from "react";
import gsap from "gsap";
import { ScrollToPlugin } from "gsap/ScrollToPlugin";
import type { Analog } from "@/lib/types";
import Story from "./Story";

gsap.registerPlugin(ScrollToPlugin);

// WebGL no existe en el servidor: se carga solo en cliente.
const Globe = dynamic(() => import("./Globe"), {
  ssr: false,
  loading: () => <div className="grid h-full place-items-center text-white/40">Cargando globo…</div>,
});

export default function Explorer({ analogs }: { analogs: Analog[] }) {
  const [activeId, setActiveId] = useState<string | null>(null);
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
    <main className="md:grid md:grid-cols-[minmax(0,1fr)_minmax(0,1fr)]">
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
        <Story analogs={analogs} onActivate={handleScrollActivate} />
      </div>

      <div className="sticky top-0 z-0 order-1 h-[50vh] md:order-2 md:h-screen">
        <Globe analogs={analogs} activeId={activeId} onSelect={handleGlobeSelect} />
      </div>
    </main>
  );
}
