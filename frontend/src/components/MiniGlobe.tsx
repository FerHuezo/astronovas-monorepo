"use client";

import { useEffect, useRef } from "react";
import type { Body, RefSite } from "@/lib/types";

interface Props {
  body: Body;
  sites: RefSite[];
  /** Sitio resaltado: el globo gira hacia él */
  highlightId: string | null;
  onSelect: (site: RefSite) => void;
}

// Texturas reales: LROC (NASA/GSFC/ASU) para la Luna y mosaico Viking MDIM 2.1 (USGS) para Marte.
const TEXTURE: Record<Body, string> = {
  moon: "/textures/moon-lroc-2k.jpg",
  mars: "/textures/mars-viking-2k.jpg",
};
const COLOR: Record<Body, string> = { moon: "#93c5fd", mars: "#fb923c" };

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type GlobeInstance = any;

export default function MiniGlobe({ body, sites, highlightId, onSelect }: Props) {
  const containerRef = useRef<HTMLDivElement>(null);
  const globeRef = useRef<GlobeInstance>(null);
  const onSelectRef = useRef(onSelect);
  const highlightRef = useRef(highlightId);
  useEffect(() => {
    onSelectRef.current = onSelect;
    highlightRef.current = highlightId;
  }, [onSelect, highlightId]);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    let disposed = false;

    import("globe.gl").then(({ default: GlobeGL }) => {
      if (disposed) return;
      const globe: GlobeInstance = (new GlobeGL(el, { animateIn: false }) as GlobeInstance)
        .width(el.clientWidth)
        .height(el.clientHeight)
        .backgroundColor("rgba(0,0,0,0)")
        .globeImageUrl(TEXTURE[body])
        .atmosphereColor(COLOR[body])
        .atmosphereAltitude(0.12)
        .htmlElementsData(sites)
        .htmlLat("lat")
        .htmlLng("lng")
        .htmlElement((d: RefSite) => {
          const btn = document.createElement("button");
          btn.dataset.id = d.id;
          btn.dataset.body = body;
          btn.title = d.name;
          btn.className = "site-marker";
          btn.style.setProperty("--c", COLOR[body]);
          btn.onclick = () => onSelectRef.current(d);
          return btn;
        });

      globe.controls().autoRotate = true;
      globe.controls().autoRotateSpeed = 0.8;
      globe.controls().enableZoom = false;
      globe.pointOfView({ lat: 10, lng: 0, altitude: 2.6 });
      globeRef.current = globe;
    });

    const observer = new ResizeObserver(() =>
      globeRef.current?.width(el.clientWidth).height(el.clientHeight),
    );
    observer.observe(el);

    return () => {
      disposed = true;
      observer.disconnect();
      globeRef.current?._destructor?.();
      globeRef.current = null;
      el.innerHTML = "";
    };
  }, [body, sites]);

  // El sitio resaltado queda de frente; sin selección, el globo vuelve a girar solo.
  useEffect(() => {
    const globe = globeRef.current;
    if (!globe) return;
    const site = sites.find((s) => s.id === highlightId);
    if (site) {
      globe.controls().autoRotate = false;
      globe.pointOfView({ lat: site.lat, lng: site.lng, altitude: 2.2 }, 1000);
    } else {
      globe.controls().autoRotate = true;
    }
    document.querySelectorAll<HTMLElement>(`.site-marker[data-body="${body}"]`).forEach((m) => {
      m.classList.toggle("is-active", m.dataset.id === highlightId);
    });
  }, [highlightId, sites, body]);

  // Pausa la rotación mientras el cursor está encima, para poder apuntar a un marcador.
  const pause = (paused: boolean) => {
    const globe = globeRef.current;
    if (globe) globe.controls().autoRotate = !paused && highlightRef.current === null;
  };

  return (
    <div
      ref={containerRef}
      className="h-full w-full"
      onPointerEnter={() => pause(true)}
      onPointerLeave={() => pause(false)}
    />
  );
}
