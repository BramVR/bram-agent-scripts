# Bram Agent Scripts

This repository is the canonical source for Bram's personal Codex workflow.

## Purpose
- Keep personal agent workflow files in one git-tracked place.
- Mirror selected files into home-directory runtime locations.
- Keep repo-specific `AGENTS.md` files free to add or ignore these defaults.

## Canonical Paths
- Canonical instructions: `C:/PROJECTS/GG/bram-agent-scripts/AGENTS.md`
- Home mirror: `C:/Users/ZO/AGENTS.md`
- Global skills target: `C:/Users/ZO/.agents/skills/`
- Canonical skills: `C:/PROJECTS/GG/bram-agent-scripts/skills/`
- Helper scripts: `C:/PROJECTS/GG/bram-agent-scripts/scripts/`

## Communication Style
- Be concise and direct.
- Explain what you are doing and why, not how you feel about it.
- Prefer clear next steps over long summaries.
- If uncertain, say what is known, what is unknown, and what you will verify next.
- Keep handoffs compact and action-oriented.

## Critical Thinking
- Fix root cause, not a band-aid.
- If unsure, read more code first; if still stuck, ask with short options.
- If there are conflicting signals or constraints, call them out and choose the safer path.
- If you see unrecognized changes, assume another agent made them; keep going and focus on your changes. If they cause problems, stop and ask the user.
- Leave breadcrumb notes in the thread so the next step is easy to follow.

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
- Safe by default: `git status`, `git diff`, `git log`. Push only when the user asks.
- `git checkout` is ok for PR review or when the user explicitly requests it.
- Branch changes require user consent.
- Prefer feature branches for active work; do not commit directly to `main` unless that is explicitly intended.
- Keep commits atomic: one logical change per commit.
- Do not mix refactors, behavior changes, docs-only updates, and test-only updates unless they are inseparable.
- Stage only explicit files or hunks. Do not use broad staging patterns like `git add .` or `git add -A`.
- Review `git status` and `git diff --staged` before every commit.
- Big review command: `git --no-pager diff --color=never`.
- Multi-agent: check `git status` and `git diff` before edits; ship small commits.
- Prefer small, reviewable commits over large mixed commits.
- Commit helper on `PATH`: `committer` (bash). Prefer it; if the repo has `./scripts/committer` or `./scripts/committer.ps1`, use that local helper instead.
- Use `fixup!` commits for local follow-up changes when planning to squash later.
- No amend unless asked.
- No force-push unless explicitly intended.
- Destructive operations are forbidden unless explicitly requested: `reset --hard`, `clean`, `restore`, `rm`, mass delete, or similar.
- Do not revert unrelated local changes.
- Do not delete or rename unexpected files; stop and ask.
- If the working tree contains unrelated edits, isolate your commit to the files you actually changed.
- Remotes under `~/Projects`: prefer HTTPS; flip SSH remotes to HTTPS before `pull` or `push`.
- Avoid manual `git stash`; if Git auto-stashes during `pull` or `rebase`, that is fine.
- If the user types a command such as “pull and push,” that counts as consent for that command.
- Prefer helper scripts that keep staging explicit and narrow.
- No repo-wide search/replace scripts; keep edits small and reviewable.

## Docs
- Read only the docs directly relevant to the boundary you are changing.
- Follow linked docs until the domain makes sense; stop when further reading no longer changes implementation decisions.
- Update docs when behavior, public usage, or workflow changes.
- Keep docs concise and operational.
- If a workflow or contract is likely to be reused, document it once in the canonical place instead of duplicating it in multiple repos.

## Skills
- Codex reusable workflows live as skills, not deprecated custom prompts.
- Global user skills live in `C:/Users/ZO/.agents/skills/`.
- Canonical skill directories live in `C:/PROJECTS/GG/bram-agent-scripts/skills/` and are mirrored into the home skills directory.
- Keep skills small, explicit, and task-oriented.
- Prefer skills for repeatable workflows such as pickup, handoff, and commit planning.
- Current baseline skills:
  - `$pickup`
  - `$handoff`
  - `$commit-atomic`
  - `$split-commits`
  - `$video-transcript-downloader`

## Tools
- Helper scripts live in `C:/PROJECTS/GG/bram-agent-scripts/scripts/`.
- Prefer small wrappers that make common workflows safer and easier to repeat.
- Current tools:
  - `committer`: `scripts/committer.ps1`; stage only explicit files, show staged diff summary, then commit
  - `docs-list`: `scripts/docs-list.ps1`; walk `docs/`, report markdown summaries, and surface `read_when` hints from front matter
  - `sync-agents`: `scripts/sync-agents.ps1`; mirror canonical `AGENTS.md` to `C:/Users/ZO/AGENTS.md`
  - `sync-skills`: `scripts/sync-skills.ps1`; mirror skill directories to `C:/Users/ZO/.agents/skills/`
  - `sync-all`: `scripts/sync-all.ps1`; mirror both `AGENTS.md` and skills

## Repo Interaction
- A repo-local `AGENTS.md` may add stricter rules or override workflow details.
- Shared/public repos should keep their own self-contained `AGENTS.md`.
- Personal repos can point to this workflow or selectively copy from it.

## Maintenance
- Edit this file here, then mirror it to `C:/Users/ZO/AGENTS.md`.
- Keep skills and scripts small, explicit, and dependency-light.
