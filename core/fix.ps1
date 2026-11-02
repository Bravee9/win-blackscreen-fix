# Win Explorer AutoFix - Core Recovery Script
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 1. Load configuration with fallback defaults
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

# 2. Allow the operating system to finish user session and display driver initialization
Start-Sleep -Seconds $initialDelay

# 3. Native Win32 API Definitions for Shell Health Inspection
$nativeDefinitions = @"
using System;
using System.Runtime.InteropServices;

public class ShellInspector {
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool IsHungAppWindow(IntPtr hWnd);
}
"@

Add-Type -TypeDefinition $nativeDefinitions -ErrorAction SilentlyContinue

function Test-ShellUnresponsive {
    # Check 1: Process presence check
    $explorers = Get-Process -Name explorer -ErrorAction SilentlyContinue
    if (-not $explorers) {
        return $true
    }

    # Check 2: Process thread responsiveness check
    foreach ($proc in $explorers) {
        if (-not $proc.Responding) {
            return $true
        }
    }

    # Check 3: Window-level inspection on Shell_TrayWnd (Taskbar)
    try {
        $trayHwnd = [ShellInspector]::FindWindow("Shell_TrayWnd", $null)
        if ($trayHwnd -eq [IntPtr]::Zero) {
            # Shell Tray window does not exist
            return $true
        }
        if ([ShellInspector]::IsHungAppWindow($trayHwnd)) {
            # Shell Tray window exists but is unresponsive
            return $true
        }
    } catch {
        # Fallback to process state if API call encounters an exception
    }

    return $false
}

# 4. Determine if intervention is required
$needsRecovery = $forceRestart -or (Test-ShellUnresponsive)

if (-not $needsRecovery) {
    # Windows shell is operating normally. Terminate silently without causing screen flicker.
    exit 0
}

# 5. Terminate unresponsive explorer processes
$explorers = Get-Process -Name explorer -ErrorAction SilentlyContinue
if ($explorers) {
    $explorers | Stop-Process -Force -ErrorAction SilentlyContinue
}

# 6. Wait for processes to exit completely (up to 3 seconds)
$timeout = 0
while ((Get-Process -Name explorer -ErrorAction SilentlyContinue) -and ($timeout -lt 3)) {
    Start-Sleep -Milliseconds 500
    $timeout += 0.5
}

# 7. Relaunch Windows Explorer from system root
Start-Process "$env:SystemRoot\explorer.exe"

# 8. Health check verification
Start-Sleep -Seconds 2
if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
    Start-Process "$env:SystemRoot\explorer.exe"
}
