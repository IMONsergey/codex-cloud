# Codex Cloud repository instructions

- Keep the repository cloud-safe: never commit tokens, cookies, local credentials, private keys, or generated `.env` files.
- Prefer reproducible commands and lockfiles over ad-hoc global installs.
- Treat `.codex/cloud/setup.sh` as the canonical dependency/bootstrap entry point.
- Treat `.codex/cloud/maintenance.sh` as the lightweight refresh entry point for an already prepared environment.
- Run `bash scripts/verify-cloud.sh` after changing environment/bootstrap files.
- When a real application is added, extend verification with that application's lint, test, typecheck, and build commands.
- Do not silently weaken tests or delete checks just to make setup pass.
- Keep setup idempotent so it is safe to run more than once.
- Keep network-dependent work limited to package/dependency installation unless a task explicitly requires more access.
