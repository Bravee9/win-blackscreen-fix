@echo off
setlocal

echo Uninstalling Win Explorer AutoFix...

:: Remove startup shortcut and installation folder
powershell -NoProfile -ExecutionPolicy Bypass -Command "Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoFixExplorer.lnk'); Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $env:LOCALAPPDATA 'AutoFixExplorer')"

:: Notify user of completion
mshta vbscript:Execute("msgbox ""Da go cai dat thanh cong."", 64, ""Win Explorer AutoFix"":close")

exit
