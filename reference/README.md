# Componentes canónicos por stack

Cada subcarpeta contiene el componente `CTASection` (u otros canónicos futuros)
implementado nativamente en un stack específico. Todos deben compartir el mismo
**vocabulario visual** (tipografía, paleta, labels técnicas, patrones de animación,
spacing) pero cada uno está escrito idiomáticamente para su framework.

## Estado

| Stack | Path | Estado | Componentes |
|---|---|---|---|
| **Astro 5 + Tailwind v4** | `astro/` | ✅ canónico | `CTASection.astro` |
| **React 19 + Vite + Tailwind v4 + shadcn** | `react/` | ⏳ pendiente | — |
| **React Native + NativeWind** | `react-native/` | — no creado | — |

## Regla fundamental

**Un componente canónico por stack.** No intentar compartir código entre Astro y React
(son sintaxis distintas, ciclos de vida distintos, herramientas de estilo distintas).
Lo que se comparte es:

- Los **tokens** (colores, fuentes, spacing) — vía `tokens/*.css`
- Las **reglas filosóficas** — vía `DESIGN.md` + `design/*.md`
- Los **4 patrones de animación** como conceptos — vía `design/animations.md`
- El **vocabulario visual** (labels técnicas, headlines oversized, footer técnico, etc.)

Lo que NO se comparte:

- Código de componente (`.astro` ≠ `.tsx`)
- CSS scoped (cada framework lo resuelve distinto)
- Lógica de lifecycle (Astro view transitions ≠ React useEffect)

## Cómo crear un canónico nuevo para un stack nuevo

1. Copiar `astro/CTASection.astro` como referencia visual del lenguaje objetivo.
2. Re-implementar en el stack nuevo preservando:
   - Estructura de 4 capas (shader / overlay / grid / content)
   - Label técnica con el patrón `◆ SISTEMA NN — NOMBRE ─── coordenada`
   - Headline oversized uppercase con clamp + última palabra en accent
   - Sub + botones primary (shimmer + glow pulse) + outline (liquid fill)
   - Footer técnico con separadores `●`
   - Lazy-load del shader, desactivación en mobile + reduced-motion
3. Usar los tokens del design system vía import del stack correspondiente.
4. Documentar en `CHANGELOG.md` del repo del design system.
5. Actualizar esta tabla de estado.

## Importante

Los componentes canónicos de `reference/` NO se importan directamente desde los
repos consumidores. Son **plantillas** — cada repo los copia, adapta a su contexto
de contenido (copy, datos, rutas), y los mantiene localmente. El design system
garantiza que el vocabulario visual se mantiene; el contenido es responsabilidad
de cada repo.
