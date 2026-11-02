@echo off
setlocal

set "TARGET_DIR=%LOCALAPPDATA%\AutoFixExplorer"

echo ==============================================
echo   Dang cai dat Win Explorer AutoFix...
echo ==============================================

:: 1. Tao thu muc cai dat vinh vien trong LocalAppData
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:: 2. Sao chep cac file core vao he thong
copy /y "%~dp0core\fix.ps1" "%TARGET_DIR%\" >nul
copy /y "%~dp0core\silent.vbs" "%TARGET_DIR%\" >nul

:: 3. Tao Shortcut trong thu muc Startup an toan (xu ly ca duong dan co dau cach)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws = New-Object -ComObject WScript.Shell; $shortcutPath = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoFixExplorer.lnk'; $targetPath = Join-Path $env:LOCALAPPDATA 'AutoFixExplorer\silent.vbs'; $s = $ws.CreateShortcut($shortcutPath); $s.TargetPath = $targetPath; $s.Save()"

:: 4. Hien thi hop thoai thong bao thanh cong
mshta vbscript:Execute("msgbox ""Cai dat thanh cong! Ung dung se tu dong chay ngam moi khi may khoi dong."", 64, ""Win Explorer AutoFix"":close")

exit
