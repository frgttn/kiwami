#!/bin/bash

set -euo pipefail

echo "--- Copying Kiwami configs ---"

CONFIG_SOURCE="$KIWAMI_PATH/config"
CONFIG_TARGET="$HOME/.config"
BACKUP_DIR="$CONFIG_TARGET/kiwami-backup-$(date +%Y%m%d-%H%M%S)"

if [[ ! -d "$CONFIG_SOURCE" ]]; then
  echo "Config source not found: $CONFIG_SOURCE" >&2
  exit 1
fi

mkdir -p "$HOME/.config"

shopt -s dotglob nullglob
for path in "$CONFIG_SOURCE"/*; do
  target="$CONFIG_TARGET/$(basename "$path")"

  if [[ -e "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp -a "$target" "$BACKUP_DIR/"
  fi
done
shopt -u dotglob nullglob

cp -a "$CONFIG_SOURCE/." "$CONFIG_TARGET/"

if [[ -d "$BACKUP_DIR" ]]; then
  echo "Existing configs were backed up to: $BACKUP_DIR"
fi
