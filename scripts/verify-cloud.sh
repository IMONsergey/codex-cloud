#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "== Environment verification =="
printf 'git: '; git --version
printf 'bash: '; bash --version | head -1

if command -v node >/dev/null 2>&1; then printf 'node: '; node --version; fi
if command -v npm >/dev/null 2>&1; then printf 'npm: '; npm --version; fi
if command -v python3 >/dev/null 2>&1; then printf 'python: '; python3 --version; fi
if command -v gh >/dev/null 2>&1; then printf 'gh: '; gh --version | head -1; fi

if [ -f package.json ] && command -v npm >/dev/null 2>&1; then
  npm pkg get scripts >/dev/null
fi

if [ -f pyproject.toml ]; then
  python3 - <<'PY'
import pathlib
assert pathlib.Path('pyproject.toml').is_file()
PY
fi

echo "verification: OK"
