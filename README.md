# AstroNovas · TerraAnalog

Plataforma web que conecta datos de la NASA con **análogos terrestres** de la Luna y Marte: lugares de la
Tierra con condiciones parecidas a las de otros mundos. Un globo 3D interactivo, una historia con parallax y
un motor de similitud entre la Tierra, la Luna y Marte.

Proyecto para el NASA Space Apps Challenge 2026 (El Salvador).

## Estructura (monorepo con npm workspaces)

```
.
├─ frontend/   App Next.js 16 + Tailwind 4 + globe.gl + GSAP (incluye las API routes)
└─ backend/    Base de datos Supabase (migraciones, seed, pruebas) y scripts de ingesta de datos
```

## Primeros pasos

```bash
npm install          # una sola vez, en la raíz: instala frontend y backend
npm run dev          # frontend en http://localhost:3000
```

Variables de entorno: copia `frontend/.env.example` a `frontend/.env.local` y `backend/.env.example` a
`backend/.env.local`. La clave `secret` de Supabase (`sb_secret_...`) vive **solo** en `backend/`; el frontend usa únicamente la `publishable`.

## Comandos (desde la raíz)

| Comando | Qué hace |
|---|---|
| `npm run dev` | Servidor de desarrollo del frontend |
| `npm run build` | Build de producción del frontend |
| `npm run lint` | ESLint del frontend |
| `npm run db:seed` | Regenera `backend/supabase/seed.sql` (consulta NASA POWER) |
| `npm run db:extract` | Reextrae las evaluaciones desde los PDF a `backend/data/analog-assessments.json` (requiere `pdftotext`) |
| `npm run db:seed:assessments` | Regenera `backend/supabase/seed.assessments.sql` desde `backend/data/` |
| `npm run db:bundle:update` | SQL para actualizar un proyecto que ya tiene las migraciones anteriores |
| `npm run test:db` | Prueba migraciones, seed y seguridad (RLS) sin Docker |

Para añadir una dependencia a una carpeta: `npm install <paquete> -w frontend` (o `-w backend`).

## Cómo fluyen los datos

Supabase (Postgres) guarda los sitios y sus variables → `frontend/src/lib/data.ts` los lee en el servidor
y los cachea (1 min) → la app calcula la similitud en el navegador. Si Supabase no responde, usa un respaldo
local (JSON + NASA POWER) y la app sigue funcionando.

## Más información

- Base de datos y puesta en marcha de Supabase: [backend/supabase/README.md](backend/supabase/README.md)
- Texturas: LROC (NASA/GSFC/Arizona State University) para la Luna y mosaico Viking MDIM 2.1 (USGS) para Marte.
- Datos climáticos: [NASA POWER](https://power.larc.nasa.gov/). Los valores de la Luna, Marte y los rasgos de
  terreno son ilustrativos hasta integrar los datos reales.
