# Forgmind Skills Installer — Windows
# Installs user-level (generic) skills from skills/ folder
# Usage: irm https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.ps1 | iex

$repo = "https://github.com/madesh6554/forgmind-skills"
$dest = "$env:USERPROFILE\.claude\commands"
$tmp  = "$env:TEMP\forgmind-skills-install"

Write-Host "Installing Forgmind user-level skills..." -ForegroundColor Cyan

if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }

git clone --depth 1 $repo $tmp | Out-Null

$count = 0
foreach ($skillDir in Get-ChildItem "$tmp\skills" -Directory) {
    $skillFile = Join-Path $skillDir.FullName "SKILL.md"
    if (Test-Path $skillFile) {
        Copy-Item $skillFile "$dest\$($skillDir.Name).md" -Force
        Write-Host "  + $($skillDir.Name)" -ForegroundColor Green
        $count++
    }
}

Remove-Item -Recurse -Force $tmp

Write-Host ""
Write-Host "$count skill(s) installed to $dest" -ForegroundColor Cyan
Write-Host "Restart Claude Code and type /skill-name to use any skill." -ForegroundColor White
Write-Host ""
Write-Host "For project-specific skills, run inside your project:" -ForegroundColor DarkGray
Write-Host "  /use-project-skills <project-name>" -ForegroundColor DarkGray
