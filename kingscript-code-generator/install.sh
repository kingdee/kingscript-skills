#!/bin/bash
# Usage:
#   bash install.sh [optional-target-dir]

set -euo pipefail

SKILL_NAME="kingscript-code-generator"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="${1:-}"

if [ -z "$TARGET_DIR" ]; then
  TARGET_DIR="$HOME/.qoder/skills/$SKILL_NAME"
fi

echo "Installing $SKILL_NAME ..."
echo "Target: $TARGET_DIR"

rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"

# --- 复制整个仓库内容到目标目录（排除 .git 和安装脚本自身）---
rsync -a --exclude='.git' --exclude='install.ps1' --exclude='install.sh' "$SCRIPT_DIR/" "$TARGET_DIR/"

# --- 验证 ---
missing=()
for entry in references SKILL.md; do
  if [ ! -e "$TARGET_DIR/$entry" ]; then
    missing+=("$entry")
  fi
done

if [ "${#missing[@]}" -gt 0 ]; then
  echo "Install verification failed. Missing: ${missing[*]}" >&2
  exit 1
fi

echo "Verification passed."
echo "Install complete."
echo "Bundle path: $TARGET_DIR"
