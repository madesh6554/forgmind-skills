---
name: use-project-skills
description: Install project-level skills from the forgmind-skills GitHub repo into the current project's .claude/commands/ folder. Use when a teammate wants to activate project-specific skills (deploy, migrate, run) for a project they just cloned.
---

# /use-project-skills — Install project-level skills

Use this skill to pull project-specific skills from the forgmind-skills library and install them into the current project so they become available as slash commands.

## How to use

Tell Claude which project's skills you want to install:

```
/use-project-skills sp-sales-log
```

Claude will run the correct install command for your OS.

## What it does

1. Looks up `projects/<project-name>/` in the forgmind-skills repo
2. Downloads all skill files from that folder
3. Copies them into `.claude/commands/` inside your current project directory
4. The skills are then available as `/skill-name` commands in this project only

## Windows (PowerShell)

```powershell
# Replace <project-name> with the folder name under projects/
$project = "<project-name>"
$repo    = "https://github.com/madesh6554/forgmind-skills"
$dest    = ".\.claude\commands"
$tmp     = "$env:TEMP\forgmind-project-skills"

if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }

git clone --depth 1 $repo $tmp | Out-Null

$skills = Get-ChildItem "$tmp\projects\$project\*.md" -ErrorAction SilentlyContinue
if (-not $skills) {
    Write-Host "No skills found for project: $project" -ForegroundColor Yellow
} else {
    foreach ($file in $skills) {
        Copy-Item $file.FullName "$dest\$($file.Name)" -Force
        Write-Host "  + $($file.BaseName)" -ForegroundColor Green
    }
    Write-Host "Done. Restart Claude Code to use the skills." -ForegroundColor Cyan
}
Remove-Item -Recurse -Force $tmp
```

## Linux / Mac (bash)

```bash
# Replace <project-name> with the folder name under projects/
PROJECT="<project-name>"
REPO="https://github.com/madesh6554/forgmind-skills"
DEST="./.claude/commands"
TMP=$(mktemp -d)

mkdir -p "$DEST"
git clone --depth 1 "$REPO" "$TMP" > /dev/null 2>&1

if [ -z "$(ls "$TMP/projects/$PROJECT/"*.md 2>/dev/null)" ]; then
  echo "No skills found for project: $PROJECT"
else
  for file in "$TMP/projects/$PROJECT/"*.md; do
    cp "$file" "$DEST/"
    echo "  + $(basename "$file" .md)"
  done
  echo "Done. Restart Claude Code to use the skills."
fi
rm -rf "$TMP"
```

## Available projects

Check the `projects/` folder in the repo to see all available project skill sets:
https://github.com/madesh6554/forgmind-skills/tree/main/projects

## Difference from the main install

| | `install.ps1` | `/use-project-skills` |
|---|---|---|
| Installs to | `~/.claude/commands/` | `./.claude/commands/` |
| Scope | Every project on your machine | This project only |
| Skills from | `skills/` folder | `projects/<name>/` folder |
| Use for | Generic skills | Project-specific workflows |
