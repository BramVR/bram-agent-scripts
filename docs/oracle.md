---
summary: "Second-model consult workflow via steipete/oracle, wrapped for this repo."
read_when:
  - "Need a second-model review with selected repo files."
  - "Need the local wrapper for steipete/oracle on Windows."
  - "Need session replay or preview commands for Oracle."
---

# Oracle

## Scope

This repo ships a thin PowerShell wrapper around `@steipete/oracle`.

Use it when you want:
- a second-model review with real repo context
- a preview of the exact prompt+file bundle before sending
- a resumable browser session for long GPT Pro runs

Do not treat it as a source of truth. Verify against local code and tests.

## Prereqs

- Node 22+
- `npx` on `PATH`
- Chrome signed into ChatGPT for browser mode

The wrapper runs `npx -y @steipete/oracle`, so a global install is not required.

## Wrapper

Default behavior:
- engine: `browser`
- model: `gpt-5.4-pro`
- Windows browser login: `--browser-manual-login`
- Windows browser profile dir: `C:\Users\ZO\.oracle\browser-profile` via `ORACLE_BROWSER_PROFILE_DIR`

Preview without sending:

```powershell
.\scripts\oracle.ps1 `
  -Prompt "Review the storage layer for risky assumptions" `
  -File "src/**" `
  -File "!**/*.test.ts" `
  -DryRun summary `
  -FilesReport
```

Run a browser consult:

```powershell
.\scripts\oracle.ps1 `
  -Prompt "List likely regressions and missing tests" `
  -File "src/**" `
  -File "docs/**"
```

First-time login with the explicit persistent profile:

```powershell
.\scripts\oracle.ps1 `
  -Prompt "HI" `
  -File README.md `
  -OracleArgs @("--browser-keep-browser","--browser-input-timeout","300000")
```

Check recent sessions:

```powershell
.\scripts\oracle.ps1 -Status
```

Reattach to a prior run:

```powershell
.\scripts\oracle.ps1 -Session "<session-id-or-slug>"
```

Use API mode only when explicitly intended:

```powershell
.\scripts\oracle.ps1 `
  -Engine api `
  -Model gpt-5.4-pro `
  -Prompt "Cross-check this migration plan" `
  -File "src/**"
```

## Notes

- Keep the attached file set tight. Smaller bundles usually beat whole-repo dumps.
- Quote exact errors in the prompt when debugging.
- Use `-OracleArgs` for uncommon upstream flags.
- Long browser runs should usually be resumed with `-Session`, not restarted.
- For multiple files, prefer repeated `-File` flags in PowerShell.
- Override the default browser profile dir with `-BrowserProfileDir "C:\path\to\profile"` when needed.
