[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$startupShortcut = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoFixExplorer.lnk'
$targetDir = Join-Path $env:LOCALAPPDATA 'AutoFixExplorer'

# 1. Remove startup shortcut
if (Test-Path $startupShortcut) {
    Remove-Item -Path $startupShortcut -Force -ErrorAction SilentlyContinue
}

# 2. Remove application directory
if (Test-Path $targetDir) {
    Remove-Item -Path $targetDir -Recurse -Force -ErrorAction SilentlyContinue
}

# 3. Native Windows Form confirmation dialog
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    'Đã gỡ cài đặt Win Explorer AutoFix thành công.',
    'Win Explorer AutoFix',
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
) | Out-Null

