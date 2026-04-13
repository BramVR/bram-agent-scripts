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

## Helper Scripts
- `committer`: run via `.\scripts\committer.ps1 "message" "path1" "path2"` to stage only explicit paths and commit them
- `docs-list`: run via `.\scripts\docs-list.ps1` to scan `docs/`, print each markdown file's front-matter summary, and surface `read_when` hints

## Using Skills
- Open Codex and type `/skills` to browse available skills.
- Type `$pickup`, `$handoff`, `$commit-atomic`, `$split-commits`, or `$video-transcript-downloader` to invoke one explicitly.

## Notes
- This repo is personal workflow infrastructure, not project documentation.
- `docs-list` is included as a portable helper for downstream repos that maintain a `docs/` directory with front matter.
- Repo-local `AGENTS.md` files remain the source of truth for repo-specific rules.
- Codex custom prompts in `~/.codex/prompts` are deprecated; this repo uses skills instead.
