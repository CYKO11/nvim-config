#!/bin/bash

# Exit on error
set -e

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Check if neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "Warning: Neovim is not installed. This config requires Neovim."
    echo "Please install Neovim before using this configuration."
fi

# Create backup of existing config if it exists
if [ -d "$HOME/.config/nvim" ]; then
    echo "Creating backup of existing Neovim configuration..."
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%Y%m%d%H%M%S)"
fi

# Clone the repository
echo "Cloning Neovim configuration..."
git clone https://github.com/liam/nvim-config.git /tmp/nvim-config

# Ensure .config directory exists
mkdir -p "$HOME/.config"

# Copy the configuration to .config/nvim
echo "Installing Neovim configuration..."
cp -r /tmp/nvim-config "$HOME/.config/nvim"

# Clean up
rm -rf /tmp/nvim-config

echo "Neovim configuration has been installed successfully!"
echo "Launch Neovim to complete the setup process."