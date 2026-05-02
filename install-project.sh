#!/usr/bin/env bash
# Forgmind Project Skills Installer — Linux / Mac
# Installs project-level skills into .claude/commands/ inside the current project
# Usage: bash install-project.sh <project-name>
# Example: bash install-project.sh sp-sales-log

PROJECT="$1"

if [ -z "$PROJECT" ]; then
  echo "Usage: bash install-project.sh <project-name>"
  exit 1
fi

REPO="https://github.com/madesh6554/forgmind-skills"
DEST="./.claude/commands"
TMP=$(mktemp -d)

echo "Installing project skills for: $PROJECT"

mkdir -p "$DEST"
git clone --depth 1 "$REPO" "$TMP" > /dev/null 2>&1

if [ ! -d "$TMP/projects/$PROJECT" ] || [ -z "$(ls "$TMP/projects/$PROJECT/"*.md 2>/dev/null)" ]; then
  echo "No skills found for project: $PROJECT"
  echo "Available projects:"
  ls "$TMP/projects/"
  rm -rf "$TMP"
  exit 1
fi

count=0
for file in "$TMP/projects/$PROJECT/"*.md; do
  cp "$file" "$DEST/"
  echo "  + $(basename "$file" .md)"
  count=$((count + 1))
done

rm -rf "$TMP"

echo ""
echo "$count skill(s) installed to $DEST"
echo "Restart Claude Code — skills are active in this project only."
