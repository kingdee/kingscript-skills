#!/bin/bash
# 用法：
#   bash install.sh [codex|qoder|claude] [可选目标目录]

set -euo pipefail

PLATFORM="${1:-codex}"
TARGET_DIR="${2:-}"
SKILL_NAME="kingscript-code-generator"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

copy_dir_contents() {
  local source="$1"
  local destination="$2"

  if [ ! -d "$source" ]; then
    echo "缺少源目录：$source" >&2
    exit 1
  fi

  mkdir -p "$destination"
  cp -R "$source"/. "$destination"
}

copy_file_to_root() {
  local source="$1"
  local destination_dir="$2"
  local destination_name="$3"

  if [ ! -f "$source" ]; then
    echo "缺少源文件：$source" >&2
    exit 1
  fi

  mkdir -p "$destination_dir"
  cp "$source" "$destination_dir/$destination_name"
}

copy_text_with_replacements() {
  local source="$1"
  local destination="$2"
  local pattern="$3"
  local replacement="$4"

  if [ ! -f "$source" ]; then
    echo "缺少源文件：$source" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$destination")"
  sed "s|$pattern|$replacement|g" "$source" > "$destination"
}

if [ -z "$TARGET_DIR" ]; then
  case "$PLATFORM" in
    codex)
      TARGET_DIR="$HOME/.agents/skills/$SKILL_NAME"
      ;;
    qoder)
      TARGET_DIR="$HOME/.qoder/skills/$SKILL_NAME"
      ;;
    claude)
      TARGET_DIR="$HOME/.claude/skills/$SKILL_NAME"
      ;;
    *)
      echo "不支持的平台：$PLATFORM" >&2
      exit 1
      ;;
  esac
fi

echo "正在为 $PLATFORM 安装 $SKILL_NAME ..."
echo "目标目录：$TARGET_DIR"

rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"

copy_dir_contents "$SCRIPT_DIR/references" "$TARGET_DIR/references"

case "$PLATFORM" in
  codex)
    copy_text_with_replacements "$SCRIPT_DIR/codex/SKILL.md" "$TARGET_DIR/SKILL.md" "\\.\\./references/" "./references/"
    copy_text_with_replacements "$SCRIPT_DIR/codex/AGENTS.md" "$TARGET_DIR/AGENTS.md" "\\.\\./references/" "./references/"
    copy_dir_contents "$SCRIPT_DIR/codex/agents" "$TARGET_DIR/agents"
    ;;
  qoder)
    copy_text_with_replacements "$SCRIPT_DIR/qoder/SKILL.md" "$TARGET_DIR/SKILL.md" "\\.\\./references/" "./references/"
    ;;
  claude)
    copy_file_to_root "$SCRIPT_DIR/claude-code/SKILL.md" "$TARGET_DIR" "SKILL.md"
    copy_text_with_replacements "$SCRIPT_DIR/claude-code/CLAUDE.md" "$TARGET_DIR/CLAUDE.md" "\\.\\./references/" "./references/"
    mkdir -p "$TARGET_DIR/commands"
    for file in "$SCRIPT_DIR"/claude-code/commands/*.md; do
      copy_text_with_replacements "$file" "$TARGET_DIR/commands/$(basename "$file")" "\\.\\./\\.\\./references/" "../references/"
    done
    ;;
esac

echo "安装完成。"
echo "安装路径：$TARGET_DIR"
