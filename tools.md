# Tools

Local helper catalog for `bram-agent-scripts`. Keep `AGENTS.md` short; put usage detail here.

## committer

Path: `C:/PROJECTS/GG/bram-agent-scripts/scripts/committer.ps1`

Use for commits in this repo:

```powershell
.\scripts\committer.ps1 "docs: update workflow notes" AGENTS.md
```

Stages only explicit paths, shows staged summary, commits.

## docs-list

Path: `C:/PROJECTS/GG/bram-agent-scripts/scripts/docs-list.ps1`

Run from a repo when `docs/` context is unclear:

```powershell
.\scripts\docs-list.ps1
```

Scans markdown docs for `summary` and `read_when` front matter.

## oracle

Path: `C:/PROJECTS/GG/bram-agent-scripts/scripts/oracle.ps1`

Use for second-model consults with selected files:

```powershell
.\scripts\oracle.ps1 -Prompt "Review this change for regressions" -File "src/**" -DryRun summary -FilesReport
.\scripts\oracle.ps1 -Prompt "Cross-check this plan" -File "src/**"
.\scripts\oracle.ps1 -Status
```

Prefer browser mode. Use API mode only when explicitly intended.

## sync

Paths:
- `scripts/sync-agents.ps1`
- `scripts/sync-skills.ps1`
- `scripts/sync-all.ps1`

Use after editing canonical workflow files:

```powershell
.\scripts\sync-all.ps1
```

Mirrors `AGENTS.md` and skills into the home runtime locations.
