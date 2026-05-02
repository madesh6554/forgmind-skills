#!/usr/bin/env bash
# Forgmind Skills Installer — Linux / Mac
# Installs user-level (generic) skills from skills/ folder
# Usage: curl -fsSL https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.sh | bash

REPO="https://github.com/madesh6554/forgmind-skills"
DEST="$HOME/.claude/commands"
TMP=$(mktemp -d)

echo "Installing Forgmind user-level skills..."

mkdir -p "$DEST"
git clone --depth 1 "$REPO" "$TMP" > /dev/null 2>&1

count=0
for skillDir in "$TMP/skills"/*/; do
  skillFile="$skillDir/SKILL.md"
  if [ -f "$skillFile" ]; then
    name=$(basename "$skillDir")
    cp "$skillFile" "$DEST/$name.md"
    echo "  + $name"
    count=$((count + 1))
  fi
done

rm -rf "$TMP"

echo ""
echo "$count skill(s) installed to $DEST"
echo "Restart Claude Code and type /skill-name to use any skill."
echo ""
echo "For project-specific skills, run inside your project:"
echo "  /use-project-skills <project-name>"
