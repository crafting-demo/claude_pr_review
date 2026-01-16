# Repo Structure

```
github-watcher/
├── .sandbox/                   # Cron job for watcher
│   └── manifest.yaml
├── gh-watcher/                 # GitHub PR watcher (Node)
│   ├── src/
│   ├── watchlist.txt
│   └── package.json
├── claude-code-automation/     # Worker sandbox definition
│   └── template.yaml
├── cmd/                        # Go binaries
│   └── worker                  # Claude worker runner
├── dev-worker/                 # Worker scripts (Claude Code setup + run)
│   └── start-worker.sh
├── pkg/                        # Shared Go packages
├── go.mod / go.sum
├── Makefile
└── readme.md
```
