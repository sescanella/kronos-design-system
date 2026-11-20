---
name: rediseño
description: Rediseña páginas y componentes de Kronos Mining con el kit del estándar (ESTANDAR.md + estandar.css + PageHero + CTASection) y los 7 patrones de movimiento del design system. Úsalo cuando el usuario pida "rediseñar X", "aplicar el estilo del home a Y", "alinear al design system", "modernizar" o "consistente con el diseño". A diferencia de `frontend-design` (libertad creativa), constraine a lo ya definido en el repo.
---

Skill constrainer, no creativo. Replica el sistema ya definido: el kit del estándar de kronos-web
(`src/styles/ESTANDAR.md`, `src/styles/estandar.css`, `PageHero.astro`, `CTASection.astro`,
`PageTransition.astro`), los componentes y clases globales (`TechLabel`, `BlueprintGrid`, `.btn-kronos-*`) y los
7 patrones de movimiento de `design/animations.md`. Prohíbe improvisar estética o movimiento nuevos.

## Cuándo usar

- `rediseña la página X`
- `aplica el estilo del home a X`
- `haz X consistente con el diseño del home`
- `modernizar la sección Y`
- `alinea este componente al sistema`

**NO disparar si:** el usuario pide crear algo nuevo con estética distinta (usar `frontend-design`) o es una
corrección de bug visual puntual (padding, typo).

## Lectura obligatoria

**Siempre (4):**
1. `src/styles/ESTANDAR.md`: las reglas, con su sección "Piezas" y "Movimiento".
2. `DESIGN.md`.
3. `src/styles/estandar.css`: las clases `k-*` y las fichas.
4. El archivo target.

**Piezas que se reutilizan (conocer antes de implementar):**
- `<PageHero>`: abre toda página interior (ruta → etiqueta → `k-h1` → `k-lede`).
- `k-sec` + `k-head`: cada sección (línea fina → etiqueta → `k-h2` → `k-lede` → `k-link`).
- `<CTASection>`: cierra toda página.
- `<TechLabel>`: etiqueta `◆ LABEL`, solo con datos reales, sin coordenadas de adorno.
- `k-spec` / `k-mono`: datos y especificaciones en mono; las cifras nunca cuentan solas.
- `k-shade`: velo bajo el rótulo de una foto.
- `.btn-kronos-primary` / `.btn-kronos-outline`: botones globales.

**Página hermana de referencia.** Antes de rediseñar una página, leer completa la página ya alineada más
parecida: el home y `/contacto` son las más completas. Si ninguna se parece, usar solo el kit.

**Bajo demanda, según el caso:**
- Dudas de color o grises → `design/tokens.md`.
- Qué está prohibido → `design/anti-patterns.md`.
- Movimiento → `design/animations.md` (7 patrones, fichas `--k-dur-*` / `--k-ease-*`).
- Tipografía → `design/typography.md`.
- Qué reutilizar → `design/components.md`.
- El caso no está resuelto por el kit → `design/references.md` (Anduril, Saronic, Mach, Hadrian).

## Flujo (3 pasos)

**1. Diagnóstico.** Lee los 4 obligatorios, el target y la página hermana. Lista:
- qué cumple ya el estándar;
- qué viola `anti-patterns.md`;
- qué piezas del kit puedes reutilizar.

Elige una etiqueta contextual para cada sección.

**2. Propuesta (condicional).** Si el cambio abarca más de una sección o introduce un patrón nuevo, escribe al
usuario un plan breve y espera confirmación: ≤150 palabras con diagnóstico, estructura, copy propuesto,
movimiento y ≤2 preguntas bloqueantes. Si el cambio es puntual y usa un patrón existente, implementa directo.

**3. Implementar + auditar.** Arma con las piezas del kit; no dupliques su CSS. El movimiento sale solo de los
7 patrones con sus fichas. Todo color sale de `@theme` o de las fichas de grises. Ejecuta la checklist, corre
`npm test` (`estandar-sitio`, `movimiento`, `design-system-al-dia`) y `npm run build`, y reporta.

## Checklist de auditoría (pre-entrega)

1. Cero hex hardcodeados; colores desde `@theme`; grises de texto solo 1 / 0,78 / 0,62 / 0,55.
2. Una sola sans (Instrument Sans) + una sola mono (Geist Mono).
3. Naranjo en ≤5% del área. Solo en el ◆, el botón principal (uno por sección), las cotas y el riel de calidad;
   nunca dentro de un titular.
4. Titulares tipo oración y livianos (`k-h1`, `k-h2`, `k-h3`). Nunca en mayúsculas, nunca cortados con guion.
5. Apertura igual en cada sección: etiqueta mono → titular → bajada de hasta 640 px.
6. Movimiento:
   - solo los 7 patrones, con las fichas;
   - nada tarjeta por tarjeta, nada en bucle sin pausa;
   - todo `:hover` dentro de `@media (hover: hover)`;
   - con `prefers-reduced-motion`, todo quieto y visible.
7. `:focus-visible` con outline visible en todo elemento interactivo; objetivos táctiles de 44 px.
8. Si vive en `src/pages/index.astro`, tiene clase `snap-section`. Ninguna pieza compartida la lleva.
9. Copy 100% español. Sin emojis decorativos. Sin `<Button>` legacy.
10. Solo fotos reales de Kronos, con su rótulo sobre la imagen; esquinas rectas.

## PROHIBITED

- Inventar tokens, hex, fonts, escalas, duraciones o curvas fuera de `@theme`, de las fichas y de `DESIGN.md`.
- Duplicar CSS de `.btn-kronos-*`, `.kronos-meta*`, `.kronos-blueprint` o de las clases `k-*`.
- Animar fuera de los 7 patrones de `design/animations.md`.
- Tocar copy de negocio (textos, datos, imágenes del cliente).
- Añadir dependencias npm sin aprobación del usuario.

## Edge cases

- **Target = una pieza del kit** (`PageHero`, `CTASection`, `PageTransition`, `estandar.css`). Cambiarla cambia
  todo el sitio. Requiere consulta explícita del usuario y actualizar `ESTANDAR.md` y los docs del design
  system en el mismo cambio.
- **Conflicto entre código y doc.** Gana el estándar con sus tests. Abrir tarea para sincronizar el doc
  desactualizado.
- **Archivo del design system ausente.** Detener y avisar al usuario. No improvisar lo que falta.

## Lo que NO hace este skill

- Crear estéticas nuevas desde cero (usar `frontend-design`).
- Redefinir el sistema: editar `DESIGN.md` o `ESTANDAR.md` es un proceso separado y explícito.
- Escribir copy de negocio: los textos del cliente los define el usuario.

## Señal de éxito

1. La página rediseñada se ve del mismo juego de planos que el home: misma apertura, mismas líneas, mismos
   datos en mono, mismo movimiento.
2. `npm test` y `npm run build` pasan; el grep de hex en el target devuelve solo excepciones documentadas.
3. El diff toca el target y, si se registró un componente nuevo, `design/components.md`. Cero dependencias npm
   nuevas y cero CSS duplicado de estilos globales.
