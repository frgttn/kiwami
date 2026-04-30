#!/bin/bash

ansi_art='
██╗  ██╗██╗██╗    ██╗ █████╗ ███╗   ███╗██╗
██║ ██╔╝██║██║    ██║██╔══██╗████╗ ████║██║
█████╔╝ ██║██║ █╗ ██║███████║██╔████╔██║██║
██╔═██╗ ██║██║███╗██║██╔══██║██║╚██╔╝██║██║
██║  ██╗██║╚███╔███╔╝██║  ██║██║ ╚═╝ ██║██║
╚═╝  ╚═╝╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝'

clear
echo -e "\n$ansi_art\n"

# Use custom branch if instructed, otherwise default to master
KIWAMI_REF="${KIWAMI_REF:-master}"

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified, otherwise default to basecamp/omarchy
KIWAMI_REPO="${KIWAMI_REPO:-frgttn/kiwami}"

echo -e "\nCloning Kiwami from: https://github.com/${KIWAMI_REPO}.git"
rm -rf ~/.local/share/kiwami/
git clone "https://github.com/${KIWAMI_REPO}.git" ~/.local/share/kiwami >/dev/null

echo -e "\e[32mUsing branch: $KIWAMI_REF\e[0m"
cd ~/.local/share/kiwami
git fetch origin "${KIWAMI_REF}" && git checkout "${KIWAMI_REF}"
cd -

echo -e "\nInstallation starting..."
source ~/.local/share/kiwami/install.sh
