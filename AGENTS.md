# Bram Agent Scripts

This repository is the canonical source for Bram's personal Codex workflow.

## Purpose
- Keep personal agent workflow files in one git-tracked place.
- Mirror selected files into home-directory runtime locations.
- Keep repo-specific `AGENTS.md` files free to add or ignore these defaults.

## Canonical Paths
- Canonical instructions: `C:/PROJECTS/GG/bram-agent-scripts/AGENTS.md`
- Home mirror: `C:/Users/ZO/AGENTS.md`
- Global prompts target: `C:/Users/ZO/.codex/prompts/`
- Helper scripts: `C:/PROJECTS/GG/bram-agent-scripts/scripts/`

## Communication Style
- Be concise and direct.
- Explain what you are doing and why, not how you feel about it.
- Prefer clear next steps over long summaries.
- If uncertain, say what is known, what is unknown, and what you will verify next.
- Keep handoffs compact and action-oriented.

## Workflow Defaults
- Shell: PowerShell on Windows by default.
- Keep commit history reviewable and small.
- Prefer one logical change per commit.
- Do not mix refactor, behavior change, docs-only, and test-only work in one commit unless inseparable.
- Stage only the files or hunks that belong to the current logical change.
- Review `git status` and `git diff --staged` before committing.
- Prefer `fixup!` commits for local follow-up adjustments when they will be squashed later.
- Do not amend, force-push, or use destructive git commands unless explicitly intended.

## Git
- Safe by default: `git status`, `git diff`, `git log`.
- Prefer feature branches for active work; do not commit directly to `main` unless that is explicitly intended.
- Keep commits atomic: one logical change per commit.
- Do not mix refactors, behavior changes, docs-only updates, and test-only updates unless they are inseparable.
- Stage only explicit files or hunks. Do not use broad staging patterns like `git add .` or `git add -A`.
- Review `git status` and `git diff --staged` before every commit.
- Prefer small, reviewable commits over large mixed commits.
- Use `fixup!` commits for local follow-up changes when planning to squash later.
- No amend unless explicitly intended.
- No force-push unless explicitly intended.
- No destructive operations unless explicitly intended: `reset --hard`, `clean`, `restore`, mass delete, or similar.
- Do not revert unrelated local changes.
- If the working tree contains unrelated edits, isolate your commit to the files you actually changed.
- Prefer helper scripts that keep staging explicit and narrow.

## Docs
- Read only the docs directly relevant to the boundary you are changing.
- Follow linked docs until the domain makes sense; stop when further reading no longer changes implementation decisions.
- Update docs when behavior, public usage, or workflow changes.
- Keep docs concise and operational.
- If a workflow or contract is likely to be reused, document it once in the canonical place instead of duplicating it in multiple repos.

## Slash Commands
- Global slash-command prompts live in `C:/Users/ZO/.codex/prompts/`.
- Canonical prompt files live in `C:/PROJECTS/GG/bram-agent-scripts/prompts/` and are mirrored into the home prompts directory.
- Keep slash commands small, explicit, and task-oriented.
- Prefer prompts for repeatable workflows such as pickup, handoff, and commit planning.
- Current baseline commands:
  - `/pickup`
  - `/handoff`
  - `/commit-atomic`
  - `/split-commits`

## Tools
- Helper scripts live in `C:/PROJECTS/GG/bram-agent-scripts/scripts/`.
- Prefer small wrappers that make common workflows safer and easier to repeat.
- Current tools:
  - `committer.ps1`: stage only explicit files, show staged diff summary, then commit
  - `sync-agents.ps1`: mirror canonical `AGENTS.md` to `C:/Users/ZO/AGENTS.md`
  - `sync-prompts.ps1`: mirror prompt files to `C:/Users/ZO/.codex/prompts/`
  - `sync-all.ps1`: mirror both `AGENTS.md` and prompts

## Repo Interaction
- A repo-local `AGENTS.md` may add stricter rules or override workflow details.
- Shared/public repos should keep their own self-contained `AGENTS.md`.
- Personal repos can point to this workflow or selectively copy from it.

## Maintenance
- Edit this file here, then mirror it to `C:/Users/ZO/AGENTS.md`.
- Keep prompts and scripts small, explicit, and dependency-light.
