#Requires -RunAsAdministrator
# Windows setup script
#
# Usage:
#   .\setup.ps1
#   .\setup.ps1 -Distro Ubuntu
#   .\setup.ps1 -Distro Ubuntu -InstallPath D:\WSL
#
# List available distros: wsl --list --online

param(
    [string]$Distro = "Ubuntu",
    [string]$InstallPath
)

$ErrorActionPreference = "Stop"
$RepoRoot = $PSScriptRoot

Write-Host "Installing WSL platform..." -ForegroundColor Cyan
wsl --install --no-distribution

Write-Host "Deploying .wslconfig..." -ForegroundColor Cyan
Copy-Item "$RepoRoot\configs\windows\.wslconfig" "$env:USERPROFILE\.wslconfig" -Force

Write-Host "Installing WSL distro: $Distro..." -ForegroundColor Cyan
wsl --install --distribution $Distro

if ($InstallPath) {
    Write-Host "Moving $Distro to $InstallPath..." -ForegroundColor Cyan
    wsl --manage $Distro --move $InstallPath
}

Write-Host "Installing Windows Terminal..." -ForegroundColor Cyan
winget install --id Microsoft.WindowsTerminal --exact --accept-source-agreements --accept-package-agreements

$WTSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path $WTSettingsDir) {
    Write-Host "Deploying Windows Terminal settings..." -ForegroundColor Cyan
    Copy-Item "$RepoRoot\configs\windows\windows-terminal.json" "$WTSettingsDir\settings.json" -Force
} else {
    Write-Warning "Unable to deploy terminal settings.json because folder does not exist."
}

Write-Host ""
Write-Host "Done. Reboot recommended for WSL changes to take effect." -ForegroundColor Green
