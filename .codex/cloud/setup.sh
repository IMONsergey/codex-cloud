#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"

echo "== Codex Cloud setup =="
echo "root: $ROOT"

for tool in git bash; do
  command -v "$tool" >/dev/null || { echo "Missing required tool: $tool" >&2; exit 1; }
done

if command -v node >/dev/null 2>&1; then node --version; fi
if command -v npm >/dev/null 2>&1; then npm --version; fi
if command -v python3 >/dev/null 2>&1; then python3 --version; fi

install_node() {
  [ -f package.json ] || return 0
  echo "Installing Node dependencies"
  if [ -f pnpm-lock.yaml ]; then
    command -v corepack >/dev/null 2>&1 && corepack enable || true
    if command -v pnpm >/dev/null 2>&1; then pnpm install --frozen-lockfile; else corepack pnpm install --frozen-lockfile; fi
  elif [ -f yarn.lock ]; then
    command -v corepack >/dev/null 2>&1 && corepack enable || true
    if command -v yarn >/dev/null 2>&1; then yarn install --immutable; else corepack yarn install --immutable; fi
  elif [ -f package-lock.json ]; then
    npm ci
  else
    npm install
  fi
}

install_python() {
  command -v python3 >/dev/null 2>&1 || return 0
  if [ -f uv.lock ] && [ -f pyproject.toml ] && command -v uv >/dev/null 2>&1; then
    echo "Installing Python dependencies with uv"
    uv sync --frozen
  elif [ -f requirements.txt ]; then
    echo "Installing Python dependencies from requirements.txt"
    python3 -m pip install --disable-pip-version-check -r requirements.txt
  fi
}

install_node
install_python
bash scripts/verify-cloud.sh
echo "== Setup complete =="
