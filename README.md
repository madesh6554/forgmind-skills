# Forgmind Skills Library

Central skill repository for the Forgmind team. Store, share, and install Claude Code slash commands across any machine or project.

## Quick Install — User-Level Skills (Generic)

These install to `~/.claude/commands/` and work in **every project** on your machine.

**Windows:**
```powershell
irm https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.ps1 | iex
```

**Linux / Mac:**
```bash
curl -fsSL https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.sh | bash
```

---

## Install Project-Level Skills (Project-Specific)

These install to `./.claude/commands/` inside your current project and work **only in that project**.

Run this from inside the project folder:

**Windows:**
```powershell
.\install-project.ps1 sp-sales-log
```

**Linux / Mac:**
```bash
bash install-project.sh sp-sales-log
```

Or just run `/use-project-skills sp-sales-log` inside Claude Code — it will do it for you.

---

## Repo Structure

```
forgmind-skills/
  ├── install.ps1              ← installs user-level skills (Windows)
  ├── install.sh               ← installs user-level skills (Linux/Mac)
  ├── install-project.ps1      ← installs project skills (Windows)
  ├── install-project.sh       ← installs project skills (Linux/Mac)
  ├── SKILL_TEMPLATE.md        ← template for creating new skills
  ├── skills/                  ← user-level: generic, work in any project
  │   ├── mockup.md
  │   ├── preview.md
  │   ├── use-project-skills.md
  │   └── forgmind-skills-guide.md
  └── projects/                ← project-level: tied to a specific repo
      └── sp-sales-log/
          ├── deploy-frontend.md
          ├── flutter-run.md
          ├── migrate-db.md
          └── n8n-push.md
```

---

## User-Level vs Project-Level

| | User-level (`skills/`) | Project-level (`projects/`) |
|---|---|---|
| Installs to | `~/.claude/commands/` | `./.claude/commands/` |
| Works in | Every project on your machine | That one project only |
| Best for | Generic tools (mockup, preview) | Project-specific workflows (deploy, migrate) |
| Install command | `install.ps1` / `install.sh` | `install-project.ps1 <name>` |

---

## Available Skills

### User-Level (Generic)
| Skill | Description |
|---|---|
| `/mockup` | Auto-generate an HTML visual mockup from conversation context |
| `/preview` | Generate HTML preview using project's real theme colors |
| `/use-project-skills` | Install a project's skills into the current project |
| `/forgmind-skills-guide` | Full guide on using and contributing to this repo |

### Project-Level
| Project | Skills |
|---|---|
| `sp-sales-log` | `/deploy-frontend`, `/flutter-run`, `/migrate-db`, `/n8n-push` |

---

## Contributing a Skill

1. Copy `SKILL_TEMPLATE.md`
2. Fill it in and save it:
   - Generic skill → `skills/<skill-name>.md`
   - Project-specific → `projects/<project-name>/<skill-name>.md`
3. Open a Pull Request to `main`

**Rules:** one skill per file · lowercase filename with hyphens · always include `name` and `description` frontmatter · test before PR
