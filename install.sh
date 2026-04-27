#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Kiwami locations
export KIWAMI_PATH="$HOME/.local/share/kiwami"
export KIWAMI_INSTALL="$KIWAMI_PATH/install"
export PATH="$KIWAMI_PATH/bin:$PATH"

# Install
source "$KIWAMI_INSTALL/paru.sh"
source "$KIWAMI_INSTALL/packages.sh"
source "$KIWAMI_INSTALL/network.sh"
source "$KIWAMI_INSTALL/firewall.sh"
# source "$KIWAMI_INSTALL/mimetypes.sh"
source "$KIWAMI_INSTALL/nvidia.sh"
source "$KIWAMI_INSTALL/sddm.sh"
source "$KIWAMI_INSTALL/usb-autosuspend.sh"
source "$KIWAMI_INSTALL/vulkan.sh"
source "$KIWAMI_INSTALL/theme.sh"
source "$KIWAMI_INSTALL/gnome-theme.sh"