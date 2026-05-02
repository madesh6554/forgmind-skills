#!/usr/bin/env bash
# Forgmind Skills Installer — Linux / Mac
# Installs user-level (generic) skills from skills/ folder
# Usage: curl -fsSL https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.sh | bash
#
# To install project-level skills for a specific project, run inside that project:
#   /use-project-skills <project-name>
# Or use install-project.sh:
#   bash install-project.sh sp-sales-log

REPO="https://github.com/madesh6554/forgmind-skills"
DEST="$HOME/.claude/commands"
TMP=$(mktemp -d)

echo "Installing Forgmind user-level skills..."

mkdir -p "$DEST"

git clone --depth 1 "$REPO" "$TMP" > /dev/null 2>&1

if [ ! -d "$TMP/skills" ] || [ -z "$(ls "$TMP/skills/"*.md 2>/dev/null)" ]; then
  echo "No skills found."
  rm -rf "$TMP"
  exit 1
fi

count=0
for file in "$TMP/skills/"*.md; do
  cp "$file" "$DEST/"
  echo "  + $(basename "$file" .md)"
  count=$((count + 1))
done

rm -rf "$TMP"

echo ""
echo "$count skill(s) installed to $DEST"
echo "Restart Claude Code and type /skill-name to use any skill."
echo ""
echo "For project-specific skills, run inside your project:"
echo "  /use-project-skills <project-name>"
