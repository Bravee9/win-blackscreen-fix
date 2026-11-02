# Core script xu ly loi treo explorer.exe
# 1. Cho 3 giay de he thong nap tai khoan va driver
Start-Sleep -Seconds 3

# 2. Tim va buoc dung cac tien trinh explorer bi treo
$explorers = Get-Process -Name explorer -ErrorAction SilentlyContinue
if ($explorers) {
    $explorers | Stop-Process -Force -ErrorAction SilentlyContinue
}

# 3. Cho toi da 3 giay den khi tien trinh cu bien mat hoan toan
$timeout = 0
while ((Get-Process -Name explorer -ErrorAction SilentlyContinue) -and ($timeout -lt 3)) {
    Start-Sleep -Milliseconds 500
    $timeout += 0.5
}

# 4. Khoi chay lai Explorer tu thu muc goc he thong
Start-Process "$env:SystemRoot\explorer.exe"

# 5. Kiem tra lai (Health Check) sau 2 giay, phong truong hop chua len
Start-Sleep -Seconds 2
if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
    Start-Process "$env:SystemRoot\explorer.exe"
}
