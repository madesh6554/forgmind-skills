# Forgmind Skills Installer — Windows
# Usage: irm https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.ps1 | iex

$repo = "https://github.com/madesh6554/forgmind-skills"
$dest = "$env:USERPROFILE\.claude\commands"
$tmp  = "$env:TEMP\forgmind-skills-install"

Write-Host "Installing Forgmind skills..." -ForegroundColor Cyan

if (-not (Test-Path $dest)) {
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
}

if (Test-Path $tmp) {
    Remove-Item -Recurse -Force $tmp
}

git clone --depth 1 $repo $tmp | Out-Null

$skills = Get-ChildItem "$tmp\skills\*.md" -ErrorAction SilentlyContinue
if (-not $skills) {
    Write-Host "No skills found in repo." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $tmp
    exit 1
}

$count = 0
foreach ($file in $skills) {
    Copy-Item $file.FullName "$dest\$($file.Name)" -Force
    Write-Host "  + $($file.BaseName)" -ForegroundColor Green
    $count++
}

Remove-Item -Recurse -Force $tmp

Write-Host ""
Write-Host "$count skill(s) installed to $dest" -ForegroundColor Cyan
Write-Host "Restart Claude Code and use /skill-name to run any skill." -ForegroundColor White
