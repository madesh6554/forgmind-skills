#!/usr/bin/env bash
# Forgmind Skills Installer — Linux / Mac
# Usage: curl -fsSL https://raw.githubusercontent.com/madesh6554/forgmind-skills/main/install.sh | bash

REPO="https://github.com/madesh6554/forgmind-skills"
DEST="$HOME/.claude/commands"
TMP=$(mktemp -d)

echo "Installing Forgmind skills..."

mkdir -p "$DEST"

git clone --depth 1 "$REPO" "$TMP" > /dev/null 2>&1

if [ ! -d "$TMP/skills" ] || [ -z "$(ls "$TMP/skills/"*.md 2>/dev/null)" ]; then
  echo "No skills found in repo."
  rm -rf "$TMP"
  exit 1
fi

count=0
for file in "$TMP/skills/"*.md; do
  name=$(basename "$file" .md)
  cp "$file" "$DEST/"
  echo "  + $name"
  count=$((count + 1))
done

rm -rf "$TMP"

echo ""
echo "$count skill(s) installed to $DEST"
echo "Restart Claude Code and use /skill-name to run any skill."
