#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"
mkdir -p .codex-cache

sha256_stream() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum | awk '{print $1}'
  else
    shasum -a 256 | awk '{print $1}'
  fi
}

hash_inputs() {
  {
    for f in package.json package-lock.json pnpm-lock.yaml yarn.lock pyproject.toml uv.lock requirements.txt; do
      if [ -f "$f" ]; then
        if command -v sha256sum >/dev/null 2>&1; then sha256sum "$f"; else shasum -a 256 "$f"; fi
      fi
    done
    true
  } | sha256_stream
}

current="$(hash_inputs)"
previous="$(cat .codex-cache/deps.sha 2>/dev/null || true)"
if [ "$current" != "$previous" ]; then
  echo "Dependency inputs changed; running full setup"
  bash .codex/cloud/setup.sh
  printf '%s\n' "$current" > .codex-cache/deps.sha
else
  echo "Dependency inputs unchanged"
  bash scripts/verify-cloud.sh
fi
