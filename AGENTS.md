# Bram Agent Scripts

Canonical Bram Codex workflow. Edit here, then mirror to `C:/Users/ZO/AGENTS.md`.

## Agent Protocol
- Purpose: keep personal workflow files in one git repo; mirror selected files into home runtime locations; keep repo-local `AGENTS.md` free to add or ignore these defaults.
- Canonical file: `C:/PROJECTS/GG/bram-agent-scripts/AGENTS.md`
- Home mirror: `C:/Users/ZO/AGENTS.md`
- Canonical skills: `C:/PROJECTS/GG/bram-agent-scripts/skills/`
- Home skills: `C:/Users/ZO/.agents/skills/`
- Helper scripts: `C:/PROJECTS/GG/bram-agent-scripts/scripts/`
- Shell: PowerShell on Windows by default.
- Style: concise, direct, telegraph. Drop filler/extra grammar. Min tokens in `AGENTS.md` and replies.
- Explain what you are doing and why. If uncertain: say knowns, unknowns, next verification step. Keep handoffs compact.

## Critical Thinking
- Fix root cause, not band-aid.
- Unsure: read more code first; if still stuck, ask with short options.
- Conflicts: call out; pick safer path.
- Unrecognized changes: assume another agent; keep going; focus your changes. If it causes issues, stop and ask.
- Leave breadcrumb notes in thread.

## Git
- Safe by default: `git status`, `git diff`, `git log`. Push only when user asks.
- `git checkout` ok for PR review or explicit request.
- Branch changes require user consent.
- Prefer feature branches for active work; do not commit to `main` unless explicitly intended.
- One logical change per commit. Keep commits small/reviewable.
- Commits: Conventional Commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Do not mix refactor, behavior, docs-only, and test-only changes unless inseparable.
- Stage explicit files/hunks only. No `git add .` or `git add -A`.
- Review `git status` and `git diff --staged` before every commit.
- Big review: `git --no-pager diff --color=never`.
- Multi-agent: check `git status` and `git diff` before edits; ship small commits.
- Commit helper on `PATH`: `committer` (bash). Prefer it; if repo has `./scripts/committer` or `./scripts/committer.ps1`, use that.
- Prefer `fixup!` commits for local follow-up changes that will be squashed later.
- No amend unless asked. No force-push unless explicitly intended.
- Destructive ops forbidden unless explicit: `reset --hard`, `clean`, `restore`, `rm`, mass delete, or similar.
- Do not revert unrelated local changes.
- Don’t delete/rename unexpected stuff; stop and ask.
- If worktree has unrelated edits, isolate your commit to your files only.
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked files wholesale.
- Remotes under `~/Projects`: prefer HTTPS; flip SSH->HTTPS before `pull` or `push`.
- Avoid manual `git stash`; if Git auto-stashes during `pull` or `rebase`, that is fine.
- If user types a command such as “pull and push,” that is consent for that command.
- No repo-wide search/replace scripts; keep edits small/reviewable.

## Docs / Web / Testing
- Read only docs relevant to the boundary you are changing. Follow links until domain makes sense; stop when more reading stops changing implementation.
- Update docs when behavior, public usage, or workflow changes. Keep docs concise/operational. Reused workflow/contract: document once in the canonical place.
- Web: search early; quote exact errors; prefer 2024-2025 sources when available.
- Bugs: add regression test when it fits.
- Prefer end-to-end verify. If blocked, say what is missing.

## Skills
- Reusable workflows live as skills, not deprecated custom prompts.
- Global user skills live in `C:/Users/ZO/.agents/skills/`.
- Canonical skill dirs live in `C:/PROJECTS/GG/bram-agent-scripts/skills/` and mirror into home skills.
- Keep skills small, explicit, task-oriented.
- Prefer skills for repeatable workflows such as pickup, handoff, and commit planning.
- Baseline skills: `$pickup`, `$handoff`, `$commit-atomic`, `$split-commits`, `$video-transcript-downloader`.

## Tools
- Prefer small wrappers that make common workflows safer/repeatable.
- `committer`: `scripts/committer.ps1`; stage only explicit files, show staged diff summary, then commit.
- `docs-list`: `scripts/docs-list.ps1`; walk `docs/`, report markdown summaries, surface `read_when` hints from front matter.
- `sync-agents`: `scripts/sync-agents.ps1`; mirror canonical `AGENTS.md` to `C:/Users/ZO/AGENTS.md`.
- `sync-skills`: `scripts/sync-skills.ps1`; mirror skill dirs to `C:/Users/ZO/.agents/skills/`.
- `sync-all`: `scripts/sync-all.ps1`; mirror both `AGENTS.md` and skills.

## Repo Interaction
- Repo-local `AGENTS.md` may add stricter rules or override workflow details.
- Shared/public repos should keep their own self-contained `AGENTS.md`.
- Personal repos can point to this workflow or selectively copy from it.

## Maintenance
- Edit this file here, then mirror to `C:/Users/ZO/AGENTS.md`.
- Keep skills and scripts small, explicit, dependency-light.
