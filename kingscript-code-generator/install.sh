#!/bin/bash
# Usage:
#   bash install.sh [codex|qoder|claude] [optional-target-dir]

set -euo pipefail

PLATFORM="${1:-codex}"
TARGET_DIR="${2:-}"
SKILL_NAME="kingscript-code-generator"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

copy_dir_contents() {
  local source="$1"
  local destination="$2"

  if [ ! -d "$source" ]; then
    echo "Missing source directory: $source" >&2
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
    echo "Missing source file: $source" >&2
    exit 1
  fi

  mkdir -p "$destination_dir"
  cp "$source" "$destination_dir/$destination_name"
}

backup_optional_file() {
  local source="$1"
  local backup="$2"

  if [ -f "$source" ]; then
    mkdir -p "$(dirname "$backup")"
    cp "$source" "$backup"
  fi
}

copy_text_with_replacements() {
  local source="$1"
  local destination="$2"
  local pattern="$3"
  local replacement="$4"

  if [ ! -f "$source" ]; then
    echo "Missing source file: $source" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$destination")"
  sed "s|$pattern|$replacement|g" "$source" > "$destination"
}

expected_entries() {
  local platform="$1"

  case "$platform" in
    codex)
      printf '%s\n' "references" "SKILL.md" "AGENTS.md" "README.md" "local-paths.example.json" "agents"
      ;;
    qoder)
      printf '%s\n' "references" "SKILL.md" "README.md" "local-paths.example.json"
      ;;
    claude)
      printf '%s\n' "references" "SKILL.md" "CLAUDE.md" "README.md" "local-paths.example.json" "commands"
      ;;
    *)
      echo "Unsupported platform: $platform" >&2
      exit 1
      ;;
  esac
}

verify_installation() {
  local platform="$1"
  local destination="$2"
  local missing=()

  while IFS= read -r entry; do
    [ -z "$entry" ] && continue
    if [ ! -e "$destination/$entry" ]; then
      missing+=("$entry")
    fi
  done < <(expected_entries "$platform")

  if [ "${#missing[@]}" -gt 0 ]; then
    echo "Install verification failed. Missing entries: ${missing[*]}" >&2
    exit 1
  fi
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
      echo "Unsupported platform: $PLATFORM" >&2
      exit 1
      ;;
  esac
fi

echo "Installing $SKILL_NAME for $PLATFORM ..."
echo "Target: $TARGET_DIR"

TEMP_ROOT="${TMPDIR:-/tmp}/${SKILL_NAME}-$(date +%s)-$$"
BACKUP_LOCAL_PATHS="$TEMP_ROOT/local-paths.json"

if [ -f "$TARGET_DIR/local-paths.json" ] && { [ "$PLATFORM" = "codex" ] || [ "$PLATFORM" = "qoder" ] || [ "$PLATFORM" = "claude" ]; }; then
  backup_optional_file "$TARGET_DIR/local-paths.json" "$BACKUP_LOCAL_PATHS"
fi

rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"

copy_dir_contents "$SCRIPT_DIR/references" "$TARGET_DIR/references"

case "$PLATFORM" in
  codex)
    copy_text_with_replacements "$SCRIPT_DIR/codex/SKILL.md" "$TARGET_DIR/SKILL.md" "\\.\\./references/" "./references/"
    copy_text_with_replacements "$SCRIPT_DIR/codex/AGENTS.md" "$TARGET_DIR/AGENTS.md" "\\.\\./references/" "./references/"
    copy_file_to_root "$SCRIPT_DIR/codex/README.md" "$TARGET_DIR" "README.md"
    copy_file_to_root "$SCRIPT_DIR/codex/local-paths.example.json" "$TARGET_DIR" "local-paths.example.json"
    copy_dir_contents "$SCRIPT_DIR/codex/agents" "$TARGET_DIR/agents"
    if [ -f "$BACKUP_LOCAL_PATHS" ]; then
      copy_file_to_root "$BACKUP_LOCAL_PATHS" "$TARGET_DIR" "local-paths.json"
    fi
    ;;
  qoder)
    copy_text_with_replacements "$SCRIPT_DIR/qoder/SKILL.md" "$TARGET_DIR/SKILL.md" "\\.\\./references/" "./references/"
    copy_file_to_root "$SCRIPT_DIR/qoder/README.md" "$TARGET_DIR" "README.md"
    copy_file_to_root "$SCRIPT_DIR/qoder/local-paths.example.json" "$TARGET_DIR" "local-paths.example.json"
    if [ -f "$BACKUP_LOCAL_PATHS" ]; then
      copy_file_to_root "$BACKUP_LOCAL_PATHS" "$TARGET_DIR" "local-paths.json"
    fi
    ;;
  claude)
    copy_file_to_root "$SCRIPT_DIR/claude-code/SKILL.md" "$TARGET_DIR" "SKILL.md"
    copy_text_with_replacements "$SCRIPT_DIR/claude-code/CLAUDE.md" "$TARGET_DIR/CLAUDE.md" "\\.\\./references/" "./references/"
    copy_file_to_root "$SCRIPT_DIR/claude-code/README.md" "$TARGET_DIR" "README.md"
    copy_file_to_root "$SCRIPT_DIR/claude-code/local-paths.example.json" "$TARGET_DIR" "local-paths.example.json"
    mkdir -p "$TARGET_DIR/commands"
    for file in "$SCRIPT_DIR"/claude-code/commands/*.md; do
      copy_text_with_replacements "$file" "$TARGET_DIR/commands/$(basename "$file")" "\\.\\./\\.\\./references/" "../references/"
    done
    if [ -f "$BACKUP_LOCAL_PATHS" ]; then
      copy_file_to_root "$BACKUP_LOCAL_PATHS" "$TARGET_DIR" "local-paths.json"
    fi
    ;;
esac

verify_installation "$PLATFORM" "$TARGET_DIR"

rm -rf "$TEMP_ROOT"

echo "Verification passed."
echo "Install complete."
echo "Bundle path: $TARGET_DIR"
