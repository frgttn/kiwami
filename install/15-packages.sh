#!/bin/bash

set -euo pipefail

# Список официальных пакетов (Pacman)
PACKAGES=(
    alacritty alsa-utils avahi bash-completion bat bluetui brightnessctl btop 
    btrfs-progs chromium cups cups-browsed cups-filters cups-pdf dkms 
    docker docker-buildx docker-compose dust egl-wayland exfatprogs eza 
    fastfetch fcitx5 fcitx5-gtk fcitx5-qt fd ffmpegthumbnailer fontconfig 
    fzf git github-cli gnome-calculator gnome-keyring gnome-themes-extra 
    gpu-screen-recorder grim gst-plugin-pipewire gum gvfs-mtp gvfs-nfs 
    gvfs-smb hypridle hyprland hyprland-guiutils hyprlock hyprpicker 
    hyprsunset imagemagick impala imv inetutils inxi iwd jq kernel-modules-hook 
    kitty kvantum-qt5 lazydocker lazygit less libsecret libyaml libsass 
    libpulse libqalculate libreoffice-fresh libva-intel-driver libva-nvidia-driver 
    limine llvm mako man-db mise mpv nautilus nautilus-python gnome-disk-utility 
    noto-fonts noto-fonts-cjk noto-fonts-emoji nss-mdns neovim pamixer 
    papers pciutils pipewire pipewire-alsa pipewire-jack pipewire-pulse plasma-login-manager 
    playerctl plocate plymouth polkit-gnome power-profiles-daemon python-gobject 
    qt5-wayland qt6-wayland ripgrep sassc satty slurp snapper starship 
    sushi swaybg swayosd system-config-printer tmux ttf-jetbrains-mono-nerd 
    ufw unzip uwsm waybar wget whois wireless-regdb wireplumber wiremix 
    wl-clipboard xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-kde 
    xdg-desktop-portal-hyprland zed zoxide zram-generator
)

echo "--- Updating system ---"
sudo pacman -Syu --noconfirm

echo "--- Install official packages ---"
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

echo "--- Installation of official packages completed! ---"
