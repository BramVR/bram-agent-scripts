param(
    [string]$SourceDir = "C:\PROJECTS\GG\bram-agent-scripts\skills",
    [string]$DestinationDir = "$HOME\.agents\skills"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $SourceDir)) {
    throw "Skills source directory not found: $SourceDir"
}

New-Item -ItemType Directory -Force -Path $DestinationDir | Out-Null
Copy-Item -Path (Join-Path $SourceDir "*") -Destination $DestinationDir -Recurse -Force
Write-Output "Mirrored skills to $DestinationDir"
