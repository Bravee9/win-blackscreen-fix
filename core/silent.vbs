Set WshShell = CreateObject("WScript.Shell")
target = WshShell.ExpandEnvironmentStrings("%LOCALAPPDATA%\AutoFixExplorer\fix.ps1")

' Launch PowerShell in hidden window mode to prevent console flashing
WshShell.Run "powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & target & """", 0, False
