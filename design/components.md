# Catálogo de componentes — Kronos Mining

> Inventario operativo de componentes `.astro` del sistema. Estado, propósito, canónico de
> referencia y migraciones pendientes. Cuando construyas UI nueva, consulta este archivo
> **antes** de inventar estructura propia.
>
> **Regla cardinal.** Hay un solo componente canónico: `src/components/CTASection.astro`.
> Todos los demás componentes son funcionales pero no son fuente de verdad visual. Cualquier
> componente nuevo o rediseño debe usar el canónico como referencia — ver
> `.claude/skills/rediseño/SKILL.md` y `DESIGN.md §10`.

---

## 1. Estados posibles

| Estado | Significado | Qué puedes hacer con él |
|---|---|---|
| **CANÓNICO** | Fuente de verdad visual del sistema | Copiar patrones, referenciar en prompts, jamás borrar sin reemplazo |
| **ALINEADO** | Ya migrado al lenguaje del canónico | Usar tal cual, extender con cuidado |
| **LEGACY** | Pre-rediseño, sirve funcionalmente pero no estéticamente | No usar en secciones nuevas, plan de migración pendiente |
| **UTILITARIO** | No define visuales (wrappers, providers, analytics, controladores) | Usar tal cual, no aplica lenguaje visual |
| **DEPRECADO** | Marcado para eliminar en la próxima migración | No usar, no extender |
| **[?]** | Pendiente de clasificación tras revisión | Inspeccionar antes de usar |

---

## 2. Catálogo completo

Una fila por componente real en `src/components/`. Orden: CANÓNICO → ALINEADO → LEGACY → UTILITARIO → DEPRECADO → [?], y alfabético dentro de cada grupo.

| Componente | Ruta | Estado | Propósito | Referencia / notas |
|---|---|---|---|---|
| **CTASection** | `src/components/CTASection.astro` | **CANÓNICO** | Sección final CTA del home con shader WebGL, headline oversized uppercase, footer técnico con dots. Consume `<TechLabel>`, `<BlueprintGrid>` y clases globales `.btn-kronos-*` | Referencia maestra — cualquier rediseño consulta aquí primero. Buttons/meta/grid promovidos a `global.css` (2026-04-06) |
| **TechLabel** | `src/components/TechLabel.astro` | **ALINEADO** | Label técnica reutilizable `◆ LABEL ─── coord`. Props: `label` (required), `coord?` | Consume `.kronos-meta*` de `global.css`. Extraído del patrón repetido 5× en CTASection + index.astro + TechnicalCatalog |
| **BlueprintGrid** | `src/components/BlueprintGrid.astro` | **ALINEADO** | Grid blueprint decorativo (background) para secciones oscuras. Props: `class?` | Consume `.kronos-blueprint` de `global.css`. Extraído del patrón repetido 5× en el home |
| TechnicalCatalog | `src/components/TechnicalCatalog.astro` | **ALINEADO** | Catálogo técnico unificado buscable de proyectos + artículos. 2-col narrativa + rich rows con GSAP SplitText. Consume `<TechLabel>`, `<BlueprintGrid>`, `.btn-kronos-*` globales con size overrides scoped | Migrado a componentes globales (2026-04-06). Button size override: `padding: 0.875rem 1.5rem; font-size: 0.8125rem` |
| ServiceSubNav | `src/components/ServiceSubNav.astro` | **ALINEADO** | Sub-navegación sticky para páginas de servicio. IntersectionObserver para highlight de sección activa + smooth scroll. Props: `items`, `navId`, `sectionClass`, `ariaLabel?` | Instrument Sans 11px/600/0.12em uppercase (no Geist Mono — es navegación, no metadata). Underline accent 1px activo. Depende de header height hardcodeado (`top: 4rem`/`5rem`). Consume `--site-gutter`. Extraído de piping + revestimientos (2026-04-07) |
| AnalyticsHead | `src/components/AnalyticsHead.astro` | UTILITARIO | Inyecta scripts de Microsoft Clarity, Cloudflare Analytics y verificación GSC en `<head>` | Sin UI visible |
| FloatingCTA | `src/components/FloatingCTA.astro` | UTILITARIO | Botón flotante de WhatsApp (color de marca `#25D366` permitido por ser logo de terceros) | Color `#25D366` es excepción documentada (marca WhatsApp) |
| Pagination | `src/components/Pagination.astro` | UTILITARIO | Controles de paginación para listados (`/recursos`, `/proyectos`) | Visual neutro, no requiere alinear al lenguaje hero/CTA |
| ReadingProgressBar | `src/components/ReadingProgressBar.astro` | UTILITARIO | Barra de progreso de lectura fija bajo el header en artículos | Usa `bg-accent`, correcto con el sistema |
| ScrollReveal | `src/components/ScrollReveal.astro` | UTILITARIO | Wrapper global de IntersectionObserver para `[data-reveal]`. Incluido en `BaseLayout` | No aplicar junto con GSAP SplitText en el mismo elemento (anti-patterns.md) |
| SearchBar | `src/components/SearchBar.astro` | UTILITARIO | Input de búsqueda con integración Pagefind (`is:inline` script) | Visual neutro |
| ShareButtons | `src/components/ShareButtons.astro` | UTILITARIO | Botones sociales (LinkedIn, WhatsApp, email) para artículos | Usa iconos SVG, no aplica lenguaje hero |
| TableOfContents | `src/components/TableOfContents.astro` | UTILITARIO | TOC generado desde headings de artículos de blog | Lectura editorial, no aplica lenguaje hero/CTA |
| AllianceCard | `src/components/AllianceCard.astro` | DEPRECADO | Card de alianza internacional (legacy). Reemplazada por inline `.alcance-card` en `index.astro` | El home ahora usa cards inline con estética Anduril; este componente ya no se importa en ninguna página |
| ArticleCard | `src/components/ArticleCard.astro` | LEGACY | Card para artículos de `/recursos` con imagen + categoría accent + meta | Pre-rediseño: rounded-xl + shadow-card, hover translate-y, usa badges `bg-accent` en lugar de label técnica. Sigue en uso en listados |
| Button | `src/components/Button.astro` | **LEGACY** | Botón genérico con 8 variantes (`primary`, `secondary`, `outline`, `ghost`, `white`, `whatsapp`, `primary-solid`, `link`) y 4 sizes | **No usar en secciones nuevas.** Usar clases globales `.btn-kronos-primary` / `.btn-kronos-outline` de `global.css`. Ver anti-patterns.md §Componentes |
| ContactCard | `src/components/ContactCard.astro` | LEGACY | Tarjeta de contacto con foto, WhatsApp, email, LinkedIn y QR | Pre-rediseño; no aplica label técnica ni footer técnico |
| FeaturedProjectsCarousel | `src/components/FeaturedProjectsCarousel.astro` | DEPRECADO | Carousel horizontal de proyectos destacados. Reemplazado por TechnicalCatalog en el home | Ya no se importa en `index.astro` |
| Footer | `src/components/Footer.astro` | LEGACY | Footer global 4-col desktop sobre `bg-neutral-900` | No incorpora footer técnico tipo CTASection (KRONOS MINING · LOCATION ● CERTS ● EST. 2016); tipografía estándar sin tracking Geist Mono |
| Globe3D | `src/components/Globe3D.astro` | LEGACY | Globo terráqueo 3D holográfico con conexiones Chile-Alemania-España (three.js CDN) | En uso en slide 3 del home como background decorativo. Se alinea con estética defense-tech |
| Globe3DBlueprint | `src/components/Globe3DBlueprint.astro` | DEPRECADO | Variante de Globe3D (estilo blueprint) | No usada — Globe3D (base) es la versión activa en producción |
| Globe3DGithub | `src/components/Globe3DGithub.astro` | DEPRECADO | Variante de Globe3D (estilo GitHub globe) | No usada — Globe3D (base) es la versión activa en producción |
| Globe3DHolo | `src/components/Globe3DHolo.astro` | DEPRECADO | Variante de Globe3D (estilo holográfico) | No usada — Globe3D (base) es la versión activa en producción |
| Header | `src/components/Header.astro` | LEGACY | Header sticky con logo, navegación desktop y hamburger mobile | Importa `Button.astro` (legacy). No usa label técnica, tipografía estándar, rounded-lg en lugar del lenguaje industrial |
| IndustriesSection | `src/components/IndustriesSection.astro` | DEPRECADO | Sección de industrias atendidas con cards y CTA opcional. Reemplazada por inline `.alcance-industria` grid en `index.astro` | Ya no se importa en el home |
| IndustryCard | `src/components/IndustryCard.astro` | DEPRECADO | Card individual de industria con icono, imagen, conteo de proyectos. Reemplazada por inline grid en slide 3 | Ya no se importa en ninguna página |
| LogoCarousel | `src/components/LogoCarousel.astro` | LEGACY | Carousel auto-scroll de logos de clientes/partners | En uso en slide 2 del home. Marquee genérico, estéticamente neutro |
| ProjectCard | `src/components/ProjectCard.astro` | LEGACY | Card de proyecto con imagen, tags (servicio) + industria, location + cliente | Pre-rediseño: rounded-xl, shadow-card, badges `bg-accent`/`bg-primary` — no label técnica, sin tipografía mono. Sigue en uso en listados |
| ProjectCardCompact | `src/components/ProjectCardCompact.astro` | DEPRECADO | Versión compacta de ProjectCard usada en FeaturedProjectsCarousel | FeaturedProjectsCarousel deprecado; este componente ya no se importa |
| ProjectGallery | `src/components/ProjectGallery.astro` | LEGACY | Galería de imágenes dentro de `/proyectos/[slug]` con lightbox | Pre-rediseño, sin integración con tokens del sistema |
| RecursosSectionH3 | `src/components/RecursosSectionH3.astro` | DEPRECADO | "Tag Grid" para sección de recursos en home. Reemplazada por TechnicalCatalog | Ya no se importa en `index.astro` |
| ServiceCard | `src/components/ServiceCard.astro` | DEPRECADO | Card de servicio (legacy). Reemplazada por inline `.svc-card` en `index.astro` y `/servicios` con video, metrics, features | Ya no se importa en ninguna página activa |
| ServiceSection | `src/components/ServiceSection.astro` | LEGACY | Sección de detalle de servicio con galería + features + CTA (usado en `/servicios/piping` y `/servicios/revestimientos`) | Pre-rediseño; no usa label técnica ni headline oversized |
| StatsBar | `src/components/StatsBar.astro` | DEPRECADO | Barra de estadísticas animadas (legacy). Reemplazada por ISO status bar (home) y stats inline hero (`DESIGN.md §7.2`, servicios) | Ya no se importa en ninguna página activa |

---

## 3. Componente canónico: CTASection

### 3.1 Ubicación
`src/components/CTASection.astro`

### 3.2 Dependencias
- `@paper-design/shaders` → `ShaderMount`, `meshGradientFragmentShader`, `getShaderColorFromString`
- `gsap` + `gsap/SplitText` + `gsap/ScrollTrigger`
- `TechLabel.astro` — label técnica (global `.kronos-meta*` classes)
- `BlueprintGrid.astro` — grid decorativo (global `.kronos-blueprint` class)
- Global `.btn-kronos-primary` / `.btn-kronos-outline` from `global.css`
- CSS scoped propio para: overlay, shader layer, headline, sub, actions, footer técnico
- Tokens consumidos: `--color-primary-dark`, `--font-sans`, `--font-heading` (con fallback inline `#052650`, `#FF5B00` en CSS — ver §3.6 Inconsistencias)

### 3.3 Anatomía (4 capas)

```
<section class="snap-section cta-wow ..." aria-label="Contacto">
  ├── LAYER 1 — Shader canvas (z-0)           → [data-cta-shader] .cta-shader-layer
  ├── LAYER 2 — Overlay gradient (z-10)       → .cta-overlay
  ├── LAYER 3 — Grid blueprint decorativo     → <BlueprintGrid class="z-10" /> (.kronos-blueprint global)
  └── LAYER 4 — Contenido (z-20)              → .cta-content > .cta-inner
        ├── <TechLabel>    (◆ tick + LABEL + divider + coord) (.kronos-meta* global)
        ├── .cta-headline  (clamp 3rem→8rem uppercase) con .cta-line y .cta-line--accent
        ├── .cta-sub       (clamp 1rem→1.25rem, rgba white 0.6, max-width 52ch)
        ├── .cta-actions   (.btn-kronos-primary + .btn-kronos-outline — global desde global.css)
        └── .cta-footer    (metadata técnica con .cta-footer__dot separadores)
</section>
```

### 3.4 Subcomponentes internos (patrones copiables)

Cada uno es un patrón visual del sistema. Cuando necesites replicar UNO de estos en otro componente, copia el HTML + el CSS scoped desde `CTASection.astro`.

#### Label técnica (`<TechLabel>` / `.kronos-meta*`)
- **Qué es.** Bloque `◆ LABEL ─── coordenada` que abre secciones hero/CTA.
- **Cómo usar.** `<TechLabel label="PORTADA" coord="-33.28°S / -70.87°W" />`. No copiar CSS — las clases `.kronos-meta*` son globales en `global.css`. El texto de `label` es libre y contextual (ej. `CONTACTO`, `SERVICIOS`, `CATÁLOGO`).
- **Especificaciones.** `◆` 10px accent; label Geist Mono 11px uppercase `letter-spacing: 0.3em` `rgba(255,255,255,0.85)`; divider 60px × 1px `rgba(255,255,255,0.2)`; coord Geist Mono 11px `rgba(255,255,255,0.4)`. Divider + coord hidden on mobile `< 768px`.

#### Headline oversized (`.cta-headline`)
- **Qué es.** Titular con `font-size: clamp(3rem, 10vw, 8rem)`, uppercase, `letter-spacing: -0.02em`, `line-height: 0.95`, con última línea en accent.
- **Dónde copiar.** `.cta-headline`, `.cta-line`, `.cta-line--accent`, más el global `:global(.cta-split-line)` que GSAP SplitText genera.
- **Cuándo usar.** Como headline principal de cualquier sección hero/CTA.
- **Importante.** Si hay GSAP SplitText, NO añadir `data-reveal` al mismo elemento (ver `anti-patterns.md §Animación`). En mobile baja a `clamp(2.5rem, 13vw, 4rem)`.

#### Botón primario shimmer (`.btn-kronos-primary`)
- **Qué es.** Botón accent con sweep diagonal blanco (gradient 115°) en hover + `kronos-glow-pulse` respirando en reposo (3.5s ease-in-out infinite).
- **Clases globales** (en `global.css`): `.btn-kronos-primary`, `.btn-kronos-primary__label`, `.btn-kronos-primary__arrow`, `::before`, `@keyframes kronos-glow-pulse`. No copiar — ya son globales. Mobile: full-width automático `< 768px`. Reduced-motion: todas las animaciones desactivadas.
- **Cuándo usar.** Como CTA primario (máximo 1 por sección).
- **NO usar** el componente legacy `<Button variant="primary">`.

#### Botón outline liquid fill (`.btn-kronos-outline`)
- **Qué es.** Botón outline con fill blanco que sube vía `clip-path: ellipse(120% 0% at 50% 100%)` → `ellipse(140% 160% at 50% 100%)` en hover. Texto cambia a `#083A75`.
- **Clases globales** (en `global.css`): `.btn-kronos-outline`, `.btn-kronos-outline__fill`, `.btn-kronos-outline__label`. No copiar — ya son globales.
- **Cuándo usar.** Como CTA secundario, normalmente pareado con el primario.

#### Footer técnico (`.cta-footer`)
- **Qué es.** Fila horizontal de metadata `KRONOS MINING · SANTIAGO, CHILE ● ISO 9001 / 14001 / 45001 ● EST. 2016` en Geist Mono 10px uppercase `letter-spacing: 0.25em`.
- **Dónde copiar.** `.cta-footer`, `.cta-footer__dot` (dots en `rgba(255,120,0,0.6)` 6px).
- **Cuándo usar.** Máximo **una vez por página** — en la sección CTA final o en el footer global. No añadir en secciones intermedias donde la metadata corporativa ya es visible en otra parte de la misma página. Ver `anti-patterns.md §Componentes → Metadata corporativa como relleno`.

### 3.5 Scripts asociados

Los scripts TypeScript al final del componente gestionan:

1. **`initCTAShader()`** — `IntersectionObserver` con `rootMargin: '200px 0px'`, `threshold: 0.1`. Monta `ShaderMount` con `meshGradientFragmentShader` y 4 colores (`#052650`, `#083A75`, `#0A4C95`, `#FF5B00`). Desactivado si `prefers-reduced-motion` o `window.innerWidth < 768`.
2. **`initCTAAnimations()`** — `SplitText` del headline en líneas (`linesClass: 'cta-split-line'`), luego `ScrollTrigger` con `start: 'top 75%'`, `once: true`, reveal con `yPercent: 110 → 0`, `blur 10px → 0`, stagger 0.14s, `power3.out`. Sub y actions reveal con delay 0.5s / 0.7s. Fallback reduced-motion: `gsap.set` al estado final.
3. **Ciclo de vida Astro View Transitions.** Re-init en `astro:page-load`, cleanup en `astro:before-swap` (`destroyCTAShader`, `splitInstance.revert()`, `ScrollTrigger.getAll().filter(...).kill()`).

Cuando copies patrones del canónico a otro componente, replica también el manejo de ciclo de vida. Detalles en `design/animations.md`.

### 3.6 Estado de alineación con tokens

El componente canónico fue actualizado (2026-04-07) para usar `var(--site-gutter)` en `.cta-inner` para el gutter horizontal, alineado con el patrón obligatorio de contenedor (tokens.md §3.2, variante A). El padding horizontal se movió de `.cta-content` (outer full-width) a `.cta-inner` (inner max-width).

**Inconsistencia remanente.** El componente **hardcodea valores hex** (`#FF5B00`, `#052650`, `#083A75`, `#0A4C95`, `#ffffff`) en el CSS scoped para headline, sub, y footer. Los colores de botones usan `var(--color-*)` correctamente (promovidos a `global.css` 2026-04-06). Los hex coinciden con `@theme` pero violan parcialmente el anti-pattern de "inventar colores fuera del `@theme`" en la forma.

**Excepción legítima.** El shader (`initCTAShader`) requiere hex literales porque Paper Shaders parsea strings a uniforms WebGL — CSS custom properties no se pueden resolver en runtime JS.

---

## 4. Plan de migración LEGACY → ALINEADO

Componentes LEGACY restantes y prioridad sugerida. Los componentes marcados DEPRECADO en §2 ya fueron reemplazados por patrones inline en el home (2026-04-06) y pueden eliminarse en una sesión de limpieza.

| # | Componente | Uso actual | Prioridad | Qué habría que cambiar |
|---|---|---|---|---|
| 1 | Button.astro | Header, páginas de servicios/recursos/contacto | **Alta** | Migrar cada `<Button>` restante a clases globales `.btn-kronos-*`. Hero y TechnicalCatalog ya migrados |
| 2 | Header.astro | Todas las páginas (BaseLayout) | **Alta** | Usar `<TechLabel>` (◆ KRONOS SYSTEM ─── coord), tipografía Geist Mono en nav, remover `rounded-lg` + `bg-white/15`, eliminar import de `Button.astro` |
| 3 | Footer.astro | Todas las páginas (BaseLayout) | **Alta** | Incorporar footer técnico estilo CTASection (KRONOS · SANTIAGO ● ISO ● EST. 2016), consumir `var(--color-primary-dark)` en vez de `bg-neutral-900`, tipografía mono para labels de columna |
| 4 | ServiceSection | `/servicios/piping`, `/servicios/revestimientos` | Media | Estructura actual eyebrow/title/description → migrar a `<TechLabel>` + headline oversized con accent |
| 5 | ProjectCard | `/proyectos` y filtros | Media | Migrar badges `bg-accent` / `bg-primary` a labels mono uppercase con dots, remover `rounded-xl + shadow-card`, añadir meta técnica (project ID + location en mono) |
| 6 | ArticleCard | `/recursos` y filtros | Media | Igual que ProjectCard: labels mono en lugar de pills redondeadas, meta técnica, borders en lugar de shadows |
| 7 | ContactCard | Página `/contacto` | Baja | Integrar `<TechLabel>` (nombre + rol en mono), footer técnico con canales |
| 8 | ProjectGallery | `/proyectos/[slug]` | Baja | Página interna editorial, prioridad baja; basta con integrar captions en Geist Mono |
| 9 | LogoCarousel | Home (clientes/partners) | Baja | Añadir `<TechLabel>` sobre la fila, marquee actual es estéticamente neutro |

**Nota.** Este plan no se ejecuta automáticamente. Cada migración es una sesión separada.

### 4.1 Componentes DEPRECADOS — pendientes de eliminación

Estos componentes fueron reemplazados durante el rediseño del home (2026-04-06). Sus reemplazos son patrones inline en `index.astro` o componentes globales nuevos. Pueden eliminarse cuando se confirme que ninguna otra página los importa.

| Componente | Reemplazado por | Páginas que aún podrían usarlo |
|---|---|---|
| AllianceCard | Inline `.alcance-card` en index.astro | Ninguna confirmada |
| FeaturedProjectsCarousel | TechnicalCatalog | Ninguna confirmada |
| Globe3DBlueprint | Globe3D (base) es la versión activa | Solo `test-globe*.astro` |
| Globe3DGithub | Globe3D (base) es la versión activa | Solo `test-globe*.astro` |
| Globe3DHolo | Globe3D (base) es la versión activa | Solo `test-globe*.astro` |
| IndustriesSection | Inline `.alcance-industria` grid en index.astro | Verificar `/industrias` si existe |
| IndustryCard | Inline grid en slide 3 | Verificar `/industrias` si existe |
| ProjectCardCompact | N/A (dependía de FeaturedProjectsCarousel) | Ninguna confirmada |
| RecursosSectionH3 | TechnicalCatalog | Ninguna confirmada |
| ServiceCard | Inline `.svc-card` en index.astro y `/servicios` | Ninguna confirmada |
| StatsBar | ISO status bar (home) + stats inline hero (servicios) | Ninguna confirmada |

**Sesión de limpieza recomendada:** eliminar archivos DEPRECADOS + páginas de test (`test-globe.astro`, `test-globe-debug.astro`, `test-cards.astro`, `test-iso.astro`).

### 4.2 Migración de gutter horizontal a `--site-gutter`

Componentes y páginas que aún usan `px-6`, `1.5rem` o `3rem` hardcodeados como gutter horizontal en lugar de `var(--site-gutter)`. No son LEGACY en el sentido visual, pero tienen deuda técnica de alineación.

**Confirmados (auditados 2026-04-07):**

| Página / componente | Estado actual | Qué cambiar |
|---|---|---|
| `Footer.astro` | `px-4 sm:px-6 lg:px-8` (2rem desktop, debería ser 3rem) | Migrar inner div a `padding-inline: var(--site-gutter)` |
| `/contacto` | Secciones con `px-6` fijo (1.5rem en todos los breakpoints) | Migrar a `var(--site-gutter)` en CSS scoped |
| `/recursos/[...page].astro` | Hero y secciones con `px-6` fijo | Migrar a `var(--site-gutter)` |
| `/recursos/[slug].astro` | `<article>` con `px-6` fijo | Migrar a `var(--site-gutter)` |
| `/recursos/categoria/` | Secciones con `px-6` fijo | Migrar a `var(--site-gutter)` |
| `/proyectos/[...page].astro` | Hero y secciones con `px-6` fijo | Migrar a `var(--site-gutter)` |
| `/proyectos/servicio/` | Secciones con `px-6` fijo | Migrar a `var(--site-gutter)` |

**Prioridad:** baja. Las páginas de servicios (piping, revestimientos, index) y el home ya están migradas. El Footer es el más visible de los pendientes.

---

## 6. Reglas de creación de componentes nuevos

1. **Antes de crear**, buscar en §2 si ya existe algo similar. Si existe → extender o copiar.
2. **Si no existe**, leer `CTASection.astro` completo y extraer los patrones relevantes (label técnica, headline oversized, botones, footer técnico).
3. **Nombrado de clases CSS.** `kronos-[componente]-[parte]-[variante]` en kebab-case, o seguir el prefijo del canónico (`cta-*` / `btn-kronos-*`) si es una variante directa.
4. **CSS scoped** en el mismo archivo `.astro` (no en `global.css`), salvo que el patrón se repita en 3+ componentes — entonces promover a global.
5. **Tokens siempre vía `var(--color-*)` y `var(--font-*)`**, no hex literales (ver §3.6).
6. **Registrar el componente nuevo en este archivo (§2) en el mismo commit que lo crea** — es regla del sistema (anti-patterns.md §Arquitectura).
7. **Estado inicial.** `ALINEADO` si se basó en el canónico, o `CANÓNICO` solo si reemplaza al existente (requiere aprobación explícita del usuario).

---

## 7. Cuándo un componente debería ser `DEPRECADO`

- Su lógica funcional fue reemplazada por otro componente ya ALINEADO.
- Su estética contradice el sistema y no vale la pena migrar (más fácil recrear desde canónico).
- Lleva más de 3 meses sin usarse en ninguna página activa.
- Es una variante experimental que perdió contra otra (caso Globe3D*).

**Procedimiento.** Marcar como `DEPRECADO` en §2, migrar todos los usos al reemplazo, eliminar archivo en una sesión de limpieza dedicada.

---

**Última actualización:** 2026-04-07 (site gutter unificado `--site-gutter`, CTASection §3.6 actualizado, ServiceSubNav registrado, migración §4.2 de gutter pendiente documentada)
**Componente canónico vigente:** `src/components/CTASection.astro`
