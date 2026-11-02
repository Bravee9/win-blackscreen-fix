@echo off
setlocal
cd /d "%~dp0"

echo Uninstalling Win Explorer AutoFix...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0core\uninstall.ps1"

exit
