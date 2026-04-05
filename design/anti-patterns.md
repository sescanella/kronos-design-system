# Anti-patterns — Reglas inviolables del sistema

> Este documento lista todo lo que **NO** debe hacerse en UI de Kronos Mining. Cada regla viene con el porqué. Cuando un agente LLM (o un humano) viola una de estas reglas, el trabajo está mal hecho, sin importar qué tan "bonito" se vea el resultado.
>
> **Orden de lectura.** Leer este archivo **antes** de cualquier cambio visual, junto con `DESIGN.md`.

---

## Cromáticos

### ❌ Inventar colores hex fuera del `@theme`

**Qué no hacer.** Escribir `#0a2e5c`, `#FF4500`, `rgb(120, 50, 200)` o cualquier valor de color que no exista en `src/styles/global.css` `@theme`.

**Por qué.** Rompe la consistencia del sistema, imposibilita migrar la paleta globalmente, introduce inconsistencias sutiles que se acumulan con el tiempo.

**Qué hacer.** Usar `var(--color-primary)`, clases Tailwind (`bg-primary`, `text-accent`), o si el color no existe: primero añadir al `@theme` + documentar en `tokens.md`, después usar.

**Excepción legítima.** `rgba(255,255,255, X)` sobre fondos oscuros — es la convención documentada en `tokens.md §1.4`.

---

### ❌ Naranjo `#FF5B00` en más del 5% del área visible

**Qué no hacer.** Usar accent como color de fondo de una sección completa, como color de todos los botones de la página, como background de cards repetidas, como color de texto de un párrafo largo.

**Por qué.** Es la firma cromática. Si se satura, pierde significado y el sitio empieza a verse "startup colorida" en vez de "defense-tech serio". Referencia: Anduril, True Anomaly, Saronic — todos restringen su acento a <5%.

**Qué hacer.** Accent solo en: CTAs primarios (1-2 por vista máximo), palabras clave de headlines (1-3 palabras por headline), tics técnicos (◆), dots de separación del footer, destellos de mesh gradient al 35%. **Auditar siempre con un pantallazo**: si el naranjo salta como protagonista, reducir.

---

### ❌ Mezclar una tercera font family

**Qué no hacer.** Introducir Roboto, Poppins, Montserrat, Inter, Space Grotesk, cualquier otra fuente que no sea Instrument Sans o Geist Mono.

**Por qué.** El sistema tipográfico es deliberadamente binario (sans + mono). Una tercera fuente introduce ruido visual y es imposible justificarla semánticamente.

**Qué hacer.** Si necesitas más contraste tipográfico, usa variantes de peso (100-900 de Instrument Sans) o size (clamp oversized). No una fuente nueva.

---

### ❌ Usar serif en cualquier contexto

**Qué no hacer.** Introducir Playfair, Instrument Serif, PP Editorial, Merriweather, Georgia, Times, ninguna serif.

**Por qué.** Kronos es industrial, no editorial ni lujo. Serif contradice la estética Anduril/defense-tech.

**Qué hacer.** Si alguien pide "algo más editorial", resiste. La respuesta es oversized sans uppercase con tracking ajustado.

---

### ❌ Headlines que no sean uppercase en secciones hero/CTA

**Qué no hacer.** "Ingeniería que resiste" en Title Case o sentence case en el hero.

**Por qué.** El uppercase oversized es parte de la firma visual del sistema. Es lo que comunica seriedad industrial.

**Qué hacer.** Todos los headlines de hero y CTA en uppercase con `letter-spacing: -0.02em` (tracking ajustado porque uppercase con tracking default se ve espaciado raro).

**Excepción legítima.** Headlines de páginas internas tipo blog post / artículo individual pueden ser title case porque son lectura larga editorial.

---

## Componentes

### ❌ Usar `<Button>` (componente legacy) en secciones nuevas

**Qué no hacer.** Importar `Button.astro` y usarlo en hero, CTA, secciones destacadas.

**Por qué.** `Button.astro` es legacy pre-rediseño. No soporta las microinteracciones del sistema nuevo (shimmer sweep, glow pulse, liquid fill).

**Qué hacer.** Usar las clases inline `.btn-kronos-primary` y `.btn-kronos-outline` como están definidas en `src/components/CTASection.astro`. Copiarlas directamente. Si un patrón de botón nuevo aparece repetidamente, entonces extraerlo como componente — pero no antes de verlo usado en 3+ lugares.

---

### ❌ Crear el mismo componente dos veces con distinta estética

**Qué no hacer.** Tener `CardA.astro` y `CardB.astro` que hacen lo mismo pero con padding, border radius o font size distintos.

**Por qué.** Fragmenta el sistema. Un mismo concepto debe tener una sola representación visual.

**Qué hacer.** Si hay variantes legítimas, una sola componente con prop `variant`. Si no, consolidar en una.

---

### ❌ Inline styles con valores mágicos

**Qué no hacer.** `<div style="padding: 23px; color: #083a75;">`.

**Por qué.** Imposible mantener, invisible al sistema, rompe consistencia.

**Qué hacer.** Clases Tailwind o `<style>` scoped del `.astro` con valores derivados de `var(--*)` o escalas Tailwind estándar.

**Excepción legítima.** Valores calculados dinámicamente en runtime (e.g., `style={`--word-index: ${i}`}` para staggers CSS custom property). Siempre custom properties, nunca valores hex/px hardcodeados.

---

## Animación

### ❌ Hero con `data-reveal` Y GSAP SplitText simultáneos

**Qué no hacer.** Añadir `data-reveal` (que dispara `ScrollReveal.astro`) a un elemento que también tiene GSAP SplitText animándolo.

**Por qué.** Los dos sistemas compiten por las mismas transforms. El resultado es un flash, un salto, o el texto que nunca se revela.

**Qué hacer.** Elegir uno. En secciones hero/CTA con SplitText, no usar `data-reveal`. En secciones de body cards con IntersectionObserver + CSS, usar `data-reveal` pero NO GSAP.

---

### ❌ Ignorar `prefers-reduced-motion`

**Qué no hacer.** Lanzar shaders, SplitText, glow pulses, shimmer sweeps sin verificar la media query.

**Por qué.** Accesibilidad no negociable. Usuarios con vestibular disorders, epilepsia o preferencia de usuario configurada se ven afectados.

**Qué hacer.** Toda animación debe tener su fallback:
- Shader: no se monta, queda fondo sólido.
- GSAP SplitText: `gsap.set` al estado final directamente.
- CSS animations: `@media (prefers-reduced-motion: reduce) { animation: none !important; }`.

---

### ❌ Animaciones decorativas sin propósito

**Qué no hacer.** Añadir floating balls, orbital particles, parallax random, cursor trail, mouse followers, solo porque "se ve cool".

**Por qué.** Kronos es defense-tech serious. Cada animación debe comunicar algo: entrada de contenido, feedback de interacción, jerarquía, estado.

**Qué hacer.** Antes de añadir animación, preguntarse: ¿qué comunica? Si la respuesta es "se ve bonito", no va.

---

## Layout y scroll

### ❌ Secciones del home sin clase `snap-section`

**Qué no hacer.** Añadir una `<section>` al `index.astro` sin la clase `snap-section`.

**Por qué.** Rompe el flujo del scroll-snap del home. La sección queda "entre slides" y descuadra la experiencia.

**Qué hacer.** Toda sección que vive en `src/pages/index.astro` debe tener `class="snap-section ..."`. Respetar `min/max-height: calc(100svh - 5rem)`. Ver `src/styles/global.css` líneas 386–403.

**Excepción documentada.** El `<footer>` es deliberadamente NO snap point (regla en `global.css` línea ~402). Esa es la única excepción.

---

### ❌ Romper el scroll-snap con overflow escondido en el body

**Qué no hacer.** Añadir `overflow: hidden` al `body` o al `html`, o cambiar `scroll-snap-type` sin entender las implicaciones.

**Por qué.** El scroll-snap vive en `html`. Cualquier interferencia con el scroll chain lo rompe silenciosamente.

**Qué hacer.** Si necesitas contener overflow de una sección, hacerlo en la sección misma (`overflow: hidden` en la `<section>`), nunca en `body`/`html`.

---

### ❌ Asumir que el scroll-snap aplica en mobile

**Qué no hacer.** Escribir JS o CSS que dependa de que las slides tengan altura de viewport en mobile.

**Por qué.** El scroll-snap está envuelto en `@media (min-width: 1024px)`. En mobile las secciones son flujo libre.

**Qué hacer.** Diseñar responsive-first. En mobile las secciones son documento scrollable normal.

---

## Idioma y contenido

### ❌ Mezclar inglés y español en copy visible

**Qué no hacer.** "Book a demo", "Learn more", "Our services", "Get started".

**Por qué.** El sitio es 100% español de Chile. Mezclar idiomas rompe la identidad de marca y es señal de copy-paste de templates.

**Qué hacer.** "Agendar visita", "Ver más", "Nuestros servicios", "Comenzar".

**Excepción legítima.** Términos técnicos que no tienen traducción establecida en español de Chile (ej. "piping", "spools", "know-how" en contextos muy específicos). Usar criterio — si tu contraparte chilena lo diría en inglés, déjalo; si no, traduce.

---

### ❌ Emojis decorativos en UI

**Qué no hacer.** `🚀 Lanza tu proyecto`, `✨ Diseño moderno`, `💡 Soluciones inteligentes`.

**Por qué.** Kronos es B2B serio. Los emojis decorativos hacen ver el sitio como startup genérica.

**Qué hacer.** Símbolos técnicos unicode son OK cuando cumplen función semántica: `◆` (tic técnico), `●` (separador), `→` (flecha de acción). Nada con emoji skin tone ni expresiones.

---

## Arquitectura

### ❌ Modificar `@theme` sin actualizar `tokens.md`

**Qué no hacer.** Añadir un token a `src/styles/global.css` en un commit que no toque también `design/tokens.md`.

**Por qué.** `@theme` y `tokens.md` son dos caras del mismo token. Si se desincronizan, la documentación miente y los agentes LLM siguen reglas obsoletas.

**Qué hacer.** Commit atómico: cambio de `@theme` + cambio de `tokens.md` en el mismo commit, siempre.

---

### ❌ Crear un componente visual sin documentarlo en `components.md`

**Qué no hacer.** Añadir `src/components/FooBar.astro` sin registrarlo en `design/components.md`.

**Por qué.** El catálogo de componentes es el mapa que Claude Code usa para saber qué existe. Si no está en el mapa, no existe para el agente y se reinventa.

**Qué hacer.** Al crear un componente nuevo, registrarlo en `components.md` con: ruta, propósito, estado (canónico/en desarrollo/legacy), y link al componente que se usó como referencia.

---

### ❌ Ignorar el componente canónico `CTASection.astro`

**Qué no hacer.** Construir una nueva sección hero/CTA desde cero sin consultar el canónico.

**Por qué.** `CTASection.astro` es la encarnación del sistema. Cualquier sección que divergue sin justificación introduce drift.

**Qué hacer.** Antes de construir: leer `CTASection.astro` completo. Copiar su estructura (label técnico + headline oversized + sub + botones + footer técnico) y adaptar contenido. Si divergues, justifica en un comentario del componente nuevo.

---

## Accesibilidad

### ❌ Focus states invisibles

**Qué no hacer.** `outline: none` sin reemplazo. `:focus { }` vacío. Remover outline del browser sin añadir `:focus-visible` estilizado.

**Por qué.** Usuarios de teclado quedan perdidos. WCAG violado.

**Qué hacer.** Todo elemento interactivo debe tener `:focus-visible` con contraste claro: outline 2px (`#fff` sobre fondo oscuro, `#FF5B00` sobre fondo claro), offset 3px.

---

### ❌ Contraste insuficiente en texto blanco sobre mesh/shader

**Qué no hacer.** Texto blanco directamente sobre un mesh gradient colorido sin overlay.

**Por qué.** Contraste baja a <3:1 en zonas claras del gradiente. Ilegible.

**Qué hacer.** Siempre añadir overlay gradient encima del shader (ver `.cta-overlay` en CTASection). Radial + linear combinados. Opacidad `0.55–0.82`. Validar con Lighthouse o axe.

---

## Uso de este documento

1. **Antes de cualquier cambio visual**, releer las secciones relevantes de este archivo.
2. **Si un requisito del usuario contradice una regla**, no la violes en silencio — avisa al usuario con cita específica del anti-pattern y propón alternativa compatible.
3. **Si detectas un anti-pattern nuevo recurrente**, añádelo a este archivo.
4. **Nunca eliminar** una regla de este archivo sin justificación documentada en el commit.
