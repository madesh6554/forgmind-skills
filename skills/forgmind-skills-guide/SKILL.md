---
name: forgmind-skills-guide
description: Explains what the forgmind-skills GitHub repo is, how to install skills from it, and how to contribute new skill files to the team library.
---

# Forgmind Skills Library — Guide

**Repo:** https://github.com/madesh6554/forgmind-skills

## What Is This Repo?

This is the **central skill library** for the Forgmind team. It stores Claude Code skill files (slash commands) that any team member can install and use across any project or server.

Instead of recreating the same skills on every machine or project, skills are stored here once and shared with everyone.

## Repo Structure

```
forgmind-skills/
  ├── README.md
  ├── skills/
  │   ├── <skill-name>.md       ← each skill is one .md file
  │   ├── <skill-name>.md
  │   └── ...
  └── install.ps1               ← Windows installer script
  └── install.sh                ← Linux/Mac installer script
```

## How to Install Skills (Windows)

Run this once in PowerShell to pull all skills to your machine:

```powershell
$dest = "$env:USERPROFILE\.claude\commands"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest }
$tmp = "$env:TEMP\forgmind-skills"
git clone https://github.com/madesh6554/forgmind-skills $tmp
Copy-Item "$tmp\skills\*.md" $dest -Force
Remove-Item -Recurse -Force $tmp
Write-Host "Skills installed to $dest"
```

## How to Install Skills (Linux / Mac)

```bash
DEST="$HOME/.claude/commands"
mkdir -p "$DEST"
TMP=$(mktemp -d)
git clone https://github.com/madesh6554/forgmind-skills "$TMP"
cp "$TMP/skills/"*.md "$DEST/"
rm -rf "$TMP"
echo "Skills installed to $DEST"
```

## How to Update Skills

Re-run the install script above. It overwrites existing files with the latest version from the repo.

## How to Use a Skill

After installing, open any Claude Code session and type:

```
/skill-name
```

The skill name matches the filename (without `.md`).

## How to Add a New Skill (Contribute)

1. Create a new `.md` file inside the `skills/` folder
2. Follow this format at the top of the file:

```markdown
---
name: your-skill-name
description: One line describing what this skill does.
---

# Skill Title

Your skill instructions here...
```

3. Open a Pull Request to the `main` branch
4. Once merged, anyone on the team can install it

## How to Install a Single Skill (Without Cloning Everything)

```powershell
# Replace <skill-name> with the actual filename
$raw = "https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/skills/<skill-name>.md"
$dest = "$env:USERPROFILE\.claude\commands\<skill-name>.md"
Invoke-WebRequest $raw -OutFile $dest
Write-Host "Skill installed."
```

## Rules for Contributing Skills

- One skill per file
- File name = skill name (use lowercase, hyphens instead of spaces)
- Always include the frontmatter block (`name`, `description`)
- Keep the skill focused on one clear task
- Test the skill before submitting a PR

## Who Maintains This Repo

Managed by the Forgmind team. For questions, open a GitHub Issue on the repo.
