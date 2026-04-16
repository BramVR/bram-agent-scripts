param(
    [string]$DocsDir
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($DocsDir)) {
    $DocsDir = Join-Path (Get-Location) "docs"
}

$excludedDirs = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($name in @("archive", "research")) {
    [void]$excludedDirs.Add($name)
}

function Get-RelativePathCompat {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BasePath,
        [Parameter(Mandatory = $true)]
        [string]$TargetPath
    )

    $pathType = [System.IO.Path]::DirectorySeparatorChar
    $baseFullPath = [System.IO.Path]::GetFullPath($BasePath)
    $targetFullPath = [System.IO.Path]::GetFullPath($TargetPath)

    if (-not $baseFullPath.EndsWith($pathType)) {
        $baseFullPath += $pathType
    }

    $baseUri = [System.Uri]$baseFullPath
    $targetUri = [System.Uri]$targetFullPath
    $relativeUri = $baseUri.MakeRelativeUri($targetUri)
    $relativePath = [System.Uri]::UnescapeDataString($relativeUri.ToString())
    return $relativePath.Replace('/', [System.IO.Path]::DirectorySeparatorChar)
}

function Get-CompactStrings {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Values
    )

    $result = [System.Collections.Generic.List[string]]::new()
    foreach ($value in $Values) {
        if ($null -eq $value) {
            continue
        }

        $normalized = [string]$value
        $normalized = $normalized.Trim()
        if ($normalized.Length -gt 0) {
            $result.Add($normalized)
        }
    }

    return $result
}

function Get-MarkdownFiles {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RootDir
    )

    $files = Get-ChildItem -LiteralPath $RootDir -Recurse -File -Filter *.md |
        Where-Object {
            $relative = Get-RelativePathCompat -BasePath $RootDir -TargetPath $_.FullName
            $segments = $relative -split '[\\/]'
            foreach ($segment in $segments) {
                if ($segment.StartsWith('.')) {
                    return $false
                }

                if ($excludedDirs.Contains($segment)) {
                    return $false
                }
            }

            return $true
        } |
        Sort-Object {
            (Get-RelativePathCompat -BasePath $RootDir -TargetPath $_.FullName).Replace('\', '/')
        }

    return $files
}

function Get-FrontMatterMetadata {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FullPath
    )

    $content = Get-Content -LiteralPath $FullPath -Raw
    if (-not $content.StartsWith("---")) {
        return @{
            Summary = $null
            ReadWhen = @()
            Error = "missing front matter"
        }
    }

    $endIndex = $content.IndexOf("`n---", 3)
    if ($endIndex -lt 0) {
        return @{
            Summary = $null
            ReadWhen = @()
            Error = "unterminated front matter"
        }
    }

    $frontMatter = $content.Substring(3, $endIndex - 3).Trim()
    $lines = $frontMatter -split "`r?`n"
    $summaryLine = $null
    $readWhen = [System.Collections.Generic.List[string]]::new()
    $collectingReadWhen = $false

    foreach ($rawLine in $lines) {
        $line = $rawLine.Trim()

        if ($line.StartsWith("summary:")) {
            $summaryLine = $line
            $collectingReadWhen = $false
            continue
        }

        if ($line.StartsWith("read_when:")) {
            $collectingReadWhen = $true
            $inline = $line.Substring("read_when:".Length).Trim()
            if ($inline.StartsWith("[") -and $inline.EndsWith("]")) {
                try {
                    $json = $inline.Replace("'", '"')
                    $parsed = ConvertFrom-Json -InputObject $json -ErrorAction Stop
                    if ($parsed -is [System.Collections.IEnumerable]) {
                        foreach ($value in (Get-CompactStrings -Values @($parsed))) {
                            $readWhen.Add($value)
                        }
                    }
                } catch {
                }
            }
            continue
        }

        if ($collectingReadWhen) {
            if ($line.StartsWith("- ")) {
                $hint = $line.Substring(2).Trim()
                if ($hint.Length -gt 0) {
                    $readWhen.Add($hint)
                }
            } elseif ($line.Length -eq 0) {
            } else {
                $collectingReadWhen = $false
            }
        }
    }

    if ($null -eq $summaryLine) {
        return @{
            Summary = $null
            ReadWhen = @($readWhen)
            Error = "summary key missing"
        }
    }

    $summaryValue = $summaryLine.Substring("summary:".Length).Trim()
    $summaryValue = [regex]::Replace($summaryValue, '^["'']|["'']$', '')
    $summaryValue = [regex]::Replace($summaryValue, '\s+', ' ').Trim()
    if ([string]::IsNullOrWhiteSpace($summaryValue)) {
        return @{
            Summary = $null
            ReadWhen = @($readWhen)
            Error = "summary is empty"
        }
    }

    return @{
        Summary = $summaryValue
        ReadWhen = @($readWhen)
        Error = $null
    }
}

$resolvedDocsDir = [System.IO.Path]::GetFullPath($DocsDir)
if (-not (Test-Path -LiteralPath $resolvedDocsDir -PathType Container)) {
    Write-Output ("No docs directory found at: {0}" -f $resolvedDocsDir)
    exit 0
}

Write-Output "Listing all markdown files in docs folder:"

foreach ($file in (Get-MarkdownFiles -RootDir $resolvedDocsDir)) {
    $relativePath = (Get-RelativePathCompat -BasePath $resolvedDocsDir -TargetPath $file.FullName).Replace('\', '/')
    $metadata = Get-FrontMatterMetadata -FullPath $file.FullName

    if ($null -ne $metadata.Summary) {
        Write-Output ("{0} - {1}" -f $relativePath, $metadata.Summary)
        if ($metadata.ReadWhen.Count -gt 0) {
            Write-Output (" Read when: {0}" -f ($metadata.ReadWhen -join "; "))
        }
    } else {
        $reason = ""
        if ($metadata.Error) {
            $reason = " - [{0}]" -f $metadata.Error
        }
        Write-Output ("{0}{1}" -f $relativePath, $reason)
    }
}

Write-Output ""
Write-Output 'Reminder: keep docs up to date as behavior changes.'
Write-Output 'When your task matches a "Read when" hint above, read that doc before coding and suggest new coverage when it is missing.'
