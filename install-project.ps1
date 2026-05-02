# Forgmind Project Skills Installer — Windows
# Installs project-level skills into .claude/commands/ inside the current project
# Usage: .\install-project.ps1 <project-name>
# Example: .\install-project.ps1 sp-sales-log

param (
    [Parameter(Mandatory=$true)]
    [string]$ProjectName
)

$repo = "https://github.com/madesh6554/forgmind-skills"
$dest = ".\.claude\commands"
$tmp  = "$env:TEMP\forgmind-project-install"

Write-Host "Installing project skills for: $ProjectName" -ForegroundColor Cyan

if (-not (Test-Path $dest)) {
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
}

if (Test-Path $tmp) {
    Remove-Item -Recurse -Force $tmp
}

git clone --depth 1 $repo $tmp | Out-Null

$skills = Get-ChildItem "$tmp\projects\$ProjectName\*.md" -ErrorAction SilentlyContinue
if (-not $skills) {
    Write-Host "No skills found for project: $ProjectName" -ForegroundColor Yellow
    Write-Host "Available projects:" -ForegroundColor White
    Get-ChildItem "$tmp\projects\" -Directory | ForEach-Object { Write-Host "  - $($_.Name)" }
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
Write-Host "Restart Claude Code — skills are active in this project only." -ForegroundColor White
