# Kronos Design System

Sistema de diseño compartido entre todos los productos de Kronos Mining:
sitio web, aplicaciones internas, paneles técnicos, futuros proyectos.

**Identidad visual:** industrial-tech con restraint cromático, inspirada en Anduril,
Saronic y Mach Industries. Paleta azul `#083A75` + naranjo `#FF5B00`, tipografía
Instrument Sans + Geist Mono, labels técnicas mono uppercase, headlines oversized,
animaciones firmadas (shader mesh gradient, GSAP SplitText, shimmer button, liquid fill).

> **Regla cardinal.** Este repo es la única fuente de verdad del lenguaje visual.
> Ningún proyecto consumidor puede definir colores, fuentes, escalas tipográficas
> o patrones de animación por su cuenta. Cualquier cambio al sistema se hace aquí,
> se versiona con tag, y los repos consumidores se actualizan cuando quieran.

---

## Estructura del repo

```
kronos-design-system/
├── DESIGN.md                  ← router del sistema (leer primero)
├── design/
│   ├── tokens.md              ← uso semántico de cada token
│   ├── typography.md          ← escalas y reglas tipográficas
│   ├── components.md          ← catálogo de componentes canónicos
│   ├── animations.md          ← los 4 patrones firmados
│   ├── anti-patterns.md       ← reglas inviolables
│   ├── references.md          ← Anduril, Saronic, Mach (URLs + qué buscar)
│   └── references/            ← screenshots archivados
├── tokens/
│   ├── colors.css             ← @theme Tailwind v4 + CSS vars
│   ├── typography.css         ← @font-face + --font-sans / --font-mono
│   └── spacing.css            ← spacing semántico
├── fonts/
│   ├── InstrumentSans-Variable.ttf
│   └── GeistMono-Variable.ttf
├── reference/
│   ├── astro/
│   │   └── CTASection.astro   ← canónico stack Astro
│   └── react/
│       └── (pendiente)        ← canónico stack React (crear cuando se migre la app)
└── skills/
    └── rediseño/
        └── SKILL.md           ← skill Claude Code portable
```

---

## Cómo consumir desde un repo nuevo

### Paso 1 — Añadir como git submodule

Desde la raíz del repo consumidor (web, app, panel, etc.):

```bash
git submodule add ../kronos-design-system .design-system
git submodule update --init --recursive
```

Esto crea la carpeta `.design-system/` dentro del repo consumidor como un clon
enlazado de este repo. El punto al inicio (`.design-system`) la mantiene discreta
en el árbol de archivos sin esconderla.

### Paso 2 — Copiar las fuentes al repo consumidor

Las `.ttf` deben vivir físicamente en la carpeta pública del proyecto para que
el navegador las cargue. Desde la raíz del repo consumidor:

**Astro / Vite / Next.js:**
```bash
mkdir -p public/fonts
cp .design-system/fonts/*.ttf public/fonts/
```

**React Native (Expo):**
```bash
mkdir -p assets/fonts
cp .design-system/fonts/*.ttf assets/fonts/
# Luego declararlas en app.json / expo-font loader
```

### Paso 3 — Importar los tokens en el CSS global

**Astro + Tailwind v4 / React + Tailwind v4:**

En tu `src/styles/global.css` (o `src/index.css`):

```css
@import "tailwindcss";
@import "../.design-system/tokens/colors.css";
@import "../.design-system/tokens/typography.css";
@import "../.design-system/tokens/spacing.css";

/* Tus estilos globales propios del proyecto debajo */
```

**Ajustar paths de fuentes.** El `typography.css` declara las `.ttf` con paths
absolutos `/fonts/*.ttf`. Esos paths asumen que copiaste los archivos a la
carpeta pública. Si tu setup usa otra ruta (ej. `/assets/fonts/`), sobrescribe
las declaraciones `@font-face` en tu propio CSS después del import.

### Paso 4 — Copiar el skill de Claude Code

Para que Claude Code tenga el skill `rediseño` disponible en el repo consumidor:

```bash
mkdir -p .claude/skills/rediseño
cp .design-system/skills/rediseño/SKILL.md .claude/skills/rediseño/
```

### Paso 5 — Crear o actualizar el `CLAUDE.md` del repo consumidor

Añadir referencias a los archivos del design system que ahora viven en `.design-system/`:

```markdown
## Mapa de documentación

- `.design-system/DESIGN.md` — router del design system, leer primero para trabajo visual
- `.design-system/design/tokens.md`
- `.design-system/design/anti-patterns.md`
- `.design-system/reference/[stack]/CTASection.*` — componente canónico del stack
- `.claude/skills/rediseño/SKILL.md` — skill de rediseño
```

### Paso 6 — Usar el componente canónico como referencia

Cuando construyas UI nueva en el repo consumidor, usa el archivo correspondiente
de `.design-system/reference/[stack]/` como fuente de verdad visual. Copia
patrones desde ahí, no inventes.

---

## Cómo actualizar el sistema en un repo consumidor

Cuando se hace un cambio en este repo (`kronos-design-system`), los repos
consumidores NO se actualizan automáticamente. Deben sincronizarse explícitamente:

```bash
cd <repo-consumidor>
cd .design-system
git fetch origin
git checkout main          # o el tag que prefieras: git checkout v1.2.0
git pull
cd ..
git add .design-system
git commit -m "design-system: sync to latest main"
```

Esto es una feature, no un bug: cada repo decide cuándo adoptar cambios del
sistema. Un refactor grande del design system no rompe todos los proyectos
simultáneamente.

---

## Cómo contribuir al design system

1. Clonar este repo directamente (no como submodule).
2. Leer `DESIGN.md` completo y entender los principios.
3. Hacer los cambios: tokens, docs, componentes de referencia, skill.
4. Si se añade un token nuevo, actualizar `design/tokens.md` en el **mismo commit**.
5. Si se añade un anti-pattern, actualizar `design/anti-patterns.md`.
6. Verificar que ningún repo consumidor se rompe (opcional, pero recomendado).
7. Commit + tag semver: `git tag v1.x.0 && git push --tags`.
8. Avisar a los repos consumidores para que sincronicen cuando puedan.

---

## Estado actual (v0.1.0)

### Tokens
- Paleta completa (primary, accent, neutrals, shadows)
- Fuentes (Instrument Sans + Geist Mono) con alias `--font-mono`
- Spacing semántico (6 tokens)

### Documentación
- `DESIGN.md` router del sistema
- `design/tokens.md`, `typography.md`, `components.md`, `animations.md`, `anti-patterns.md`, `references.md`

### Componentes canónicos
- **Astro:** `reference/astro/CTASection.astro` — hero CTA con shader WebGL + GSAP SplitText + shimmer button + liquid fill
- **React:** pendiente (crear cuando se migre la app React al sistema)
- **React Native:** pendiente

### Skill
- `skills/rediseño/SKILL.md` — skill Claude Code (español) para replicar el sistema en cualquier repo consumidor

### Referencias visuales
- Anduril Industries, Saronic Technologies, Mach Industries (canónicas)
- True Anomaly, Hermeus, Epirus, Kairos Power, Path Robotics, KoBold Metals, Ursa Major, Basement Studio (secundarias)

---

## Filosofía del sistema

- **Restraint cromático.** El naranjo ocupa ≤5% del área visible en cualquier vista.
- **Jerarquía tipográfica binaria.** Instrument Sans (sans) + Geist Mono (technical labels). Nunca una tercera fuente. Nunca serif.
- **Replicar, no inventar.** Los componentes canónicos son la fuente de verdad; cualquier UI nueva copia patrones de ahí.
- **100% español en contenido visible.** Comentarios de código en inglés.
- **Sin dark mode.** Decisión deliberada — el sistema es "dark-first" en hero/CTA, "light" en contenido editorial.
- **Animación con propósito.** Cada animación comunica algo (entrada, estado, interacción). Nada decorativo.

Más detalles en `DESIGN.md`.

---

## Licencia

Uso interno de Kronos Mining. No redistribuir.
