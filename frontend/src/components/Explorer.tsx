"use client";

import dynamic from "next/dynamic";
import { useCallback, useEffect, useMemo, useState } from "react";
import {
  activeCount,
  DEFAULT_FILTERS,
  filtersFromProfile,
  filtersFromValues,
  scoreWith,
  searchAnalogs,
  toWeights,
  type Filters,
} from "@/lib/filters";
import { BODY_TARGET, MISSIONS, missionFilters } from "@/lib/missions";
import { earthProfile, rankSites } from "@/lib/similarity";
import type { Analog, Body, Profile, RefSite } from "@/lib/types";
import AnalogDetail from "./AnalogDetail";
import Dock, { type DockMatch } from "./Dock";
import FilterPanel from "./FilterPanel";
import LinkOverlay from "./LinkOverlay";
import MissionPanel from "./MissionPanel";
import MissionResults from "./MissionResults";
import ResultsPanel from "./ResultsPanel";
import TopBar, { type Mode, type TargetScope } from "./TopBar";

// WebGL no existe en el servidor: se carga solo en cliente.
const Globe = dynamic(() => import("./Globe"), {
  ssr: false,
  loading: () => <div className="grid h-full place-items-center text-white/40">Cargando globo…</div>,
});

type Tab = "filters" | "results";

export default function Explorer({ analogs, sites }: { analogs: Analog[]; sites: RefSite[] }) {
  const [filters, setFilters] = useState<Filters>(DEFAULT_FILTERS);
  const [scope, setScope] = useState<TargetScope>("all");
  const [minScore, setMinScore] = useState(0);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [hoverId, setHoverId] = useState<string | null>(null);
  /** Sitio de la Luna o Marte con el que se llenaron los filtros; se suelta al editarlos a mano */
  const [templateId, setTemplateId] = useState<string | null>(null);
  const [tab, setTab] = useState<Tab>("filters");

  // ---- Explorador de misión: mundo -> tipo de misión -> buscar.
  const [mode, setMode] = useState<Mode>("mission");
  const [mBody, setMBody] = useState<Body | null>(null);
  const [mMissionId, setMMissionId] = useState<string | null>(null);
  const [mSearched, setMSearched] = useState(false);
  const mission = MISSIONS.find((m) => m.id === mMissionId) ?? null;
  const missionResults = useMemo(
    () =>
      mode === "mission" && mSearched && mission && mBody
        ? searchAnalogs(
            analogs.filter((a) => a.target === BODY_TARGET[mBody]),
            missionFilters(mission),
          )
        : null,
    [mode, mSearched, mission, mBody, analogs],
  );

  const hasFilters = activeCount(filters) > 0;

  // ---- Búsqueda: cada punto terrestre se compara con el perfil descrito por los filtros.
  const ranked = useMemo(() => {
    const scoped = scope === "all" ? analogs : analogs.filter((a) => a.target === scope);
    return searchAnalogs(scoped, filters);
  }, [analogs, scope, filters]);
  const results = useMemo(() => ranked.filter((r) => r.score >= minScore), [ranked, minScore]);
  const scores = useMemo(() => Object.fromEntries(ranked.map((r) => [r.item.id, r.score])), [ranked]);
  const visibleIds = useMemo(() => new Set(results.map((r) => r.item.id)), [results]);

  // Lo que pinta el globo depende del modo: en misión, solo los sitios de la búsqueda (o del mundo elegido).
  const globeScores = useMemo(
    () => (mode === "mission" ? Object.fromEntries((missionResults ?? []).map((r) => [r.item.id, r.score])) : scores),
    [mode, missionResults, scores],
  );
  const globeVisible = useMemo(() => {
    if (mode === "explore") return visibleIds;
    if (missionResults) return new Set(missionResults.map((r) => r.item.id));
    return new Set(analogs.filter((a) => !mBody || a.target === BODY_TARGET[mBody]).map((a) => a.id));
  }, [mode, visibleIds, missionResults, analogs, mBody]);

  const selected = analogs.find((a) => a.id === selectedId) ?? null;
  const template = sites.find((s) => s.id === templateId) ?? null;

  // ---- Tierra -> Luna/Marte: gemelo más parecido del punto elegido (o la plantilla si no hay punto).
  const twins = useMemo(() => {
    const out: Record<Body, DockMatch | null> = { moon: null, mars: null };
    const weights = toWeights(filters);
    for (const body of ["moon", "mars"] as const) {
      if (selected) {
        const best = rankSites(selected, sites, body, weights)[0];
        out[body] = best ? { item: best.item, score: best.score } : null;
      } else if (template?.body === body) {
        out[body] = { item: template, score: null };
      }
    }
    return out;
  }, [selected, sites, filters, template]);

  const handleSelect = useCallback((id: string | null) => {
    setSelectedId(id);
    if (id) {
      setTab("results");
      // En móvil el globo queda arriba: se vuelve a él para ver el viaje de la cámara.
      if (window.matchMedia("(max-width: 1023px)").matches) window.scrollTo({ top: 0, behavior: "smooth" });
    }
  }, []);

  // ---- Luna/Marte -> Tierra: el sitio se vuelve plantilla y se abre el mejor resultado.
  const handleSitePick = useCallback(
    (site: RefSite) => {
      const next = filtersFromProfile(site.profile);
      const scoped = scope === "all" ? analogs : analogs.filter((a) => a.target === scope);
      const best = searchAnalogs(scoped, next)[0];
      setFilters(next);
      setTemplateId(site.id);
      handleSelect(best?.item.id ?? null);
    },
    [analogs, scope, handleSelect],
  );

  const handleTemplate = useCallback(
    (id: string) => {
      const site = sites.find((s) => s.id === id);
      if (site) handleSitePick(site);
    },
    [sites, handleSitePick],
  );

  const editFilters = useCallback((f: Filters) => {
    setFilters(f);
    setTemplateId(null);
  }, []);

  const applyPreset = useCallback((values: Partial<Profile>) => {
    setFilters((prev) => filtersFromValues(values, prev));
    setTemplateId(null);
  }, []);

  const reset = useCallback(() => {
    setFilters(DEFAULT_FILTERS);
    setTemplateId(null);
    setMinScore(0);
  }, []);

  const changeMode = useCallback((m: Mode) => {
    setMode(m);
    setSelectedId(null);
    setHoverId(null);
    setTab("filters");
  }, []);

  const pickBody = useCallback(
    (b: Body) => {
      setMBody(b);
      // Una misión que no aplica al nuevo mundo se descarta.
      if (!MISSIONS.find((m) => m.id === mMissionId)?.bodies.includes(b)) setMMissionId(null);
      setMSearched(false);
      setSelectedId(null);
    },
    [mMissionId],
  );

  const pickMission = useCallback((id: string) => {
    setMMissionId(id);
    setMSearched(false);
    setSelectedId(null);
  }, []);

  const searchMission = useCallback(() => {
    if (!mission || !mBody) return;
    const best = searchAnalogs(
      analogs.filter((a) => a.target === BODY_TARGET[mBody]),
      missionFilters(mission),
    )[0];
    setMSearched(true);
    handleSelect(best?.item.id ?? null);
    setTab("results");
  }, [mission, mBody, analogs, handleSelect]);

  // Escape cierra la ficha de detalle.
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && setSelectedId(null);
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, []);

  const explore = mode === "explore";

  return (
    <div className="flex min-h-dvh flex-col lg:h-dvh lg:overflow-hidden">
      <TopBar
        mode={mode}
        onMode={changeMode}
        scope={scope}
        onScope={setScope}
        analogCount={analogs.length}
        siteCount={sites.length}
      />

      <main
        className={`flex flex-1 flex-col lg:grid lg:min-h-0 ${
          explore ? "lg:grid-cols-[320px_minmax(0,1fr)_360px]" : "lg:grid-cols-[340px_minmax(0,1fr)_420px]"
        }`}
      >
        {/* Globo terrestre (+ globos de la Luna y Marte en exploración libre) */}
        <section className="relative order-1 h-[58vh] min-h-[380px] lg:order-2 lg:h-auto">
          <Globe
            analogs={analogs}
            activeId={selectedId}
            hoverId={hoverId}
            scores={globeScores}
            visibleIds={globeVisible}
            onSelect={handleSelect}
          />
          {explore && (
            <>
              <LinkOverlay activeId={selectedId} />
              <Dock sites={sites} matches={twins} onPick={handleSitePick} />
            </>
          )}
        </section>

        {/* Pestañas (solo móvil) */}
        <div role="tablist" className="order-2 grid grid-cols-2 border-y border-white/10 bg-black/50 lg:hidden">
          {(["filters", "results"] as const).map((t) => (
            <button
              key={t}
              role="tab"
              aria-selected={tab === t}
              onClick={() => setTab(t)}
              className={`py-3 text-sm transition ${
                tab === t ? "border-b-2 border-sky-400 font-medium text-white" : "text-white/50"
              }`}
            >
              {t === "filters" ? (explore ? "Filtros" : "Misión") : `Resultados${explore ? ` (${results.length})` : ""}`}
            </button>
          ))}
        </div>

        <aside
          className={`order-3 border-white/10 bg-black/35 backdrop-blur lg:order-1 lg:block lg:min-h-0 lg:border-r ${
            tab === "filters" ? "block" : "hidden"
          }`}
        >
          {explore ? (
            <FilterPanel
              filters={filters}
              onChange={editFilters}
              onPreset={applyPreset}
              onReset={reset}
              sites={sites}
              templateId={templateId}
              onTemplate={handleTemplate}
              minScore={minScore}
              onMinScore={setMinScore}
            />
          ) : (
            <MissionPanel
              body={mBody}
              onBody={pickBody}
              missionId={mMissionId}
              onMission={pickMission}
              onSearch={searchMission}
              searched={mSearched}
            />
          )}
        </aside>

        <aside
          className={`order-4 border-white/10 bg-black/35 backdrop-blur lg:order-3 lg:block lg:min-h-0 lg:border-l ${
            tab === "results" ? "block" : "hidden"
          }`}
        >
          {!explore ? (
            <MissionResults
              mission={mission}
              body={mBody}
              results={missionResults}
              selectedId={selectedId}
              onSelect={setSelectedId}
              onHover={setHoverId}
            />
          ) : selected ? (
            <AnalogDetail
              analog={selected}
              score={scoreWith(earthProfile(selected), filters)}
              filters={filters}
              twins={twins}
              onClose={() => setSelectedId(null)}
            />
          ) : (
            <ResultsPanel
              results={results}
              total={ranked.length}
              minScore={minScore}
              hasFilters={hasFilters}
              selectedId={selectedId}
              onSelect={handleSelect}
              onHover={setHoverId}
              onLowerThreshold={() => setMinScore(0)}
            />
          )}
        </aside>
      </main>
    </div>
  );
}
