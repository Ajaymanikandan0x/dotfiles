#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define colors for better readability
GREEN='\033[0;32m'
NC='\033[0m' # No color

echo -e "${GREEN}Starting setup...${NC}"

# 1. Detect if the distro is Arch Linux
if [ -f /etc/arch-release ]; then
    echo -e "${GREEN}Arch Linux detected!${NC}"

    # Update and install base packages
    echo -e "${GREEN}Updating system and installing base packages...${NC}"
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm base-devel git curl wget stow bat fzf yazi \
        btop htop clang neovim ripgrep zoxide trash-cli vnstat zip unzip alacritty kitty

    # Install paru if not already installed
    if ! command -v paru &> /dev/null; then
        echo -e "${GREEN}Installing paru (AUR helper)...${NC}"
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        cd /tmp/paru
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/paru
    fi

    # Install additional AUR packages
    echo -e "${GREEN}Installing AUR packages...${NC}"
    paru -S --noconfirm google-chrome librewolf-bin
else
    echo -e "${GREEN}This script is designed for Arch Linux.${NC}"
    exit 1
fi

# 2. Clone your dotfiles repository
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${GREEN}Cloning dotfiles repository...${NC}"
    git clone https://github.com/Ajaymanikandan0x/dotfiles.git $DOTFILES_DIR
else
    echo -e "${GREEN}Dotfiles repository already exists. Pulling latest changes...${NC}"
    git -C $DOTFILES_DIR pull
fi

# 3. Use stow to apply configurations
echo -e "${GREEN}Applying configurations with stow...${NC}"
cd $DOTFILES_DIR
stow -v nvim mybash starship kitty tmux bat fastfetch

# 4. Final steps
echo -e "${GREEN}Setup completed successfully!${NC}"

