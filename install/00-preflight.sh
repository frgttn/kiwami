#!/bin/bash

set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Do not run this installer as root. Run it as your regular user." >&2
  exit 1
fi

if [[ ! -f /etc/arch-release ]]; then
  echo "This installer is intended for Arch Linux." >&2
  exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo is required to run this installer." >&2
  exit 1
fi

if [[ ! -d "$KIWAMI_INSTALL" ]]; then
  echo "Installer directory not found: $KIWAMI_INSTALL" >&2
  exit 1
fi

sudo -v

echo "--- Preflight checks passed ---"
