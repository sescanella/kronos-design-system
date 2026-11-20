# Design Tokens — Kronos Mining

> Fuente única de verdad de los valores atómicos del sistema. Los tokens vivos están en `src/styles/global.css` dentro del bloque `@theme`. Este documento explica el **uso semántico** de cada uno — cuándo usar qué.
>
> **Regla crítica.** Nunca hardcodees un color, spacing o shadow fuera del `@theme`. Si necesitas un valor que no existe, primero actualiza `@theme` y este documento, después úsalo.

---

## 1. Colores

### 1.1 Primary (azul corporativo)

| Token | Hex | Tailwind class | Uso semántico |
|---|---|---|---|
| `--color-primary-dark` | `#052650` | `bg-primary-dark` / `text-primary-dark` | **Fondos dominantes** de secciones oscuras (hero, CTA, footer). Es el negro-azul base del sistema. |
| `--color-primary` | `#083A75` | `bg-primary` / `text-primary` | Azul corporativo medio. Superficies secundarias, hover states sobre fondos claros, gradientes intermedios. |
| `--color-primary-light` | `#0A4C95` | `bg-primary-light` / `text-primary-light` | Highlights azules y gradientes. **No usar como color de texto principal** — contraste insuficiente sobre blanco. |

### 1.2 Accent (naranjo firmado)

| Token | Hex | Tailwind class | Uso semántico |
|---|---|---|---|
| `--color-accent` | `#FF5B00` | `bg-accent` / `text-accent` | **El botón principal, el ◆ de la etiqueta, las cotas del dibujo y el riel de calidad, en menos del 5% del área visible.** Nunca dentro de un titular. Es la firma cromática del sistema. |
| `--color-accent-dark` | `#E64A19` | `bg-accent-dark` | Hover states de botones accent, variante oscurecida. |
| `--color-accent-light` | `#FF7A33` | `bg-accent-light` | Reservado. Sin uso en el sitio desde que salió el brillo de los botones (20-nov-2026). |

**Regla del 5%.** El accent nunca debe ocupar más del 5% del área visible de una vista (viewport). Auditar visualmente: si al pantallazo de una página completa el naranjo se ve como color dominante o co-protagonista, está mal proporcionado.

**Jerarquía de opacidades del accent sobre fondo oscuro:**
- `100%` (sólido): botón principal, ◆ de la etiqueta, cotas, riel de calidad
- `0.6` (rgba): separadores técnicos puntuales

Ni etiquetas, ni chips, ni cifras, ni enlaces en naranjo: eso es lo que hace que el naranjo deje de significar algo.

### 1.3 Neutrals

| Token | Hex | Uso semántico |
|---|---|---|
| `--color-neutral-50` | `#F9FAFB` | Fondo de secciones claras |
| `--color-neutral-100` | `#F3F4F6` | Superficies secundarias claras, cards sobre fondo blanco |
| `--color-neutral-200` | `#E5E7EB` | Bordes sutiles en modo claro, separadores |
| `--color-neutral-300` | `#D1D5DB` | Bordes definidos, inputs |
| `--color-neutral-400` | `#9CA3AF` | Texto deshabilitado, placeholders |
| `--color-neutral-500` | `#6B7280` | Texto secundario sobre fondo claro |
| `--color-neutral-600` | `#4B5563` | Texto de body en modo claro |
| `--color-neutral-700` | `#374151` | Texto de énfasis en modo claro |
| `--color-neutral-800` | `#1F2937` | Headings en modo claro |
| `--color-neutral-900` | `#111827` | Texto principal en modo claro |

**Nota.** El sitio NO tiene dark mode (decisión deliberada, ver `memory/MEMORY.md`). Los neutrals existen para secciones sobre fondo blanco/claro (páginas de contenido tipo blog, artículo detalle), no para alternar temas.

### 1.4 Blancos semánticos sobre fondo oscuro

Estos valores NO viven en `@theme` pero son convención del sistema. Úsalos con rgba literal:

Desde el 20-nov-2026 hay **4 grises de texto y 2 de línea**, nada más (kronos-web los declara en `src/styles/estandar.css`):

| Ficha (kronos-web) | Valor | Uso |
|---|---|---|
| `--k-text` | `var(--color-white)` | Titulares, texto principal, botones |
| `--k-text-2` | `rgb(255 255 255 / 0.78)` | Bajadas y cuerpo de lectura |
| `--k-text-3` | `rgb(255 255 255 / 0.62)` | Datos mono, rótulos, pies de foto |
| `--k-text-4` | `rgb(255 255 255 / 0.55)` | Lo más tenue permitido en texto (migas, notas): 5,4:1 sobre `#052650` |
| `--k-line` | `rgb(255 255 255 / 0.14)` | Línea fina entre secciones y filas |
| `--k-line-strong` | `rgb(255 255 255 / 0.4)` | Línea fuerte (bajo el encabezado de una tabla). Nunca para texto |

**Ningún texto bajo 0,55:** el blanco al 0,4 sobre `#052650` da 3,5:1 y no alcanza AA en rótulos chicos.

---

## 2. Tipografía (resumen, detalle en `typography.md`)

| Token | Valor | Uso |
|---|---|---|
| `--font-sans` | `"Instrument Sans", system-ui, -apple-system, sans-serif` | Headlines, sub, body, botones |
| `--font-heading` | `"Geist Mono", ui-monospace, monospace` | Etiquetas técnicas, datos, rótulos (nombre legacy) |
| `--font-mono` | `"Geist Mono", ui-monospace, monospace` | Lo mismo que `--font-heading`; úsalo en código nuevo |

**Nota de naming.** El token se llama `--font-heading` por legacy, pero semánticamente es la fuente **monoespaciada de labels técnicas**, NO la fuente de headlines. Los headlines usan `--font-sans`. No renombrar en esta fase (rompe clases Tailwind existentes); documentar y seguir.

---

## 3. Spacing

Kronos usa el **sistema de spacing nativo de Tailwind v4** (escala 0.25rem base) más un token custom para el gutter horizontal del sitio.

### 3.1 Site gutter (`--site-gutter`)

Token unificado para el padding horizontal de **todos** los contenedores con `max-width`: header, sub-nav, heroes, secciones de contenido, CTA. Un solo gutter garantiza que el borde izquierdo del logo alinee con el borde izquierdo del contenido en toda la página.

| Breakpoint | Valor |
|---|---|
| mobile (default) | `1.5rem` (24px) |
| desktop (≥ 1024px) | `3rem` (48px) |

**Dónde vive.** En `src/styles/global.css` del proyecto consumidor como `:root` con media query. No tiene token en `@theme` porque Tailwind v4 no soporta media queries en `@theme` y un valor estático sería engañoso.

```css
/* src/styles/global.css */
:root {
  --site-gutter: 1.5rem;
}
@media (min-width: 1024px) {
  :root {
    --site-gutter: 3rem;
  }
}
```

**Cómo usar.** Siempre `padding-inline: var(--site-gutter)` en CSS scoped del componente o página. No usar clases Tailwind `px-6` / `px-12` como gutter de sección — esas clases producen los mismos valores numéricos pero son estáticas: `px-6` es siempre `1.5rem` sin importar el breakpoint, mientras que `--site-gutter` responde al media query y se propaga si el valor cambia en un solo lugar.

**Decisión de diseño: salto discreto vs clamp().** Se eligió un salto discreto (`1.5rem` → `3rem` en `lg`) en lugar de `clamp(1.5rem, 4vw, 3rem)` por consistencia con el sistema de breakpoints del proyecto (las secciones usan saltos discretos en `padding-block` a los mismos breakpoints). Un `clamp()` crearía una transición fluida del gutter mientras el padding vertical salta — comportamiento mixto.

**Referencia.** Las 5 referencias canónicas usan un solo gutter para header y contenido. Ninguna usa gutters diferenciados entre nav y secciones. Ver `design/references.md` §Patrones universales, punto 9.

### 3.2 Patrón de contenedor

El gutter se aplica en el elemento que lleva `max-width`. Hay dos variantes válidas:

**Variante A — Outer + inner separados** (heroes, secciones con layers de fondo):
```css
/* ✅ CORRECTO — gutter en el inner que lleva max-width */
.section-outer {
  padding-block: 5rem;
  /* sin padding-inline — full-width para fondos */
}
.section-inner {
  max-width: 80rem;
  margin: 0 auto;
  padding-inline: var(--site-gutter);
}
```

**Variante B — Elemento único** (secciones sin layers, slides simples):
```css
/* ✅ CORRECTO — max-width y gutter en el mismo elemento */
.section {
  max-width: 80rem;
  margin: 0 auto;
  padding: 5rem var(--site-gutter);
}
```

**Lo que NO está permitido:**
```css
/* ❌ INCORRECTO — gutter en el outer, max-width en el inner */
.section-outer {
  padding: 5rem 1.5rem;
}
.section-inner {
  max-width: 80rem;
  margin: 0 auto;
  /* sin padding — el inner ocupa 80rem completos, más ancho que el header */
}
```

**Por qué la variante incorrecta desalinea.** El gutter se consume antes de que `max-width` aplique. El inner ocupa 80rem completos, mientras que el header (gutter dentro del max-width) tiene 80rem - 2×gutter de contenido útil.

### 3.3 Otras convenciones de spacing

| Contexto | Valor recomendado |
|---|---|
| Relleno vertical de sección (`k-sec`) | `clamp(5rem, 10vw, 9.5rem)`: ~144 px a 1440, 80 px a 393 |
| Max-width de contenido principal | `max-w-7xl` (80rem) |
| Ancho de bajada / cuerpo largo | `40rem` (`k-lede`) / `68ch` (`k-prose`) |
| Gap entre botones en CTA row | `gap-4` (1rem) |
| Margin bottom entre headline y sub | `clamp(1.5rem, 3vw, 2.5rem)` |
| Margin bottom entre sub y actions | `clamp(2rem, 4vw, 3rem)` |

---

## 4. Border radius

Kronos usa **radius 0 (sharp corners)** como decisión de diseño Anduril-style. Excepciones controladas:

| Contexto | Valor |
|---|---|
| **Todo**: botones, tarjetas, fotos, filtros, buscador, paneles | `0` |
| **Círculos funcionales**: botón de WhatsApp, puntos | `50%` |
| **La tarjeta del cambio de página** (`PageTransition`) | `4px` |

**Regla.** Esquinas rectas en todo (desde el 20-nov-2026 también las tarjetas). Si dudas, recto.

---

## 5. Shadows

| Token | Uso |
|---|---|
| `--shadow-card` | Cards en reposo sobre fondo claro |
| `--shadow-card-hover` | Cards en hover |

**Sobre fondos oscuros**, NO usar box-shadows tradicionales. Usar en su lugar:
- **Borde luminoso**: `border: 1px solid rgba(255,255,255,0.4)` + transición a `border-color: #fff` en hover
- **Separación sobre dark**: una línea fina `var(--k-line)`; sin cajas ni sombras alrededor de las tarjetas

---

## 6. Z-index layering

Sistema de capas estandarizado para secciones con múltiples layers (hero, CTA):

| Capa | z-index | Contenido |
|---|---|---|
| Fondo | `0` | Foto, video o grilla de dibujo |
| Overlay gradient (legibilidad) | `10` | Gradientes para contraste de texto |
| Grid / texturas decorativas | `10` | Blueprint grid, noise, patterns |
| Contenido principal | `20` | Headline, sub, botones |
| Navegación sticky | `30` | Header fijo |
| Modales / overlays globales | `50+` | Dialogs, lightbox, floating CTA |

---

## 7. Breakpoints

Tailwind v4 default:

| Breakpoint | Min-width | Uso |
|---|---|---|
| `sm` | 640px | Ajustes mobile-landscape |
| `md` | 768px | Los botones pasan a fila (abajo van apilados a todo el ancho) |
| `lg` | 1024px | **Activación de scroll-snap del home** |
| `xl` | 1280px | Ajustes desktop amplio |
| `2xl` | 1536px | Ultra-wide, pocas reglas |

---

## 8. Movimiento

Las fichas de duración y curva están en `design/animations.md` (con su fuente) y en `src/styles/estandar.css`
de kronos-web: `--k-dur-1` a `--k-dur-4` y `--k-ease-taller`, `--k-ease-entrada`, `--k-ease-salida`. Ninguna
transición ni animación usa un valor fuera de ellas.

---

## 9. Cómo añadir un token nuevo

1. Proponer el token con justificación (¿qué problema resuelve? ¿por qué no sirve uno existente?).
2. Añadirlo a `src/styles/global.css` dentro del `@theme`.
3. Documentarlo en este archivo con hex, uso semántico y ejemplo.
4. Si reemplaza un patrón previo, auditar uso del viejo y migrar.
5. Commit único que incluya: `@theme` + `design/tokens.md` + migración si aplica.

**Nunca añadas tokens "por si acaso".** Si no tiene uso concreto ya identificado, no entra.
