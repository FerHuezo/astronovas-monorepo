"use client";

import { useEffect, useRef } from "react";
import type { Body } from "@/lib/types";

const BODIES: { body: Body; color: string; bend: number }[] = [
  { body: "moon", color: "#93c5fd", bend: -70 },
  { body: "mars", color: "#fb923c", bend: 70 },
];

/**
 * Curvas animadas entre el análogo terrestre activo y los globos de la Luna y Marte.
 * Las posiciones se leen del DOM en cada frame, así siguen al globo mientras la cámara se mueve.
 */
export default function LinkOverlay({ activeId }: { activeId: string | null }) {
  const rootRef = useRef<SVGSVGElement>(null);
  const pathRefs = useRef<Partial<Record<Body, SVGPathElement | null>>>({});

  useEffect(() => {
    if (!activeId) {
      for (const { body } of BODIES) pathRefs.current[body]?.setAttribute("opacity", "0");
      return;
    }
    let raf = 0;
    const tick = () => {
      const root = rootRef.current;
      if (root) {
        const origin = root.getBoundingClientRect();
        const marker = document.querySelector<HTMLElement>(`.analog-marker[data-id="${activeId}"]`);
        const m = marker?.getBoundingClientRect();
        for (const { body, bend } of BODIES) {
          const path = pathRefs.current[body];
          const anchor = document.querySelector<HTMLElement>(`[data-dock-anchor="${body}"]`);
          if (!path) continue;
          if (!m || !anchor || m.width === 0) {
            path.setAttribute("opacity", "0");
            continue;
          }
          const a = anchor.getBoundingClientRect();
          const x1 = m.left + m.width / 2 - origin.left;
          const y1 = m.top + m.height / 2 - origin.top;
          const x2 = a.left + a.width / 2 - origin.left;
          const y2 = a.top - origin.top + 2;
          path.setAttribute("d", `M${x1} ${y1} Q${(x1 + x2) / 2 + bend} ${(y1 + y2) / 2 - 30} ${x2} ${y2}`);
          path.setAttribute("opacity", "0.9");
        }
      }
      raf = requestAnimationFrame(tick);
    };
    tick();
    return () => cancelAnimationFrame(raf);
  }, [activeId]);

  return (
    <svg ref={rootRef} className="pointer-events-none absolute inset-0 z-[5] h-full w-full" aria-hidden>
      {BODIES.map(({ body, color }) => (
        <path
          key={body}
          ref={(el) => {
            pathRefs.current[body] = el;
          }}
          className="link-path"
          stroke={color}
          fill="none"
          strokeWidth={1.8}
          strokeLinecap="round"
          opacity={0}
          d="M0 0"
        />
      ))}
    </svg>
  );
}
