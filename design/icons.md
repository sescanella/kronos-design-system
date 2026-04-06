# Iconografía — Kronos Mining

> **Biblioteca oficial:** [Lucide Icons](https://lucide.dev) — stroke-based, tree-shakeable, multi-stack.
> Cada icono en el sistema es funcional. Si un icono no aporta información que el texto no puede dar,
> no va. Los símbolos técnicos unicode (`◆`, `●`, `→`) del sistema se preservan — Lucide es para
> acciones e información, no para labels técnicas.
>
> **Componente canónico de referencia:** `src/components/CTASection.astro` (no usa iconos Lucide,
> pero define los patrones de botones y labels donde los iconos se integran).
> **Repo de referencia de integración:** `lector-planos/frontend` (lucide-react en producción).

---

## 1. Principio fundamental

Lucide Icons es la única biblioteca de iconos permitida en el ecosistema Kronos.

**Por qué Lucide.**
- **Stroke-based.** Los trazos limpios de 1.5–2px encajan con la estética industrial del sistema. No hay rellenos pesados ni sombras.
- **Tree-shakeable.** Cada icono se importa individualmente — el bundle solo incluye los que se usan. En un proyecto con 10 iconos, se cargan 10, no 1000+.
- **`currentColor`.** Todos los iconos heredan color del contexto CSS. No hay colores hardcodeados en los SVGs.
- **Multi-stack.** Paquetes oficiales para React (`lucide-react`), Vue, Svelte, y core para cualquier otro framework (Astro incluido).
- **ViewBox 24x24.** Escala predecible, proporciones consistentes.

**Por qué NO Material Symbols.**
- Acoplamiento a Google Fonts CDN — dependencia de terceros para un recurso crítico de UI.
- No tree-shakeable — se carga la familia completa o un subset manual.
- Filled by default — la estética rounded/filled contradice el carácter industrial stroke-based del sistema.
- `kronos-web` actualmente usa Material Symbols (legacy). Migración pendiente — ver §9.

**Por qué NO Heroicons.**
- También stroke-based, pero catálogo significativamente menor (~300 vs. ~1500 en Lucide).
- Mantenimiento menos activo. Lucide tiene releases semanales.
- Sin ventaja técnica que justifique elegirlo sobre Lucide.

**Por qué NO emojis.**
- Ya documentado en `design/anti-patterns.md §Idioma y contenido`. Los emojis decorativos (`🚀`, `✨`, `💡`) están prohibidos en UI de Kronos. Los símbolos técnicos unicode (`◆`, `●`, `→`) cumplen otra función y se preservan.

---

## 2. Integración por stack

### React (`lucide-react`)

```tsx
import { Upload, Download, ChevronRight } from 'lucide-react';

<Upload size={24} strokeWidth={1.75} className="text-white/60" />
```

- Versión mínima: `^1.0.0`.
- Siempre importar iconos individuales (tree-shaking).
- **NUNCA** `import * from 'lucide-react'` — importa 1000+ iconos al bundle.
- Props principales: `size` (number, en px), `strokeWidth` (number), `className` (string, clases Tailwind).
- `color` se omite — se controla vía `className` con clases Tailwind (`text-white`, `text-accent`, etc.) que resuelven a `currentColor`.

### Astro

Dos estrategias según el caso:

**Opción A — Rendering estático (preferida para iconos que no cambian):**

Usar `lucide` (core) para generar el SVG en build time:

```astro
---
import { icons } from 'lucide';

const uploadIcon = icons['upload'];
const svgContent = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">${uploadIcon.map(([tag, attrs]) => {
  const attrStr = Object.entries(attrs).map(([k, v]) => `${k}="${v}"`).join(' ');
  return `<${tag} ${attrStr}/>`;
}).join('')}</svg>`;
---
<Fragment set:html={svgContent} />
```

**Opción B — Componente React con `client:load`:**

```astro
---
import LucideIcon from '../components/LucideIcon';
---
<LucideIcon client:load name="Upload" size={24} strokeWidth={1.75} class="text-white/60" />
```

Usar solo cuando el icono necesita interactividad del lado del cliente (ej: spinner animado, toggle de visibilidad).

**Migración desde Material Symbols.** `kronos-web` actualmente carga Material Symbols vía Google Fonts CDN. La migración a Lucide se ejecutará en una sesión dedicada — ver §9.

---

## 3. Escala de tamaños

Cuatro tamaños canónicos. Análogo a cómo `typography.md` define roles tipográficos, cada tamaño tiene un rol funcional y un `strokeWidth` calibrado.

| Rol | Size (px) | Tailwind class | Stroke-width | Uso |
|---|---|---|---|---|
| **Inline** | 16 | `h-4 w-4` | 2 | Junto a texto de 11–14px: badges, tablas, breadcrumbs, botones con texto |
| **Standard** | 20 | `h-5 w-5` | 2 | Botones de acción, navegación, inputs con icono |
| **Prominent** | 24 | `h-6 w-6` | 1.75 | Acciones primarias standalone, headers de sección |
| **Display** | 40–48 | `h-10 w-10` a `h-12 w-12` | 1.5 | Drop zones, empty states, secciones hero de apps |

**Regla de escala inversa.** A mayor tamaño, menor `strokeWidth`. Un icono de 48px con `strokeWidth: 2` se ve pesado e infantil. Un icono de 16px con `strokeWidth: 1.5` se ve débil e ilegible. Esto es análogo a cómo los headlines usan tracking negativo (`-0.02em`) y las labels técnicas usan tracking positivo (`0.3em`) — la proporción visual se ajusta al tamaño.

**No usar tamaños fuera de la escala** (ej: 13px, 17px, 22px, 32px). Si un contexto parece necesitar un tamaño intermedio, es señal de que la jerarquía del contenedor está mal — resolver la jerarquía, no inventar un quinto tamaño.

---

## 4. Colores y opacidades

Los iconos **siempre** heredan color del contexto vía `currentColor`. Las clases de color son las mismas de `tokens.md §1.4`:

| Contexto | Clase Tailwind | Uso |
|---|---|---|
| Acción primaria | `text-white` | Iconos en botones primarios, acciones principales |
| Acción secundaria | `text-white/60` | Iconos en botones outline, acciones secundarias, navegación |
| Metadata / auxiliar | `text-white/40` | Breadcrumb separadores, timestamps, hints, placeholders |
| Accent (`< 5%`) | `text-accent` | Indicadores de estado activo, CTA icons (misma regla del 5% de `tokens.md §1.2`) |
| Estado error | `text-[#F87171]` | Iconos de error, close en contexto de error |
| Estado ready | `text-[#4ADE80]` | Checkmarks de completado, estados exitosos |
| Disabled | `text-white/20` | Iconos en contexto deshabilitado |

**NUNCA hardcodear un color hex en un icono.** No `stroke="#FF5B00"`, no `color="#ffffff"`. Usar las clases Tailwind que resuelven contra los tokens del `@theme`. Los colores de estado (`#F87171`, `#4ADE80`) se usan vía clases Tailwind arbitrarias (`text-[#F87171]`) porque no tienen token en `@theme` — si se repiten en 3+ contextos, promover a token.

---

## 5. Catálogo Kronos (subset recomendado)

Organizado por categoría funcional. Solo lista los que tienen uso real o previsto en el ecosistema.

### Acciones

| Icono | Nombre Lucide | Uso en Kronos |
|---|---|---|
| Upload | `Upload` | Subir archivos (drop zones, botones de carga) |
| Download | `Download` | Descargar archivos, exportar Excel |
| Plus | `Plus` | Añadir elemento, crear nuevo |
| Pencil | `Pencil` | Editar, corregir |
| Trash2 | `Trash2` | Eliminar (preferido sobre `Trash` por ser visualmente más claro) |
| RotateCcw | `RotateCcw` | Deshacer, reintentar, refresh |
| Check | `Check` | Confirmar acción, selección |
| X | `X` | Cerrar, cancelar, dismiss |
| Copy | `Copy` | Copiar al clipboard |
| ArrowUpDown | `ArrowUpDown` | Ordenar columnas de tabla |

### Navegación

| Icono | Nombre Lucide | Uso en Kronos |
|---|---|---|
| ChevronRight | `ChevronRight` | Expandir, siguiente, breadcrumb en apps |
| ChevronLeft | `ChevronLeft` | Colapsar, anterior |
| ChevronDown | `ChevronDown` | Dropdown, expandir vertical |
| ChevronUp | `ChevronUp` | Colapsar vertical |
| ArrowLeft | `ArrowLeft` | Volver (navegación de página) |
| ArrowRight | `ArrowRight` | Avanzar (navegación de página) |

### Estado

| Icono | Nombre Lucide | Uso en Kronos |
|---|---|---|
| Loader2 | `Loader2` | Spinner (siempre con `className="animate-spin"`) |
| CircleCheck | `CircleCheck` | Completado exitosamente |
| CircleAlert | `CircleAlert` | Advertencia |
| CircleX | `CircleX` | Error |
| Info | `Info` | Información contextual |

### Archivos

| Icono | Nombre Lucide | Uso en Kronos |
|---|---|---|
| FileText | `FileText` | Documento genérico, PDF |
| FileSpreadsheet | `FileSpreadsheet` | Excel, CSV, datos tabulares |
| FolderOpen | `FolderOpen` | Carpeta abierta, explorador de archivos |
| File | `File` | Archivo genérico |

### Sistema

| Icono | Nombre Lucide | Uso en Kronos |
|---|---|---|
| LogOut | `LogOut` | Cerrar sesión |
| Settings | `Settings` | Configuración |
| Search | `Search` | Buscar |
| Eye | `Eye` | Mostrar / previsualizar |
| EyeOff | `EyeOff` | Ocultar |

**Nota.** Este catálogo crece según necesidad. Si necesitas un icono que no está aquí, búscalo en [lucide.dev](https://lucide.dev). Si existe en Lucide, úsalo directamente. Si no existe, **NO inventes un SVG custom** — busca una alternativa en Lucide o prescinde del icono.

---

## 6. Cuándo usar iconos vs. texto vs. símbolos unicode

| Situación | Solución | Ejemplo |
|---|---|---|
| Acción en botón con texto | Icono Lucide inline + texto | `[Download] DESCARGAR` |
| Acción en botón solo icono | Icono Lucide + `aria-label` obligatorio | `[X]` con `aria-label="Cerrar"` |
| Separador técnico | Símbolo unicode | `◆`, `●`, `→`, `›` |
| Label de sección | Símbolo unicode + texto | `◆ SISTEMA 01 — NOMBRE` |
| Estado en badge | Símbolo unicode (dot) | `● PROCESANDO` |
| Close / dismiss | Icono Lucide | `X` de Lucide, no `×` unicode |
| Spinner / loading | Icono Lucide + `animate-spin` | `Loader2` con `className="animate-spin"` |
| Flecha en CTA marketing | Carácter `→` | Como en `CTASection.astro` canónico |
| Flecha en navegación app | Icono Lucide | `ChevronRight` |

**Principio.** Los símbolos unicode (`◆`, `●`, `→`) son firma del sistema Kronos y se preservan en labels técnicas, footers técnicos y CTAs de marketing. Los iconos Lucide son para acciones e información funcional en aplicaciones. No mezclar: un breadcrumb usa `›` unicode **o** `ChevronRight` Lucide, no ambos en la misma app.

---

## 7. Patrones de implementación

### Botón con icono

```tsx
<button className="flex items-center gap-2 ...">
  <Download size={16} strokeWidth={2} />
  <span>DESCARGAR</span>
</button>
```

El icono va **antes** del texto (lectura izquierda a derecha). Size Inline (16px) para acompañar texto de botón. `gap-2` (0.5rem) separa icono de texto.

### Icono solo (accesibilidad)

```tsx
<button aria-label="Cerrar" className="...">
  <X size={16} strokeWidth={2} />
</button>
```

**Obligatorio** `aria-label` cuando el botón no tiene texto visible. Sin `aria-label`, el botón es invisible para lectores de pantalla.

### Spinner

```tsx
<Loader2 size={16} strokeWidth={2} className="animate-spin text-accent" />
```

Siempre `Loader2` (tiene la geometría correcta para rotación continua). Siempre `animate-spin` de Tailwind. Respetar `prefers-reduced-motion` — en contextos donde se controla, pausar o reemplazar por texto "Cargando...".

### Drop zone icon

```tsx
<Upload size={40} strokeWidth={1.5} className="text-white/40" />
```

Size Display (40px) con `strokeWidth: 1.5` y opacidad reducida. El icono es una guía visual secundaria — el texto principal de la drop zone ("Arrastra archivos aquí") es el elemento dominante.

### Icono en input

```tsx
<div className="relative">
  <Search size={16} strokeWidth={2} className="absolute left-3 top-1/2 -translate-y-1/2 text-white/40" />
  <input className="pl-9 ..." placeholder="Buscar..." />
</div>
```

Posición absoluta dentro de un contenedor relativo. Padding-left del input compensa el ancho del icono + su margen.

---

## 8. Anti-patterns de iconografía

- **No usar emojis como iconos** — ya documentado en `anti-patterns.md`.
- **No usar Material Symbols** — migración pendiente en `kronos-web`, no usar en código nuevo.
- **No usar SVGs custom inline** cuando Lucide tiene un equivalente — un SVG custom es una deuda de mantenimiento.
- **No usar iconos decorativos sin función** — un icono al lado de cada título "porque sí" contradice el restraint visual del sistema.
- **No mezclar librerías de iconos** — Lucide + Heroicons + Material en el mismo repo rompe consistencia de proporciones y stroke.
- **No `import * from 'lucide-react'`** — mata tree-shaking, importa 1000+ iconos al bundle.
- **No hardcodear colores en iconos** — `stroke="#FF5B00"` viola el principio de `currentColor`. Usar clases Tailwind.
- **No usar tamaños fuera de la escala** — 13px, 17px, 22px no existen. Usar los 4 roles definidos en §3.
- **No usar `strokeWidth` diferente al recomendado por tamaño** sin justificación documentada.

Estos anti-patterns están registrados también en `design/anti-patterns.md §Componentes`.

---

## 9. Migración Material Symbols a Lucide

Tabla de equivalencias para `kronos-web`:

| Material Symbol | Lucide equivalent | Notas |
|---|---|---|
| `check_circle` | `CircleCheck` | |
| `close` | `X` | |
| `chevron_left` | `ChevronLeft` | |
| `chevron_right` | `ChevronRight` | |
| `expand_more` | `ChevronDown` | |
| `arrow_forward` | `ArrowRight` | |
| `arrow_back` | `ArrowLeft` | |
| `search` | `Search` | |
| `menu` | `Menu` | |
| `home` | `Home` | |
| `info` | `Info` | |
| `mail` | `Mail` | |
| `phone` | `Phone` | |
| `location_on` | `MapPin` | |
| `schedule` | `Clock` | |
| `engineering` | `Wrench` | Closest — no equivalente exacto |
| `construction` | `HardHat` | Closest — no equivalente exacto |
| `plumbing` | `Pipette` | Closest — evaluar caso a caso |
| `factory` | `Factory` | |
| `warehouse` | `Warehouse` | |
| `layers` | `Layers` | |
| `link` | `Link` | |
| `star` | `Star` | |
| `verified` | `BadgeCheck` | |
| `shield` | `Shield` | |

No todos tienen equivalente exacto — los marcados con "Closest" se resuelven caso por caso durante la migración. Si un Material Symbol no tiene equivalente aceptable en Lucide, se evalúa si el icono es prescindible o si se necesita un enfoque alternativo (texto, símbolo unicode, o restructuración del componente).

---

## 10. Estado de integración por repo

| Repo | Biblioteca actual | Estado Lucide | Acción |
|---|---|---|---|
| `kronos-design-system` | — (docs only) | Documentado en `icons.md` | Ninguna |
| `lector-planos` | `lucide-react ^0.469.0` | En uso, subir a `^1.0.0` | Actualizar versión |
| `kronos-web` | Material Symbols (CDN) | No instalado | Sesión de migración futura |

---

**Última actualización:** 2026-04-04
**Componente canónico de referencia:** `src/components/CTASection.astro`
**Repo de referencia de integración:** `lector-planos/frontend` (lucide-react en producción)
**Tokens relacionados:** `design/tokens.md` §1.4 (blancos semánticos)
**Anti-patterns relacionados:** `design/anti-patterns.md` §Componentes
