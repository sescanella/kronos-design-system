# Changelog

Sistema de versionado: semver (`MAJOR.MINOR.PATCH`).

- **MAJOR** — cambios que rompen la compatibilidad (cambio de nombre de tokens, eliminación de componentes canónicos, reestructura del sistema).
- **MINOR** — nuevos tokens, nuevos componentes canónicos, nuevos patrones. Compatible con versiones previas.
- **PATCH** — fixes de docs, refinamiento de tokens existentes sin cambio de nombre, clarificaciones.

---

## [Unreleased]

### Pendiente de migrar
- Crear `reference/react/CTASection.tsx` para stack React (cuando se migre la app React)
- Añadir screenshots archivados de Anduril, Saronic, Mach a `design/references/`
- Evaluar añadir `tokens/colors.json` en formato DTCG si se integra con Style Dictionary o Figma MCP

---

## [0.1.0] — 2026-04-04

### Primera versión extraída desde `kronos-web/`

**Origen.** Este repo nació de la extracción del design system que previamente vivía
dentro del repo `kronos-web/`. El objetivo: convertirlo en fuente de verdad compartida
entre la web y las múltiples apps React de Kronos Mining.

### Incluido

**Tokens** (`tokens/`)
- `colors.css` — paleta completa: primary (azul corporativo), accent (naranjo firmado), neutrals, shadows
- `typography.css` — `@font-face` de Instrument Sans + Geist Mono con alias `--font-mono`
- `spacing.css` — 6 tokens semánticos: `--space-section-y/x`, `--space-actions-gap`, `--space-headline-to-sub`, `--space-sub-to-actions`, `--space-actions-to-footer`

**Documentación** (`DESIGN.md` + `design/`)
- `DESIGN.md` — router del sistema con los 10 principios
- `design/tokens.md` — uso semántico de cada token, regla del 5% del accent, opacidades rgba sobre dark
- `design/typography.md` — escalas, tracking, uppercase rules, pesos permitidos
- `design/components.md` — catálogo de 31 componentes del proyecto web origen (1 canónico, 8 utilitarios, 19 legacy, 3 pendientes)
- `design/animations.md` — los 4 patrones firmados: shader mesh gradient, GSAP SplitText, shimmer button, liquid fill outline
- `design/anti-patterns.md` — reglas inviolables (cromáticos, componentes, animación, layout, idioma, arquitectura, accesibilidad)
- `design/references.md` — 3 referencias canónicas (Anduril, Saronic, Mach) + 8 secundarias con ratings

**Fuentes** (`fonts/`)
- `InstrumentSans-Variable.ttf` (variable 100-900, stretch 75-100%)
- `GeistMono-Variable.ttf` (variable 100-900)

**Componentes canónicos** (`reference/`)
- `reference/astro/CTASection.astro` — componente de referencia stack Astro. Incluye shader WebGL (Paper Shaders), GSAP SplitText + ScrollTrigger, botones con shimmer sweep + glow pulse + liquid fill clip-path. Tokens consumidos desde `@theme` vía `var(--color-*)`. Reduced-motion defensivo. Mobile degradation.

**Skill Claude Code** (`skills/rediseño/`)
- `SKILL.md` — skill de 72 líneas (refactorizado desde 214) para rediseñar páginas/componentes replicando el canónico. Portable a cualquier repo consumidor copiándolo a `.claude/skills/rediseño/`.

### Decisiones arquitectónicas importantes de esta versión

1. **Repo independiente, no monorepo.** Cada producto Kronos mantiene su propio repo; el design system es un cuarto repo consumido vía git submodule.
2. **Git submodule** como mecanismo de distribución, no npm package. Razón: los archivos markdown (DESIGN.md, skill) deben ser leíbles por Claude Code como archivos locales, no enterrados en `node_modules/`.
3. **Tokens en CSS nativo + Tailwind v4 `@theme`.** Sin Style Dictionary, sin JSON DTCG (por ahora), sin herramientas de build. La simplicidad es intencional.
4. **Legacy token `--font-heading`** preservado con alias nuevo `--font-mono` para evitar romper clases Tailwind en repos consumidores.
5. **Una sola versión del canónico por stack.** `reference/astro/`, `reference/react/`, etc. El mismo vocabulario visual se implementa nativamente en cada framework en lugar de compartir código entre ellos.

### Previo a la extracción (histórico del proyecto `kronos-web/`)

Este sistema se construyó incrementalmente en `kronos-web/` durante marzo-abril 2026:

- **Rediseño del CTASection** con estética Anduril-style (shader + GSAP + shimmer).
- **Fase 1 del design system:** creación de `DESIGN.md`, `CLAUDE.md`, `tokens.md`, `anti-patterns.md`, comentarios semánticos en `@theme`.
- **Investigación de comunidad** sobre cómo estandarizar design systems para Claude Code (3 reportes en `investigacion/`).
- **Ola 1:** creación de `typography.md`, `components.md`, `animations.md`, `references.md` + `.gitkeep`.
- **Ola Bonus:** limpieza del canónico (cero hex hardcodeados, cleanup parametrizado, reduced-motion defensivo).
- **Ola 2:** refactor del skill `rediseño` de 214 a 72 líneas.
- **Extracción a repo propio** (esta versión).
