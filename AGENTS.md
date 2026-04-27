# Bram Agent Scripts

Canonical Bram Codex workflow. Edit here, then mirror to `C:/Users/ZO/AGENTS.md`.

## Protocol
- Purpose: keep personal workflow files in one git repo; mirror selected files into home runtime locations; keep repo-local `AGENTS.md` free to add or ignore these defaults.
- Canonical file: `C:/PROJECTS/GG/bram-agent-scripts/AGENTS.md`
- Home mirror: `C:/Users/ZO/AGENTS.md`
- Canonical skills: `C:/PROJECTS/GG/bram-agent-scripts/skills/`
- Home skills: `C:/Users/ZO/.agents/skills/`
- Helper scripts: `C:/PROJECTS/GG/bram-agent-scripts/scripts/`
- Shell: PowerShell on Windows.
- Style: concise, direct, telegraph. Min tokens in `AGENTS.md` and replies.
- Say what you are doing and why. If uncertain: knowns, unknowns, next check.
- Repo-local `AGENTS.md` may add stricter rules or override workflow details.
- Shared/public repos should keep their own self-contained `AGENTS.md`.
- Personal repos can point here or copy selectively.
- Edit this file here, then mirror to `C:/Users/ZO/AGENTS.md`.

## Operating Rules
- Fix root cause, not symptoms.
- Unsure: read more code first; if still stuck, state knowns, unknowns, next check.
- Conflicts: call out; pick safer path.
- Unrecognized changes: assume another agent; keep going; focus your changes. If it causes issues, stop and ask.
- Leave breadcrumb notes in thread.

## Git
- Safe by default: `git status`, `git diff`, `git log`. Push only when user asks.
- `git checkout` ok for PR review or explicit request.
- Branch changes require user consent.
- Personal/solo repos: prefer linear history on `main`. Do not create a branch/worktree unless the user asks or the task is risky enough to justify it.
- Shared/team repos or repos with branch protection: follow repo policy; use a feature branch/PR when required.
- If a PR is required, follow the `PR Workflow` section below.
- One logical change per commit. Keep commits small/reviewable.
- Commits: Conventional Commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- Do not mix refactor, behavior, docs-only, and test-only changes unless inseparable.
- Stage explicit files/hunks only. No `git add .` or `git add -A`.
- Review `git status` and `git diff --staged` before every commit.
- Big review: `git --no-pager diff --color=never`.
- Multi-agent: check `git status` and `git diff` before edits; ship small commits.
- Use `committer` for commits; `C:/PROJECTS/GG/bram-agent-scripts/scripts/committer.ps1`.
- Prefer `fixup!` commits for local follow-up changes that will be squashed later.
- No amend unless asked. No force-push unless explicitly intended.
- Destructive ops forbidden unless explicit: `reset --hard`, `clean`, `restore`, `rm`, mass delete, or similar.
- Do not revert unrelated local changes.
- Do not delete or rename unexpected stuff; stop and ask.
- If the worktree has unrelated edits, isolate your commit to your files only.
- Need upstream file: stage in `/tmp/`, then cherry-pick; never overwrite tracked files wholesale.
- Remotes under `~/Projects`: prefer HTTPS; flip SSH to HTTPS before `pull` or `push`.
- Avoid manual `git stash`; if Git auto-stashes during `pull` or `rebase`, that is fine.
- If the user types a command such as `pull and push`, that is consent for that command.
- No repo-wide search/replace scripts; keep edits small and reviewable.

## PR Workflow
- Keep PRs thin: one logical change, short-lived branch, small diff.
- PR titles: `type[(scope)]: short outcome`.
- Preferred types: `fix|feat|build|refactor|docs|test|chore|perf|ci`.
- Add scope only when it helps review routing.
- Default PR body: `## Summary`, `## Tests` or `## Validation`, optional `## Why` or `## Notes`.
- Include exact verification commands in the PR body.
- If replacing earlier work, say `Supersedes #...` or `Replacement for #...` directly.
- Prefer scoped commits via `committer` before opening or updating a PR.

## Docs / Web / Testing
- Read only docs relevant to the boundary you are changing. Follow links until the domain makes sense; stop when more reading stops changing implementation.
- Prefer project docs over session memory. If the active repo has `docs/`, scan that repo's `docs/` first with `docs-list` when entering a subsystem with unclear rules or prior decisions.
- Update docs when behavior, public usage, or workflow changes. Reused workflow/contract: document once in the canonical place.
- If a feature or subsystem needs durable context, write or update the active repo's `docs/*.md` as part of the change so later sessions can reload it fast.
- Do not document helper scripts, skills, or commands unless they exist in this repo or the stated runtime location.
- Before adding command docs, verify the path or command. If optional, say `if present`.
- New docs should start with front matter for `docs-list`: `summary` and `read_when`. Example:
  ```yaml
  ---
  summary: "Automation agent for the Chrome side panel (daemon-backed)."
  read_when:
    - "When working on automation tools, /v1/agent, or the side panel agent loop."
  ---
  ```
- Web: search early; quote exact errors; prefer 2024-2025 sources when available.
- Bugs: add regression test when it fits.
- Prefer end-to-end verify. If blocked, say what is missing.

## Skills
- Reusable workflows live as skills, not deprecated custom prompts.
- Global user skills live in `C:/Users/ZO/.agents/skills/`.
- Canonical skill dirs live in `C:/PROJECTS/GG/bram-agent-scripts/skills/` and mirror into home skills.
- Keep skills small, explicit, task-oriented.
- Each skill should include a clear `description`, concrete trigger/use case, and a short verification or troubleshooting note when it wraps a tool.
- Avoid duplicated long capability lists; keep discoverability in metadata, workflow details in the body.
- Prefer skills for repeatable workflows such as pickup, handoff, and commit planning.
- Baseline skills: `$pickup`, `$handoff`, `$commit-atomic`, `$split-commits`, `$video-transcript-downloader`, `$oracle`.

## Tools
- Prefer small wrappers that make common workflows safer and repeatable.
- `committer`: canonical helper at `C:/PROJECTS/GG/bram-agent-scripts/scripts/committer.ps1`; Stage only explicit files, show staged diff summary, then commit.
- `docs-list`: `scripts/docs-list.ps1`; by default, walk the active working repo's `docs/`, report markdown summaries, surface `read_when` hints from front matter.
- `oracle`: `scripts/oracle.ps1`; thin wrapper around `npx -y @steipete/oracle` for previewing or running second-model consults with selected files.
- `sync-agents`: `scripts/sync-agents.ps1`; mirror canonical `AGENTS.md` to `C:/Users/ZO/AGENTS.md`.
- `sync-skills`: `scripts/sync-skills.ps1`; mirror skill dirs to `C:/Users/ZO/.agents/skills/`.
- `sync-all`: `scripts/sync-all.ps1`; mirror both `AGENTS.md` and skills.
