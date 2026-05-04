#!/bin/bash

set -euo pipefail

PACKAGES=(
    alacritty alsa-utils bash-completion bat bluetui brightnessctl btop 
    chromium cups cups-browsed cups-filters cups-pdf dkms 
    docker docker-buildx docker-compose dust exfatprogs eza 
    fastfetch fd ffmpegthumbnailer fontconfig 
    fzf git github-cli gnome-calculator gnome-keyring gnome-themes-extra 
    gpu-screen-recorder grim gst-plugin-pipewire gum gvfs-mtp gvfs-nfs 
    gvfs-smb hypridle hyprland hyprland-guiutils hyprlock hyprpicker 
    hyprsunset imagemagick impala imv inetutils inxi iwd jq kernel-modules-hook 
    kitty kvantum-qt5 lazydocker lazygit less libreoffice-fresh limine llvm ly mako 
    man-db mise mpv nautilus nautilus-python gnome-disk-utility 
    noto-fonts noto-fonts-cjk noto-fonts-emoji nss-mdns neovim pamixer 
    papers pciutils pipewire pipewire-alsa pipewire-jack pipewire-pulse
    playerctl plocate plymouth polkit-gnome power-profiles-daemon
    qt5-wayland qt6-wayland ripgrep sassc satty slurp snapper starship 
    sushi swaybg swayosd tmux ttf-jetbrains-mono-nerd 
    ufw unzip uwsm waybar wget whois wireless-regdb wireplumber wiremix 
    wl-clipboard xdg-desktop-portal xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland zed zoxide
)

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
