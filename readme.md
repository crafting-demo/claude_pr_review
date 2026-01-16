# Claude PR Reviews on Crafting

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

## How it works

- **Watcher (`gh-watcher/`)** polls GitHub for new/updated PRs on a schedule and prepares a review prompt.
- **Sandbox definition (`watcher-sandbox.yaml` + `claude-code-automation/template.yaml`)** defines the watcher sandbox and the worker sandbox used for reviews.
- **Worker scripts (`dev-worker/`)** install Claude Code and launch the Go worker inside the review sandbox.
- **Go worker (`cmd/worker` + `pkg/`)** clones the target repo, applies tool permissions, runs Claude with the prompt, and posts a PR comment.
- **Cron manifest (`.sandbox/manifest.yaml`)** runs `npm run watch` every 5 minutes so the watcher keeps polling.

## Quick setup

1. Create a sandbox using `watcher-sandbox.yaml` in this repo.
2. Configure `gh-watcher/watchlist.txt` with `owner/repo` lines.
3. Ensure `GH_TOKEN` (or `GITHUB_TOKEN`) is set.
4. Run the watcher locally:

```bash
cd gh-watcher
npm install
npm run watch
```

## Environment variables (watcher)

- `GITHUB_TOKEN` or `GH_TOKEN` (required): GitHub token with access to the watched repos.
- `PROCESS_EXISTING_PRS` (optional, `true|false`): If `true`, process all current open PRs on first run; otherwise only new/updated PRs after the first run.
- `PR_LABELS` (optional, comma-separated): Only review PRs that have at least one of these labels.
- `CMD_DIR` (optional; default `/home/owner/cmd`): Where the watcher drops prompt/config files inside the sandbox.
- `SANDBOX_DEF_PATH` (optional; default `../claude-code-automation/template.yaml`): Local sandbox definition file to use with `cs sandbox create --from def:...`.
- `SANDBOX_TEMPLATE_NAME` (optional): If set, uses a named Crafting template instead of the local definition file.
- `TOOL_WHITELIST_JSON` (optional): JSON array of allowed tools for Claude (e.g. `["Bash","Read","Write"]`).

## Tests

```bash
make test
```
