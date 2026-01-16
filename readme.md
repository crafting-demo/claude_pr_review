# GitHub Watcher

Minimal GitHub PR watcher that:

1. Polls GitHub on a cron schedule.
2. Creates a sandbox from a local definition.
3. Runs Claude Code to review the PR.
4. Posts a review comment back to the PR.

## Components

- `gh-watcher/` — Node watcher (polling + sandbox creation)
- `claude-code-automation/template.yaml` — sandbox definition
- `dev-worker/` — worker scripts to run Claude
- `cmd/worker` + `pkg/` — Go worker and shared packages
- `.sandbox/manifest.yaml` — cron job to run the watcher

## Quick setup

1. Configure `gh-watcher/watchlist.txt` with `owner/repo` lines.
2. Ensure `GH_TOKEN` (or `GITHUB_TOKEN`) is set.
3. Run the watcher locally:

```bash
cd gh-watcher
npm install
npm run watch
```

## Environment variables (watcher)

- `GITHUB_TOKEN` or `GH_TOKEN` (required)
- `PROCESS_EXISTING_PRS` (optional)
- `PR_LABELS` (optional; comma-separated)
- `CMD_DIR` (optional; default `/home/owner/cmd`)
- `SANDBOX_DEF_PATH` (optional; default `../claude-code-automation/template.yaml`)
- `SANDBOX_TEMPLATE_NAME` (optional; use named template instead of local file)
- `TOOL_WHITELIST_JSON` (optional; JSON array of allowed tools)

## Tests

```bash
make test
```
