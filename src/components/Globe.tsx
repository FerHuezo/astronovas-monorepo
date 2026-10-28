"use client";

import { useEffect, useRef } from "react";
import type { Analog } from "@/lib/types";
import { createMarsTexture, createMoonTexture } from "@/lib/planetTextures";

interface Props {
  analogs: Analog[];
  activeId: string | null;
  onSelect: (id: string) => void;
}

const COLORS = { Marte: "#fb923c", Luna: "#93c5fd" } as const;

const INITIAL_POV = { lat: 10, lng: -40, altitude: 2.4 };

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type GlobeInstance = any;

export default function Globe({ analogs, activeId, onSelect }: Props) {
  const containerRef = useRef<HTMLDivElement>(null);
  const globeRef = useRef<GlobeInstance>(null);
  const onSelectRef = useRef(onSelect);
  useEffect(() => {
    onSelectRef.current = onSelect;
  }, [onSelect]);

  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    let disposed = false;

    // globe.gl usa WebGL: se importa solo en el cliente.
    let frame = 0;
    Promise.all([import("globe.gl"), import("three")]).then(([{ default: GlobeGL }, THREE]) => {
      if (disposed) return;
      const globe: GlobeInstance = (new GlobeGL(el) as GlobeInstance)
        .width(el.clientWidth)
        .height(el.clientHeight)
        .backgroundColor("rgba(0,0,0,0)")
        .globeImageUrl("/textures/earth-blue-marble.jpg")
        .bumpImageUrl("/textures/earth-topology.png")
        .atmosphereColor("#7dd3fc")
        .htmlElementsData(analogs)
        .htmlLat("lat")
        .htmlLng("lng")
        .htmlElement((d: Analog) => {
          const btn = document.createElement("button");
          btn.dataset.id = d.id;
          btn.title = `${d.name} · análogo de ${d.target}`;
          btn.className = "analog-marker";
          btn.style.setProperty("--c", COLORS[d.target]);
          btn.onclick = () => onSelectRef.current(d.id);
          return btn;
        })
        .ringsData(analogs)
        .ringColor((d: Analog) => () => COLORS[d.target])
        .ringMaxRadius(3)
        .ringPropagationSpeed(1.5)
        .ringRepeatPeriod(1800);

      globe.controls().autoRotate = true;
      globe.controls().autoRotateSpeed = 0.4;
      globe.controls().enableZoom = false;
      globe.pointOfView(INITIAL_POV);
      globeRef.current = globe;

      // Luna y Marte al fondo: hijos de la cámara, así siempre quedan detrás del globo
      // sin importar hacia dónde gire.
      const camera = globe.camera() as import("three").PerspectiveCamera;
      globe.scene().add(camera);
      const makePlanet = (canvas: HTMLCanvasElement, radius: number) => {
        const map = new THREE.CanvasTexture(canvas);
        map.colorSpace = THREE.SRGBColorSpace;
        const mesh = new THREE.Mesh(
          new THREE.SphereGeometry(radius, 64, 64),
          new THREE.MeshStandardMaterial({ map, bumpMap: map, bumpScale: 1.5, roughness: 1, metalness: 0 }),
        );
        camera.add(mesh);
        return mesh;
      };
      const moon = makePlanet(createMoonTexture(), 24);
      const mars = makePlanet(createMarsTexture(), 34);
      // Posición relativa al encuadre: esquinas opuestas sea cual sea la proporción del canvas.
      const placePlanets = () => {
        const halfH = Math.tan(THREE.MathUtils.degToRad(camera.fov / 2));
        const halfW = halfH * (el.clientWidth / el.clientHeight);
        const put = (m: import("three").Object3D, depth: number, fx: number, fy: number) =>
          m.position.set(fx * halfW * depth, fy * halfH * depth, -depth);
        put(moon, 520, -0.62, 0.68);
        put(mars, 600, 0.6, -0.66);
      };
      placePlanets();
      placePlanetsRef.current = placePlanets;
      const spin = () => {
        moon.rotation.y += 0.0008;
        mars.rotation.y += 0.0012;
        frame = requestAnimationFrame(spin);
      };
      spin();
    });

    const placePlanetsRef = { current: null as (() => void) | null };
    const observer = new ResizeObserver(() => {
      globeRef.current?.width(el.clientWidth).height(el.clientHeight);
      placePlanetsRef.current?.();
    });
    observer.observe(el);

    return () => {
      disposed = true;
      cancelAnimationFrame(frame);
      observer.disconnect();
      globeRef.current?._destructor?.();
      globeRef.current = null;
      el.innerHTML = "";
    };
  }, [analogs]);

  // Al activarse un análogo (clic o scroll) la cámara viaja hacia él.
  useEffect(() => {
    const globe = globeRef.current;
    if (!globe) return;
    const a = analogs.find((x) => x.id === activeId);
    if (!a) {
      // Sin análogo activo (de vuelta en el inicio): la cámara regresa a la vista general.
      globe.controls().autoRotate = true;
      globe.pointOfView(INITIAL_POV, 1500);
      highlightMarker(null);
      return;
    }
    globe.controls().autoRotate = false;
    globe.pointOfView({ lat: a.lat, lng: a.lng, altitude: 1.6 }, 1200);
    highlightMarker(activeId);
  }, [activeId, analogs]);

  return (
    <div className="relative h-full w-full overflow-hidden">
      <div ref={containerRef} className="absolute inset-0" />
    </div>
  );
}

function highlightMarker(id: string | null) {
  document.querySelectorAll<HTMLElement>(".analog-marker").forEach((m) => {
    m.classList.toggle("is-active", m.dataset.id === id);
  });
}
