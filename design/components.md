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
| **CTASection** | `src/components/CTASection.astro` | **CANÓNICO** | Sección final CTA del home con shader WebGL, label técnica SISTEMA 05, headline oversized uppercase, botones shimmer + liquid fill, footer técnico con dots | Referencia maestra — cualquier rediseño consulta aquí primero |
| AnalyticsHead | `src/components/AnalyticsHead.astro` | UTILITARIO | Inyecta scripts de Microsoft Clarity, Cloudflare Analytics y verificación GSC en `<head>` | Sin UI visible |
| FloatingCTA | `src/components/FloatingCTA.astro` | UTILITARIO | Botón flotante de WhatsApp (color de marca `#25D366` permitido por ser logo de terceros) | Color `#25D366` es excepción documentada (marca WhatsApp) |
| Pagination | `src/components/Pagination.astro` | UTILITARIO | Controles de paginación para listados (`/recursos`, `/proyectos`) | Visual neutro, no requiere alinear al lenguaje hero/CTA |
| ReadingProgressBar | `src/components/ReadingProgressBar.astro` | UTILITARIO | Barra de progreso de lectura fija bajo el header en artículos | Usa `bg-accent`, correcto con el sistema |
| ScrollReveal | `src/components/ScrollReveal.astro` | UTILITARIO | Wrapper global de IntersectionObserver para `[data-reveal]`. Incluido en `BaseLayout` | No aplicar junto con GSAP SplitText en el mismo elemento (anti-patterns.md) |
| SearchBar | `src/components/SearchBar.astro` | UTILITARIO | Input de búsqueda con integración Pagefind (`is:inline` script) | Visual neutro |
| ShareButtons | `src/components/ShareButtons.astro` | UTILITARIO | Botones sociales (LinkedIn, WhatsApp, email) para artículos | Usa iconos SVG, no aplica lenguaje hero |
| TableOfContents | `src/components/TableOfContents.astro` | UTILITARIO | TOC generado desde headings de artículos de blog | Lectura editorial, no aplica lenguaje hero/CTA |
| AllianceCard | `src/components/AllianceCard.astro` | LEGACY | Card de alianza internacional con logo, país (SVG flag), descripción y tags | Pre-rediseño: rounded-xl + shadow-card, tipografía Instrument pero sin labels técnicas ni tracking industrial |
| ArticleCard | `src/components/ArticleCard.astro` | LEGACY | Card para artículos de `/recursos` con imagen + categoría accent + meta | Pre-rediseño: rounded-xl + shadow-card, hover translate-y, usa badges `bg-accent` en lugar de label técnica |
| Button | `src/components/Button.astro` | **LEGACY** | Botón genérico con 8 variantes (`primary`, `secondary`, `outline`, `ghost`, `white`, `whatsapp`, `primary-solid`, `link`) y 4 sizes | **No usar en secciones nuevas.** Copiar `.btn-kronos-primary` / `.btn-kronos-outline` desde CTASection. Ver anti-patterns.md §Componentes |
| ContactCard | `src/components/ContactCard.astro` | LEGACY | Tarjeta de contacto con foto, WhatsApp, email, LinkedIn y QR | Pre-rediseño; no aplica label técnica ni footer técnico |
| FeaturedProjectsCarousel | `src/components/FeaturedProjectsCarousel.astro` | LEGACY | Carousel horizontal de proyectos destacados sobre `bg-primary-dark` | Usa `bg-primary-dark` correctamente pero sin label técnica ni headline oversized; header plano |
| Footer | `src/components/Footer.astro` | LEGACY | Footer global 4-col desktop sobre `bg-neutral-900` | No incorpora footer técnico tipo CTASection (KRONOS MINING · LOCATION ● CERTS ● EST. 2016); tipografía estándar sin tracking Geist Mono |
| Globe3D | `src/components/Globe3D.astro` | LEGACY | Globo terráqueo 3D holográfico con conexiones Chile-Alemania-España (three.js CDN) | Se alinea con estética defense-tech pero no consume tokens del sistema ni integra labels técnicas |
| Globe3DBlueprint | `src/components/Globe3DBlueprint.astro` | [?] | Variante de Globe3D (estilo blueprint) | Uno de 4 Globe3D*, pendiente decidir cuál queda canónico y cuáles DEPRECADOS |
| Globe3DGithub | `src/components/Globe3DGithub.astro` | [?] | Variante de Globe3D (estilo GitHub globe) | Posible DEPRECADO tras decisión de cuál Globe3D queda |
| Globe3DHolo | `src/components/Globe3DHolo.astro` | [?] | Variante de Globe3D (estilo holográfico) | Posible DEPRECADO tras decisión de cuál Globe3D queda |
| Header | `src/components/Header.astro` | LEGACY | Header sticky con logo, navegación desktop y hamburger mobile | Importa `Button.astro` (legacy). No usa label técnica, tipografía estándar, rounded-lg en lugar del lenguaje industrial |
| IndustriesSection | `src/components/IndustriesSection.astro` | LEGACY | Sección de industrias atendidas con cards y CTA opcional | Usa eyebrow/title/subtitle pero no label técnica SISTEMA NN |
| IndustryCard | `src/components/IndustryCard.astro` | LEGACY | Card individual de industria con icono, imagen, conteo de proyectos | Estética pre-rediseño (cards suaves con shadow), sin labels técnicas |
| LogoCarousel | `src/components/LogoCarousel.astro` | LEGACY | Carousel auto-scroll de logos de clientes/partners | Marquee genérico, sin label técnica ni integración con el sistema industrial |
| ProjectCard | `src/components/ProjectCard.astro` | LEGACY | Card de proyecto con imagen, tags (servicio) + industria, location + cliente | Pre-rediseño: rounded-xl, shadow-card, badges `bg-accent`/`bg-primary` — no label técnica, sin tipografía mono |
| ProjectCardCompact | `src/components/ProjectCardCompact.astro` | LEGACY | Versión compacta de ProjectCard usada en FeaturedProjectsCarousel | Mismo lenguaje legacy que ProjectCard |
| ProjectGallery | `src/components/ProjectGallery.astro` | LEGACY | Galería de imágenes dentro de `/proyectos/[slug]` con lightbox | Pre-rediseño, sin integración con tokens del sistema |
| RecursosSectionH3 | `src/components/RecursosSectionH3.astro` | LEGACY | "Tag Grid" featured + secondary para sección de recursos en home | Pre-rediseño aunque usa pill pattern y overlay azul (correcto); no usa label SISTEMA NN ni headline oversized |
| ServiceCard | `src/components/ServiceCard.astro` | LEGACY | Card de servicio con imagen + overlay azul + icono Material + título uppercase + features | Tiene `inline style="background-color: rgba(8, 58, 117, 0.7)"` (anti-pattern inline style) y depende de Material Symbols. Parcialmente alineado por el overlay azul + uppercase |
| ServiceSection | `src/components/ServiceSection.astro` | LEGACY | Sección de detalle de servicio con galería + features + CTA (usado en `/servicios/piping` y `/servicios/revestimientos`) | Pre-rediseño; no usa label técnica ni headline oversized |
| StatsBar | `src/components/StatsBar.astro` | LEGACY | Barra de estadísticas animadas (contadores, "días sin accidentes") | Pre-rediseño; podría alinearse al sistema con footer técnico / labels mono |
| TechnicalCatalog | `src/components/TechnicalCatalog.astro` | LEGACY | Catálogo unificado buscable de proyectos + artículos, 2-col narrativa + rich rows | Importa `Button.astro` legacy. Comment header indica "Unified searchable catalog" en inglés — revisar |

---

## 3. Componente canónico: CTASection

### 3.1 Ubicación
`src/components/CTASection.astro`

### 3.2 Dependencias
- `@paper-design/shaders` → `ShaderMount`, `meshGradientFragmentShader`, `getShaderColorFromString`
- `gsap` + `gsap/SplitText` + `gsap/ScrollTrigger`
- CSS scoped propio (no global)
- Tokens consumidos: `--color-primary-dark`, `--font-sans`, `--font-heading` (con fallback inline `#052650`, `#FF5B00` en CSS — ver §3.6 Inconsistencias)

### 3.3 Anatomía (4 capas)

```
<section class="snap-section cta-wow ..." aria-label="Contacto">
  ├── LAYER 1 — Shader canvas (z-0)           → [data-cta-shader] .cta-shader-layer
  ├── LAYER 2 — Overlay gradient (z-10)       → .cta-overlay
  ├── LAYER 3 — Grid blueprint decorativo     → .cta-grid (z-10, opacity 0.04)
  └── LAYER 4 — Contenido (z-20)              → .cta-content > .cta-inner
        ├── .cta-meta      (◆ tick + SISTEMA 05 label + divider 60px + coord)
        ├── .cta-headline  (clamp 3rem→8rem uppercase) con .cta-line y .cta-line--accent
        ├── .cta-sub       (clamp 1rem→1.25rem, rgba white 0.6, max-width 52ch)
        ├── .cta-actions   (primary .btn-kronos-primary + outline .btn-kronos-outline)
        └── .cta-footer    (metadata técnica con .cta-footer__dot separadores)
</section>
```

### 3.4 Subcomponentes internos (patrones copiables)

Cada uno es un patrón visual del sistema. Cuando necesites replicar UNO de estos en otro componente, copia el HTML + el CSS scoped desde `CTASection.astro`.

#### Label técnica (`.cta-meta`)
- **Qué es.** Bloque `◆ SISTEMA NN — NOMBRE ─── coordenada` que abre secciones hero/CTA.
- **Dónde copiar.** `CTASection.astro` clases `.cta-meta`, `.cta-tick`, `.cta-label`, `.cta-divider`, `.cta-coord`.
- **Cuándo usar.** Al inicio de cualquier sección hero o CTA del sistema.
- **Catálogo SISTEMA NN.** Ver `DESIGN.md §6` (01 Hero, 02 Servicios, 03 Global/Alianzas, 04 Catálogo, 05 Contacto/CTA, páginas internas incrementales).
- **Especificaciones.** `◆` 10px accent; label Geist Mono 11px uppercase `letter-spacing: 0.3em` `rgba(255,255,255,0.85)`; divider 60px × 1px `rgba(255,255,255,0.2)`; coord Geist Mono 11px `rgba(255,255,255,0.4)`.

#### Headline oversized (`.cta-headline`)
- **Qué es.** Titular con `font-size: clamp(3rem, 10vw, 8rem)`, uppercase, `letter-spacing: -0.02em`, `line-height: 0.95`, con última línea en accent.
- **Dónde copiar.** `.cta-headline`, `.cta-line`, `.cta-line--accent`, más el global `:global(.cta-split-line)` que GSAP SplitText genera.
- **Cuándo usar.** Como headline principal de cualquier sección hero/CTA.
- **Importante.** Si hay GSAP SplitText, NO añadir `data-reveal` al mismo elemento (ver `anti-patterns.md §Animación`). En mobile baja a `clamp(2.5rem, 13vw, 4rem)`.

#### Botón primario shimmer (`.btn-kronos-primary`)
- **Qué es.** Botón accent con sweep diagonal blanco (gradient 115°) en hover + `cta-glow-pulse` respirando en reposo (3.5s ease-in-out infinite).
- **Dónde copiar.** `.btn-kronos-primary`, `.btn-kronos-primary__label`, `.btn-kronos-primary__arrow`, `::before`, `@keyframes cta-glow-pulse`.
- **Cuándo usar.** Como CTA primario (máximo 1 por sección).
- **NO usar** el componente legacy `<Button variant="primary">` — copiar estas clases directamente.

#### Botón outline liquid fill (`.btn-kronos-outline`)
- **Qué es.** Botón outline con fill blanco que sube vía `clip-path: ellipse(120% 0% at 50% 100%)` → `ellipse(140% 160% at 50% 100%)` en hover. Texto cambia a `#083A75`.
- **Dónde copiar.** `.btn-kronos-outline`, `.btn-kronos-outline__fill`, `.btn-kronos-outline__label`.
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

### 3.6 Inconsistencias detectadas entre CTASection y tokens.md

Al leer el código real, el componente **hardcodea valores hex** (`#FF5B00`, `#052650`, `#083A75`, `#0A4C95`, `#ffffff`) en el CSS scoped en lugar de consumir `var(--color-*)`. También usa fallback `var(--font-heading, 'Geist Mono', ...)` lo cual es correcto, pero los colores no siguen la misma regla.

**No es un defecto funcional** — los hex coinciden con `@theme`. Pero viola parcialmente el anti-pattern de "inventar colores fuera del `@theme`" en la forma (aunque no en el fondo). Al replicar el canónico en componentes nuevos, **preferir `var(--color-*)`** sobre hex literales.

---

## 4. Plan de migración LEGACY → ALINEADO

Componentes LEGACY detectados y prioridad sugerida de migración. Ejecutar cada migración como una sesión separada con el skill `rediseño`.

| # | Componente | Uso actual | Prioridad | Qué habría que cambiar |
|---|---|---|---|---|
| 1 | Button.astro | Hero legacy, Header, TechnicalCatalog, páginas de servicios/recursos/contacto | **Alta** | Preservar API (`variant`, `size`, `arrow`) pero redirigir internamente a las clases `.btn-kronos-*`. Alternativa: marcar DEPRECADO y migrar cada `<Button>` a clases inline caso por caso |
| 2 | Header.astro | Todas las páginas (BaseLayout) | **Alta** | Añadir label técnica (◆ KRONOS SYSTEM ─── coord), tipografía Geist Mono en nav, remover `rounded-lg` + `bg-white/15`, eliminar import de `Button.astro` |
| 3 | Footer.astro | Todas las páginas (BaseLayout) | **Alta** | Incorporar footer técnico estilo CTASection (KRONOS · SANTIAGO ● ISO ● EST. 2016), consumir `var(--color-primary-dark)` en vez de `bg-neutral-900`, tipografía mono para labels de columna |
| 4 | FeaturedProjectsCarousel | Home `/` | Alta | Añadir label SISTEMA 0X, headline oversized uppercase con accent en última palabra, cards con lenguaje industrial (remover shadow-card, integrar borders blueprint) |
| 5 | RecursosSectionH3 | Home `/` | Alta | Label SISTEMA 0X, headline oversized, featured card con overlay tipo CTA, secondary cards con labels mono en lugar de pills rounded |
| 6 | ServiceCard | Home + `/servicios` | Media | Remover `style="background-color: ..."` inline (anti-pattern), migrar a `bg-primary/70`, añadir label mono para categoría en lugar de icono Material centrado, eliminar `rounded-xl + shadow-card` |
| 7 | ServiceSection | `/servicios/piping`, `/servicios/revestimientos` | Media | Estructura actual eyebrow/title/description → migrar a label técnica SISTEMA NN + headline oversized con `.cta-line--accent` |
| 8 | ProjectCard | `/proyectos` y filtros | Media | Migrar badges `bg-accent` / `bg-primary` a labels mono uppercase con dots, remover `rounded-xl + shadow-card`, añadir meta técnica (project ID + location en mono) |
| 9 | ArticleCard | `/recursos` y filtros | Media | Igual que ProjectCard: labels mono en lugar de pills redondeadas, meta técnica, borders en lugar de shadows |
| 10 | IndustriesSection | Home + páginas de industria | Media | Label SISTEMA NN + headline oversized. La sección ya soporta eyebrow/title/subtitle, por lo que la migración es mapeo directo |
| 11 | IndustryCard | Sección de industrias | Media | Similar a ServiceCard: overlay azul + label mono + remover shadows suaves |
| 12 | AllianceCard | Sección alianzas | Media | Reemplazar pills de tags por labels mono con dots, mantener bandera SVG pero integrarla como coordenada técnica |
| 13 | TechnicalCatalog | Página de catálogo técnico | Media | Eliminar import de Button legacy, revisar comment header en inglés, labels mono para categorías |
| 14 | ContactCard | Página `/contacto` | Baja | Integrar label técnica (nombre + rol en mono), footer técnico con canales |
| 15 | ProjectCardCompact | FeaturedProjectsCarousel | Baja | Se migrará automáticamente cuando se migre ProjectCard (mismo lenguaje) |
| 16 | ProjectGallery | `/proyectos/[slug]` | Baja | Página interna editorial, prioridad baja; basta con integrar captions en Geist Mono |
| 17 | StatsBar | Home + páginas de servicios | Baja | Labels de stats en Geist Mono uppercase, dots accent como separadores, sin cambios estructurales mayores |
| 18 | LogoCarousel | Home (clientes/partners) | Baja | Añadir label SISTEMA NN sobre la fila, marquee actual es estéticamente neutro |
| 19 | Globe3D (+ variantes) | Sección global/alianzas | Baja | Primero decidir cuál de las 4 variantes queda canónica — ver §5. Luego integrar con label SISTEMA 03 alrededor del canvas |

**Nota.** Este plan no se ejecuta automáticamente. Cada migración es una sesión separada. El orden de prioridad es sugerido por impacto visual (componentes globales que afectan todas las páginas primero).

---

## 5. Componentes en estado `[?]` — Pendientes de clasificación

| Componente | Razón |
|---|---|
| Globe3DBlueprint | Existen 4 variantes de Globe3D (base + Blueprint + Github + Holo). No queda claro cuál está en uso real en producción ni cuál es la referencia oficial. **Acción:** verificar qué archivo importa cada página del home (probablemente `src/pages/index.astro` o una página de test). Marcar una como ALINEADO y las restantes como DEPRECADO |
| Globe3DGithub | Mismo problema. Posible sobrante de experimentación |
| Globe3DHolo | Mismo problema. Posible sobrante de experimentación |

**Observación adicional.** En `src/pages/` aparecen páginas de test (`test-globe.astro`, `test-globe-debug.astro`, `test-cards.astro`, `test-iso.astro`) que probablemente consumen estas variantes. Una sesión de limpieza debería eliminar páginas de test + variantes no usadas.

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

**Última actualización:** 2026-04-04 (creación inicial)
**Componente canónico vigente:** `src/components/CTASection.astro`
