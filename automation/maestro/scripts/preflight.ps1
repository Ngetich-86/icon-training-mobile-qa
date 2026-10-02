<#
.SYNOPSIS
  Preflight check before running Maestro flows against ENV-001 (Icon Training).

.DESCRIPTION
  Dot-source this script in the PowerShell session that will run Maestro:

      . .\automation\maestro\scripts\preflight.ps1
      if ($env:ICON_QA_PREFLIGHT -eq 'READY') {
          maestro --device $env:ICON_QA_DEVICE test --no-reinstall-driver <flow.yaml>
      }

  It resolves the adb transport at run time and never prints device identifiers
  (serials, IP addresses, ports, mDNS names). The selected transport is stored only
  in the session variable ICON_QA_DEVICE.

  Result (in $env:ICON_QA_PREFLIGHT):
    READY    all checks passed
    BLOCKED  a check failed; treat any run as BLOCKED/INFRASTRUCTURE, not as an app result

  Checks:
    1. adb is reachable
    2. transports in state "device" are grouped by physical device (hashed serial, in memory only)
    3. exactly one physical device; several transports for the same device are allowed
    4. the app package is installed
    5. the installed app version matches the expected test environment
    6. Maestro helper apps (dev.mobile.maestro, dev.mobile.maestro.test) are installed (or -AllowHelperInstall)
    7. no known blocking system UI (ColorOS post-install screen, package installer) is in the foreground
    8. an optional Maestro debug-output path is outside the repository
#>
param(
    [string]$ExpectedVersion = '2.5.0',
    [string]$AppId = 'app.icontraining.icon',
    [string]$Adb = 'adb',
    [switch]$AllowHelperInstall,
    [string]$DebugOutput = ''
)

$env:ICON_QA_PREFLIGHT = 'BLOCKED'
$env:ICON_QA_DEVICE = $null
$script:preflightOk = $true

function Write-Check([string]$Name, [bool]$Ok, [string]$Detail) {
    $mark = if ($Ok) { 'OK     ' } else { 'BLOCKED' }
    Write-Host ("[{0}] {1}: {2}" -f $mark, $Name, $Detail)
    if (-not $Ok) { $script:preflightOk = $false }
}

function Get-Sha256([string]$Text) {
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $bytes = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Text))
    ($bytes | ForEach-Object { $_.ToString('x2') }) -join ''
}

function Get-TransportKind([string]$Id) {
    if ($Id -like '*._adb-tls-connect._tcp*' -or $Id -like '*._adb._tcp*') { return 'mdns' }
    if ($Id -match '^[^:]+:\d+$') { return 'tcp' }
    return 'usb'
}

# 1. adb reachable
$adbVersion = & $Adb version 2>$null | Select-Object -Index 1
Write-Check 'adb' ($LASTEXITCODE -eq 0 -and $adbVersion) "$adbVersion"
if (-not $script:preflightOk) { return }

# 2-3. transports and physical devices
$transports = @(& $Adb devices 2>$null | Select-Object -Skip 1 |
    Where-Object { $_ -match '\S+\s+device$' } |
    ForEach-Object { ($_ -split '\s+')[0] })
$groups = @{}
foreach ($t in $transports) {
    $serial = (& $Adb -s $t shell getprop ro.serialno 2>$null | Out-String).Trim()
    if (-not $serial) { continue }
    $key = Get-Sha256 $serial
    if (-not $groups.ContainsKey($key)) { $groups[$key] = @() }
    $groups[$key] += $t
}
$kinds = ($transports | ForEach-Object { Get-TransportKind $_ }) -join ', '
Write-Check 'transports' ($transports.Count -ge 1) ("{0} in state 'device' ({1})" -f $transports.Count, $kinds)
Write-Check 'physical devices' ($groups.Count -eq 1) ("{0} (expected exactly 1)" -f $groups.Count)
if (-not $script:preflightOk) { return }

# Deterministic transport choice for the single device: explicit TCP, then mDNS, then USB.
$preference = @{ 'tcp' = 0; 'mdns' = 1; 'usb' = 2 }
$device = @($groups.Values)[0] | Sort-Object { $preference[(Get-TransportKind $_)] }, { $_ } | Select-Object -First 1
Write-Check 'selected transport' $true ("kind={0} (identifier not printed)" -f (Get-TransportKind $device))

function Invoke-DeviceShell([string]$Command) {
    (& $Adb -s $device shell $Command 2>$null | Out-String).Trim()
}

$model = Invoke-DeviceShell 'getprop ro.product.model'
$release = Invoke-DeviceShell 'getprop ro.build.version.release'
$sdk = Invoke-DeviceShell 'getprop ro.build.version.sdk'
Write-Check 'device' $true ("model={0}, Android {1} (API {2})" -f $model, $release, $sdk)

# 4. package present
$pkgPath = Invoke-DeviceShell "pm path $AppId"
Write-Check 'app installed' ($pkgPath -like 'package:*') $AppId

# 5. app version
$versionLine = (Invoke-DeviceShell "dumpsys package $AppId") -split "`n" | Where-Object { $_ -match 'versionName=' } | Select-Object -First 1
$version = if ($versionLine -match 'versionName=(\S+)') { $Matches[1] } else { '' }
Write-Check 'app version' ($version -eq $ExpectedVersion) ("installed={0}, expected={1}" -f $version, $ExpectedVersion)

# 6. Maestro helper apps
$packages = (Invoke-DeviceShell 'pm list packages') -split "`n" | ForEach-Object { $_.Trim() }
$helpers = @('dev.mobile.maestro', 'dev.mobile.maestro.test') | Where-Object { $packages -contains "package:$_" }
$helpersOk = ($helpers.Count -eq 2) -or $AllowHelperInstall
Write-Check 'maestro helpers' $helpersOk ("{0}/2 installed{1}" -f $helpers.Count, $(if ($AllowHelperInstall -and $helpers.Count -lt 2) { ' (first run will install them)' } else { '' }))

# 7. blocking system UI
$top = (Invoke-DeviceShell 'dumpsys activity activities') -split "`n" | Where-Object { $_ -match 'topResumedActivity' } | Select-Object -First 1
$topPkg = if ($top -match 'u0 ([^/\s]+)/') { $Matches[1] } else { 'unknown' }
$blocking = @('com.oplus.appdetail', 'com.android.packageinstaller', 'com.google.android.packageinstaller')
Write-Check 'foreground' (-not ($blocking -contains $topPkg)) "top package=$topPkg"

# 8. output destination
if ($DebugOutput) {
    $repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
    $out = [System.IO.Path]::GetFullPath($DebugOutput)
    Write-Check 'debug output' (-not $out.StartsWith($repoRoot, [System.StringComparison]::OrdinalIgnoreCase)) 'must be outside the repository'
} else {
    Write-Check 'debug output' $true 'Maestro default (%USERPROFILE%\.maestro\tests), outside the repository'
}

if ($script:preflightOk) {
    $env:ICON_QA_DEVICE = $device
    $env:ICON_QA_PREFLIGHT = 'READY'
    Write-Host 'PREFLIGHT: READY'
} else {
    Write-Host 'PREFLIGHT: BLOCKED (treat as BLOCKED/INFRASTRUCTURE)'
}
