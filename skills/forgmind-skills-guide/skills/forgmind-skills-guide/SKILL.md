---
name: forgmind-skills-guide
description: Complete guide for the forgmind-skills GitHub repo — what it is, how to install skills via the Manage Plugins dialog or install scripts, how to add a new skill with the correct plugin structure, and the difference between user-level and project-level skills.
---

# Forgmind Skills Library — Complete Guide

**Repo:** https://github.com/madesh6554/forgmind-skills

---

## What Is This Repo?

This is the **central skill library** for the Forgmind team. It stores Claude Code slash commands (skills) that any team member can install on any machine or project — without recreating them from scratch each time.

---

## How to Install Skills

### Option 1 — Manage Plugins dialog (recommended)

1. Open Claude Code and run `/manage-plugins`
2. Click the **Marketplaces** tab
3. In the input box enter: `madesh6554/forgmind-skills`
4. Click **Add**
5. Go to the **Plugins** tab — all skills appear listed
6. Click install on whichever skills you want

### Option 2 — One-line install script

**Windows:**
```powershell
irm https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.ps1 | iex
```

**Linux / Mac:**
```bash
curl -fsSL https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.sh | bash
```

This copies all user-level skills to `~/.claude/commands/` — available in every project on your machine.

---

## Repo Structure

```
forgmind-skills/
  ├── .claude-plugin/
  │   └── marketplace.json          ← lists all skills for Manage Plugins dialog
  ├── skills/                       ← user-level skills (generic, any project)
  │   ├── mockup/
  │   │   ├── SKILL.md              ← skill instructions Claude reads
  │   │   └── plugin.json           ← plugin metadata (name, version, description)
  │   ├── preview/
  │   │   ├── SKILL.md
  │   │   └── plugin.json
  │   ├── use-project-skills/
  │   │   ├── SKILL.md
  │   │   └── plugin.json
  │   └── forgmind-skills-guide/
  │       ├── SKILL.md              ← this file
  │       └── plugin.json
  ├── projects/                     ← project-level skills (tied to one repo)
  │   └── sp-sales-log/
  │       ├── deploy-frontend.md
  │       ├── flutter-run.md
  │       ├── migrate-db.md
  │       └── n8n-push.md
  ├── SKILL_TEMPLATE.md             ← copy this to create a new skill
  ├── install.ps1                   ← Windows installer
  ├── install.sh                    ← Linux/Mac installer
  ├── install-project.ps1           ← Windows project-skill installer
  └── install-project.sh            ← Linux/Mac project-skill installer
```

---

## How to Add a New Skill (Contribute)

Every new skill needs **3 things**: a folder, a `SKILL.md`, and a `plugin.json`. Then one entry added to `marketplace.json`.

### Step 1 — Create the skill folder

```
skills/your-skill-name/
  ├── SKILL.md
  └── plugin.json
```

### Step 2 — Write `SKILL.md`

```markdown
---
name: your-skill-name
description: One clear sentence — what this skill does and when to use it.
---

# Skill Title

Your skill instructions here...
```

### Step 3 — Write `plugin.json`

```json
{
  "name": "your-skill-name",
  "version": "1.0.0",
  "description": "Same one-line description as in SKILL.md frontmatter.",
  "author": { "name": "YourName" },
  "license": "MIT",
  "repository": "https://github.com/madesh6554/forgmind-skills",
  "keywords": ["your-skill", "claude-skill"]
}
```

### Step 4 — Add entry to `.claude-plugin/marketplace.json`

Open `.claude-plugin/marketplace.json` and add a new object inside the `"plugins"` array:

```json
{
  "name": "your-skill-name",
  "description": "Same one-line description.",
  "author": { "name": "YourName" },
  "category": "productivity",
  "source": {
    "source": "git-subdir",
    "url": "https://github.com/madesh6554/forgmind-skills.git",
    "path": "skills/your-skill-name",
    "ref": "main"
  },
  "homepage": "https://github.com/madesh6554/forgmind-skills"
}
```

Valid categories: `design`, `productivity`, `development`, `testing`, `security`

### Step 5 — Open a Pull Request

Push your branch and open a PR to `main`. Once merged, the skill appears in the Manage Plugins dialog for everyone.

---

## User-Level vs Project-Level Skills

| | User-level (`skills/`) | Project-level (`projects/`) |
|---|---|---|
| Installs to | `~/.claude/commands/` | `./.claude/commands/` |
| Works in | Every project on your machine | That one project only |
| Shared via | Manage Plugins / install script | `install-project.ps1 <name>` or `/use-project-skills` |
| Best for | Generic tools (mockup, preview) | Project-specific workflows (deploy, migrate) |
| Format | `SKILL.md` + `plugin.json` | Plain `.md` file |

### To install project-level skills

Run inside your project folder:

```
/use-project-skills sp-sales-log
```

Or via script:

```powershell
# Windows — run from inside your project folder
.\install-project.ps1 sp-sales-log
```

```bash
# Linux/Mac — run from inside your project folder
bash install-project.sh sp-sales-log
```

---

## Available Skills

### User-level (install via Manage Plugins or install script)
| Skill | What it does |
|---|---|
| `/mockup` | Auto-generate HTML visual mockup from conversation context |
| `/preview` | Generate HTML preview using project's real theme colors |
| `/use-project-skills` | Install a project's skills into the current project |
| `/forgmind-skills-guide` | This guide |

### Project-level (install via `/use-project-skills <name>`)
| Project | Skills |
|---|---|
| `sp-sales-log` | `/deploy-frontend` `/flutter-run` `/migrate-db` `/n8n-push` |

---

## Contribution Rules

- One skill per folder
- Folder name = skill name (lowercase, hyphens, no spaces)
- Always include both `SKILL.md` and `plugin.json`
- Always add an entry to `.claude-plugin/marketplace.json`
- Test the skill before submitting a PR
- Generic skills → `skills/` · Project-specific → `projects/<project-name>/`
