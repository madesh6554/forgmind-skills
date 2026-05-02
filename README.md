# Forgmind Skills Library

Central skill repository for the Forgmind team. Store, share, and install Claude Code slash commands across any machine or project.

## Quick Install

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.ps1 | iex
```

**Linux / Mac:**
```bash
curl -fsSL https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.sh | bash
```

This copies all skills from `skills/` into your `~/.claude/commands/` folder. After that, every skill is available as a `/skill-name` command in any Claude Code session.

## Update Skills

Re-run the install command above to pull the latest skills.

## Available Skills

| Skill | Description |
|---|---|
| `/forgmind-skills-guide` | How to use this repo, install skills, and contribute new ones |

## Contributing a Skill

1. Create a `.md` file in the `skills/` folder
2. Use this format:

```markdown
---
name: your-skill-name
description: One line describing what this skill does.
---

# Skill Title

Your skill instructions here...
```

3. Open a Pull Request to `main`

**Rules:**
- One skill per file
- Filename = skill name (lowercase, hyphens, no spaces)
- Always include `name` and `description` in frontmatter
- Test before submitting PR

## Repo Structure

```
forgmind-skills/
  ├── README.md
  ├── install.ps1       ← Windows installer
  ├── install.sh        ← Linux/Mac installer
  └── skills/
      └── *.md          ← skill files
```

## Need Help?

Run `/forgmind-skills-guide` in Claude Code or open a GitHub Issue.
