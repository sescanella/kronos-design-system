---
name: rediseño
description: Rediseña páginas y componentes de Kronos Mining replicando el lenguaje visual canónico de `CTASection.astro`. Úsalo cuando el usuario pida "rediseñar X", "aplicar el estilo del home a Y", "alinear al design system", "modernizar" o "consistente con el diseño". A diferencia de `frontend-design` (libertad creativa), constraine a lo ya definido en el repo.
---

Skill constrainer, no creativo. Replica el sistema ya definido en `DESIGN.md` y `CTASection.astro`. Prohíbe improvisar estética nueva.

## Cuándo usar

- `rediseña la página X`
- `aplica el estilo de CTASection a X`
- `haz X consistente con el diseño del home`
- `modernizar la sección Y`
- `alinea este componente al sistema`

**NO disparar si:** el usuario pide crear algo nuevo con estética distinta (usar `frontend-design`) o es una corrección de bug visual puntual (padding, typo).

## Lectura obligatoria

**Siempre (3):** `DESIGN.md`, `src/components/CTASection.astro`, archivo target.

**Bajo demanda, según el caso:**
- Dudas de color → `design/tokens.md`
- Dudas sobre qué está prohibido → `design/anti-patterns.md`
- El componente necesita animación → `design/animations.md`
- Dudas tipográficas → `design/typography.md`
- Dudas sobre qué reutilizar → `design/components.md`
- El caso no está resuelto por el canónico → `design/references.md` (Anduril, Saronic, Mach)

## Flujo (3 pasos)

**1. Diagnóstico.** Lee los 3 obligatorios + el target. Lista qué cumple ya el sistema, qué viola `anti-patterns.md`, qué componentes existentes puedes reutilizar. Detecta el `SISTEMA NN` correcto según `DESIGN.md §6`.

**2. Propuesta (condicional).** Si el cambio abarca más de una sección o introduce un patrón nuevo, escribe al usuario un plan breve (≤150 palabras: diagnóstico, estructura, copy propuesto, animaciones, ≤2 preguntas bloqueantes) y espera confirmación. Si el cambio es puntual con patrón existente, implementa directo.

**3. Implementar + auditar.** Copia patrones desde `CTASection.astro` (no los inventes). Los 4 patrones canónicos de animación y sus snippets viven en `design/animations.md`; los valores numéricos exactos se copian del canónico, nunca se tipean de memoria. Todo color desde `@theme`. Ejecuta la checklist. Corre `npm run build`. Reporta.

## Checklist de auditoría (pre-entrega)

1. Cero hex hardcodeados — todos los colores desde `@theme` (excepción blancos primitivos documentados).
2. Una sola sans (Instrument Sans) + una sola mono (Geist Mono).
3. Naranjo `var(--color-accent)` en ≤5% del área: máx 1 botón accent por sección, máx 3 palabras accent por headline, cero `bg-accent` como fondo principal.
4. Headlines de hero/CTA en uppercase con `letter-spacing: -0.02em`.
5. Animaciones con fallback `prefers-reduced-motion` y mobile degradation.
6. `:focus-visible` con outline visible en todo elemento interactivo.
7. Si vive en `src/pages/index.astro`, tiene clase `snap-section`.
8. Copy 100% español. Sin emojis decorativos. Sin `<Button>` legacy. Sin `data-reveal` + GSAP SplitText simultáneos.

## PROHIBITED

- Inventar tokens, hex, fonts o escalas fuera de `@theme` y `DESIGN.md`.
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

1. La página rediseñada usa el mismo vocabulario visual que `CTASection.astro` (labels técnicas, uppercase headlines, paleta, patrones de botón) — no es indistinguible, comparte lenguaje.
2. `npm run build` pasa sin warnings; grep de hex en el archivo target devuelve solo excepciones documentadas.
3. Diff del commit toca el target + opcionalmente `design/components.md` si se registró un componente nuevo. Cero dependencias npm nuevas.
