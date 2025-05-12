#!/bin/bash

LOGO_DIR="/home/ajay_/dotfiles/fastfetch/.config/fastfetch/logo"

# Find all valid logo files (PNG, JPG, ICO)
RANDOM_LOGO=$(find "$LOGO_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.icon" \) | shuf -n 1)

# Print the path so Fastfetch can use it
echo "$RANDOM_LOGO"

