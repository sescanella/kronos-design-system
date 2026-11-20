# Kronos Mining — Design System

> **Propósito de este archivo.** Fuente única de verdad del lenguaje visual de kronosmining.tech. Escrito para ser leído por agentes LLM (Claude Code, Cursor, otros) y por humanos. Cuando construyas, modifiques o audites cualquier UI del proyecto, este documento manda sobre cualquier improvisación estética.
>
> **Cómo se lee.** Este archivo es el router. Los detalles viven en `design/tokens.md`, `design/typography.md`, `design/icons.md`, `design/components.md`, `design/animations.md` y `design/anti-patterns.md`. Carga bajo demanda solo las secciones que necesites.
>
> **Kit de referencia (desde el 20-nov-2026).** El kit del estándar de kronos-web encarna el sistema: `src/styles/ESTANDAR.md` (reglas, con tests), `src/styles/estandar.css` (clases `k-*` y fichas), `PageHero.astro`, `CTASection.astro` y `PageTransition.astro`. La referencia de este repo es `reference/astro/CTASection.astro`. Cuando dudes sobre proporciones, jerarquías o movimiento, replica sus decisiones antes que inventar.

---

## 1. Identidad visual

**Estética objetivo.** Industrial-tech con restraint cromático. Referencias canónicas, medidas en el DOM el 13-nov-2026: [Anduril Industries](https://www.anduril.com/), [Saronic Technologies](https://www.saronic.com/), [Mach Industries](https://machindustries.com/) y [Hadrian](https://www.hadrian.co/). Referencias secundarias y detalle de qué consultar en cada una: `design/references.md`. NO SaaS colorido, NO startup playful, NO ilustraciones decorativas.

**Principios inviolables:**

1. **Restraint cromático.** El naranjo `#FF5B00` ocupa `< 5%` del área visible en cualquier vista. Se usa en el botón principal, el ◆ de la etiqueta, las cotas del dibujo y el riel de calidad. Nunca dentro de un titular ni como fondo dominante.
2. **Jerarquía por escala, no por peso.** Titulares grandes y livianos, tipo oración (`k-h1` 72 px y `k-h2` 60 px a 1440, peso 300), contra etiquetas mono chicas (12 px). Contraste de escala = personalidad.
3. **Espacio negativo generoso.** Respira. Menos elementos, mejor posicionados.
4. **Etiquetas técnicas en monoespaciada.** Etiquetas contextuales como `CONTACTO`, datos y certificaciones. En Geist Mono, mayúsculas, 12 px, `letter-spacing: 0.2em`. Solo datos reales: nada de coordenadas de adorno.
5. **Movimiento con propósito.** 7 patrones con nombre y fichas (`design/animations.md`): las líneas se trazan y el contenido se asienta. Nada decorativo, nada en bucle.
6. **100% español en contenido.** Todo el copy visible para el usuario final es en español de Chile. Las keywords técnicas en código pueden ser inglés.
7. **El plano de taller.** Cada página es una lámina del mismo juego de planos de Kronos: la misma apertura (ruta → etiqueta → título → bajada), las mismas líneas finas, datos en mono, fotos reales con su rótulo encima y cotas solo donde miden algo.

---

## 2. Paleta

Definida en `src/styles/global.css` `@theme`. Detalles y uso semántico en `design/tokens.md`.

| Token | Hex | Uso |
|---|---|---|
| `--color-primary-dark` | `#052650` | Fondos dominantes de secciones oscuras |
| `--color-primary` | `#083A75` | Azul corporativo, superficies secundarias |
| `--color-primary-light` | `#0A4C95` | Highlights y gradientes |
| `--color-accent` | `#FF5B00` | Botón principal, ◆, cotas, riel de calidad (`< 5%` del área; nunca en titulares) |
| `--color-accent-dark` | `#E64A19` | Hover states de accent |
| `--color-accent-light` | `#FF7A33` | Reservado (sin uso desde que salió el brillo de botones) |
| `--color-neutral-*` | Gray 50-900 | Textos secundarios, bordes, separadores |

**Texto sobre fondos oscuros:** 4 grises, 1 / 0,78 / 0,62 / 0,55 (ninguno bajo 0,55), y 2 líneas, 0,14 y 0,4. Detalle en `design/tokens.md` §1.4.

---

## 3. Tipografía

| Familia | Variable CSS | Uso |
|---|---|---|
| Instrument Sans (variable) | `var(--font-sans)` | Titulares tipo oración (peso 300), bajadas, cuerpo, botones |
| Geist Mono (variable) | `var(--font-mono)` (alias legacy `--font-heading`) | Etiquetas, datos, rótulos, ruta, enlace de sección |

Detalles completos en `design/typography.md`.

**Regla de oro.** Jamás mezclar una tercera familia. Jamás usar serif. Jamás fallback a `system-ui` como decisión de diseño (solo como fallback de emergencia).

---

## 4. Componentes canónicos

Detalles completos en `design/components.md`.

| Componente | Archivo | Estado |
|---|---|---|
| **CTASection** | `src/components/CTASection.astro` | **CANÓNICO** — cierre de toda página |
| **PageHero** | `src/components/PageHero.astro` | **CANÓNICO** — apertura de toda página interior |
| **PageTransition** | `src/components/PageTransition.astro` | **CANÓNICO** — cambio de página (movimiento, patrón 1) |
| **TechLabel** | `src/components/TechLabel.astro` | **ALINEADO** — label técnica reutilizable `◆ LABEL ─── coord` |
| **BlueprintGrid** | `src/components/BlueprintGrid.astro` | **ALINEADO** — grid blueprint decorativo para secciones oscuras |
| TechnicalCatalog | `src/components/TechnicalCatalog.astro` | DEPRECADO — sin uso, se borra en 5IN-825 |
| Header | `src/components/Header.astro` | Legacy, pendiente alinear a canon |
| Footer | `src/components/Footer.astro` | Legacy, pendiente alinear a canon |
| Button | `src/components/Button.astro` | Legacy — no usar en secciones nuevas, preferir `.btn-kronos-*` globales |

**Estilos globales disponibles** (en `src/styles/global.css`):
- `.btn-kronos-primary` / `.btn-kronos-outline` — botón principal y de contorno (responden con el patrón 5)
- `.kronos-meta*` — label técnica pattern (tick + label + divider + coord)
- `.kronos-blueprint` — grid blueprint decorativo

**Cuando crees UI nueva**, la instrucción base es:

> "Usa el kit del estándar (`k-sec`, `k-head`, `k-h1`/`k-h2`/`k-h3`, `k-lede`, `k-link`, `k-spec`), `<PageHero>` para abrir, `<CTASection>` para cerrar, `<TechLabel>` y `.btn-kronos-*`. Mueve solo con los 7 patrones y sus fichas. No inventes tokens, colores, fonts, escalas ni animaciones que no estén en `DESIGN.md` o `design/*.md`."

---

## 4b. Iconografía

**Biblioteca oficial:** [Lucide Icons](https://lucide.dev) — stroke-based, tree-shakeable, multi-stack.

Detalles completos en `design/icons.md`. Los 4 tamaños canónicos: Inline (16px), Standard (20px), Prominent (24px), Display (40–48px).

**Regla de oro.** Los iconos son funcionales, no decorativos. Si un icono no aporta información que el texto no puede dar, no va. Los símbolos técnicos unicode (`◆`, `●`, `→`) del sistema se preservan — Lucide es para acciones e información, no para labels técnicas.

---

## 5. Movimiento

Detalles, fichas y fuentes en `design/animations.md`. Los 7 patrones del sistema:

1. **Cambio de página.** La barra queda y la página se vuelve tarjeta (`PageTransition.astro`).
2. **Entrada de la primera pantalla.** Etiqueta → título → bajada suben 24 px, una vez, solo con CSS.
3. **Aparición de sección.** La línea se traza, la apertura sube y el contenido aparece como un bloque. Nunca tarjeta por tarjeta.
4. **Trazo.** Cotas y líneas guía se dibujan una vez al verse. Es la firma del sistema.
5. **Respuesta.** Al poner el mouse encima, en 150 ms, siempre dentro de `@media (hover: hover)`.
6. **Medios en bucle.** Video real, solo mientras se ve y con botón de pausa.
7. **Carga.** La línea de 1 px bajo la barra.

**Fichas:** cuatro duraciones (150, 250, 400 y 700 ms) y tres curvas (`taller`, `entrada`, `salida`).

**Stack:** CSS e `IntersectionObserver`, sin dependencias de animación.

---

## 6. Etiquetas técnicas (patrón Anduril)

Elemento firma del sistema. Abren cada sección y dicen de qué trata:

```
◆ CONTACTO
```

**Anatomía:**
- `◆` tick naranjo 10px
- Etiqueta: texto contextual libre en Geist Mono, 12 px, mayúsculas, `letter-spacing: 0.2em`, `rgb(255 255 255 / 0.8)`
- Dato opcional (`coord`): solo si es un dato real que el visitante usa; nunca coordenadas de adorno

**Regla de etiquetas.** El texto de la etiqueta es libre y contextual: describe la sección que acompaña. No hay
catálogo fijo ni numeración. Ejemplos válidos: `PORTADA`, `SERVICIOS`, `PROYECTOS`, `CONTACTO`.

**Línea de datos de la empresa** (al cierre, una vez por página): `Kronos Mining · Lampa, Chile · ISO 9001 /
14001 / 45001 · Desde 2016`, en Geist Mono de 11 px al 0,62.

---

## 7. Responsive

- **Mobile (< 768px).** Una columna. Los titulares escalan con `clamp()`. Botones a todo el ancho, apilados. Objetivos táctiles de 44 px o más; cuerpo nunca bajo 15 px.
- **Tablet (768–1023px).** Layout intermedio, jerarquía preservada.
- **Desktop (≥ 1024px).** Scroll-snap en el home activo (ver `src/styles/global.css` líneas 386–403). Padding generoso, labels técnicas completas.

### 7.1 Video

Solo material real (un escaneo, la planta), sin interfaz de software ni logos ajenos:
- dura de 4 a 8 s, en bucle de ida y vuelta, sin audio;
- H.264 con `faststart`, de menos de 1 MB;
- `preload="none"` con póster;
- se reproduce solo mientras se ve y lleva botón de pausa (patrón 6);
- queda quieto con movimiento reducido o ahorro de datos.

Los renders y simulaciones van solo rotulados como tales. Regla completa: `ESTANDAR.md` 10b (kronos-web).

### 7.2 Cifras

Las cifras van en el texto o como especificación mono (`k-spec`: `DN 900 · ASME IX · SA 2½`), de 3 a 4 por
sección como máximo. No hay contadores ni números en negrita pesada.

**Regla del home.** Cada sección del home lleva `snap-section` (`scroll-snap-type: y proximity`) y mide lo que
mide su contenido, sin alto fijo. El ajuste de scroll es solo del home: ninguna pieza compartida (el cierre, el
pie) lleva `snap-section`, y el pie no es punto de ajuste.

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
- `prefers-reduced-motion`: cada patrón tiene su versión quieta (`design/animations.md`).
- Nada se mueve solo más de 5 s sin pausa (WCAG 2.2.2).
- Ningún texto bajo 0,55 de opacidad sobre el azul.
- `focus-visible`: outline 2px (blanco sobre fondo oscuro, accent sobre fondo claro), offset 3px.
- `aria-label` en `<section>` decorativas, `aria-hidden="true"` en layers puramente visuales.
- Skip link ya presente en `BaseLayout.astro`.

---

## 9. Anti-patterns

Ver `design/anti-patterns.md` para la lista completa. Los más críticos:

- ❌ Inventar colores hex fuera de `@theme`.
- ❌ Mezclar una tercera font family.
- ❌ Usar emojis decorativos en UI (los `◆ ●` técnicos son OK, los `🚀 ✨ 💡` NO).
- ❌ Animar fuera de los 7 patrones o de las fichas; mover tarjeta por tarjeta, contar cifras o brillar en bucle.
- ❌ Naranjo en área `> 5%` de la vista.
- ❌ Secciones del home sin clase `snap-section`.
- ❌ Usar `<Button>` (componente legacy) en secciones nuevas — usar los patrones `.btn-kronos-*` del CTASection.
- ❌ Iconos decorativos sin función — ver `design/icons.md §8`.
- ❌ Mezclar librerías de iconos — Lucide es la única permitida.
- ❌ Ignorar `prefers-reduced-motion`.
- ❌ Titulares en mayúsculas o con una palabra en naranjo.

---

## 10. Workflow para modificaciones

**Para cualquier trabajo de UI, invoca el skill `/rediseño`.** Vive en `.claude/skills/rediseño/SKILL.md` y define el flujo obligatorio de lectura, propuesta, implementación y auditoría.

Reglas transversales que el skill hace cumplir:

1. **Antes de escribir código UI**, leer `DESIGN.md` + el `design/*.md` relevante + `src/components/CTASection.astro`.
2. **Replica, no inventes.** Si el patrón ya existe como componente (`<TechLabel>`, `<BlueprintGrid>`) o clase global (`.btn-kronos-*`, `.kronos-meta*`, `.kronos-blueprint`), úsalo directamente — no dupliques CSS.
3. **Si tienes que introducir un patrón nuevo**, primero actualiza `DESIGN.md` y el `design/*.md` correspondiente, después codéalo.
4. **Después de un cambio visual significativo**, audita que el naranjo siga `< 5%`, que las etiquetas sigan en Geist Mono y que ningún titular quede en mayúsculas ni con naranjo. En kronos-web corre `npm test`: `estandar-sitio`, `movimiento` y `design-system-al-dia` revisan el estándar.
5. **Nunca toques** `src/styles/global.css` `@theme` sin actualizar `design/tokens.md` en el mismo commit.

---

**Última actualización del sistema:** 2026-11-20 — 5IN-824: el estándar de noviembre (kit `k-*`, titulares tipo oración, 7 patrones de movimiento con fichas) pasa al design system; los patrones de abril quedan en las secciones "Retirados" de cada documento.
**Kit vigente:** `src/styles/estandar.css` + `PageHero.astro` + `CTASection.astro` + `PageTransition.astro` (kronos-web).
