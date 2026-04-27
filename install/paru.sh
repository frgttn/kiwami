#!/bin/bash

set -e

echo "--- Installation of paru ---"

sudo pacman -S --needed --noconfirm base-devel git

BUILD_DIR=$(mktemp -d)
cd "$BUILD_DIR"

echo "--- Cloning paru repository to $BUILD_DIR ---"
git clone https://aur.archlinux.org/paru.git .

makepkg -si --noconfirm

cd ~
rm -rf "$BUILD_DIR"

echo "--- paru installation completed ---"