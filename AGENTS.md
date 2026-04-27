# Bram Agent Scripts

Canonical Bram Codex workflow. Edit here, mirror to `C:/Users/ZO/AGENTS.md`.

## Protocol
- Source: `C:/PROJECTS/GG/bram-agent-scripts/AGENTS.md`; mirror: `C:/Users/ZO/AGENTS.md`.
- Skills: `skills/` -> `C:/Users/ZO/.agents/skills/`; scripts: `scripts/`.
- Shell: PowerShell.
- Style: concise, direct, telegraph. Say what/why. If uncertain: knowns, unknowns, next check.
- Conflicts: call out; pick safer path.
- Personal repo `AGENTS.md`: pointer here first, repo-local overrides below.
- Shared/public repos: self-contained `AGENTS.md`.

## Git
- Safe: `git status`, `git diff`, `git log`. Push only when asked.
- Branch changes require consent.
- Personal/solo repos: prefer linear `main`; no branch/worktree unless asked or risk warrants.
- Shared/team repos: follow repo policy; PR when required.
- Conventional commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`.
- One logical change per commit; do not mix docs/tests/refactor/behavior unless inseparable.
- Stage explicit files/hunks only. No `git add .` or `git add -A`.
- Use `scripts/committer.ps1`; review status and staged diff first.
- No amend, force-push, or destructive ops unless explicit.
- Do not revert unrelated changes. Unrecognized changes: assume another agent; focus yours.
- Do not delete/rename unexpected files; stop and ask.
- No repo-wide search/replace scripts.

## PR / CI
- Thin PRs; title `type[(scope)]: short outcome`.
- Body: `Summary`, `Tests`/`Validation`, optional `Why`/`Notes`.
- Include exact verification commands.
- GitHub URL: use CLI/connectors; inspect metadata, diff, comments, and checks before judging.
- CI red: inspect logs, fix/rerun when possible; report exact blocked check if unable.

## Docs / Testing
- Read only relevant docs. If repo has `docs/`, run `docs-list` when context is unclear.
- Update docs when behavior, public usage, or workflow changes.
- New docs: front matter with `summary` and `read_when`.
- Do not document commands/scripts/skills unless verified present; say `if present` when optional.
- Bugs: add regression test when it fits.
- Prefer end-to-end verify; if blocked, say what is missing.

## Skills
- Reusable workflows live as skills, not custom prompts.
- Keep skills small, explicit, task-oriented.
- Skills need clear `description`, trigger/use case, and verification/troubleshooting for tool wrappers.

## Tools
- Prefer small wrappers that make common workflows safer and repeatable.
- `committer`: `scripts/committer.ps1`
- `docs-list`: `scripts/docs-list.ps1`
- `oracle`: `scripts/oracle.ps1`
- `sync-agents`, `sync-skills`, `sync-all`: mirror runtime files.
- More local tool notes: `C:/PROJECTS/GG/bram-agent-scripts/tools.md` if present.
