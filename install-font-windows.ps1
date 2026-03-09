# install-font-windows.ps1
# Run from WSL:  powershell.exe -File scripts/install-font-windows.ps1
# Or from PowerShell directly.
#
# Copies all .ttf files from the fonts/ folder to the Windows user font directory.

$scriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Definition
$fontDir    = Join-Path (Split-Path $scriptDir) "fonts"
$destDir    = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir | Out-Null }

Get-ChildItem "$fontDir\*.ttf" | ForEach-Object {
    $dest = Join-Path $destDir $_.Name
    if (-not (Test-Path $dest)) {
        Copy-Item $_.FullName $dest
        # Register the font for the current user
        $regPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
        New-ItemProperty -Path $regPath -Name $_.BaseName -Value $dest -Force | Out-Null
        Write-Host "Installed: $($_.Name)"
    } else {
        Write-Host "Already installed: $($_.Name)"
    }
}

Write-Host "`nDone. Restart your terminal to use the new font."
