---
name: commit-atomic
description: Use when the user asks how to commit the current work cleanly, wants an atomic commit plan, or needs help separating changes before committing.
---

Review the current diff and propose the smallest sensible atomic commit plan.

Rules:
- one logical change per commit
- separate refactor from behavior changes when possible
- separate docs-only or test-only commits when they are independently reviewable
- call out files or hunks that should not be staged together

Output:
- proposed commit groups
- recommended commit message for each group
- any files that should stay uncommitted for now
