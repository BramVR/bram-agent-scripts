---
name: oracle
description: Use when Codex needs a second-model review with real repo context, especially when stuck on bugs, refactors, design tradeoffs, release checks, or risky changes. Runs the local `scripts/oracle.ps1` wrapper for `@steipete/oracle` to bundle a prompt plus selected files. Prefer browser mode by default; use API mode only with explicit user consent because it incurs usage cost.
---

Use Oracle as a one-shot consult with attached repo context.

Workflow:
- Pick the smallest file set that still contains the truth.
- Preview first with `-DryRun summary` and add `-FilesReport` when token usage might spike.
- Prefer browser mode on Windows; the wrapper defaults to manual-login browser flow.
- Reattach to an existing session instead of re-running long Pro requests.
- Do not attach secrets unless the user explicitly approves and the data is required.

Commands:

```powershell
.\scripts\oracle.ps1 -Prompt "Review this refactor for regressions" -File "src/**" -DryRun summary -FilesReport
.\scripts\oracle.ps1 -Prompt "Cross-check this plan" -File "src/**" -File "!**/*.test.ts"
.\scripts\oracle.ps1 -Status
.\scripts\oracle.ps1 -Session "<session-id-or-slug>"
```

Prompt shape:
- State the stack, build/test commands, and any platform constraints.
- Name the exact files or directories that matter.
- Include the concrete question and the desired output format.
- Quote exact errors verbatim when debugging.

Notes:
- The wrapper uses `npx -y @steipete/oracle`, so Node 22+ and `npx` must exist on `PATH`.
- Pass uncommon upstream flags through `-OracleArgs`.
- Treat Oracle output as advisory; verify against local code and tests before acting on it.
