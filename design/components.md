# Catálogo de componentes — Kronos Mining

> Inventario operativo de componentes `.astro` del sistema. Estado, propósito, canónico de
> referencia y migraciones pendientes. Cuando construyas UI nueva, consulta este archivo
> **antes** de inventar estructura propia.
>
> **Regla cardinal (desde el 20-nov-2026).** La fuente de verdad visual es el **kit del estándar** de
> kronos-web: `src/styles/ESTANDAR.md` (reglas), `src/styles/estandar.css` (clases `k-*` y fichas),
> `PageHero.astro` (abre toda página interior), `CTASection.astro` (la cierra) y `PageTransition.astro`
> (cambio de página). La referencia de este repo es `reference/astro/CTASection.astro`. Cualquier
> componente nuevo o rediseño parte de ahí — ver `skills/rediseño/SKILL.md` y `DESIGN.md §10`.

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
| **CTASection** | `src/components/CTASection.astro` | **CANÓNICO** | Cierre de toda página: etiqueta mono → titular tipo oración (`k-h2`) → bajada → botones → una línea de datos de la empresa, sobre `k-sec` con la grilla de dibujo | Referencia oficial: `reference/astro/CTASection.astro`. Sin fondo animado ni revelado por línea desde el 20-nov-2026 |
| **PageHero** | `src/components/PageHero.astro` | **CANÓNICO** | Apertura de toda página interior: ruta → etiqueta → `k-h1` → `k-lede`; opcional, foto real con rótulo o línea de datos | 5IN-827 la lleva a proyectos, artículos, servicios y materiales |
| **PageTransition** | `src/components/PageTransition.astro` | **CANÓNICO** | Cambio de página (patrón 1 de `design/animations.md`): la barra queda, la página se vuelve tarjeta | Regla 14b de `ESTANDAR.md` (kronos-web) |
| **TechLabel** | `src/components/TechLabel.astro` | **ALINEADO** | Etiqueta técnica `◆ LABEL`. Props: `label` (required), `coord?` solo para un dato real | Consume `.kronos-meta*` de `global.css`. Extraído del patrón repetido 5× en CTASection + index.astro + TechnicalCatalog |
| **BlueprintGrid** | `src/components/BlueprintGrid.astro` | **ALINEADO** | Grid blueprint decorativo (background) para secciones oscuras. Props: `class?` | Consume `.kronos-blueprint` de `global.css`. Extraído del patrón repetido 5× en el home |
| TechnicalCatalog | `src/components/TechnicalCatalog.astro` | DEPRECADO | Catálogo técnico de abril, con revelado por línea y cifras que cuentan. Ninguna página lo importa | Se borra en 5IN-825 |
| ServiceSubNav | `src/components/ServiceSubNav.astro` | **ALINEADO** | Sub-navegación sticky para páginas de servicio. IntersectionObserver para highlight de sección activa + smooth scroll. Props: `items`, `navId`, `sectionClass`, `ariaLabel?` | Instrument Sans 11px/600/0.12em uppercase (no Geist Mono — es navegación, no metadata). Underline accent 1px activo. Depende de header height hardcodeado (`top: 4rem`/`5rem`). Consume `--site-gutter`. Extraído de piping + revestimientos (2026-04-07) |
| AnalyticsHead | `src/components/AnalyticsHead.astro` | UTILITARIO | Inyecta scripts de Microsoft Clarity, Cloudflare Analytics y verificación GSC en `<head>` | Sin UI visible |
| FloatingCTA | `src/components/FloatingCTA.astro` | UTILITARIO | Botón flotante de WhatsApp (color de marca `#25D366` permitido por ser logo de terceros) | Color `#25D366` es excepción documentada (marca WhatsApp) |
| Pagination | `src/components/Pagination.astro` | UTILITARIO | Controles de paginación para listados (`/recursos`, `/proyectos`) | Hecha para tema claro: pasa a oscura, mono y de 44 px en 5IN-828 |
| ReadingProgressBar | `src/components/ReadingProgressBar.astro` | UTILITARIO | Barra de progreso de lectura fija bajo el header en artículos | Usa `bg-accent`, correcto con el sistema |
| ScrollReveal | `src/components/ScrollReveal.astro` | UTILITARIO | Wrapper global de IntersectionObserver para `[data-reveal]`. Incluido en `BaseLayout` | Lo reemplaza `src/scripts/movimiento.ts` (patrón 3 de `design/animations.md`, 5IN-825). No usar en piezas nuevas |
| SearchBar | `src/components/SearchBar.astro` | UTILITARIO | Input de búsqueda con integración Pagefind (`is:inline` script) | Visual neutro |
| ShareButtons | `src/components/ShareButtons.astro` | UTILITARIO | Botones sociales (LinkedIn, WhatsApp, email) para artículos | Usa iconos SVG, no aplica lenguaje hero |
| TableOfContents | `src/components/TableOfContents.astro` | UTILITARIO | TOC generado desde headings de artículos de blog | Lectura editorial, no aplica lenguaje hero/CTA |
| AllianceCard | `src/components/AllianceCard.astro` | DEPRECADO | Card de alianza internacional (legacy). Reemplazada por inline `.alcance-card` en `index.astro` | El home ahora usa cards inline con estética Anduril; este componente ya no se importa en ninguna página |
| ArticleCard | `src/components/ArticleCard.astro` | LEGACY | Card para artículos de `/recursos` con imagen + categoría accent + meta | Caja azul claro, etiquetas naranjas, sube al pasar el mouse. La reemplaza la tarjeta única (5IN-828) |
| Button | `src/components/Button.astro` | DEPRECADO | Botón genérico con 8 variantes (`primary`, `secondary`, `outline`, `ghost`, `white`, `whatsapp`, `primary-solid`, `link`) y 4 sizes | **No usar en secciones nuevas.** Usar clases globales `.btn-kronos-primary` / `.btn-kronos-outline` de `global.css`. Ver anti-patterns.md §Componentes. Usa Material Symbols (legacy) — migrar a Lucide Icons, ver `design/icons.md §9` |
| ContactCard | `src/components/ContactCard.astro` | LEGACY | Tarjeta de contacto con foto, WhatsApp, email, LinkedIn y QR | Pre-rediseño; no aplica label técnica ni footer técnico |
| FeaturedProjectsCarousel | `src/components/FeaturedProjectsCarousel.astro` | DEPRECADO | Carousel horizontal de proyectos destacados. Reemplazado por TechnicalCatalog en el home | Ya no se importa en `index.astro` |
| Footer | `src/components/Footer.astro` | LEGACY | Footer global 4-col desktop sobre `bg-neutral-900` | Pasa al azul marino, títulos de columna mono y sin íconos decorativos en 5IN-826 |
| Globe3D | `src/components/Globe3D.astro` | LEGACY | Globo terráqueo 3D holográfico con conexiones Chile-Alemania-España (three.js CDN) | En uso en slide 3 del home como background decorativo. Se alinea con estética defense-tech |
| Globe3DBlueprint | `src/components/Globe3DBlueprint.astro` | DEPRECADO | Variante de Globe3D (estilo blueprint) | No usada — Globe3D (base) es la versión activa en producción |
| Globe3DGithub | `src/components/Globe3DGithub.astro` | DEPRECADO | Variante de Globe3D (estilo GitHub globe) | No usada — Globe3D (base) es la versión activa en producción |
| Globe3DHolo | `src/components/Globe3DHolo.astro` | DEPRECADO | Variante de Globe3D (estilo holográfico) | No usada — Globe3D (base) es la versión activa en producción |
| Header | `src/components/Header.astro` | LEGACY | Barra fija, la misma en todas las páginas; es parte del cambio de página (14b) | Le queda su propia copia del botón principal y los enlaces en sans: 5IN-825 y 5IN-826 |
| IndustriesSection | `src/components/IndustriesSection.astro` | DEPRECADO | Sección de industrias atendidas con cards y CTA opcional. Reemplazada por inline `.alcance-industria` grid en `index.astro` | Ya no se importa en el home |
| IndustryCard | `src/components/IndustryCard.astro` | DEPRECADO | Card individual de industria con icono, imagen, conteo de proyectos. Reemplazada por inline grid en slide 3 | Ya no se importa en ninguna página |
| LogoCarousel | `src/components/LogoCarousel.astro` | DEPRECADO | Carrusel de logos en bucle. Ninguna página lo importa: los logos van en su sección con `h2` (regla 12) | Se borra en 5IN-825 |
| ProjectCard | `src/components/ProjectCard.astro` | LEGACY | Card de proyecto con imagen, tags (servicio) + industria, location + cliente | Caja azul claro, etiquetas naranjas, título en 700. La reemplaza la tarjeta única (5IN-828) |
| ProjectCardCompact | `src/components/ProjectCardCompact.astro` | DEPRECADO | Versión compacta de ProjectCard usada en FeaturedProjectsCarousel | FeaturedProjectsCarousel deprecado; este componente ya no se importa |
| ProjectGallery | `src/components/ProjectGallery.astro` | LEGACY | Galería de imágenes dentro de `/proyectos/[slug]` con lightbox | Pre-rediseño, sin integración con tokens del sistema |
| RecursosSectionH3 | `src/components/RecursosSectionH3.astro` | DEPRECADO | "Tag Grid" para sección de recursos en home. Reemplazada por TechnicalCatalog | Ya no se importa en `index.astro` |
| ServiceCard | `src/components/ServiceCard.astro` | DEPRECADO | Card de servicio (legacy). Reemplazada por inline `.svc-card` en `index.astro` y `/servicios` con video, metrics, features | Ya no se importa en ninguna página activa |
| ServiceSection | `src/components/ServiceSection.astro` | LEGACY | Sección de detalle de servicio con galería + features + CTA (usado en `/servicios/piping` y `/servicios/revestimientos`) | Pre-rediseño; no usa label técnica ni headline oversized |
| StatsBar | `src/components/StatsBar.astro` | DEPRECADO | Barra de estadísticas animadas (legacy). Reemplazada por ISO status bar (home) y stats inline hero (`DESIGN.md §7.2`, servicios) | Ya no se importa en ninguna página activa |

---

## 3. El kit del estándar

### 3.1 Apertura de página: `PageHero.astro`

Ruta (`k-crumb`) → etiqueta (`<TechLabel>`) → `k-h1` (`k-h1--long` si el título es una oración) → `k-lede`.
Opcional: un cuerpo (`page-hero__body`) y un lado (`page-hero__aside`) con una foto real y su rótulo, o una
línea de datos mono. Abre toda página interior.

### 3.2 Sección: `k-sec`

```
<section class="k-sec">                 línea fina superior, en el borde del sitio
  └── .k-sec__inner                     relleno clamp(5rem, 10vw, 9.5rem) · --site-gutter
        ├── header.k-head               <TechLabel> · h2.k-h2 · p.k-lede · a.k-link (a la derecha desde 64rem)
        └── contenido                   lámina de foto, tarjetas, lista técnica, datos (k-spec)
```

### 3.3 Cierre: `CTASection.astro`

```
<section class="k-sec cta" aria-label="Contacto">
  ├── <BlueprintGrid />
  └── .k-sec__inner
        ├── header.k-head               <TechLabel label="CONTACTO" /> · h2.k-h2 · p.k-lede
        ├── .cta__actions               .btn-kronos-primary (SOLICITAR COTIZACIÓN) + .btn-kronos-outline
        ├── .cta__axis                  la línea de eje de la portada, en naranjo
        └── .cta__foot                  una sola línea de datos de la empresa, en mono
</section>
```

Sin fondo animado ni revelado por línea; aparece con el patrón 3 de `design/animations.md`. No lleva
`snap-section`: el ajuste de scroll es solo del home.

### 3.4 Botones

Clases globales de `global.css`; no se copia su CSS.
- `.btn-kronos-primary`: naranjo sólido, uno por vista. Al pasar el mouse oscurece su naranjo y la flecha
  avanza 4 px.
- `.btn-kronos-outline`: contorno blanco que se llena desde abajo al pasar el mouse.

Los dos responden solo cuando se los toca (patrón 5): nada en bucle.

### 3.5 Movimiento

Los 7 patrones y sus fichas están en `design/animations.md`. `PageTransition.astro` es el patrón 1.

### Retirados

El 20-nov-2026 salió la anatomía de abril de `CTASection`: 4 capas con fondo WebGL, titular gigante en
mayúsculas con palabra naranja revelado por línea y botón con brillo en bucle. El detalle está en
`design/animations.md` § Retirados y en el historial de git de este archivo.

---

## 4. Plan de migración (nov 2026)

Lo que falta para que todo el sitio use el kit está en Linear, issue padre 5IN-823:

| Sub-issue | Qué |
|---|---|
| 5IN-825 | Movimiento: los 7 patrones; salen el brillo, los contadores y el giro; se borran TechnicalCatalog, LogoCarousel, Button y ScrollReveal |
| 5IN-826 | Pie y barra |
| 5IN-827 | Aperturas de proyectos, artículos, servicios y materiales con `PageHero` |
| 5IN-828 | Una sola tarjeta (reemplaza ProjectCard y ArticleCard), filtros, paginación y buscador |
| 5IN-829 | Industrias, contacto, legales y 404 |
| 5IN-830 | Títulos de proyectos y artículos en tipo oración |

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
2. **Si no existe**, leer el kit del estándar (§3) y `ESTANDAR.md` de kronos-web, y armar la pieza con sus clases (`k-sec`, `k-head`, `k-h2`, `k-lede`, `k-link`, `k-spec`) y las globales (`<TechLabel>`, `.btn-kronos-*`).
3. **Nombrado de clases CSS.** `kronos-[componente]-[parte]-[variante]` en kebab-case, o seguir el prefijo del canónico (`cta-*` / `btn-kronos-*`) si es una variante directa.
4. **CSS scoped** en el mismo archivo `.astro` (no en `global.css`), salvo que el patrón se repita en 3+ componentes — entonces promover a global.
5. **Tokens siempre vía `var(--color-*)`, `var(--font-*)` y las fichas `--k-*`**, no hex literales (ver `design/tokens.md`).
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

**Última actualización:** 2026-11-20 (5IN-824: el kit del estándar pasa a ser la fuente de verdad; anatomía de abril retirada)
**Kit vigente:** `src/styles/estandar.css` + `PageHero.astro` + `CTASection.astro` + `PageTransition.astro` (kronos-web)
