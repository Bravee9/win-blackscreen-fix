@echo off
setlocal
cd /d "%~dp0"

echo Installing Win Explorer AutoFix...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0core\install.ps1"

exit
