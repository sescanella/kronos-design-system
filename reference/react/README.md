# Canónico React — PENDIENTE

Este espacio está reservado para `CTASection.tsx` — la implementación del
componente canónico del sistema Kronos para stack React 19 + Vite +
Tailwind v4 + shadcn/ui (el stack de las apps React de Kronos).

## Estado

⏳ **Pendiente de creación.**

## Cuándo crear este archivo

Cuando se migre el primer repo React (ej. `ZEUES-by-KM/frontend/`) al design
system. La implementación debe partir del canónico Astro
(`../astro/CTASection.astro`) y portarlo a React preservando:

- Estructura de 4 capas (shader / overlay / grid / content)
- Label técnica `◆ SISTEMA NN — NOMBRE ─── coordenada`
- Headline oversized uppercase con clamp + última palabra en accent
- Sub + botón primary (shimmer + glow pulse) + botón outline (liquid fill)
- Footer técnico con separadores `●`
- Lazy-load del shader con `IntersectionObserver`
- Desactivación del shader en `window.innerWidth < 768` y `prefers-reduced-motion`
- Cleanup de GSAP ScrollTrigger al desmontar (`useEffect` return)

## Dependencias esperadas en el repo consumidor

```bash
npm install @paper-design/shaders gsap
```

## Puntos de atención al portar de Astro → React

1. **`<script>` vanilla → `useEffect`** para montaje de shader y GSAP.
2. **CSS scoped `.astro` → CSS modules o clases Tailwind + `@theme`.**
   Preferir clases Tailwind cuando el patrón es reutilizable; CSS module
   solo para los botones con microinteracciones complejas (`btn-kronos-*`).
3. **Paper Shaders en React:** existe wrapper oficial `@paper-design/shaders-react`
   con componente `<MeshGradient />`. Usar ese en lugar del `ShaderMount` vanilla.
4. **GSAP SplitText en React:** usar `useGSAP()` hook de `@gsap/react` para
   scope y cleanup automático. Evita memory leaks en re-renders.
5. **Router.** El canónico Astro usa `<a href>`. En React con React Router usar
   `<Link to="/...">` — ajustar imports.
6. **TypeScript.** Tipar props mínimamente: `title`, `subtitle`, `primaryCta`,
   `secondaryCta`, `systemNumber`, `coordinate`. No hardcodear el copy.

## Ejemplo de estructura esperada (esqueleto)

```tsx
// src/components/CTASection.tsx (en el repo consumidor)
import { useEffect, useRef } from 'react';
import { MeshGradient } from '@paper-design/shaders-react';
import { useGSAP } from '@gsap/react';
import { SplitText } from 'gsap/SplitText';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import styles from './CTASection.module.css'; // para .btn-kronos-*

interface Props {
  systemNumber: string;   // ej. "05"
  systemName: string;     // ej. "CONTACTO"
  coordinate: string;     // ej. "-33.45°S / -70.66°W"
  headline: [string, string]; // ej. ["Ingeniería que", "resiste."]
  sub: string;
  primaryCta: { label: string; href: string };
  secondaryCta: { label: string; href: string };
}

export function CTASection(props: Props) { /* ... */ }
```

## Cuando esté listo

1. Crear `CTASection.tsx` en este directorio.
2. Crear `CTASection.module.css` para los botones con microinteracciones.
3. Actualizar el `README.md` de `reference/` con estado `✅ canónico`.
4. Actualizar `CHANGELOG.md` del design system con la entrada `[0.2.0]`.
5. Tag: `git tag v0.2.0 && git push --tags`.
