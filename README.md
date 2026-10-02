# codex-cloud

Portable baseline for a reusable Codex Cloud environment.

The repository is intentionally minimal. It does not contain credentials, machine-specific paths, or application dependencies. The setup scripts install project dependencies only when matching manifests/lockfiles exist.

## Codex Cloud configuration

Use these values in **Cloud Environment Onboarding → Setup**:

- Repository: `IMONsergey/codex-cloud`
- Default branch: `main`
- Install script: `bash .codex/cloud/setup.sh`
- Maintenance script: `bash .codex/cloud/maintenance.sh`
- Start skill: use the instructions from `.codex/cloud/start.md`
- Environment variables: none required
- Secrets: none required
- Network access: package managers only by default; add domains only for a concrete task
- Visibility: private / only me unless collaboration is explicitly needed

## What setup supports

- npm via `package-lock.json`
- pnpm via `pnpm-lock.yaml`
- Yarn via `yarn.lock`
- Python `uv` via `uv.lock` + `pyproject.toml`
- Python `requirements.txt`

If no dependency manifest exists, setup only verifies the base toolchain.

## Local verification

```bash
bash .codex/cloud/setup.sh
bash .codex/cloud/maintenance.sh
```

After a real application is added, update `AGENTS.md`, the start skill, and `scripts/verify-cloud.sh` with the project's actual checks.
