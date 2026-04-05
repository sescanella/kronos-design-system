#!/bin/bash
# ============================================================
# Kronos Design System — Script de instalación
# ------------------------------------------------------------
# Automatiza los pasos de adopción del design system en un
# repo consumidor. Ver README.md del design system para flujo manual.
#
# Uso (desde la raíz del repo consumidor):
#   bash .design-system/scripts/install.sh [stack]
#
# Stacks soportados:
#   astro        — Astro + Tailwind v4
#   react-vite   — React + Vite + Tailwind v4 (apps tipo ZEUES)
#   next         — Next.js + Tailwind v4
#
# Qué hace:
#   1. Verifica que existe .design-system/ (el submodule)
#   2. Copia las fuentes .ttf a la carpeta pública del repo
#   3. Copia el skill rediseño a .claude/skills/
#   4. Muestra los próximos pasos manuales (imports CSS)
# ============================================================

set -e

STACK="${1:-}"
if [ -z "$STACK" ]; then
  echo "Uso: bash .design-system/scripts/install.sh <astro|react-vite|next>"
  exit 1
fi

DS_PATH=".design-system"

if [ ! -d "$DS_PATH" ]; then
  echo "ERROR: No se encuentra $DS_PATH/"
  echo "Primero añade el design system como submodule:"
  echo "  git submodule add ../kronos-design-system .design-system"
  exit 1
fi

echo "Kronos Design System — instalación para stack: $STACK"
echo ""

# 1. Copiar fuentes según el stack
case "$STACK" in
  astro|react-vite|next)
    FONTS_DST="public/fonts"
    ;;
  *)
    echo "Stack no soportado: $STACK"
    exit 1
    ;;
esac

mkdir -p "$FONTS_DST"
cp "$DS_PATH/fonts/InstrumentSans-Variable.ttf" "$FONTS_DST/"
cp "$DS_PATH/fonts/GeistMono-Variable.ttf" "$FONTS_DST/"
echo "[OK] Fuentes copiadas a $FONTS_DST/"

# 2. Copiar skill rediseño
mkdir -p ".claude/skills/rediseño"
cp "$DS_PATH/skills/rediseño/SKILL.md" ".claude/skills/rediseño/"
echo "[OK] Skill rediseño copiado a .claude/skills/rediseño/SKILL.md"

# 3. Próximos pasos manuales
echo ""
echo "============================================================"
echo "Siguientes pasos MANUALES (el script no los ejecuta):"
echo "============================================================"
echo ""
echo "1. Importa los tokens del design system en tu CSS global."
echo "   Edita src/styles/global.css (o src/index.css) y añade:"
echo ""
echo "   @import \"tailwindcss\";"
echo "   @import \"../../.design-system/tokens/colors.css\";"
echo "   @import \"../../.design-system/tokens/typography.css\";"
echo "   @import \"../../.design-system/tokens/spacing.css\";"
echo ""
echo "   (Ajusta la profundidad ../ según la ubicación de tu CSS global)"
echo ""
echo "2. Actualiza o crea CLAUDE.md en la raíz del repo con referencias"
echo "   a los archivos del design system. Ver README.md del design system."
echo ""
echo "3. Copia el componente canónico del stack a src/components/:"
case "$STACK" in
  astro)
    echo "   cp $DS_PATH/reference/astro/CTASection.astro src/components/"
    ;;
  react-vite|next)
    echo "   (Pendiente: reference/react/CTASection.tsx aún no existe."
    echo "   Leer reference/react/README.md para crearlo.)"
    ;;
esac
echo ""
echo "4. Ejecuta npm run build para verificar que todo compila."
echo ""
echo "Listo."
