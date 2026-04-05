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
4. **Labels técnicas en monoespaciada.** `SISTEMA 05 — CONTACTO`, coordenadas, `EST. 2016`, certificaciones. En Geist Mono, uppercase, `letter-spacing: 0.25em–0.3em`.
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
| Header | `src/components/Header.astro` | Existente, pendiente alinear a canon |
| Footer | `src/components/Footer.astro` | Existente, pendiente alinear a canon |
| Button | `src/components/Button.astro` | Legacy — no usar en secciones nuevas, preferir botones inline tipo `.btn-kronos-primary` |
| ServiceCard, ProjectCard, ArticleCard | `src/components/*.astro` | Existentes, pendiente auditoría |

**Cuando crees UI nueva**, la instrucción base es:

> "Usa `src/components/CTASection.astro` como referencia exacta de estilo (tipografía, labels técnicas, botones, animaciones). No inventes tokens, colores, fonts ni escalas que no estén en `DESIGN.md` o `design/tokens.md`."

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
◆ SISTEMA 05 — CONTACTO ─── -33.45°S / -70.66°W
```

**Anatomía:**
- `◆` tick naranjo 10px
- Label: `SISTEMA NN — NOMBRE` en Geist Mono 11px uppercase `letter-spacing: 0.3em`
- Divider: 60px línea 1px `rgba(255,255,255,0.2)`
- Metadata: coordenada/fecha/ID en Geist Mono 11px `rgba(255,255,255,0.4)`

**Footer técnico** (bottom de secciones CTA):
```
KRONOS MINING · SANTIAGO, CHILE ● ISO 9001 / 14001 / 45001 ● EST. 2016
```
Geist Mono 10px `letter-spacing: 0.25em`, `rgba(255,255,255,0.3)`, separadores en naranjo `rgba(255,120,0,0.6)` 6px.

**Catálogo de SISTEMA NN** (se asigna en orden de aparición en la página):
- `SISTEMA 01` → Hero principal
- `SISTEMA 02` → Servicios
- `SISTEMA 03` → Alcance global / alianzas
- `SISTEMA 04` → Catálogo técnico
- `SISTEMA 05` → Contacto / CTA
- Páginas internas incrementan desde 01.

---

## 7. Responsive

- **Mobile (< 768px).** Shader WebGL desactivado (fallback sólido). Headlines escalan con `clamp()`. Botones full-width apilados. Dividers y separadores ocultos si estorban.
- **Tablet (768–1023px).** Layout intermedio, shader activo, jerarquía preservada.
- **Desktop (≥ 1024px).** Scroll-snap en el home activo (ver `src/styles/global.css` líneas 386–403). Padding generoso, labels técnicas completas.

**Regla crítica del home.** El home usa `scroll-snap-type: y proximity` + `.snap-section` con `min/max-height: calc(100svh - 5rem)`. Cualquier sección del home debe tener la clase `snap-section`. El footer NO es snap point.

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
2. **Replica, no inventes.** Si el patrón ya existe, cópialo exactamente desde el canónico.
3. **Si tienes que introducir un patrón nuevo**, primero actualiza `DESIGN.md` y el `design/*.md` correspondiente, después codéalo.
4. **Después de un cambio visual significativo**, audita que el naranjo siga `< 5%`, que los labels técnicas sigan en Geist Mono, que el headline siga uppercase.
5. **Nunca toques** `src/styles/global.css` `@theme` sin actualizar `design/tokens.md` en el mismo commit.

---

**Última actualización del sistema:** 2026-04-04 — Fase 1 del design system (5 archivos markdown + skill `rediseño` + `design/references.md`).
**Componente canónico vigente:** `src/components/CTASection.astro`.
