#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEuo pipefail

trap 'echo "Installation failed at ${BASH_SOURCE[0]}:${LINENO}: ${BASH_COMMAND}" >&2' ERR

# Define Kiwami locations
export KIWAMI_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export KIWAMI_INSTALL="$KIWAMI_PATH/install"
export PATH="$KIWAMI_PATH/bin:$PATH"

run_step() {
  local step="$1"

  echo "--- Running ${step} ---"
  bash "$KIWAMI_INSTALL/${step}"
}

# Install
run_step 00-preflight.sh
run_step 10-aur-helper.sh
run_step 15-packages.sh
run_step 16-aur-packages.sh
run_step 20-config.sh
run_step 30-network.sh
run_step 31-firewall.sh
run_step 40-nvidia.sh
run_step 41-vulkan.sh
run_step 42-vaapi.sh
run_step 50-display-manager.sh
run_step 51-usb-autosuspend.sh
run_step 60-theme.sh
run_step 61-applications.sh
run_step 62-mimetypes.sh
run_step 90-finish.sh
