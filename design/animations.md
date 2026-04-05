# Patrones de animación — Kronos Mining

> El sistema Kronos tiene **4 patrones firmados** de animación. Cualquier animación en el
> sitio debe usar uno de estos o justificar por qué no. Las animaciones decorativas sin
> propósito están prohibidas por `design/anti-patterns.md` §Animación.
>
> **Fuente de verdad de todos los parámetros numéricos:** `src/components/CTASection.astro`.
> Este archivo documenta los patrones y cómo copiarlos, no duplica los parámetros exactos.
> Cuando necesites los valores precisos, copia directamente del canónico.

## Stack instalado

Verifica en `package.json` que estas dependencias están presentes antes de usar los patrones que dependen de JS:

- `@paper-design/shaders` (`^0.0.72`) — Patrón A (shader mesh gradient WebGL)
- `gsap` (`^3.14.2`, incluye `SplitText` y `ScrollTrigger` gratis desde septiembre 2024 post-Webflow) — Patrón B
- Patrones C y D son CSS puro, sin dependencias

**Nunca añadir una nueva dependencia de animación sin aprobación del usuario.** Prohibido traer `framer-motion`, `motion-one`, `anime.js`, `lottie`, `three.js` (para animación de UI), `locomotive-scroll`.

---

## Los 4 patrones firmados

### Patrón A — Shader mesh gradient WebGL (Paper Shaders)

**Qué hace.** Fondo animado con WebGL que mezcla 4 colores en un mesh gradient suave. En Kronos se usa con la paleta `#052650 / #083A75 / #0A4C95 / #FF5B00` para generar un ambiente "tech premium" sin recurrir a imágenes o videos estáticos.

**Cuándo usar.**
- Secciones hero de alto impacto.
- Secciones CTA al final de una página con peso estratégico.
- Fondos de landing pages de campaña.

**Cuándo NO usar.**
- Secciones de contenido de lectura larga (blog, artículo detalle).
- Secciones del home que ya tienen otro elemento visual dominante (logo carrusel, globe 3D, video).
- Páginas con performance crítico (pricing, checkout si existiera).
- Mobile (`< 768px`) — se desactiva automáticamente por batería y performance.

**Reglas de activación/desactivación (obligatorias).**
- Desactivado si `window.innerWidth < 768`.
- Desactivado si `window.matchMedia('(prefers-reduced-motion: reduce)').matches`.
- Montaje lazy con `IntersectionObserver` (`threshold: 0.1`, `rootMargin: '200px 0px'`) — no se inicializa hasta que la sección está a 200px de entrar al viewport.
- Cleanup en `astro:before-swap` (importante para View Transitions futuras).
- Fallback sólido: la sección debe tener `bg-primary-dark` (o `background: var(--color-primary-dark)` en el layer del shader) como clase base para que el color exista antes de que el canvas monte.

**Anatomía de capas necesaria.**
Cualquier sección que use Patrón A debe tener 4 layers con z-index estandarizado (ver `tokens.md §6`):

1. Canvas del shader (`z-index: 0`) — `<div class="cta-shader-layer" data-cta-shader aria-hidden="true"></div>`
2. Overlay gradient (`z-index: 10`) — radial + lineal para garantizar contraste del texto.
3. Grid blueprint decorativo (`z-index: 10`) — opcional, refuerza el mood técnico.
4. Contenido (`z-index: 20`) — el texto y botones.

**Snippet de referencia.**
Copiar desde `src/components/CTASection.astro`:
- HTML: las 4 layers (`cta-shader-layer`, `cta-overlay`, `cta-grid`, `cta-content`).
- CSS scoped: `.cta-shader-layer`, `.cta-shader-layer :global(canvas)`, `.cta-overlay`, `.cta-grid`.
- Script: la función `initCTAShader()` completa, `destroyCTAShader()`, y los listeners `astro:page-load` / `astro:before-swap`.

**Uniforms del shader (referencia, valores exactos en el canónico).**
- `u_colors`: array de 4 colores de la paleta convertidos con `getShaderColorFromString`.
- `u_colorsCount`: 4.
- `u_distortion`, `u_swirl`, `u_grainMixer`, `u_grainOverlay`: ver valores exactos en `CTASection.astro`. Si el shader se siente muy intenso, bajar `u_distortion` y `u_swirl`.
- Speed: último argumento posicional de `new ShaderMount(...)`, muy bajo (respiración, no movimiento). Ver canónico.

**Error handling.**
El script envuelve `new ShaderMount(...)` en `try/catch`. Si WebGL falla (Safari viejo, context limit alcanzado), se cae al fallback sólido y se loguea warning con `console.warn('[CTASection] Shader init failed, using fallback:', err)`. Nunca bloquea el render del resto de la sección.

---

### Patrón B — GSAP SplitText + ScrollTrigger (text reveal)

**Qué hace.** Revela headlines línea por línea cuando la sección entra en viewport, con efecto `yPercent + blur + opacity` y stagger. El sub y los botones caen después con un fade + y-offset delayed.

**Cuándo usar.**
- Headlines de secciones hero/CTA donde el texto es protagonista.
- Secciones con "momento wow" de entrada.
- Máximo 2-3 por página para preservar el impacto.

**Cuándo NO usar.**
- Navigation (Header, menu items) — no hay "entrada" aquí.
- Body copy de lectura larga.
- Componentes que ya tienen `data-reveal` (conflicto, ver `anti-patterns.md §Animación → data-reveal + GSAP SplitText simultáneos`).

**Reglas de activación/desactivación.**
- Fallback en `prefers-reduced-motion`: usar `gsap.set` directo al estado final (`opacity: 1`, `y: 0`, `filter: 'none'`). No intentar animar.
- `ScrollTrigger.create` con `once: true` para no re-disparar al volver a la sección.
- `start: 'top 75%'` — dispara cuando la sección está 75% dentro del viewport.
- Cleanup en `astro:before-swap`: `splitInstance.revert()` + recorrer `ScrollTrigger.getAll()` y matar los triggers cuyo `.trigger` pertenezca a esta sección (filtro por `closest('[aria-label="Contacto"]')` o por el attr que identifique la sección canónica).
- Re-init en `astro:page-load`.

**Parámetros relevantes (ver valores exactos en el canónico).**
- `SplitText` con `type: 'lines'`, `linesClass: 'cta-split-line'` (la clase interna para wrap de líneas con `overflow: hidden`).
- `gsap.set` inicial sobre líneas: `yPercent: 110, opacity: 0, filter: 'blur(10px)'`.
- `gsap.to` en `onEnter`: `duration`, `stagger`, `ease` (`power3.out`) — ver canónico.
- `sub` y `actions` con `delay` adicional respecto al headline.

**Importante — clase global para SplitText.** `SplitText` genera los `<div class="cta-split-line">` en runtime, por lo que el CSS scoped de Astro no los alcanza. En el canónico la clase está declarada con selector `:global(.cta-split-line)` dentro del bloque `<style>` scoped. Cualquier sección que use Patrón B debe replicar ese patrón o mover la declaración a CSS global.

**Snippet de referencia.**
Copiar desde `CTASection.astro`:
- Imports: `import { gsap } from 'gsap'`, `import { SplitText } from 'gsap/SplitText'`, `import { ScrollTrigger } from 'gsap/ScrollTrigger'`, `gsap.registerPlugin(SplitText, ScrollTrigger)`.
- La función `initCTAAnimations()` completa.
- La función `cleanupAll()` y los listeners `astro:page-load` / `astro:before-swap`.

---

### Patrón C — Botón primario con shimmer sweep + glow pulse (CSS puro)

**Qué hace.** Botón con fondo accent que:
- En reposo: respira con un glow pulse infinito (`@keyframes cta-glow-pulse`, `3.5s ease-in-out infinite`, `box-shadow` pulsante en `rgba(255, 91, 0, 0.28)`).
- En hover: un destello diagonal atraviesa el botón (`::before` con `linear-gradient 115deg` + `translateX` de `-120%` a `120%`), se eleva `-2px` en `translateY`, y la flecha interna se desliza `4px` a la derecha.

**Cuándo usar.**
- CTA primario de secciones hero/CTA (máximo 1 por sección).
- Botones de alta importancia donde la atención debe ser inevitable.

**Cuándo NO usar.**
- Botones secundarios (usar Patrón D).
- Links de navegación.
- Botones dentro de cards o componentes densos (el glow distrae).
- Nunca como único tipo de botón de una página (satura el patrón).

**Reglas de activación/desactivación.**
- `@media (prefers-reduced-motion: reduce)`: `animation: none !important`, `transition: none !important` para `.btn-kronos-primary`, `.btn-kronos-primary::before`, `.btn-kronos-primary__arrow` (y también afecta `.btn-kronos-outline__fill`, ver bloque unificado en el canónico).
- `:focus-visible` con `outline: 2px solid #ffffff`, `outline-offset: 3px` (crítico para accesibilidad).
- En mobile, el shimmer sweep sigue funcionando en tap (`:active` hereda `:hover` en móviles modernos). Se mantiene activo.

**Snippet de referencia.**
Copiar desde `CTASection.astro` las clases:
- `.btn-kronos-primary` (base, `isolation: isolate`, `overflow: hidden`).
- `.btn-kronos-primary::before` (shimmer).
- `.btn-kronos-primary__label`, `.btn-kronos-primary__arrow` (contenido sobre `z-index: 2`).
- `.btn-kronos-primary:hover`, `:hover::before`, `:hover .btn-kronos-primary__arrow`.
- `.btn-kronos-primary:focus-visible`.
- `@keyframes cta-glow-pulse`.

**HTML mínimo:**
```html
<a href="..." class="btn-kronos-primary">
  <span class="btn-kronos-primary__label">TEXTO CTA</span>
  <span class="btn-kronos-primary__arrow" aria-hidden="true">→</span>
</a>
```

---

### Patrón D — Botón outline con liquid fill clip-path (CSS puro)

**Qué hace.** Botón outline fino (`border: 1px solid rgba(255,255,255,0.4)`) que al hover se llena con un óvalo blanco que sube desde abajo (`clip-path: ellipse(120% 0% at 50% 100%)` → `ellipse(140% 160% at 50% 100%)`), invirtiendo el color del texto a azul Kronos `#083A75`.

**Cuándo usar.**
- CTA secundario pareado con Patrón C.
- Cualquier acción secundaria importante pero no primaria.
- Puede repetirse más que el primario (2-3 por sección no es exagerado).

**Cuándo NO usar.**
- Solo sobre fondos oscuros. Sobre fondos claros no tiene suficiente contraste.
- Sin un Patrón C cerca (queda huérfano estéticamente).

**Reglas de activación/desactivación.**
- `@media (prefers-reduced-motion: reduce)`: `transition: none !important` para `.btn-kronos-outline__fill` (cubierto en el mismo bloque reduced-motion del canónico).
- `:focus-visible` con `outline: 2px solid #FF5B00`, `outline-offset: 3px`.
- Transición del `clip-path` con `cubic-bezier(0.25, 0.46, 0.45, 0.94)` que da la sensación de líquido.

**Snippet de referencia.**
Copiar desde `CTASection.astro`:
- `.btn-kronos-outline`, `.btn-kronos-outline__fill`, `.btn-kronos-outline__label`.
- `.btn-kronos-outline:hover`, `:hover .btn-kronos-outline__fill`.
- `.btn-kronos-outline:focus-visible`.

**HTML mínimo:**
```html
<a href="..." class="btn-kronos-outline">
  <span class="btn-kronos-outline__fill" aria-hidden="true"></span>
  <span class="btn-kronos-outline__label">TEXTO SECUNDARIO</span>
</a>
```

---

## Ciclo de vida en Astro (obligatorio para Patrones A y B)

Todo script de animación que toque el DOM debe seguir este patrón para ser compatible con View Transitions futuras de Astro. Los nombres de funciones son los reales del canónico:

```javascript
// Variables de instancia en el scope del <script>
let shaderInstance: any = null;
let splitInstance: any = null;

function initCTAShader()    { /* Patrón A: IntersectionObserver + new ShaderMount(...) */ }
function destroyCTAShader() { /* shaderInstance.dispose(); shaderInstance = null; */ }
function initCTAAnimations(){ /* Patrón B: SplitText + ScrollTrigger.create */ }

function initAll() {
  initCTAShader();
  initCTAAnimations();
}

function cleanupAll() {
  destroyCTAShader();
  if (splitInstance?.revert) { splitInstance.revert(); splitInstance = null; }
  ScrollTrigger.getAll().forEach((t) => {
    if (t.trigger && (t.trigger as HTMLElement).closest('[aria-label="Contacto"]')) {
      t.kill();
    }
  });
}

// Primer load
initAll();
// Astro View Transitions lifecycle
document.addEventListener('astro:page-load', initAll);
document.addEventListener('astro:before-swap', cleanupAll);
```

**Razón.** Hoy Astro Kronos no usa `<ClientRouter />`, pero los listeners son defensivos. Si en el futuro se activa View Transitions, los scripts no se duplicarán ni generarán memory leaks. El filtro por `closest('[aria-label="Contacto"]')` es el que garantiza que `cleanupAll` solo mate los triggers de la sección canónica — en secciones nuevas, cambiar ese selector al `aria-label` correspondiente.

---

## Reglas globales

1. **Reduced motion siempre.** Cualquier patrón debe tener su fallback a estado final.
2. **Mobile degradation.** Shader WebGL off (`< 768px`). GSAP SplitText + CSS patterns (C, D) siguen activos en todos los breakpoints.
3. **Una dependencia más requiere discusión.** No añadir `framer-motion`, `motion-one`, `anime.js`, `lottie` sin justificación.
4. **Los parámetros numéricos viven en el canónico.** Si necesitas un valor exacto, cópialo de `CTASection.astro`. Si ajustas el canónico, el sistema entero se actualiza (por eso no se duplican aquí).
5. **Nunca combinar `data-reveal` con Patrón B en el mismo elemento** (ver `anti-patterns.md §Animación`).
6. **Cada animación comunica algo.** Si no puedes explicar en una frase qué comunica (entrada, jerarquía, feedback, estado), no va.

---

## Cuándo proponer un quinto patrón

Solo si:
1. Hay un caso concreto repetible que los 4 existentes no cubren.
2. El patrón nuevo se puede implementar con las dependencias ya instaladas (sin añadir libs).
3. El patrón es usable en al menos 3 componentes distintos.
4. El usuario lo aprueba explícitamente.

Si pasa los 4 filtros: documentarlo como Patrón E aquí, implementarlo en un componente canónico (probablemente `CTASection.astro` si aplica, o un nuevo canónico si es un tipo de sección distinta), y referenciarlo desde `DESIGN.md §5`.

---

**Última actualización:** 2026-04-04 (creación inicial)
**Componente canónico de referencia:** `src/components/CTASection.astro`
