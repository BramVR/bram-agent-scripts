param()

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

& (Join-Path $scriptDir "sync-agents.ps1")
& (Join-Path $scriptDir "sync-prompts.ps1")

Write-Output "Finished syncing AGENTS.md and prompts."
