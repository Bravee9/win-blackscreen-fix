# Win Explorer AutoFix - Core Recovery Script

# 1. Allow the operating system to finish user session, display driver, and profile initialization
Start-Sleep -Seconds 5

# 2. Terminate unresponsive explorer processes
$explorers = Get-Process -Name explorer -ErrorAction SilentlyContinue
if ($explorers) {
    $explorers | Stop-Process -Force -ErrorAction SilentlyContinue
}

# 3. Wait for processes to exit completely (up to 3 seconds)
$timeout = 0
while ((Get-Process -Name explorer -ErrorAction SilentlyContinue) -and ($timeout -lt 3)) {
    Start-Sleep -Milliseconds 500
    $timeout += 0.5
}

# 4. Relaunch Windows Explorer from system root
Start-Process "$env:SystemRoot\explorer.exe"

# 5. Health check verification
Start-Sleep -Seconds 2
if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
    Start-Process "$env:SystemRoot\explorer.exe"
}
