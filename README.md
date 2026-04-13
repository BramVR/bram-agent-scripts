# bram-agent-scripts

Personal Codex workflow files, skills, and helper scripts.

## Layout
- `AGENTS.md`: canonical personal workflow instructions
- `skills/`: reusable Codex skills mirrored into `~/.agents/skills`
- `scripts/`: helper scripts for syncing and git workflow

## Intended Runtime Locations
- `C:/Users/ZO/AGENTS.md`
- `C:/Users/ZO/.agents/skills/`

## Bootstrap
```powershell
.\scripts\sync-agents.ps1
.\scripts\sync-skills.ps1
```

## Using Skills
- Open Codex and type `/skills` to browse available skills.
- Type `$pickup`, `$handoff`, `$commit-atomic`, or `$split-commits` to invoke one explicitly.

## Notes
- This repo is personal workflow infrastructure, not project documentation.
- Repo-local `AGENTS.md` files remain the source of truth for repo-specific rules.
- Codex custom prompts in `~/.codex/prompts` are deprecated; this repo uses skills instead.
