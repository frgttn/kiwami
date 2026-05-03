#!/bin/bash

set -euo pipefail

if ! command -v lspci >/dev/null 2>&1; then
  echo "lspci not found. Install pciutils before running NVIDIA detection." >&2
  exit 1
fi

multilib_enabled() {
  pacman-conf --repo-list | grep -qx multilib
}

NVIDIA="$(lspci | grep -i 'nvidia' || true)"

if [[ -n $NVIDIA ]]; then
  # Check which kernel is installed and set appropriate headers package
  KERNEL_HEADERS="$(pacman -Qqs '^linux(-zen|-lts|-hardened)?$' | head -1)-headers"

  # Turing+ (GTX 16xx, RTX 20xx-50xx, RTX Pro, Quadro RTX, datacenter A/H/T/L series) have GSP firmware
  if echo "$NVIDIA" | grep -qE "GTX 16[0-9]{2}|RTX [2-5][0-9]{3}|RTX PRO [0-9]{4}|Quadro RTX|RTX A[0-9]{4}|A[1-9][0-9]{2}|H[1-9][0-9]{2}|T4|L[0-9]+"; then
    PACKAGES=(nvidia-open-dkms nvidia-utils libva-nvidia-driver)
    LIB32_PACKAGES=(lib32-nvidia-utils)
    GPU_ARCH="turing_plus"
  # Maxwell (GTX 9xx), Pascal (GT/GTX 10xx, Quadro P, MX series), Volta (Titan V, Tesla V100, Quadro GV100) lack GSP
  elif echo "$NVIDIA" | grep -qE "GTX (9[0-9]{2}|10[0-9]{2})|GT 10[0-9]{2}|Quadro [PM][0-9]{3,4}|Quadro GV100|MX *[0-9]+|Titan (X|Xp|V)|Tesla V100"; then
    PACKAGES=(nvidia-580xx-dkms nvidia-580xx-utils)
    LIB32_PACKAGES=(lib32-nvidia-580xx-utils)
    GPU_ARCH="maxwell_pascal_volta"
  fi
  # Bail if no supported GPU
  if [[ -z ${PACKAGES+x} ]]; then
    echo "No compatible driver for your NVIDIA GPU. See: https://wiki.archlinux.org/title/NVIDIA"
    exit 0
  fi

  if multilib_enabled; then
    PACKAGES+=("${LIB32_PACKAGES[@]}")
  else
    echo "--- multilib is disabled; skipping 32-bit NVIDIA packages: ${LIB32_PACKAGES[*]} ---"
  fi

  paru -S --needed --noconfirm "$KERNEL_HEADERS" "${PACKAGES[@]}"

  # Configure modprobe for early KMS
  sudo tee /etc/modprobe.d/nvidia.conf <<EOF >/dev/null
options nvidia_drm modeset=1
EOF

  # Configure mkinitcpio for early loading
  sudo tee /etc/mkinitcpio.conf.d/nvidia.conf <<EOF >/dev/null
MODULES+=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
EOF

  sudo mkinitcpio -P

  HYPR_ENVS="$HOME/.config/hypr/config/envs.conf"
  mkdir -p "$(dirname "$HYPR_ENVS")"

  # Add NVIDIA environment variables based on GPU architecture
  if grep -q "# NVIDIA (managed by Kiwami installer)" "$HYPR_ENVS" 2>/dev/null; then
    echo "--- NVIDIA Hyprland environment block already exists, skipping ---"
  elif [[ $GPU_ARCH = "turing_plus" ]]; then
    # Turing+ (RTX 20xx, GTX 16xx, and newer) with GSP firmware support
    cat >>"$HYPR_ENVS" <<'EOF'

# NVIDIA (managed by Kiwami installer)
# NVIDIA (Turing+ with GSP firmware)
env = NVD_BACKEND,direct
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
EOF
  elif [[ $GPU_ARCH = "maxwell_pascal_volta" ]]; then
    # Maxwell/Pascal/Volta (GTX 9xx/10xx, GT 10xx, Quadro P/M/GV, MX series, Titan X/Xp/V) lack GSP firmware
    cat >>"$HYPR_ENVS" <<'EOF'

# NVIDIA (managed by Kiwami installer)
# NVIDIA (Maxwell/Pascal/Volta without GSP firmware)
env = NVD_BACKEND,egl
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
EOF
  fi
fi
