---
summary: "Windows setup and daily commands for this repo's agent workflow."
read_when:
  - "Need to run repo helper scripts from PowerShell."
  - "Need to sync AGENTS.md or skills into home runtime locations."
  - "Need the canonical Windows paths used by this repo."
---

# Windows

## Scope

This repo is the canonical source for personal Bram agent workflow files on Windows.

- Canonical AGENTS: `C:/PROJECTS/GG/bram-agent-scripts/AGENTS.md`
- Home AGENTS mirror: `C:/Users/ZO/AGENTS.md`
- Canonical skills: `C:/PROJECTS/GG/bram-agent-scripts/skills/`
- Home skills mirror: `C:/Users/ZO/.agents/skills/`
- Helper scripts: `C:/PROJECTS/GG/bram-agent-scripts/scripts/`

## Shell

Default shell: PowerShell.

Run repo scripts from the repo root:

```powershell
Set-Location C:\PROJECTS\GG\bram-agent-scripts
```

If execution policy blocks local scripts in the current session:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

## Common Commands

Sync only `AGENTS.md`:

```powershell
.\scripts\sync-agents.ps1
```

Sync only skills:

```powershell
.\scripts\sync-skills.ps1
```

Sync both:

```powershell
.\scripts\sync-all.ps1
```

List docs in the current working repo when that helper exists:

```powershell
.\scripts\docs-list.ps1
```

Commit staged changes with the helper when available:

```powershell
committer
```

Repo-local fallback:

```powershell
.\scripts\committer.ps1
```

## Git Safety

- Prefer `git status`, `git diff`, `git log`.
- Stage explicit files only.
- Do not commit to `main` unless explicitly intended.
- Do not use destructive commands unless explicitly requested.

Useful checks:

```powershell
git status
git diff
git --no-pager diff --color=never
```

## Notes

- Edit workflow docs here first, then mirror to home.
- Keep docs concise and operational.
- Reused workflows should live in docs or skills, not only in chat history.
