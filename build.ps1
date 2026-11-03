# Win Explorer AutoFix - Automated Release Builder
[CmdletBinding()]
param(
    [string]$Version = "1.0.0"
)

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$rootDir = $PSScriptRoot
$releaseDir = Join-Path $rootDir 'release'

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Win Explorer AutoFix - Release Build   " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Ensure clean release directory
if (Test-Path $releaseDir) {
    Write-Host "[1/4] Cleaning previous release folder..." -ForegroundColor Yellow
    Remove-Item -Path $releaseDir -Recurse -Force
}
New-Item -ItemType Directory -Path $releaseDir -Force | Out-Null

# 2. Locate Inno Setup Compiler (ISCC.exe)
Write-Host "[2/4] Locating Inno Setup Compiler..." -ForegroundColor Yellow
$isccPaths = @(
    (Get-Command iscc.exe -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source),
    (Join-Path $env:LOCALAPPDATA 'Programs\Inno Setup 6\ISCC.exe'),
    (Join-Path $env:LOCALAPPDATA 'Programs\Inno Setup 7\ISCC.exe'),
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "${env:ProgramFiles(x86)}\Inno Setup 7\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 6\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 7\ISCC.exe"
)

$iscc = $null
foreach ($p in $isccPaths) {
    if ($p -and (Test-Path $p)) {
        $iscc = $p
        break
    }
}

if (-not $iscc) {
    Write-Error "ISCC.exe not found! Please install Inno Setup 6 (winget install JRSoftware.InnoSetup)."
}
Write-Host "Found ISCC at: $iscc" -ForegroundColor Green

# 3. Compile Installer (.exe)
Write-Host "[3/4] Compiling WinExplorerAutoFix-Setup.exe..." -ForegroundColor Yellow
$issFile = Join-Path $rootDir 'installer.iss'
& $iscc "/DMyAppVersion=$Version" "/O$releaseDir" $issFile
if ($LASTEXITCODE -ne 0) {
    Write-Error "Inno Setup compilation failed with exit code $LASTEXITCODE"
}
Write-Host "Installer compiled successfully!" -ForegroundColor Green

# 4. Create Portable Archive (.zip)
Write-Host "[4/4] Creating WinExplorerAutoFix-Portable.zip..." -ForegroundColor Yellow
$zipOutput = Join-Path $releaseDir 'WinExplorerAutoFix-Portable.zip'
$stagingDir = Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $stagingDir -Force | Out-Null

try {
    # Copy essential files to staging directory
    Copy-Item -Path (Join-Path $rootDir 'Install.bat') -Destination $stagingDir
    Copy-Item -Path (Join-Path $rootDir 'Uninstall.bat') -Destination $stagingDir
    Copy-Item -Path (Join-Path $rootDir 'LICENSE') -Destination $stagingDir
    Copy-Item -Path (Join-Path $rootDir 'README.md') -Destination $stagingDir
    Copy-Item -Path (Join-Path $rootDir 'core') -Destination (Join-Path $stagingDir 'core') -Recurse
    Copy-Item -Path (Join-Path $rootDir 'images') -Destination (Join-Path $stagingDir 'images') -Recurse

    Compress-Archive -Path "$stagingDir\*" -DestinationPath $zipOutput -CompressionLevel Optimal
    Write-Host "Portable archive created successfully!" -ForegroundColor Green
}
finally {
    if (Test-Path $stagingDir) {
        Remove-Item -Path $stagingDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Summary
Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "          BUILD COMPLETED                 " -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan

Get-ChildItem -Path $releaseDir | ForEach-Object {
    $hash = (Get-FileHash -Path $_.FullName -Algorithm SHA256).Hash
    $sizeKb = [math]::Round($_.Length / 1KB, 2)
    Write-Host "-> $($_.Name) ($sizeKb KB)" -ForegroundColor White
    Write-Host "   SHA256: $hash" -ForegroundColor DarkGray
}
Write-Host "`nRelease assets ready in: $releaseDir" -ForegroundColor Cyan

