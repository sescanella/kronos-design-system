---
name: rediseño
description: Rediseña páginas y componentes de Kronos Mining replicando el lenguaje visual canónico de `CTASection.astro`. Úsalo cuando el usuario pida "rediseñar X", "aplicar el estilo del home a Y", "alinear al design system", "modernizar" o "consistente con el diseño". A diferencia de `frontend-design` (libertad creativa), constraine a lo ya definido en el repo.
---

Skill constrainer, no creativo. Replica el sistema ya definido en `DESIGN.md`, los componentes globales (`TechLabel`, `BlueprintGrid`, clases `.btn-kronos-*` / `.kronos-meta*` / `.kronos-blueprint`) y `CTASection.astro` como referencia de overlays, headlines y animaciones. Prohíbe improvisar estética nueva.

## Cuándo usar

- `rediseña la página X`
- `aplica el estilo de CTASection a X`
- `haz X consistente con el diseño del home`
- `modernizar la sección Y`
- `alinea este componente al sistema`

**NO disparar si:** el usuario pide crear algo nuevo con estética distinta (usar `frontend-design`) o es una corrección de bug visual puntual (padding, typo).

## Lectura obligatoria

**Siempre (3):** `DESIGN.md`, `src/components/CTASection.astro`, archivo target.

**Componentes y clases globales (conocer antes de implementar):**
- `<TechLabel>` (`src/components/TechLabel.astro`) — label técnica `◆ LABEL ─── coord`. Props: `label`, `coord?`.
- `<BlueprintGrid>` (`src/components/BlueprintGrid.astro`) — grid decorativo. Props: `class?`.
- `<ServiceSubNav>` (`src/components/ServiceSubNav.astro`) — sub-nav sticky para secciones/categorías. Props: `items`, `navId`, `sectionClass`, `ariaLabel?`. Usar como referencia visual cuando la página tiene navegación por categorías o secciones.
- `.btn-kronos-primary` / `.btn-kronos-outline` — botones con shimmer + liquid fill (global en `src/styles/global.css`).
- `.kronos-meta*` — label técnica CSS (consumida por TechLabel, global en `global.css`).
- `.kronos-blueprint` — blueprint grid CSS (consumida por BlueprintGrid, global en `global.css`).

**Página hermana de referencia (obligatorio para páginas completas).** Antes de rediseñar una página, buscar en `src/pages/` una página interna ya alineada al sistema (grep por `TechLabel`, `BlueprintGrid`, `ServiceSubNav`). Leer completa la más similar al target para extraer el patrón de estructura (hero full-screen, capas, sub-nav, secciones). Si ninguna existe, usar solo `CTASection.astro` como referente.

**Bajo demanda, según el caso:**
- Dudas de color → `design/tokens.md`
- Dudas sobre qué está prohibido → `design/anti-patterns.md`
- El componente necesita animación → `design/animations.md`
- Dudas tipográficas → `design/typography.md`
- Dudas sobre qué reutilizar → `design/components.md`
- El caso no está resuelto por el canónico → `design/references.md` (Anduril, Saronic, Mach)

## Flujo (3 pasos)

**1. Diagnóstico.** Lee los 3 obligatorios + el target + la página hermana de referencia (si el target es una página completa). Lista qué cumple ya el sistema, qué viola `anti-patterns.md`, qué componentes/clases globales puedes reutilizar (consulta `design/components.md §2` para componentes ALINEADOS relevantes). Elige una label contextual apropiada para la sección (ej. `CONTACTO`, `SERVICIOS`).

**2. Propuesta (condicional).** Si el cambio abarca más de una sección o introduce un patrón nuevo, escribe al usuario un plan breve (≤150 palabras: diagnóstico, estructura, copy propuesto, animaciones, ≤2 preguntas bloqueantes) y espera confirmación. Si el cambio es puntual con patrón existente, implementa directo.

**3. Implementar + auditar.** Usa los componentes globales (`<TechLabel>`, `<BlueprintGrid>`) y clases globales (`.btn-kronos-*`) — no dupliques su CSS. Para overlays, headlines y animaciones, copia patrones desde `CTASection.astro`. Los 4 patrones canónicos de animación viven en `design/animations.md`; los valores numéricos exactos se copian del canónico, nunca se tipean de memoria. Todo color desde `@theme`. Ejecuta la checklist. Corre `npm run build`. Reporta.

## Checklist de auditoría (pre-entrega)

1. Cero hex hardcodeados — todos los colores desde `@theme` (excepción blancos primitivos documentados).
2. Una sola sans (Instrument Sans) + una sola mono (Geist Mono).
3. Naranjo `var(--color-accent)` en ≤5% del área: máx 1 botón accent por sección, máx 3 palabras accent por headline, cero `bg-accent` como fondo principal.
4. Headlines de hero/CTA en uppercase con `letter-spacing: -0.02em`.
5. Animaciones con fallback `prefers-reduced-motion` y mobile degradation.
6. `:focus-visible` con outline visible en todo elemento interactivo.
7. Si vive en `src/pages/index.astro`, tiene clase `snap-section`.
8. Copy 100% español. Sin emojis decorativos. Sin `<Button>` legacy (usar `.btn-kronos-*` globales). Sin `data-reveal` + GSAP SplitText simultáneos.
9. Labels técnicas via `<TechLabel>`, no copiando `.kronos-meta*` CSS manualmente. Blueprint grids via `<BlueprintGrid>`.
10. Cero duplicación de CSS de botones/meta/grid — esos estilos son globales en `global.css`.

## PROHIBITED

- Inventar tokens, hex, fonts o escalas fuera de `@theme` y `DESIGN.md`.
- Duplicar CSS de `.btn-kronos-*`, `.kronos-meta*` o `.kronos-blueprint` en scoped styles — esos son globales.
- Re-implementar patrones de animación desde cero en lugar de copiar de `CTASection.astro` + `design/animations.md`.
- Tocar copy de negocio (textos, datos, imágenes del cliente).
- Añadir dependencias npm sin aprobación del usuario.

## Edge cases

- **Target = `CTASection.astro`.** Es el canónico; no se rediseña desde el skill. Requiere consulta explícita del usuario y actualización de los docs (`DESIGN.md`, `design/*.md`) en el mismo commit.
- **Conflicto código canónico vs doc.** Gana el código ejecutándose. Abrir tarea para sincronizar el doc desactualizado.
- **Archivo del design system ausente.** Detener y avisar al usuario. No improvisar lo que falta.

## Lo que NO hace este skill

- Crear estéticas nuevas desde cero (usar `frontend-design`).
- Redefinir el sistema (editar `DESIGN.md` es proceso separado y explícito).
- Escribir copy de negocio (textos del cliente los define el usuario).

## Señal de éxito

1. La página rediseñada usa el mismo vocabulario visual que `CTASection.astro` (`<TechLabel>`, uppercase headlines, paleta, `.btn-kronos-*`, `<BlueprintGrid>`) — no es indistinguible, comparte lenguaje.
2. `npm run build` pasa sin warnings; grep de hex en el archivo target devuelve solo excepciones documentadas.
3. Diff del commit toca el target + opcionalmente `design/components.md` si se registró un componente nuevo. Cero dependencias npm nuevas. Cero CSS duplicado de estilos globales.
