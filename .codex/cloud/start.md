# Start skill

This repository currently has no long-running application service.

1. Run `bash scripts/verify-cloud.sh` to confirm the workspace is healthy.
2. Read `AGENTS.md` before making changes.
3. If the repository later gains an app server, start it using the project's documented package script rather than inventing a global command.
4. Keep the service in the foreground only when the active task needs it; otherwise do not start a daemon.
5. Report the local URL and health-check command whenever a service is started.
