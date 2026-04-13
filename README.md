# bram-agent-scripts

Personal Codex workflow files, prompts, and helper scripts.

## Layout
- `AGENTS.md`: canonical personal workflow instructions
- `prompts/`: global slash-command prompt files to mirror into `~/.codex/prompts`
- `scripts/`: helper scripts for syncing and git workflow

## Intended Runtime Locations
- `C:/Users/ZO/AGENTS.md`
- `C:/Users/ZO/.codex/prompts/`

## Bootstrap
```powershell
.\scripts\sync-agents.ps1
.\scripts\sync-prompts.ps1
```

## Notes
- This repo is personal workflow infrastructure, not project documentation.
- Repo-local `AGENTS.md` files remain the source of truth for repo-specific rules.
