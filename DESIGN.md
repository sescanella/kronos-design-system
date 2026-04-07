# Kronos Mining — Design System

> **Propósito de este archivo.** Fuente única de verdad del lenguaje visual de kronosmining.tech. Escrito para ser leído por agentes LLM (Claude Code, Cursor, otros) y por humanos. Cuando construyas, modifiques o audites cualquier UI del proyecto, este documento manda sobre cualquier improvisación estética.
>
> **Cómo se lee.** Este archivo es el router. Los detalles viven en `design/tokens.md`, `design/typography.md`, `design/components.md`, `design/animations.md` y `design/anti-patterns.md`. Carga bajo demanda solo las secciones que necesites.
>
> **Componente canónico de referencia.** `src/components/CTASection.astro` es el componente que encarna el sistema al 100%. Cuando dudes sobre proporciones, jerarquías o microinteracciones, replica sus decisiones antes que inventar.

---

## 1. Identidad visual

**Estética objetivo.** Industrial-tech con restraint cromático. Tres referencias canónicas: [Anduril Industries](https://www.anduril.com/), [Saronic Technologies](https://www.saronic.com/) y [Mach Industries](https://machindustries.com/). Referencias secundarias y detalle de qué consultar en cada una: `design/references.md`. NO SaaS colorido, NO startup playful, NO ilustraciones decorativas.

**Principios inviolables:**

1. **Restraint cromático.** El naranjo `#FF5B00` ocupa `< 5%` del área visible en cualquier vista. Se usa en CTAs primarios, palabras destacadas de headlines, acentos técnicos (◆, •, separadores puntuales). Nunca como fondo dominante.
2. **Jerarquía tipográfica brutal.** Headlines `oversized` (clamp 3rem → 8rem), labels técnicos `tiny` (10-11px), subs medios (1-1.25rem). Contraste de escala = personalidad.
3. **Espacio negativo generoso.** Respira. Menos elementos, mejor posicionados.
4. **Labels técnicas en monoespaciada.** Labels contextuales como `CONTACTO`, coordenadas, `EST. 2016`, certificaciones. En Geist Mono, uppercase, `letter-spacing: 0.25em–0.3em`.
5. **Animación con propósito.** Cada animación comunica algo (entrada de sección, preparación para acción, transición de estado). Nada decorativo.
6. **100% español en contenido.** Todo el copy visible para el usuario final es en español de Chile. Las keywords técnicas en código pueden ser inglés.

---

## 2. Paleta

Definida en `src/styles/global.css` `@theme`. Detalles y uso semántico en `design/tokens.md`.

| Token | Hex | Uso |
|---|---|---|
| `--color-primary-dark` | `#052650` | Fondos dominantes de secciones oscuras |
| `--color-primary` | `#083A75` | Azul corporativo, superficies secundarias |
| `--color-primary-light` | `#0A4C95` | Highlights, mesh gradient, gradientes |
| `--color-accent` | `#FF5B00` | CTAs primarios, palabras destacadas, tics técnicos (`< 5%` del área) |
| `--color-accent-dark` | `#E64A19` | Hover states de accent |
| `--color-accent-light` | `#FF7A33` | Glow pulse, destellos |
| `--color-neutral-*` | Gray 50-900 | Textos secundarios, bordes, separadores |

**Texto sobre fondos oscuros:** `#fff` para primario, `rgba(255,255,255,0.6)` para sub, `rgba(255,255,255,0.3-0.4)` para labels técnicas, `rgba(255,255,255,0.08-0.2)` para bordes sutiles.

---

## 3. Tipografía

| Familia | Variable CSS | Uso |
|---|---|---|
| Instrument Sans (variable) | `var(--font-sans)` | Headlines oversized, sub, body, botones |
| Geist Mono (variable) | `var(--font-heading)` | Labels técnicas, coordenadas, footer técnico, metadata |

Detalles completos en `design/typography.md`.

**Regla de oro.** Jamás mezclar una tercera familia. Jamás usar serif. Jamás fallback a `system-ui` como decisión de diseño (solo como fallback de emergencia).

---

## 4. Componentes canónicos

Detalles completos en `design/components.md`.

| Componente | Archivo | Estado |
|---|---|---|
| **CTASection** | `src/components/CTASection.astro` | **CANÓNICO** — referencia maestra del sistema |
| **TechLabel** | `src/components/TechLabel.astro` | **ALINEADO** — label técnica reutilizable `◆ LABEL ─── coord` |
| **BlueprintGrid** | `src/components/BlueprintGrid.astro` | **ALINEADO** — grid blueprint decorativo para secciones oscuras |
| TechnicalCatalog | `src/components/TechnicalCatalog.astro` | **ALINEADO** — catálogo técnico unificado |
| Header | `src/components/Header.astro` | Legacy, pendiente alinear a canon |
| Footer | `src/components/Footer.astro` | Legacy, pendiente alinear a canon |
| Button | `src/components/Button.astro` | Legacy — no usar en secciones nuevas, preferir `.btn-kronos-*` globales |

**Estilos globales disponibles** (en `src/styles/global.css`):
- `.btn-kronos-primary` / `.btn-kronos-outline` — botones con shimmer sweep + liquid fill
- `.kronos-meta*` — label técnica pattern (tick + label + divider + coord)
- `.kronos-blueprint` — grid blueprint decorativo

**Cuando crees UI nueva**, la instrucción base es:

> "Usa `<TechLabel>` para labels técnicas, `<BlueprintGrid>` para grids, y clases `.btn-kronos-*` para botones. Consulta `src/components/CTASection.astro` como referencia de estilo (tipografía, animaciones, overlays). No inventes tokens, colores, fonts ni escalas que no estén en `DESIGN.md` o `design/tokens.md`."

---

## 5. Patrones de animación

Detalles y snippets en `design/animations.md`.

Los cuatro patrones firmados del sistema:

1. **Shader mesh gradient WebGL** para fondos de secciones hero/CTA (Paper Shaders, lazy-load por IntersectionObserver, desactivado en mobile y `prefers-reduced-motion`).
2. **GSAP SplitText + ScrollTrigger** para reveal de headlines línea por línea (stagger + `translateY + blur` + `power3.out`, `once: true`). Valores numéricos exactos en el canónico `src/components/CTASection.astro` — los docs no los duplican.
3. **Shimmer sweep + glow pulse** para botones primarios (CSS puro, sin JS).
4. **Liquid fill con clip-path ellipse** para botones outline (CSS puro, sin JS).

**Stack de animación:**
- `@paper-design/shaders` — WebGL backgrounds
- `gsap` + `SplitText` + `ScrollTrigger` — text reveal y scroll-driven
- CSS puro para microinteracciones (botones, hovers, pulses)

---

## 6. Labels técnicas (patrón Anduril)

Elemento firma del sistema. Se usan para contextualizar secciones con metadata tipo "defense-tech panel":

```
◆ CONTACTO ─── -33.45°S / -70.66°W
```

**Anatomía:**
- `◆` tick naranjo 10px
- Label: texto contextual libre en Geist Mono 11px uppercase `letter-spacing: 0.3em` (ej. `CONTACTO`, `PORTADA`, `CATÁLOGO`, `SERVICIOS`)
- Divider: 60px línea 1px `rgba(255,255,255,0.2)`
- Metadata: coordenada/fecha/ID en Geist Mono 11px `rgba(255,255,255,0.4)`

**Regla de labels.** El texto de la label es libre y contextual — describe la sección que acompaña. No hay catálogo fijo ni numeración. Ejemplos válidos: `PORTADA`, `SERVICIOS`, `ALCANCE GLOBAL`, `CATÁLOGO`, `CONTACTO`.

**Footer técnico** (bottom de secciones CTA):
```
KRONOS MINING · SANTIAGO, CHILE ● ISO 9001 / 14001 / 45001 ● EST. 2016
```
Geist Mono 10px `letter-spacing: 0.25em`, `rgba(255,255,255,0.3)`, separadores en naranjo `rgba(255,120,0,0.6)` 6px.

---

## 7. Responsive

- **Mobile (< 768px).** Shader WebGL desactivado (fallback sólido). Headlines escalan con `clamp()`. Botones full-width apilados. Dividers y separadores ocultos si estorban.
- **Tablet (768–1023px).** Layout intermedio, shader activo, jerarquía preservada.
- **Desktop (≥ 1024px).** Scroll-snap en el home activo (ver `src/styles/global.css` líneas 386–403). Padding generoso, labels técnicas completas.

### 7.1 Video decorativo como layer de hero

Patrón para páginas internas que necesitan un video ambiental en el hero sin reemplazar el shader. El video se posiciona como capa absoluta entre el shader (z-0) y el blueprint grid (z-10).

**Anatomía de capas con video:**
1. Shader canvas (`z-index: 0`) — fondo WebGL
2. Overlay gradient (`z-index: 10`) — legibilidad
3. **Video decorativo (`z-index: 5`)** — absolute, lado derecho, 50% ancho en desktop
4. Grid blueprint (`z-index: 10`) — se ve *sobre* el video (requiere override scoped: `.svc-hero :global(.kronos-blueprint) { z-index: 10; }` porque el global `.kronos-blueprint` define `z-index: 0`)
5. Contenido (`z-index: 20`) — texto y botones

**Difuminado de bordes.** El video usa `mask-image` con dos gradientes lineales intersectados para fade simétrico en los 4 bordes:
```css
mask-image:
  linear-gradient(to right, transparent 0%, black 20%, black 80%, transparent 100%),
  linear-gradient(to bottom, transparent 0%, black 20%, black 80%, transparent 100%);
mask-composite: intersect;
-webkit-mask-composite: source-in;
```

**Responsive:**
- Mobile (`< 768px`): `display: none` — solo texto.
- Tablet (768–1023px): visible, `width: 40%`, `opacity: 0.6`, mask más agresivo (30%/70%).
- Desktop (`≥ 1024px`): `width: 50%`, opacidad completa, mask simétrico 20%.

**Atributos obligatorios:** `autoplay muted loop playsinline aria-hidden="true"`.

**Referencia de implementación:** `src/pages/servicios/index.astro` (hero section).

### 7.2 Stats inline en hero

Patrón para mostrar métricas clave (proyectos, años, seguridad) directamente en el hero, debajo de los botones. Reemplaza al componente legacy `StatsBar` con un diseño integrado al lenguaje defense-tech.

**Anatomía:**
```
+610          |  +35           |  316
PROYECTOS     |  AÑOS EN LA    |  DÍAS SIN
REALIZADOS    |  INDUSTRIA     |  ACCIDENTES
```

**Especificaciones:**
- Valor: Instrument Sans 800, `clamp(1.5rem, 4vw, 2.5rem)`, `#ffffff`, `letter-spacing: -0.02em`, `font-variant-numeric: tabular-nums`.
- Label: Geist Mono 10px 600, `letter-spacing: 0.2em`, uppercase, `rgba(255,255,255,0.4)`.
- Divider vertical: `1px × 2rem`, `rgba(255,255,255,0.15)`. Hidden en mobile (`< 768px`).
- Counter animado con `requestAnimationFrame`, easing cuadrático, duración 2s. **Fallback `prefers-reduced-motion`:** mostrar valor final inmediatamente sin animación.

**Cuándo usar:**
- Heros de páginas internas donde las métricas refuerzan credibilidad (servicios, industrias).
- No en el home (el home usa la ISO status bar separada).
- Máximo 3-4 stats por fila para no saturar.

**Referencia de implementación:** `src/pages/servicios/index.astro` (`.svc-stats`).

**Regla crítica del home.** El home usa `scroll-snap-type: y proximity` + `.snap-section` con `min/max-height: calc(100svh - 5rem)`. Cualquier sección del home debe tener la clase `snap-section`. El footer NO es snap point.

### 7.3 Alineación horizontal — site gutter unificado

Todo el contenido del sitio se alinea a una sola línea vertical izquierda (y derecha) mediante `--site-gutter` aplicado al inner wrapper de cada sección.

**Token:** `--site-gutter` — `1.5rem` mobile, `3rem` desktop.
**Documentación y patrón de contenedor:** `design/tokens.md §3`.
**Anti-pattern relacionado:** `design/anti-patterns.md §Gutter horizontal en wrapper externo`.

### 7.4 Header height como dependencia del sub-nav

El header tiene altura fija: `4rem` (mobile) / `5rem` (desktop ≥ 1024px). El componente `ServiceSubNav` usa `top: 4rem` / `top: 5rem` hardcodeados para posicionarse justo debajo del header cuando ambos son sticky.

**Dependencia frágil.** Si el header cambia de altura, el sub-nav se desacopla. Candidato a token futuro `--header-height` si esta dependencia se repite en más componentes. Actualmente solo afecta a `ServiceSubNav`.

---

## 8. Accesibilidad

- Contraste texto blanco sobre overlays oscuros: validar siempre ≥ 4.5:1.
- `prefers-reduced-motion`: shaders desactivados, GSAP cae a estado final, animaciones CSS pausadas.
- `focus-visible`: outline 2px (blanco sobre fondo oscuro, accent sobre fondo claro), offset 3px.
- `aria-label` en `<section>` decorativas, `aria-hidden="true"` en layers puramente visuales.
- Skip link ya presente en `BaseLayout.astro`.

---

## 9. Anti-patterns

Ver `design/anti-patterns.md` para la lista completa. Los más críticos:

- ❌ Inventar colores hex fuera de `@theme`.
- ❌ Mezclar una tercera font family.
- ❌ Usar emojis decorativos en UI (los `◆ ●` técnicos son OK, los `🚀 ✨ 💡` NO).
- ❌ Hero con `data-reveal` Y GSAP SplitText simultáneos (se cancelan).
- ❌ Naranjo en área `> 5%` de la vista.
- ❌ Secciones del home sin clase `snap-section`.
- ❌ Usar `<Button>` (componente legacy) en secciones nuevas — usar los patrones `.btn-kronos-*` del CTASection.
- ❌ Ignorar `prefers-reduced-motion`.
- ❌ Headlines que no sean uppercase en secciones hero/CTA.

---

## 10. Workflow para modificaciones

**Para cualquier trabajo de UI, invoca el skill `/rediseño`.** Vive en `.claude/skills/rediseño/SKILL.md` y define el flujo obligatorio de lectura, propuesta, implementación y auditoría.

Reglas transversales que el skill hace cumplir:

1. **Antes de escribir código UI**, leer `DESIGN.md` + el `design/*.md` relevante + `src/components/CTASection.astro`.
2. **Replica, no inventes.** Si el patrón ya existe como componente (`<TechLabel>`, `<BlueprintGrid>`) o clase global (`.btn-kronos-*`, `.kronos-meta*`, `.kronos-blueprint`), úsalo directamente — no dupliques CSS.
3. **Si tienes que introducir un patrón nuevo**, primero actualiza `DESIGN.md` y el `design/*.md` correspondiente, después codéalo.
4. **Después de un cambio visual significativo**, audita que el naranjo siga `< 5%`, que los labels técnicas sigan en Geist Mono, que el headline siga uppercase.
5. **Nunca toques** `src/styles/global.css` `@theme` sin actualizar `design/tokens.md` en el mismo commit.

---

**Última actualización del sistema:** 2026-04-07 — Fase 4: site gutter unificado `--site-gutter` (§7.3, tokens.md §3), patrón de contenedor obligatorio, anti-pattern de gutter externo, header height como dependencia documentada (§7.4), componente ServiceSubNav extraído y registrado.
**Componente canónico vigente:** `src/components/CTASection.astro`.
