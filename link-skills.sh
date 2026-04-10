#!/bin/bash
# link-skills.sh — Symlinks all skills (user + plugin) into each config directory's skills/ folder.
# Run this after adding or removing skills.

REPO="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIRS=(
  "$HOME/.claude-personal"
  "$HOME/.claude-workmax"
  "$HOME/.codex-work"
)

for dir in "${CONFIG_DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "Skipping $dir (does not exist)"
    continue
  fi

  # Remove old symlink (if skills/ is a single symlink to the repo)
  # or remove old individual symlinks
  if [ -L "$dir/skills" ]; then
    rm "$dir/skills"
    mkdir -p "$dir/skills"
    echo "Replaced directory symlink with individual links in $dir/skills/"
  elif [ -d "$dir/skills" ]; then
    # Remove existing symlinks inside skills/ (leave non-symlinks alone)
    find "$dir/skills" -maxdepth 1 -type l -delete
    echo "Cleaned existing symlinks in $dir/skills/"
  else
    mkdir -p "$dir/skills"
    echo "Created $dir/skills/"
  fi

  # Link user skills
  for skill in "$REPO"/skills/*/; do
    [ -d "$skill" ] || continue
    name=$(basename "$skill")
    ln -s "$skill" "$dir/skills/$name"
  done

  # Link plugin skills
  for skill in "$REPO"/plugins/*/; do
    [ -d "$skill" ] || continue
    name=$(basename "$skill")
    ln -s "$skill" "$dir/skills/$name"
  done

  # Link .system skills
  if [ -d "$REPO/skills/.system" ]; then
    ln -s "$REPO/skills/.system" "$dir/skills/.system"
  fi

  count=$(find "$dir/skills" -maxdepth 1 -type l | wc -l | tr -d ' ')
  echo "Linked $count skills into $dir/skills/"
done

echo "Done."
