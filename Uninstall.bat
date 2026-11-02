@echo off
setlocal

echo ==============================================
echo   Dang go cai dat Win Explorer AutoFix...
echo ==============================================

:: Xoa shortcut trong Startup va thu muc cai dat LocalAppData
powershell -NoProfile -ExecutionPolicy Bypass -Command "Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoFixExplorer.lnk'); Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $env:LOCALAPPDATA 'AutoFixExplorer')"

:: Hien thi hop thoai thong bao
mshta vbscript:Execute("msgbox ""Da go cai dat Win Explorer AutoFix thanh cong."", 64, ""Win Explorer AutoFix"":close")

exit

