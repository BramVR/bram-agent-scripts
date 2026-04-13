param(
    [string]$Source = "C:\PROJECTS\GG\bram-agent-scripts\AGENTS.md",
    [string]$Destination = "$HOME\AGENTS.md"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Source)) {
    throw "Source AGENTS.md not found: $Source"
}

Copy-Item -LiteralPath $Source -Destination $Destination -Force
Write-Output "Mirrored AGENTS.md to $Destination"
