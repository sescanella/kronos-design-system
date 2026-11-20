# Movimiento — Kronos Mining

> Desde el 20-nov-2026 el sistema tiene **7 patrones de movimiento con nombre** y **fichas** de duración y
> curva. Toda animación usa uno de esos patrones con sus fichas, o no va. Estos patrones reemplazan a los 4
> "patrones firmados" de abril (ver **Retirados** al final).
>
> **De dónde salen los valores.** Las duraciones y curvas vienen de Material 3 (`md-sys-motion`, repo
> material-web) y de Carbon (`@carbon/motion`), leídos en su fuente el 20-nov-2026. El cambio de página
> conserva los tiempos que Sebastián aprobó el 13-nov-2026. Las fichas viven en el CSS del sitio
> (`src/styles/estandar.css` de kronos-web) y este documento las cita tal cual:
> `tests/design-system-al-dia.test.mjs` compara las dos copias.
>
> **El concepto.** El sitio se lee como un plano de taller: las líneas se trazan y el contenido se asienta.
> Nada rebota, nada brilla, nada se repite en bucle sin razón.

---

## Fichas

| Ficha | Para qué | Fuente |
|---|---|---|
| `--k-dur-1: 150ms` | Responder: mouse encima, foco, cambio de color | M3 `short3` · Carbon `moderate-01` |
| `--k-dur-2: 250ms` | Controles: menú, acordeón, filtros | M3 `medium1` · Carbon `moderate-02` (240) |
| `--k-dur-3: 400ms` | Aparición de un bloque | M3 `medium4` · Carbon `slow-01` |
| `--k-dur-4: 700ms` | La entrada de la primera pantalla y el trazo de líneas, una vez por página | Carbon `slow-02` · M3 `extra-long1` |
| `--k-ease-taller: cubic-bezier(0.5, 0, 0, 1)` | Lo que va de un reposo a otro: la tarjeta del cambio de página, el menú, un acordeón, la foto de una tarjeta | La curva del cambio de página (13-nov-2026) |
| `--k-ease-entrada: cubic-bezier(0.05, 0.7, 0.1, 1)` | Lo que aparece y las líneas que se trazan | M3 `emphasized-decelerate` |
| `--k-ease-salida: cubic-bezier(0.3, 0, 1, 1)` | Lo que se va para siempre, con una ficha de duración menos que su entrada | M3 `standard-accelerate` |

La duración crece con la distancia o con el tamaño de lo que se mueve; M3 y Carbon dicen lo mismo. Fuera de
estas fichas solo quedan los tiempos del cambio de página (patrón 1) y de la línea de carga (patrón 7), que
son piezas únicas.

---

## Los 7 patrones

### 1. Cambio de página

La barra queda fija y lo que se mueve es la página, debajo de ella:
- la página se encoge hasta ser una tarjeta (420 ms);
- sale de lado mientras entra la nueva (700 ms);
- la nueva crece a pantalla completa (450 ms).

Todo usa `--k-ease-taller`. Si la página ya estaba precargada, los tiempos son 300/550/350 ms; en el
celular, ×0,7. La página nueva llega en su estado final: no repite su entrada. Implementación:
`src/components/PageTransition.astro` (kronos-web). Regla completa: `ESTANDAR.md` 14b.

**Movimiento reducido:** fundido de 180 ms.

### 2. Entrada de la primera pantalla

La etiqueta, el título y la bajada de la apertura suben 24 px con fundido, escalonados cada 80 ms
(`--k-dur-4`, `--k-ease-entrada`). Ocurre una sola vez y solo con CSS, al cargar la página directo. La foto
principal no se esconde nunca, porque es la que mide la velocidad de carga. Si la página llega por cambio de
página, ya está quieta.

**Movimiento reducido:** quieto y visible.

### 3. Aparición de sección

Cuando una sección (`k-sec`) entra en pantalla:

1. Su línea fina superior se traza de izquierda a derecha (`--k-dur-4`, `--k-ease-entrada`).
2. La apertura (etiqueta → titular → bajada) sube como en el patrón 2 (`--k-dur-3`).
3. El contenido aparece **como un bloque**, solo con opacidad (`--k-dur-3`, 120 ms después).

Pasa una sola vez y **nunca tarjeta por tarjeta**. Lo que ya está en pantalla al cargar, o al llegar por un
enlace a una sección, se muestra quieto.

**Movimiento reducido:** quieto y visible.

### 4. Trazo (la firma)

Las líneas del dibujo se trazan una vez al verse, con `--k-dur-4` y `--k-ease-entrada`:
- las cotas, que solo van donde miden algo real;
- las líneas guía de los rótulos sobre fotos;
- el plano de cómo llegar a la planta;
- el riel de calidad.

Se anima con `stroke-dashoffset` o `transform: scaleX`.

**Movimiento reducido:** dibujado desde el principio.

### 5. Respuesta

Al poner el mouse o el dedo encima, en `--k-dur-1`:
- la flecha de un enlace avanza 4 px;
- el botón principal oscurece su naranjo;
- el contorno se llena desde abajo;
- la foto de una tarjeta se acerca apenas (escala 1,03, `--k-dur-3`, `--k-ease-taller`) y su título se
  subraya.

Todo `:hover` va dentro de `@media (hover: hover)`, para que en el celular no quede pegado.

**Movimiento reducido:** solo cambia el color.

### 6. Medios en bucle

Un video corre solo mientras se ve y lleva un botón de pausa chico en mono. Lo exige WCAG 2.2.2 (nivel A)
para todo lo que se mueve solo más de 5 s junto a otro contenido. Solo se usa material real: de 4 a 8 s, sin
audio y de menos de 1 MB. El dibujo del spool del home dura 4,2 s y se detiene, así que no necesita pausa.

**Movimiento reducido o ahorro de datos:** el póster, quieto.

### 7. Carga

Si la página nueva tarda, avanza una línea de 1 px bajo la barra (`PageTransition`). No hay otra vista de
carga ni otro movimiento.

**Movimiento reducido:** igual, porque es la única señal de que algo está pasando.

---

## Coreografía

El orden de entrada viene de Carbon:
1. la barra (que no se mueve);
2. la apertura: etiqueta → título → bajada;
3. el contenido;
4. la acción principal;
5. los dibujos.

Hay como máximo 4 pasos escalonados, cada 80 ms. Lo que significa lo mismo se mueve igual en todo el sitio.

---

## Reglas

1. **Una sola vez.** Nada vuelve a animarse al subir y bajar.
2. **Solo se anima `transform`, `opacity`, `clip-path` y el trazo (`stroke-dashoffset`).** En una
   respuesta también puede cambiar el color. Nunca se anima `width`, `height`, `top`, `left`, `margin`,
   `box-shadow`, `filter` ni `backdrop-filter`, porque cuestan cuadros (web.dev, propiedades de compositor).
3. **Movimiento reducido siempre.** Cada patrón tiene su versión quieta, descrita arriba. Con
   `prefers-reduced-motion` solo se admite opacidad de hasta `--k-dur-1`.
4. **Nada en bucle infinito**, salvo un video en pantalla con su pausa (patrón 6).
5. **Nada se esconde para siempre.** Sin JavaScript, al imprimir o si el script falla, todo se ve. Solo se
   esconde lo que está bajo la primera pantalla en el momento de arrancar.
6. **Un solo módulo, que arranca una vez.** En kronos-web el patrón 3 vive en `src/scripts/movimiento.ts`
   (5IN-825) y reemplaza a `ScrollReveal`. No guarda estado en `<html>`, porque Astro lo borra en cada cambio
   de página, y se apaga en `astro:before-swap`.
7. **Sin dependencias nuevas de animación.** Lo que el sistema necesita sale de CSS y de
   `IntersectionObserver`. `animation-timeline: view()` funciona en iOS recién desde iOS 26: sirve como
   mejora opcional, nunca como base.
8. **Cada animación comunica algo:** entrada, jerarquía, respuesta o estado. Si no se puede decir en una frase
   qué comunica, no va.

---

## Retirados

Estos patrones de abril de 2026 salieron el 20-nov-2026 (5IN-824). Quedan escritos para que nadie los vuelva
a meter.

- **Patrón A: fondo WebGL animado** (shader mesh gradient, `@paper-design/shaders`).
  - Hacía que 53 de ~85 páginas abrieran distinto al resto.
  - Corría en bucle sin pausarse fuera de pantalla.
  - El plano de taller usa fotos reales y la grilla de dibujo.
- **Patrón B: revelado de titulares línea a línea** (GSAP SplitText + ScrollTrigger, con desenfoque).
  - Lo prohíbe la regla 14 del estándar: ninguna de las referencias medidas lo usa.
  - Además, peleaba con `data-reveal`.
- **Patrón C: botón principal con brillo pulsante infinito** (glow pulse) **y destello diagonal** (shimmer).
  - Era un bucle decorativo en cada página, también en el botón de la barra.
  - La respuesta del botón ahora es el patrón 5.
- **Contadores animados de cifras** (stats inline del hero). Las cifras van en el texto o como especificación
  mono, sin contar.
- **Tarjetas que giran en 3D al mover el mouse y apariciones tarjeta por tarjeta.**
- **Patrón D: relleno líquido del botón de contorno.** No se retira: pasa a ser parte del patrón 5, con las
  fichas.

---

**Última actualización:** 2026-11-20 (5IN-824).
**Dónde se aplica (kronos-web):** `src/styles/estandar.css`, `src/components/PageTransition.astro` y
`src/scripts/movimiento.ts`.
