#!/bin/bash

set -e

echo "--- Installation of paru ---"

if command -v paru >/dev/null 2>&1; then
    echo "--- paru is already installed, skipping installation ---"
else
    sudo pacman -S --needed --noconfirm base-devel git

    BUILD_DIR=$(mktemp -d)
    trap 'rm -rf "$BUILD_DIR"' EXIT

    cd "$BUILD_DIR"

    echo "--- Cloning paru repository to $BUILD_DIR ---"
    git clone https://aur.archlinux.org/paru.git .

    makepkg -si --noconfirm

    echo "--- paru installation completed ---"
fi
