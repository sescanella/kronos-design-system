# Tipografía — Kronos Mining

> Sistema tipográfico binario: **Instrument Sans** (principal) + **Geist Mono** (etiquetas y datos técnicos).
> Cualquier tercera familia, serif o font display adicional está prohibida (ver `design/anti-patterns.md`).
>
> **Fuente de los valores (desde el 20-nov-2026):** el kit del estándar en kronos-web,
> `src/styles/estandar.css` (`k-h1`, `k-h2`, `k-h3`, `k-lede`, `k-prose`, `k-mono`, `k-link`, `k-crumb`) y las
> clases globales de `src/styles/global.css` (`.kronos-meta*`, `.btn-kronos-*`). Nació de medir en el DOM, el
> 13-nov-2026, los home de Anduril, Saronic, Mach Industries y Hadrian a 1440 y 393 px. No inventar valores
> nuevos sin actualizar primero esta tabla y el kit.

---

## 1. Familias

### Instrument Sans (principal)

- Variable font (pesos `100–900`, stretch `75%–100%`).
- Token CSS: `var(--font-sans)` — clase Tailwind: `font-sans`.
- Stack fallback: `system-ui, -apple-system, sans-serif`.

**Usos en el sistema:**
- Titulares de página, de sección y de bloque: tipo oración, livianos (peso `300`; `400` el de bloque).
- Bajadas y cuerpo de lectura (peso `400`).
- Texto de botones `.btn-kronos-primary` y `.btn-kronos-outline` (peso `700`, en mayúsculas).

### Geist Mono (técnica)

- Variable font (pesos `100–900`).
- Token CSS: `var(--font-mono)`. El alias legacy `var(--font-heading)` apunta a lo mismo y se mantiene para no
  romper la clase Tailwind `font-heading`.
- Stack fallback: `ui-monospace, monospace`.

**Nota de naming legacy.** `--font-heading` se llama así por razones históricas, pero es la fuente **mono de
etiquetas y datos**, NO la de los titulares. Los titulares usan `--font-sans`. En código nuevo, `--font-mono`.

**Usos en el sistema** (todo en mayúsculas, peso `400`):
- Etiqueta técnica que abre cada sección (`◆ PROYECTOS`).
- Datos y especificaciones (`DN 900 · ASME IX · SA 2½`), rótulos sobre fotos y pies de foto.
- El enlace de texto de cada sección (`VER PROYECTOS →`) y la ruta (migas).
- La línea de datos de la empresa al cierre (`Kronos Mining · Lampa, Chile · ISO 9001 / 14001 / 45001`).

---

## 2. Escala tipográfica

Una fila por rol. Valores literales del kit (`src/styles/estandar.css` y `global.css` de kronos-web).

| Rol | Clase | Font | Size (393 → 1440) | Weight | Line-height | Tracking | Color |
|---|---|---|---|---|---|---|---|
| **Título de página** | `k-h1` | sans | `clamp(2.25rem, 1.406rem + 3.438vw, 4.75rem)` → 36–72 px | `300` | `1` | `-0.04em` | blanco |
| **Título de página largo** (un proyecto, un artículo) | `k-h1--long` | sans | `clamp(1.875rem, 1.359rem + 2.101vw, 3.5rem)` → 30–52 px | `300` | `1.06` | `-0.03em` | blanco |
| **Titular de sección** | `k-h2` | sans | `clamp(2rem, 1.343rem + 2.674vw, 4rem)` → 32–60 px | `300` | `1.04` | `-0.035em` | blanco |
| **Título de bloque** | `k-h3` | sans | `clamp(1.375rem, 1.14rem + 0.955vw, 2rem)` → 22–32 px | `400` | `1.15` | `-0.02em` | blanco |
| **Bajada** | `k-lede` | sans | `1.125rem` → `1.25rem` (≥ 64rem) | `400` | `1.5` | normal | `rgb(255 255 255 / 0.78)`, máx. `40rem` |
| **Cuerpo largo** | `k-prose` | sans | `1.0625rem` → `1.125rem` | `400` | `1.65` | normal | `rgb(255 255 255 / 0.78)`, máx. `68ch` |
| **Subtítulo en el cuerpo** | `k-prose h2` / `h3` / `h4` | sans | 24–34 px / 19–22 px / 17 px | `300` / `500` / `600` | `1.15` / `1.25` / — | `-0.02em` / `-0.01em` / — | blanco |
| **Etiqueta técnica** | `.kronos-meta__label` (`<TechLabel>`) | mono | `12px` | `400` | — | `0.2em` | `rgb(255 255 255 / 0.8)` |
| **Tick** | `.kronos-meta__tick` | — | `10px` | — | `1` | — | `var(--color-accent)` (◆) |
| **Datos / especificación** | `k-mono`, `k-spec` | mono | `12px` | `400` | `1.6` | `0.12em` | `rgb(255 255 255 / 0.62)`; el dato destacado en blanco |
| **Enlace de sección** | `k-link` | mono | `12px` | `400` | — | `0.2em` | blanco, → en naranjo |
| **Ruta (migas)** | `k-crumb` | mono | `11px` | `400` | — | `0.16em` | `rgb(255 255 255 / 0.55)` / `0.7` el enlace |
| **Botón** | `.btn-kronos-*` | sans | `0.875rem` | `700` | — | `0.15em` | blanco (contorno: azul al llenarse) |

---

## 3. Jerarquía visual

La jerarquía la hace la **escala, no el peso**: un titular grande y liviano contra una etiqueta mono chica
(72 px contra 12 px a 1440). Entre ambos, la bajada (18–20 px al 0,78) acompaña sin competir.

**Cuándo usar cada nivel:**
- Un `k-h1` por página. Un `k-h2` por sección. `k-h3` para bloques dentro de una sección.
- La etiqueta va antes del titular y dice de qué trata la sección. Nunca lleva coordenadas de adorno.
- La línea de datos de la empresa aparece una vez por página, al cierre.

**Combinaciones a evitar:**
- Una bajada de tamaño cercano al titular, porque rompe la jerarquía.
- Una etiqueta de más de `13px`, porque deja de ser etiqueta y empieza a competir.
- Dos titulares del mismo nivel compitiendo en una misma pantalla.

---

## 4. Tracking (letter-spacing)

| Contexto | Valor | Razón |
|---|---|---|
| `k-h1` | `-0.04em` | Tamaño grande y peso liviano: el tracking negativo compacta la línea |
| `k-h1--long` | `-0.03em` | Oración más larga, algo menos apretada para leerla |
| `k-h2` | `-0.035em` | Igual criterio que `k-h1`, un paso menos |
| `k-h3` | `-0.02em` | Tamaño medio |
| Botones | `0.15em` | Texto corto en mayúsculas: el tracking positivo le da aire |
| Etiqueta y enlace de sección | `0.2em` | Panel técnico, al estilo de las referencias |
| Ruta (migas) | `0.16em` | Un paso menos que la etiqueta |
| Datos y especificaciones | `0.12em` | Se leen como cifras: sin tanto aire |
| Bajada y cuerpo | normal | La fuente ya viene ajustada para lectura larga |

---

## 5. Mayúsculas y tipo oración

**Van en mayúsculas:** la etiqueta técnica, los datos y especificaciones mono, el enlace de sección, los
rótulos de foto, la ruta y el texto de los botones.

**Nunca van en mayúsculas:** los títulos `h1`, `h2` y `h3` (de página, de sección, de bloque, de tarjeta), las
bajadas ni el cuerpo. Tampoco los títulos de proyectos y artículos, que van en tipo oración en el contenido
mismo: no se pasan a "Title Case".

**Tampoco hay naranjo dentro de un titular:** el naranjo vive en el ◆, el botón principal, las cotas y el riel
de calidad.

---

## 6. Pesos tipográficos

**Instrument Sans:**
- `300`: títulos de página y de sección (`k-h1`, `k-h2`) y el subtítulo grande del cuerpo.
- `400`: título de bloque (`k-h3`), bajadas, cuerpo.
- `500` y `600`: solo subtítulos chicos dentro del cuerpo largo (`k-prose h3`, `h4`, `strong`).
- `700`: botones.
- **Nunca** `800–900`: el peso pesado era la firma de abril y ya no lo es.

**Geist Mono:**
- `400` en todo.
- **Nunca** `700+`: la mono en negrita se satura en tamaños chicos.

**Sobre font-stretch.** No se condensa ni se expande sin una razón técnica documentada. Default = `100%`.

---

## 7. Ejemplos copiables

Del kit de kronos-web. Las clases son globales: se usan en el HTML, no se copia su CSS.

### 7.1 Apertura de sección

```html
<section class="k-sec" aria-label="Proyectos">
  <div class="k-sec__inner">
    <header class="k-head">
      <TechLabel label="PROYECTOS" />
      <h2 class="k-h2">Spools revestidos para la gran minería</h2>
      <p class="k-lede">Fabricamos y revestimos spools de 6″ a 42″ en nuestra planta de Lampa.</p>
      <a class="k-link" href="/proyectos">Ver proyectos <span aria-hidden="true">→</span></a>
    </header>
    <!-- contenido de la sección -->
  </div>
</section>
```

### 7.2 Apertura de página interior

```astro
<PageHero
  crumbs={[{ label: 'Inicio', href: '/' }, { label: 'Proyectos' }]}
  label="PROYECTOS"
  title="Proyectos de piping y revestimientos"
  lede="Más de 600 trabajos en minería, energía e industria."
/>
```

### 7.3 Datos y especificación

```html
<ul class="k-spec k-mono"><li><b>DN 900</b></li><li>ASME IX</li><li>SA 2½</li></ul>
```

### 7.4 Botones

```html
<a href="/contacto" class="btn-kronos-primary">
  <span class="btn-kronos-primary__label">SOLICITAR COTIZACIÓN</span>
  <span class="btn-kronos-primary__arrow" aria-hidden="true">→</span>
</a>
<a href="/proyectos" class="btn-kronos-outline">
  <span class="btn-kronos-outline__fill" aria-hidden="true"></span>
  <span class="btn-kronos-outline__label">VER PROYECTOS</span>
</a>
```

---

## 8. Responsive

| Rol | 393 px (iPhone 15) | 1440 px | ≥ 1560 px |
|---|---|---|---|
| `k-h1` | 36 px | 72 px | 76 px (tope) |
| `k-h2` | 32 px | 60 px | 64 px (tope) |
| `k-h3` | 22 px | 32 px | 32 px |
| `k-lede` | 18 px | 20 px | 20 px |
| `k-prose` | 17 px | 18 px | 18 px |
| Etiqueta, datos, enlace | 12 px fijos | 12 px | 12 px |

**Regla.** Lo mono es fijo en px: es metadata y mantiene su tamaño. Los titulares escalan con `clamp()`. En el
celular, el cuerpo nunca baja de 15 px.

---

## 9. Anti-patterns tipográficos

Ver `design/anti-patterns.md`. Los que tocan tipografía:

- Mezclar una tercera familia o usar serif.
- ❌ Titulares en mayúsculas, en negrita pesada o con una palabra en naranjo.
- Cortar un titular con guion (`hyphens: auto`).
- Justificar el cuerpo largo.
- Usar Geist Mono en un `h1`, `h2` o `h3`. Los titulares son siempre Instrument Sans.
- `system-ui` como decisión de diseño, en vez de dejarlo solo como fallback de emergencia.

---

## 10. Qué hacer cuando necesites un tamaño o peso nuevo

1. Ver si un rol de la tabla §2 cubre el caso.
2. Si no, y el caso se repite (≥ 2 apariciones previstas), agregar una fila a §2 y la clase al kit en el mismo
   cambio.
3. Nunca inventar un peso fuera de §6, un tamaño de etiqueta fuera de 11–12 px, ni un tracking fuera de §4.

---

## Retirados

El 20-nov-2026 (5IN-824) salieron las reglas tipográficas de abril de 2026:

- El "headline oversized" de `clamp(3rem, 10vw, 8rem)`, peso 800, en mayúsculas y con la última palabra en
  naranjo (`.cta-headline`, `.cta-line--accent`).
- La etiqueta de 11 px, peso 600, con tracking 0.3em y coordenadas de adorno.
- La regla de que los titulares de hero y CTA iban siempre en mayúsculas.

Las reemplazan el kit del estándar y las reglas 1 a 3 de `ESTANDAR.md` (kronos-web).

---

**Última actualización:** 2026-11-20 (5IN-824).
**Kit de referencia:** `src/styles/estandar.css` (kronos-web).
**Tokens relacionados:** `design/tokens.md` §1.4 y §2.
