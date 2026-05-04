#!/bin/bash

set -euo pipefail

AUR_HELPER="paru"

AUR_PACKAGES=(
  hyprland-preview-share-picker-git
  walker
  limine-mkinitcpio-hook
  limine-snapper-sync
  visual-studio-code-bin
  xdg-terminal-exec
)

if ! command -v "$AUR_HELPER" >/dev/null 2>&1; then
  echo "!!! $AUR_HELPER not found. AUR packages were not installed." >&2
  exit 1
fi

echo "--- Installing AUR packages ---"
"$AUR_HELPER" -S --needed --noconfirm "${AUR_PACKAGES[@]}"
