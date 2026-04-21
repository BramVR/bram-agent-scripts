$ErrorActionPreference = "Stop"
if ($null -ne (Get-Variable -Name PSNativeCommandUseErrorActionPreference -ErrorAction SilentlyContinue)) {
    $PSNativeCommandUseErrorActionPreference = $false
}

function Show-Usage {
    @'
Usage:
  .\scripts\oracle.ps1 -Prompt "..." -File "src/**"
  .\scripts\oracle.ps1 -Prompt "..." -File README.md -File AGENTS.md
  .\scripts\oracle.ps1 -Prompt "..." -File "src/**" -DryRun summary -FilesReport
  .\scripts\oracle.ps1 -Status [-Hours 72]
  .\scripts\oracle.ps1 -Session "<session-id-or-slug>"
  .\scripts\oracle.ps1 -Help

Notes:
  - Wraps: npx -y @steipete/oracle
  - Defaults: -Engine browser -Model gpt-5.4-pro
  - On Windows browser runs, adds --browser-manual-login unless -NoBrowserManualLogin is set
  - On Windows browser runs, defaults ORACLE_BROWSER_PROFILE_DIR to $HOME\.oracle\browser-profile
  - Multiple files: use repeated -File flags
'@ | Write-Output
}

function Test-CommandExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    return $null -ne (Get-Command -Name $Name -ErrorAction SilentlyContinue)
}

function Resolve-BrowserProfileDir {
    param(
        [string]$RequestedPath
    )

    if ($RequestedPath) {
        return $RequestedPath
    }

    if ($env:OS -eq "Windows_NT") {
        return (Join-Path $HOME ".oracle\browser-profile")
    }

    return $null
}

function Invoke-Oracle {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$CliArgs
    )

    if (-not (Test-CommandExists -Name "npx")) {
        throw "npx was not found on PATH. Install Node.js 22+ first."
    }

    $env:CODEX_MANAGED_BY_NPM = "1"
    & npx @CliArgs
    exit $LASTEXITCODE
}

function Throw-UsageError {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    [Console]::Error.WriteLine($Message)
    Show-Usage
    exit 2
}

function Test-KnownOption {
    param(
        [string]$Token
    )

    return $Token -in @(
        "-Prompt", "-p",
        "-File", "-f",
        "-Engine",
        "-Model", "-m",
        "-DryRun",
        "-Slug",
        "-FilesReport",
        "-Copy",
        "-Wait",
        "-Status",
        "-Hours",
        "-Session",
        "-Help",
        "-BrowserProfileDir",
        "-NoBrowserManualLogin",
        "-OracleArgs"
    )
}

$Prompt = $null
$File = New-Object System.Collections.Generic.List[string]
$Engine = "browser"
$Model = "gpt-5.4-pro"
$DryRun = $null
$Slug = $null
$FilesReport = $false
$Copy = $false
$Wait = $false
$Status = $false
$Hours = 72
$Session = $null
$Help = $false
$BrowserProfileDir = $null
$NoBrowserManualLogin = $false
$OracleArgs = New-Object System.Collections.Generic.List[string]

$argv = @($args)
$i = 0
while ($i -lt $argv.Count) {
    $token = [string]$argv[$i]

    switch ($token) {
        { $_ -in @("-Prompt", "-p") } {
            $i++
            if ($i -ge $argv.Count) {
                Throw-UsageError "Missing value for $token"
            }
            $Prompt = [string]$argv[$i]
            $i++
            continue
        }

        { $_ -in @("-File", "-f") } {
            $i++
            $added = $false
            while ($i -lt $argv.Count) {
                $candidate = [string]$argv[$i]
                if (Test-KnownOption -Token $candidate) {
                    break
                }
                $File.Add($candidate)
                $added = $true
                $i++
            }

            if (-not $added) {
                Throw-UsageError "Missing value for $token"
            }
            continue
        }

        "-Engine" {
            $i++
            if ($i -ge $argv.Count) {
                Throw-UsageError "Missing value for $token"
            }
            $Engine = [string]$argv[$i]
            if ($Engine -notin @("browser", "api")) {
                Throw-UsageError "Invalid -Engine value: $Engine"
            }
            $i++
            continue
        }

        { $_ -in @("-Model", "-m") } {
            $i++
            if ($i -ge $argv.Count) {
                Throw-UsageError "Missing value for $token"
            }
            $Model = [string]$argv[$i]
            $i++
            continue
        }

        "-DryRun" {
            $nextIndex = $i + 1
            if ($nextIndex -lt $argv.Count) {
                $candidate = [string]$argv[$nextIndex]
                if ($candidate -in @("summary", "json", "full")) {
                    $DryRun = $candidate
                    $i += 2
                    continue
                }
                if (Test-KnownOption -Token $candidate) {
                    $DryRun = "summary"
                    $i++
                    continue
                }
                Throw-UsageError "Invalid -DryRun value: $candidate"
            }
            $DryRun = "summary"
            $i++
            continue
        }

        "-Slug" {
            $i++
            if ($i -ge $argv.Count) {
                Throw-UsageError "Missing value for $token"
            }
            $Slug = [string]$argv[$i]
            $i++
            continue
        }

        "-FilesReport" {
            $FilesReport = $true
            $i++
            continue
        }

        "-Copy" {
            $Copy = $true
            $i++
            continue
        }

        "-Wait" {
            $Wait = $true
            $i++
            continue
        }

        "-Status" {
            $Status = $true
            $i++
            continue
        }

        "-Hours" {
            $i++
            if ($i -ge $argv.Count) {
                Throw-UsageError "Missing value for $token"
            }
            try {
                $Hours = [int]$argv[$i]
            } catch {
                Throw-UsageError "Invalid -Hours value: $($argv[$i])"
            }
            $i++
            continue
        }

        "-Session" {
            $i++
            if ($i -ge $argv.Count) {
                Throw-UsageError "Missing value for $token"
            }
            $Session = [string]$argv[$i]
            $i++
            continue
        }

        "-Help" {
            $Help = $true
            $i++
            continue
        }

        "-BrowserProfileDir" {
            $i++
            if ($i -ge $argv.Count) {
                Throw-UsageError "Missing value for $token"
            }
            $BrowserProfileDir = [string]$argv[$i]
            $i++
            continue
        }

        "-NoBrowserManualLogin" {
            $NoBrowserManualLogin = $true
            $i++
            continue
        }

        "-OracleArgs" {
            $i++
            $added = $false
            while ($i -lt $argv.Count) {
                $candidate = [string]$argv[$i]
                if (Test-KnownOption -Token $candidate) {
                    break
                }
                $OracleArgs.Add($candidate)
                $added = $true
                $i++
            }

            if (-not $added) {
                Throw-UsageError "Missing value for $token"
            }
            continue
        }

        default {
            Throw-UsageError "Unknown argument: $token"
        }
    }
}

$baseArgs = @("-y", "@steipete/oracle")

if ($Help) {
    Invoke-Oracle -CliArgs ($baseArgs + @("--help"))
}

if ($Status) {
    $statusArgs = $baseArgs + @("status", "--hours", $Hours.ToString())
    if ($OracleArgs.Count -gt 0) {
        $statusArgs += $OracleArgs.ToArray()
    }
    Invoke-Oracle -CliArgs $statusArgs
}

if ($Session) {
    $sessionArgs = $baseArgs + @("session", $Session, "--render")
    if ($OracleArgs.Count -gt 0) {
        $sessionArgs += $OracleArgs.ToArray()
    }
    Invoke-Oracle -CliArgs $sessionArgs
}

if ([string]::IsNullOrWhiteSpace($Prompt)) {
    Throw-UsageError "Missing required -Prompt"
}

if ($File.Count -eq 0) {
    Throw-UsageError "Missing required -File"
}

$runArgs = $baseArgs + @("--engine", $Engine, "--model", $Model, "-p", $Prompt)

foreach ($entry in $File) {
    if (-not [string]::IsNullOrWhiteSpace($entry)) {
        $runArgs += @("--file", $entry)
    }
}

if ($DryRun) {
    $runArgs += @("--dry-run", $DryRun)
}

if ($Slug) {
    $runArgs += @("--slug", $Slug)
}

if ($FilesReport) {
    $runArgs += "--files-report"
}

if ($Copy) {
    $runArgs += @("--render", "--copy")
}

if ($Wait) {
    $runArgs += "--wait"
}

$shouldAddManualLogin = (
    $Engine -eq "browser" -and
    $env:OS -eq "Windows_NT" -and
    -not $NoBrowserManualLogin
)

if ($Engine -eq "browser") {
    $resolvedBrowserProfileDir = Resolve-BrowserProfileDir -RequestedPath $BrowserProfileDir
    if ($resolvedBrowserProfileDir) {
        New-Item -ItemType Directory -Force -Path $resolvedBrowserProfileDir | Out-Null
        $env:ORACLE_BROWSER_PROFILE_DIR = $resolvedBrowserProfileDir
    }
}

if ($shouldAddManualLogin) {
    $runArgs += "--browser-manual-login"
}

if ($OracleArgs.Count -gt 0) {
    $runArgs += $OracleArgs.ToArray()
}

Invoke-Oracle -CliArgs $runArgs
