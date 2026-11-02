# Win Explorer AutoFix - Core Recovery Script
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 1. Environment Verification: Ensure explorer.exe binary exists (e.g. Windows Server Core safety)
$explorerBinary = Join-Path $env:SystemRoot 'explorer.exe'
if (-not (Test-Path $explorerBinary)) {
    # Headless or Server Core installation where Explorer shell is absent
    exit 0
}

# 2. Load configuration with fallback defaults
$configPath = Join-Path $PSScriptRoot 'config.json'
$initialDelay = 5
$forceRestart = $false

if (Test-Path $configPath) {
    try {
        $rawConfig = Get-Content -Path $configPath -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($rawConfig.initialDelaySeconds -and [int]$rawConfig.initialDelaySeconds -ge 1) {
            $initialDelay = [int]$rawConfig.initialDelaySeconds
        }
        if ($null -ne $rawConfig.forceRestart) {
            $forceRestart = [bool]$rawConfig.forceRestart
        }
    } catch {
        $initialDelay = 5
        $forceRestart = $false
    }
}

# 3. Allow user logon, display driver, and profile initialization
Start-Sleep -Seconds $initialDelay

# 4. Native Win32 API Definitions for Shell Health Inspection
$nativeDefinitions = @"
using System;
using System.Runtime.InteropServices;

public class ShellInspector {
    [DllImport("user32.dll", EntryPoint = "FindWindowW", SetLastError = true, CharSet = CharSet.Unicode)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool IsHungAppWindow(IntPtr hWnd);
}
"@

Add-Type -TypeDefinition $nativeDefinitions -ErrorAction SilentlyContinue

function Test-ShellUnresponsive {
    param([int]$SessionId)

    # Check 1: Process presence in the current logon session
    $explorers = Get-Process -Name explorer -ErrorAction SilentlyContinue | Where-Object { $_.SessionId -eq $SessionId }
    if (-not $explorers) {
        # Explorer process is absent in the current user session
        return $true
    }

    # Check 2: Process thread responsiveness check
    foreach ($proc in $explorers) {
        if (-not $proc.Responding) {
            # An active explorer thread in this session is hung
            return $true
        }
    }

    # Check 3: Window-level inspection on Taskbar (Shell_TrayWnd)
    try {
        $trayHwnd = [ShellInspector]::FindWindow("Shell_TrayWnd", $null)
        if ($trayHwnd -ne [IntPtr]::Zero -and [ShellInspector]::IsHungAppWindow($trayHwnd)) {
            return $true
        }
    } catch {
        # Fallback cleanly if window lookup fails
    }

    return $false
}

# 5. Determine if intervention is required for the current logon session
$currentSessionId = [System.Diagnostics.Process]::GetCurrentProcess().SessionId
$needsRecovery = $forceRestart -or (Test-ShellUnresponsive -SessionId $currentSessionId)

if (-not $needsRecovery) {
    # Windows shell is operating normally. Terminate silently without causing screen flicker.
    exit 0
}

# 6. Terminate unresponsive explorer processes strictly scoped to current session
$explorers = Get-Process -Name explorer -ErrorAction SilentlyContinue | Where-Object { $_.SessionId -eq $currentSessionId }
if ($explorers) {
    $explorers | Stop-Process -Force -ErrorAction SilentlyContinue
}

# 7. Wait for processes in current session to exit completely (up to 3 seconds)
$timeout = 0
while ((Get-Process -Name explorer -ErrorAction SilentlyContinue | Where-Object { $_.SessionId -eq $currentSessionId }) -and ($timeout -lt 3)) {
    Start-Sleep -Milliseconds 500
    $timeout += 0.5
}

# 8. Relaunch Windows Explorer from system root
Start-Process $explorerBinary

# 9. Health check verification
Start-Sleep -Seconds 2
$postExplorers = Get-Process -Name explorer -ErrorAction SilentlyContinue | Where-Object { $_.SessionId -eq $currentSessionId }
if (-not $postExplorers) {
    Start-Process $explorerBinary
}
