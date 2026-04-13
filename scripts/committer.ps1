param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ArgsList
)

$ErrorActionPreference = "Stop"
if ($null -ne (Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue)) {
    $PSNativeCommandUseErrorActionPreference = $false
}

function Show-Usage {
    [Console]::Error.WriteLine('Usage: committer.ps1 [--force] "commit message" "file" ["file" ...]')
    exit 2
}

if (-not $ArgsList -or $ArgsList.Count -lt 2) {
    Show-Usage
}

$forceDeleteLock = $false
if ($ArgsList[0] -eq "--force") {
    $forceDeleteLock = $true
    $ArgsList = @($ArgsList | Select-Object -Skip 1)
}

if (-not $ArgsList -or $ArgsList.Count -lt 2) {
    Show-Usage
}

$commitMessage = $ArgsList[0]
$files = @($ArgsList | Select-Object -Skip 1)

if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    [Console]::Error.WriteLine("Error: commit message must not be empty")
    exit 1
}

if (Test-Path -LiteralPath $commitMessage) {
    [Console]::Error.WriteLine(("Error: first argument looks like a file path (`"{0}`"); provide the commit message first" -f $commitMessage))
    exit 1
}

if ($files.Count -eq 0) {
    Show-Usage
}

foreach ($file in $files) {
    if ($file -eq ".") {
        [Console]::Error.WriteLine('Error: "." is not allowed; list specific paths instead')
        exit 1
    }
}

$lastCommitError = ""

function Test-GitPathExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$PathValue
    )

    if (Test-Path -LiteralPath $PathValue) {
        return $true
    }

    & git ls-files --error-unmatch -- $PathValue *> $null
    if ($LASTEXITCODE -eq 0) {
        return $true
    }

    & git rev-parse --verify HEAD *> $null
    if ($LASTEXITCODE -ne 0) {
        return $false
    }

    & git cat-file -e ("HEAD:{0}" -f $PathValue) *> $null
    return $LASTEXITCODE -eq 0
}

function Invoke-GitCommitAttempt {
    $script:lastCommitError = ""
    $tempFile = [System.IO.Path]::GetTempFileName()
    $previous = $ErrorActionPreference

    try {
        $ErrorActionPreference = "Continue"
        & git commit -m $commitMessage -- @files 2> $tempFile
        if ($LASTEXITCODE -eq 0) {
            return $true
        }

        $script:lastCommitError = Get-Content -LiteralPath $tempFile -Raw
        if ($script:lastCommitError) {
            [Console]::Error.Write($script:lastCommitError)
        }
        return $false
    } finally {
        $ErrorActionPreference = $previous
        Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue
    }
}

function Test-GitHeadExists {
    $previous = $ErrorActionPreference
    try {
        $ErrorActionPreference = "Continue"
        & git rev-parse --verify HEAD 1> $null 2> $null
        return $LASTEXITCODE -eq 0
    } finally {
        $ErrorActionPreference = $previous
    }
}

foreach ($file in $files) {
    if (-not (Test-GitPathExists -PathValue $file)) {
        [Console]::Error.WriteLine(("Error: file not found: {0}" -f $file))
        exit 1
    }
}

if (Test-GitHeadExists) {
    & git restore --staged :/
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}

& git add -A -- @files
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

& git diff --staged --quiet
if ($LASTEXITCODE -eq 0) {
    [Console]::Error.WriteLine(("Warning: no staged changes detected for: {0}" -f ($files -join " ")))
    exit 1
}

$committed = $false
if (Invoke-GitCommitAttempt) {
    $committed = $true
} elseif ($forceDeleteLock) {
    $match = [regex]::Match($lastCommitError, "Unable to create .*?('(?<path>[^']+\.git/index\.lock)')")
    if ($match.Success) {
        $lockPath = $match.Groups["path"].Value
        if ($lockPath -and (Test-Path -LiteralPath $lockPath)) {
            Remove-Item -LiteralPath $lockPath -Force
            [Console]::Error.WriteLine(("Removed stale git lock: {0}" -f $lockPath))
            if (Invoke-GitCommitAttempt) {
                $committed = $true
            }
        }
    }
}

if (-not $committed) {
    exit 1
}

Write-Output ('Committed "{0}" with {1} files' -f $commitMessage, $files.Count)
