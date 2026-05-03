#!/bin/bash

set -euo pipefail

if ! command -v lspci >/dev/null 2>&1; then
  echo "lspci not found. Install pciutils before running VA-API detection." >&2
  exit 1
fi

PACKAGES=()

if lspci | grep -iE "(VGA|Display).*(Intel|HD Graphics|UHD Graphics|Iris)" >/dev/null; then
  PACKAGES+=(libva-intel-driver)
fi

if lspci | grep -iE "(VGA|Display).*(AMD|ATI)" >/dev/null; then
  PACKAGES+=(libva-mesa-driver)
fi

if (( ${#PACKAGES[@]} > 0 )); then
  sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
fi
