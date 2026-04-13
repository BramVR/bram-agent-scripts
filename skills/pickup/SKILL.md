---
name: pickup
description: Use when the user asks to resume work, reconstruct current repo state, or summarize task status before making changes.
---

Reconstruct the current task state before making changes.

Checklist:
- Read the active repo `AGENTS.md` and any directly relevant docs.
- Run `git status --short` and identify unrelated local changes.
- Summarize the current task, changed files, open risks, and next concrete step.
- Do not repeat long diffs; compress to the important state only.
