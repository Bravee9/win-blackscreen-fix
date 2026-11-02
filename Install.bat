@echo off
setlocal

set "TARGET_DIR=%LOCALAPPDATA%\AutoFixExplorer"

echo Installing Win Explorer AutoFix...

:: 1. Create target directory in LocalAppData
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: 2. Copy core components
copy /y "%~dp0core\fix.ps1" "%TARGET_DIR%\" >nul
copy /y "%~dp0core\silent.vbs" "%TARGET_DIR%\" >nul

:: 3. Create shortcut in User Startup folder
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws = New-Object -ComObject WScript.Shell; $shortcutPath = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoFixExplorer.lnk'; $targetPath = Join-Path $env:LOCALAPPDATA 'AutoFixExplorer\silent.vbs'; $s = $ws.CreateShortcut($shortcutPath); $s.TargetPath = $targetPath; $s.Save()"

:: 4. Notify user of completion
mshta vbscript:Execute("msgbox ""Cai dat thanh cong. Tien trinh se tu dong khoi chay cung he thong."", 64, ""Win Explorer AutoFix"":close")

exit
