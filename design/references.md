# Referencias visuales canónicas — Kronos Mining

> Fuente operativa de inspiración visual del sistema. Cuando un caso de diseño no esté
> resuelto en `src/components/CTASection.astro` ni en `DESIGN.md`, consulta este archivo.
>
> **Regla de oro.** Estas son referencias de **lenguaje visual**, no de contenido. Nunca copiar
> textos, estructura exacta ni elementos identificables. Adaptar el vocabulario visual al
> contexto industrial chileno minero de Kronos.
>
> **Aviso de decay.** Las webs externas rediseñan sin aviso. Cuando una referencia se actualice
> de manera significativa y pierda alineación con el sistema Kronos, archivar la versión vigente
> como screenshot en `design/references/` antes de perder el benchmark.

---

## Las 3 canónicas

### 1. Anduril Industries

- **URL:** https://www.anduril.com/
- **Rating Anduril-likeness:** 10/10 (es la referencia madre)
- **Screenshot archivado:** `design/references/anduril-home.png` *(pendiente de captura)*
- **Por qué es canónica para Kronos:**
  Es el origen del lenguaje "defense-tech serious" que todo el resto del nicho copia. Define las reglas del
  sistema que Kronos adopta: fondo oscuro dominante, un único acento cromático usado con extrema
  economía (<5% del área), tipografía oversized uppercase, labels técnicas como elemento de diseño y
  densidad visual deliberadamente baja. Cuando el sistema Kronos dude, Anduril es el juez final: si una
  decisión visual no se siente afín a `anduril.com`, está fuera del sistema.
- **Qué buscar cuando la consultes:**
  - Restraint cromático extremo: fondo dominante + un solo acento usado en <5% del área visible.
  - Tipografía display oversized en headlines, uppercase sin excepción, tracking ajustado.
  - Labels técnicas (códigos de producto, nomenclatura de sistemas) tratadas como elementos de diseño, no como texto decorativo.
  - Navbar transparente al cargar, opacidad creciente al hacer scroll.
  - Video hero de instalación o producto real, nunca stock footage ni render genérico.
  - Footer técnico con metadata (direcciones, coordenadas, certificaciones) en mono uppercase, tracking amplio.
  - Espacio negativo generoso: baja densidad de elementos por vista como declaración de confianza.
- **Qué NO copiar:**
  - Temática de defensa militar, armamento, drones de combate — Kronos es minería civil industrial.
  - Copy agresivo de "mission readiness", "warfighter", "lethality" — incompatible con el contexto chileno B2B.
  - Referencias geopolíticas USA-centric, flags, naming militarista.
  - Nomenclatura de productos clasificados ("Lattice", "Roadrunner", etc.) — Kronos nombra proyectos y especificaciones, no armas.
  - Estética "dark futurism" llevada al extremo (glitch, scan lines marcadas) — el sistema Kronos es más sobrio.

---

### 2. Saronic Technologies

- **URL:** https://www.saronic.com/
- **Rating Anduril-likeness:** 9/10
- **Screenshot archivado:** `design/references/saronic-home.png` *(pendiente de captura)*
- **Por qué es canónica para Kronos:**
  Es la aplicación más disciplinada del código Anduril fuera de Anduril. Fondo navy profundo `#1B2733`
  (casi idéntico al `#083A75` de Kronos), acento usado exclusivamente como textura SVG de fondo en opacidad
  reducida (~15%), jerarquía tipográfica codificada en clases semánticas (`type--display-large` /
  `type--heading-small` / `type--caption-small`), y fotografía industrial de buques sobre gradientes oscuros.
  Saronic demuestra que el código es replicable con variaciones de paleta — no depende de usar negro.
- **Qué buscar cuando la consultes:**
  - Uso del color de acento como textura SVG de fondo (círculos concéntricos, grillas, patrones geométricos) en baja opacidad, no como fill de elementos.
  - Jerarquía tipográfica codificada en nombres de clase semánticos (display / heading / caption).
  - CTA primario con fondo de acento + texto oscuro e ícono de flecha direccional.
  - Fotografía de producto sobre gradientes oscuros — nunca producto recortado sobre blanco.
  - Patrones SVG geométricos como capa de textura técnica que da profundidad sin ruido visual.
- **Qué NO copiar:**
  - Verde lima neón `#ACFF24` de Saronic — Kronos tiene `#FF5B00` como acento único del sistema.
  - Imaginería naval / autonomous surface vessels — irrelevante para piping y revestimientos.
  - Copy en inglés con terminología de Armada (`USV`, `fleet`, `maritime dominance`).

---

### 3. Mach Industries

- **URL:** https://machindustries.com/
- **Rating Anduril-likeness:** 8.5/10
- **Screenshot archivado:** `design/references/mach-home.png` *(pendiente de captura)*
- **Por qué es canónica para Kronos:**
  Es la referencia del sistema para **tamaños tipográficos fluidos extremos** y **CTAs como acceso a contenido
  técnico en lugar de formulario de contacto**. Mach define H1 con fluid sizing de `4rem` en mobile a `7rem` en
  desktop — oversized por principio, no por decoración. Su CTA principal es "Read Thesis", no "Contact Us":
  posiciona la empresa como entidad de ingeniería seria cuyo activo comunicacional es documentación técnica,
  no un formulario de captura de leads. Este patrón es directamente trasladable a Kronos (`Descargar
  Especificaciones`, `Ver Catálogo Técnico`).
- **Qué buscar cuando la consultes:**
  - Fluid sizing agresivo en headlines (`clamp(4rem, 8vw, 7rem)` o similar).
  - Variables CSS semánticas: `--color--black`, `--color--white` como backbone del sistema.
  - CTA primario enlazando a documento técnico descargable, no a formulario de contacto.
  - Video de producto operando como thumbnail focal del hero (no fondo decorativo, sino contenido).
  - Navegación secundaria con nombres de producto monosilábicos, tratados como labels.
  - Fade-up suave en animaciones de entrada, sin rebote ni overshoot.
- **Qué NO copiar:**
  - Imaginería de drones, hidrógeno, propulsión — contexto producto irrelevante.
  - Copy en inglés con lenguaje de defensa hipersónica / cinética.
  - Naming monosilábico inventado tipo `Viper`, `Glide`, `Stratos` — Kronos nombra proyectos por ubicación y cliente, no por metáforas.

---

## Referencias secundarias

Solo consultar si los 3 canónicos no resuelven el caso específico. Ranqueadas por alineación con el sistema Kronos.

| # | Empresa | URL | Rating | Cuándo consultar |
|---|---------|-----|--------|------------------|
| 1 | True Anomaly | https://www.trueanomaly.space | 9.5/10 | **Tratamiento del naranjo.** Usa `#FF5519` / `#ED5927` casi idéntico al `#FF5B00` de Kronos. Es la referencia para proporción del acento (<3% del área), botón fantasma con borde naranjo + hover de inversión a fill sólido, y flechas animadas con `translateX(4px)` en hover. |
| 2 | Hermeus | https://www.hermeus.com | 9/10 | **Nomenclatura técnica como elemento de diseño.** Consultar cuando haya que tratar nombres de proyecto o códigos de especificación (`PROYECTO ATACAMA`, `ASME B31.3`) como labels visuales oversized, no como texto corriente. También para fotografía real de instalación industrial como hero (no render). |
| 3 | Epirus | https://www.epirusinc.com | 8.5/10 | **Efecto typewriter + navbar transparente-a-opaca en scroll.** Consultar para subtítulos técnicos con cursor `█` parpadeando ("sistema en tiempo real") y para el patrón de header con `opacity: 0` inicial que transiciona al hacer scroll. |
| 4 | Kairos Power | https://www.kairospower.com | 8/10 | **Geist Mono en toda la jerarquía de metadata.** Consultar cuando haya dudas sobre aplicación de monospace en labels técnicas secundarias (`PROYECTO N.º 047 — LAMPA, RM — COMPLETADO 2024`). También para microinteracción "dot-spreading" en botones. |
| 5 | Path Robotics | https://www.path-robotics.com | 8/10 | **Fotografía industrial real como hero.** Es la referencia más directa del tipo de imagen que Kronos ya tiene (celdas de soldadura, piping en obra). Consultar para tratamiento fotográfico de alto contraste sobre fondo oscuro y headlines de tres palabras con carga conceptual. |
| 6 | KoBold Metals | https://www.koboldmetals.com | 7.5/10 | **Única referencia minera del set.** Consultar cuando se necesite validar que un patrón defense-tech funciona en contexto minero. Usa header transparente → opaco en scroll, intersection observers para reveal, y paleta near-black con botones `#32373c` (traducible directamente a `#083A75`). |
| 7 | Ursa Major | https://www.ursamajor.com | 7.5/10 | **Patrón de dos botones primario sólido + secundario fantasma.** Consultar cuando haya que decidir tratamiento de par de CTAs (primario relleno + secundario borde fino). Es el estándar del sector y referencia para pureza cromática blanco/negro sin acentos. |
| 8 | Basement Studio | https://basement.studio | 7.5/10 | **Jerarquía tipográfica por opacidades del mismo color.** Consultar cuando haya dudas sobre crear jerarquía con `text-white/100`, `text-white/60`, `text-white/30` en lugar de introducir grises nuevos. También para implementación técnica WebGL/Three.js si se evalúa añadir 3D. |

---

## Patrones universales observados en las 10 referencias

Extraídos del reporte de investigación. Son los que se repiten **sin excepción** en el set completo:

1. **Paleta 2 + 1.** Un fondo oscuro dominante, un texto claro, un acento saturado usado en <5% del área. Cualquier variación adicional se logra con opacidades del mismo color, nunca con colores nuevos.
2. **Botón fantasma con hover de inversión.** `background: transparent` + `border: 1px solid [acento]` + texto claro en reposo; `background: [acento]` en hover. True Anomaly, Saronic y Hermeus lo usan idénticamente.
3. **Video hero con overlay oscuro.** Todas las referencias top usan video de instalación real (no stock, no render 3D estático) con overlay entre `rgba(0,0,0,0.5)` y `rgba(0,0,0,0.75)` para legibilidad.
4. **Headlines uppercase sin excepción.** Los titulares principales son uppercase siempre. El uppercase comunica precisión industrial y elimina la ambigüedad interpretativa.
5. **Navbar transparente → opaca en scroll.** El 80% de las referencias usa `opacity: 0` en el header inicial, con transición a fondo oscuro semitransparente al hacer scroll. Crea la ilusión de que el contenido "emerge" del hero.
6. **Labels técnicas como elementos de diseño.** Números de sistema, coordenadas, códigos de producto (`JACKAL MK-2`, `SAC-EC`, `SISTEMA 01`) usados como elementos visuales — metadatos que duplican como decoración tipográfica en Geist Mono uppercase con tracking amplio.
7. **Flechas animadas, no íconos decorativos.** Los CTAs usan flechas `→` que se trasladan con `transform: translateX(4px)` en hover. Cero íconos SVG decorativos, cero ilustraciones.
8. **Espacio negativo como declaración de intención.** Densidad visual deliberadamente baja. La cantidad de espacio en blanco (o en negro) es la señal de que la empresa no necesita llenar cada pixel para convencer al visitante.

---

## Cómo usar este archivo en un rediseño

1. **Antes de codear**, lee las 3 canónicas + la secundaria más relevante al caso específico.
2. **Nunca abras las URLs para copiar código.** Solo para extraer vocabulario visual (tipografía, spacing, jerarquía, microinteracciones). El código del sistema Kronos ya está en `src/components/CTASection.astro` y `src/styles/global.css`.
3. **Si detectas un patrón nuevo en una de las canónicas que aún no está en el sistema Kronos**, anótalo en `design/components.md` como candidato a incorporar tras discusión con el usuario. No incorpores patrones nuevos silenciosamente.
4. **Si una URL deja de cargar o cambia significativamente**, avisar al usuario y marcarla aquí como "STALE" hasta revisión. Archivar el screenshot vigente en `design/references/` antes de perder el benchmark.

---

## Archivo de screenshots

Todos los screenshots de referencias se guardan en:
`design/references/`

**Nomenclatura:** `[empresa]-[pagina]-[fecha].png`
**Ejemplos:** `anduril-home-2026-04.png`, `saronic-products-2026-04.png`, `mach-home-2026-04.png`.

Actualizar cuando el sitio original rediseñe o cuando se detecte drift significativo respecto al snapshot previo.

---

**Última revisión de referencias:** 2026-04-04 (creación inicial).
**Próxima revisión sugerida:** cada 6 meses, o cuando se detecte drift visual en el sitio Kronos respecto a las canónicas.
