# Tipografía — Kronos Mining

> Sistema tipográfico binario: **Instrument Sans** (principal) + **Geist Mono** (labels técnicas).
> Cualquier tercera familia, serif, o font display adicional está prohibida — ver
> `design/anti-patterns.md`.
>
> **Componente canónico de referencia:** `src/components/CTASection.astro`. Todos los valores de este documento están extraídos literalmente de su `<style>` scoped. No inventar valores nuevos sin actualizar primero esta tabla.

---

## 1. Familias

### Instrument Sans (principal)

- Variable font (pesos `100–900`, stretch `75%–100%`).
- Token CSS: `var(--font-sans)` — clase Tailwind: `font-sans`.
- Self-hosted en `/public/fonts/InstrumentSans-Variable.ttf`.
- Declaración `@font-face`: `src/styles/global.css` líneas 4–10.
- Declaración `@theme`: `src/styles/global.css` línea 62.
- Stack fallback: `system-ui, -apple-system, sans-serif`.

**Usos en el sistema:**
- Headlines oversized de hero y CTA (peso `800`, uppercase, clamp a viewport).
- Sub / lead bajo headlines (peso `400`, sentence case).
- Body copy en páginas de lectura (blog, artículo detalle).
- Texto de botones `.btn-kronos-primary` y `.btn-kronos-outline` (peso `700`, uppercase).

### Geist Mono (técnica)

- Variable font (pesos `100–900`).
- Token CSS: `var(--font-heading)` — clase Tailwind: `font-heading`.
- Self-hosted en `/public/fonts/GeistMono-Variable.ttf`.
- Declaración `@font-face`: `src/styles/global.css` líneas 12–17.
- Declaración `@theme`: `src/styles/global.css` línea 66.
- Stack fallback: `ui-monospace, monospace`.

**Nota de naming legacy.** El token se llama `--font-heading` por razones históricas, pero semánticamente es la fuente **mono para labels técnicas**, NO la fuente de headlines. Los headlines del sistema usan `--font-sans` (Instrument Sans). No renombrar el token actual (rompe clases Tailwind `font-heading` ya en uso en el árbol). Fix futuro sugerido: añadir un alias `--font-mono: var(--font-heading)` en el bloque `@theme` de `src/styles/global.css` y migrar gradualmente los consumidores, manteniendo el legacy como shim.

**Usos en el sistema:**
- Labels técnicas tipo `SISTEMA 05 — CONTACTO` (peso `600`, uppercase, tracking `0.3em`).
- Coordenadas y metadata (`-33.45°S / -70.66°W`, peso `400`).
- Footer técnico (razón social · ISO · EST., peso `600`, uppercase, tracking `0.25em`).
- Tics (`◆`) y dot separators (`●`) técnicos de labels y footers.

---

## 2. Escala tipográfica

Una fila por rol tipográfico. Valores extraídos de `src/components/CTASection.astro` `<style>` scoped. Celdas con `?` o `[pendiente]` son roles aún no definidos porque no existe un componente canónico que los use.

| Rol | Uso | Font | Size | Weight | Line-height | Letter-spacing | Transform | Color | Referencia en código |
|---|---|---|---|---|---|---|---|---|---|
| **Headline oversized** | Hero / CTA titles | sans | `clamp(3rem, 10vw, 8rem)` (mobile: `clamp(2.5rem, 13vw, 4rem)`) | `800` | `0.95` | `-0.02em` | uppercase | `#ffffff` (accent word: `#FF5B00`) | `CTASection.astro` `.cta-headline`, `.cta-line--accent` |
| **Headline sección** | Secciones internas no-hero | sans | `?` | `?` | `?` | `?` | `?` | `?` | [pendiente — cuando se cree el primer componente no-hero canónico] |
| **Sub / lead** | Párrafo bajo headline | sans | `clamp(1rem, 1.15vw, 1.25rem)` | `400` | `1.6` | normal | none | `rgba(255,255,255,0.6)` | `CTASection.astro` `.cta-sub` |
| **Body** | Texto de lectura larga | sans | `?` | `?` | `?` | `?` | none | `?` | [pendiente — cuando se audite blog / artículo detalle] |
| **Button label** | Texto de botones | sans | `0.875rem` | `700` | (heredado) | `0.15em` | uppercase | `#ffffff` (primary) / `#ffffff → #083A75` (outline en hover) | `CTASection.astro` `.btn-kronos-primary`, `.btn-kronos-outline` |
| **Label técnica** | `SISTEMA NN — NOMBRE` | mono | `11px` | `600` | (heredado) | `0.3em` | uppercase | `rgba(255,255,255,0.85)` | `CTASection.astro` `.cta-label` |
| **Metadata técnica** | Coordenadas, IDs | mono | `11px` | `400` | (heredado) | `0.08em` | none | `rgba(255,255,255,0.4)` | `CTASection.astro` `.cta-coord` |
| **Footer técnico** | Razón social · ISO · EST. | mono | `10px` (mobile: `9px`) | `600` | (heredado) | `0.25em` | uppercase | `rgba(255,255,255,0.3)` | `CTASection.astro` `.cta-footer` |
| **Dot separator** | Separador en footer técnico | mono | `6px` | — | — | — | — | `rgba(255,120,0,0.6)` | `CTASection.astro` `.cta-footer__dot` |
| **Tick técnico** | `◆` al inicio de labels | mono (heredado) | `10px` | — | `1` | — | — | `#FF5B00` | `CTASection.astro` `.cta-tick` |

**Nota operativa.** Las celdas con `?` o `[pendiente]` no son huecos a rellenar con valores imaginarios. Cuando se diseñe la primera sección canónica interna (no-hero) o la primera página de lectura larga auditada, se extraen los valores reales de ese componente y se actualiza esta tabla en el mismo commit.

---

## 3. Jerarquía visual

El sistema se apoya en un contraste de escala extremo entre dos polos: el headline oversized (hasta `8rem` = `128px`) y la label técnica (`10px`–`11px`). El ratio máximo es de aproximadamente `13:1`. Ese salto es la firma del sistema y emula la estética de paneles de instrumentación de Anduril / True Anomaly / Saronic.

Entre ambos polos el sub (`1rem`–`1.25rem`) y el button label (`0.875rem`) son tamaños intermedios deliberadamente discretos: no compiten con el headline, no desaparecen frente a la label técnica. El sub usa color `rgba(255,255,255,0.6)` precisamente para ceder peso visual al headline blanco puro.

**Cuándo usar cada nivel:**
- Una sola instancia de headline oversized por sección hero/CTA. Nunca dos headlines del mismo peso compitiendo.
- Las labels técnicas preceden al headline (en orden de lectura vertical) y lo contextualizan con metadata.
- El footer técnico cierra la sección con certificaciones y firma corporativa, nunca aparece en el medio del contenido.

**Combinaciones a evitar:**
- Sub en tamaño cercano al headline (rompe jerarquía).
- Label técnica en tamaño > `12px` (pierde su carácter de metadata y empieza a competir).
- Button label en mayúsculas con tamaño > `1rem` (desbalancea el conjunto).

---

## 4. Reglas de tracking (letter-spacing)

El tracking es donde más errores aparecen. Las reglas son específicas por familia, transform y tamaño.

| Contexto | Valor | Razón |
|---|---|---|
| Instrument Sans uppercase (headlines hero/CTA) | `-0.02em` | Uppercase con tracking default se percibe espaciado artificialmente; negativo compacta y refuerza densidad. |
| Instrument Sans uppercase (botones) | `0.15em` | En texto corto de botón (2–3 palabras), tracking positivo da peso tipográfico y legibilidad. |
| Instrument Sans sentence case (body, sub) | normal (default) | La fuente ya está optimizada en su tracking default para lectura larga. |
| Geist Mono uppercase (labels técnicas `11px`) | `0.3em` | Tracking amplio refuerza la estética "technical panel" tipo Anduril. |
| Geist Mono uppercase (footer técnico `10px`) | `0.25em` | Ligeramente menor que el de labels para diferenciar jerarquía dentro de la misma familia. |
| Geist Mono sentence case (coordenadas, metadata) | `0.08em` | Discreto, solo para desambiguar caracteres (`0`/`O`, `1`/`l`) en tamaño pequeño. |

---

## 5. Uppercase vs case natural

**Obligatorio uppercase:**
- Headlines de hero y CTA (siempre, sin excepciones).
- Labels técnicas (`SISTEMA NN`, coordenadas con prefijo alfabético, footer técnico).
- Texto de botones primarios y outline.
- Tags, chips, badges técnicos.

**Prohibido uppercase:**
- Párrafos de lectura larga (anti-legibilidad).
- Títulos de artículos de blog (legibilidad editorial prima).
- Navegación del Header (se mantiene sentence case).

**Zona gris (consultar caso a caso):**
- Headlines de secciones internas no-hero (servicios, alcance global, catálogo técnico): **preferir uppercase para mantener coherencia con el hero**, a menos que haya razón concreta (p. ej. títulos editoriales con 2 líneas largas donde uppercase rompe la cadencia de lectura).
- Titulares de cards (ArticleCard, ProjectCard, ServiceCard): sentence case OK.

---

## 6. Pesos tipográficos

Ambas familias son variable fonts con rango completo `100–900`. La variabilidad se usa con restricción — solo los pesos listados abajo están permitidos en el sistema.

**Instrument Sans:**
- `400` — sub, body, metadata, párrafos.
- `700` — botones (bold).
- `800` — headlines (extra bold, es la firma del sistema).
- **Nunca** `100–300` (demasiado delicado para el tono industrial).
- **Nunca** `500–600` (peso intermedio sin justificación de rol).
- **Nunca** `900` (demasiado denso, choca con la estructura ya cargada del clamp oversized).

**Geist Mono:**
- `400` — coordenadas y metadata discreta.
- `600` — labels técnicas y footer técnico (semibold es el peso sweet spot para tamaños `10–11px` en monoespaciada).
- **Nunca** `700+` (mono bold se satura en tamaños pequeños).
- **Nunca** `100–300` (insuficiente contraste sobre fondos oscuros a `10–11px`).

**Sobre font-stretch (Instrument Sans).** La variabilidad `75%–100%` está declarada en `@font-face` pero el sistema actual NO la explota. No condensar ni expandir headlines sin una razón técnica concreta documentada. Default = `100%`.

---

## 7. Ejemplos copiables

Extraídos literalmente de `src/components/CTASection.astro`. Copiar sin modificar.

### 7.1 Label técnica completa

```html
<div class="cta-meta">
  <span class="cta-tick" aria-hidden="true">◆</span>
  <span class="cta-label">SISTEMA 05 — CONTACTO</span>
  <div class="cta-divider" aria-hidden="true"></div>
  <span class="cta-coord">-33.45°S / -70.66°W</span>
</div>
```

```css
.cta-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}
@media (min-width: 1024px) {
  .cta-meta {
    margin-bottom: 3rem;
  }
}
.cta-tick {
  color: #FF5B00;
  font-size: 10px;
  line-height: 1;
}
.cta-label {
  font-family: var(--font-heading, 'Geist Mono', ui-monospace, monospace);
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.3em;
  color: rgba(255, 255, 255, 0.85);
  text-transform: uppercase;
}
.cta-divider {
  flex: 0 0 60px;
  height: 1px;
  background: rgba(255, 255, 255, 0.2);
}
.cta-coord {
  font-family: var(--font-heading, 'Geist Mono', ui-monospace, monospace);
  font-size: 11px;
  color: rgba(255, 255, 255, 0.4);
  letter-spacing: 0.08em;
}
```

### 7.2 Headline oversized

```html
<h2 class="cta-headline" data-cta-headline>
  <span class="cta-line">Ingeniería que</span>
  <span class="cta-line cta-line--accent">resiste.</span>
</h2>
```

```css
.cta-headline {
  font-family: var(--font-sans, 'Instrument Sans', system-ui, sans-serif);
  font-weight: 800;
  font-size: clamp(3rem, 10vw, 8rem);
  line-height: 0.95;
  letter-spacing: -0.02em;
  text-transform: uppercase;
  color: #ffffff;
  margin: 0 0 clamp(1.5rem, 3vw, 2.5rem) 0;
}
.cta-line {
  display: block;
  overflow: hidden;
}
.cta-line--accent {
  color: #FF5B00;
}
@media (max-width: 767px) {
  .cta-headline {
    font-size: clamp(2.5rem, 13vw, 4rem);
  }
}
```

### 7.3 Sub / lead

```html
<p class="cta-sub" data-cta-sub>
  Diseñamos, fabricamos e instalamos sistemas certificados para la industria minera más exigente de Chile.
</p>
```

```css
.cta-sub {
  font-family: var(--font-sans, 'Instrument Sans', system-ui, sans-serif);
  font-size: clamp(1rem, 1.15vw, 1.25rem);
  line-height: 1.6;
  color: rgba(255, 255, 255, 0.6);
  max-width: 52ch;
  margin: 0 0 clamp(2rem, 4vw, 3rem) 0;
}
```

### 7.4 Button labels

```html
<a href="/contacto#visitas" class="btn-kronos-primary">
  <span class="btn-kronos-primary__label">AGENDAR VISITA</span>
  <span class="btn-kronos-primary__arrow" aria-hidden="true">→</span>
</a>
<a href="/proyectos" class="btn-kronos-outline">
  <span class="btn-kronos-outline__fill" aria-hidden="true"></span>
  <span class="btn-kronos-outline__label">VER PROYECTOS</span>
</a>
```

Tipografía de ambos botones (extracto — ver CTASection para animaciones completas):

```css
.btn-kronos-primary,
.btn-kronos-outline {
  font-family: var(--font-sans, 'Instrument Sans', system-ui, sans-serif);
  font-weight: 700;
  font-size: 0.875rem;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  text-decoration: none;
}
```

### 7.5 Footer técnico

```html
<div class="cta-footer">
  <span>KRONOS MINING · SANTIAGO, CHILE</span>
  <span class="cta-footer__dot" aria-hidden="true">●</span>
  <span>ISO 9001 / 14001 / 45001</span>
  <span class="cta-footer__dot" aria-hidden="true">●</span>
  <span>EST. 2016</span>
</div>
```

```css
.cta-footer {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
  font-family: var(--font-heading, 'Geist Mono', ui-monospace, monospace);
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.25em;
  color: rgba(255, 255, 255, 0.3);
  text-transform: uppercase;
}
.cta-footer__dot {
  color: rgba(255, 120, 0, 0.6);
  font-size: 6px;
}
@media (max-width: 767px) {
  .cta-footer {
    font-size: 9px;
    gap: 0.5rem;
  }
}
```

---

## 8. Responsive y clamp()

Las escalas `clamp(min, vw-unit, max)` están calibradas para tres zonas de viewport. Los valores de la tabla §2 se resuelven así:

| Rol | Mobile (< 768px) | Tablet (768–1023px) | Desktop (≥ 1024px) | Ultra-wide (≥ 1536px) |
|---|---|---|---|---|
| Headline oversized | `clamp(2.5rem, 13vw, 4rem)` → `40–64px` | `clamp(3rem, 10vw, 8rem)` → `~77–102px` | `clamp(3rem, 10vw, 8rem)` → `~102–128px` | cap en `8rem` (`128px`) |
| Sub / lead | `clamp(1rem, 1.15vw, 1.25rem)` → `16px` | `16–17.6px` | `17.6–20px` | cap en `1.25rem` (`20px`) |
| Label técnica | `11px` (fijo) | `11px` | `11px` | `11px` |
| Footer técnico | `9px` (override mobile) | `10px` | `10px` | `10px` |

**Regla crítica.** Las labels técnicas (`mono`) son **fijas en px**, no escalan con viewport. Son metadata y deben mantener tamaño constante para preservar el carácter "technical panel". Los headlines (`sans`) sí escalan con `vw` porque son el elemento expresivo del sistema.

**Mobile override explícito** (CTASection.astro líneas 354–368):
- Headline comprimido a `clamp(2.5rem, 13vw, 4rem)`.
- Footer técnico bajado a `9px` con gap reducido.
- Divider de meta label oculto (`display: none`).

---

## 9. Anti-patterns tipográficos

Ver `design/anti-patterns.md` para la lista completa. Los más críticos que aplican a tipografía:

- Mezclar una tercera font family.
- Usar serif en cualquier contexto.
- Headlines que no sean uppercase en secciones hero/CTA.
- Fallback a `system-ui` como decisión de diseño (solo como fallback de emergencia del stack).

**Anti-pattern específico de este archivo (no cubierto en el resto del sistema):**

- **Usar Geist Mono para headlines.** El token `--font-heading` tiene un nombre engañoso. NUNCA asignar Geist Mono a un `<h1>`/`<h2>`/`<h3>` estructural. Los headlines son siempre Instrument Sans. Geist Mono es exclusivamente metadata técnica.

---

## 10. Qué hacer cuando necesites un tamaño/peso nuevo

1. Verificar si existe un rol tipográfico en la tabla §2 que cubra el caso.
2. Si no existe pero el caso es repetible (≥ 2 apariciones previstas), añadir una nueva fila a §2 con justificación en el PR.
3. Si es un one-off aislado, usar clases Tailwind directas sin añadir a la tabla, pero respetando los pesos permitidos en §6.
4. Nunca inventar un peso fuera de los permitidos en §6.
5. Nunca inventar un tamaño de label técnica fuera del rango `10–11px`.
6. Nunca usar `letter-spacing` que no esté en la tabla §4 sin justificación documentada.

---

**Última actualización:** 2026-04-04
**Componente canónico de referencia:** `src/components/CTASection.astro`
**Tokens relacionados:** `design/tokens.md` §2
**Reglas globales:** `DESIGN.md` §3, §6
