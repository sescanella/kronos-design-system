#!/bin/bash
# ============================================================
# kronos-design-system — Smoke test de tokens CSS
# ------------------------------------------------------------
# Valida que los archivos tokens/*.css no tienen errores de
# sintaxis antes de commit/push. Detecta el bug clásico de
# `*/` dentro de comentarios que cierran el bloque prematuramente
# y otros errores de parseo.
#
# Uso:
#   bash scripts/check-tokens.sh
#
# Ideal: correr antes de cada commit del repo.
# Futuro: convertir en pre-commit hook o CI check.
# ============================================================

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

FAIL=0

echo "Kronos Design System — Smoke test de tokens"
echo ""

# Test 1 — Los 3 archivos existen
for f in tokens/colors.css tokens/typography.css tokens/spacing.css; do
  if [ ! -f "$f" ]; then
    echo "[FAIL] Missing: $f"
    FAIL=1
  else
    echo "[OK]   Exists:  $f"
  fi
done
echo ""

# Test 2 — Detectar `*/` dentro de comentarios (el bug histórico).
# Busca patrones `/*.*\*.*\*/.*\*/` en la misma línea (dos cierres).
echo "Checking for premature comment closures..."
for f in tokens/*.css; do
  # Cuenta cuántos /* y */ hay. Deben ser iguales.
  OPENS=$(grep -o '/\*' "$f" | wc -l | tr -d ' ')
  CLOSES=$(grep -o '\*/' "$f" | wc -l | tr -d ' ')
  if [ "$OPENS" != "$CLOSES" ]; then
    echo "[FAIL] Unbalanced comments in $f: $OPENS opens vs $CLOSES closes"
    FAIL=1
  else
    echo "[OK]   Balanced comments: $f ($OPENS pairs)"
  fi
done
echo ""

# Test 3 — Llaves balanceadas (bug común: @theme { sin cerrar)
echo "Checking for balanced braces..."
for f in tokens/*.css; do
  OPENS=$(grep -o '{' "$f" | wc -l | tr -d ' ')
  CLOSES=$(grep -o '}' "$f" | wc -l | tr -d ' ')
  if [ "$OPENS" != "$CLOSES" ]; then
    echo "[FAIL] Unbalanced braces in $f: $OPENS opens vs $CLOSES closes"
    FAIL=1
  else
    echo "[OK]   Balanced braces: $f ($OPENS pairs)"
  fi
done
echo ""

# Test 4 — Paréntesis balanceados (bug común en rgba, var, etc.)
echo "Checking for balanced parentheses..."
for f in tokens/*.css; do
  OPENS=$(grep -o '(' "$f" | wc -l | tr -d ' ')
  CLOSES=$(grep -o ')' "$f" | wc -l | tr -d ' ')
  if [ "$OPENS" != "$CLOSES" ]; then
    echo "[FAIL] Unbalanced parens in $f: $OPENS opens vs $CLOSES closes"
    FAIL=1
  else
    echo "[OK]   Balanced parens: $f ($OPENS pairs)"
  fi
done
echo ""

# Test 5 — Detectar el patrón exacto que causó el bug de Fase B:
# un comentario con `/\*/` en medio (asterisco entre slashes).
echo "Checking for the /*/ anti-pattern (caused Fase B build failure)..."
for f in tokens/*.css; do
  if grep -qE '/\*/' "$f"; then
    echo "[FAIL] Found /*/ pattern in $f (breaks CSS parsers)"
    grep -n '/\*/' "$f"
    FAIL=1
  else
    echo "[OK]   No /*/ pattern: $f"
  fi
done
echo ""

# Test 6 — Cada archivo empieza con un comentario de header (convención del sistema)
echo "Checking header comment convention..."
for f in tokens/*.css; do
  FIRST_LINE=$(head -1 "$f")
  if [[ "$FIRST_LINE" == "/*"* ]]; then
    echo "[OK]   Has header comment: $f"
  else
    echo "[WARN] Missing header comment: $f (convention only, not blocking)"
  fi
done
echo ""

if [ "$FAIL" -eq 0 ]; then
  echo "============================================================"
  echo "All checks passed. Tokens are safe to commit."
  echo "============================================================"
  exit 0
else
  echo "============================================================"
  echo "FAILURES DETECTED. Fix issues before committing."
  echo "============================================================"
  exit 1
fi
