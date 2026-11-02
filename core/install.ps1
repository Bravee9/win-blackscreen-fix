[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$targetDir = Join-Path $env:LOCALAPPDATA 'AutoFixExplorer'
$sourceScript = Join-Path $PSScriptRoot 'fix.ps1'
$sourceConfig = Join-Path $PSScriptRoot 'config.json'

# 1. Create target directory in LocalAppData
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

# 2. Copy core script into system directory
Copy-Item -Path $sourceScript -Destination $targetDir -Force

# 3. Copy default configuration if not already present (preserves user settings on update)
$targetConfig = Join-Path $targetDir 'config.json'
if (-not (Test-Path $targetConfig) -and (Test-Path $sourceConfig)) {
    Copy-Item -Path $sourceConfig -Destination $targetConfig -Force
}

# 4. Register startup shortcut (Zero-UAC, native PowerShell launcher)
$ws = New-Object -ComObject WScript.Shell
$startupShortcut = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoFixExplorer.lnk'
$installedScript = Join-Path $targetDir 'fix.ps1'

$shortcut = $ws.CreateShortcut($startupShortcut)
$shortcut.TargetPath = 'powershell.exe'
$shortcut.Arguments = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$installedScript`""
$shortcut.WindowStyle = 7 # Minimized execution prevents console popup
$shortcut.Description = 'Win Explorer AutoFix background recovery utility'
$shortcut.Save()

# 5. Native Windows Form confirmation dialog
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    'Cài đặt thành công. Tiến trình sẽ tự động giám sát và bảo vệ khởi động cùng hệ thống.',
    'Win Explorer AutoFix',
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
) | Out-Null
