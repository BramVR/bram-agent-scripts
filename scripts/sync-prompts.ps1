param(
    [string]$SourceDir = "C:\PROJECTS\GG\bram-agent-scripts\prompts",
    [string]$DestinationDir = "$HOME\.codex\prompts"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $SourceDir)) {
    throw "Prompts source directory not found: $SourceDir"
}

New-Item -ItemType Directory -Force -Path $DestinationDir | Out-Null
Copy-Item -Path (Join-Path $SourceDir "*") -Destination $DestinationDir -Recurse -Force
Write-Output "Mirrored prompts to $DestinationDir"
