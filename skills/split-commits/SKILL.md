---
name: split-commits
description: Use when the user wants the current worktree split into reviewable commits or needs help grouping changes before staging.
---

Split the current worktree into reviewable commit groups.

For each group, provide:
- rationale for why the changes belong together
- files likely included
- whether hunk-level staging is needed
- a conventional commit message suggestion

Prefer a small number of coherent commits over excessive fragmentation.
