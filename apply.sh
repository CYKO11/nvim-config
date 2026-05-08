#!/bin/bash

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

apply_one() {
    local name="$1"
    local src="$REPO_DIR/config/$name"
    local dst="$CONFIG_DIR/$name"

    if [ ! -d "$src" ]; then
        echo "Error: $src does not exist"
        exit 1
    fi

    if [ -e "$dst" ]; then
        local backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
        echo "Backing up existing $name config to $backup"
        mv "$dst" "$backup"
    fi

    echo "Installing $name configuration..."
    mkdir -p "$CONFIG_DIR"
    cp -r "$src" "$dst"
}

case "${1:-}" in
    "")
        apply_one nvim
        apply_one tmux
        apply_one kitty
        ;;
    nvim|tmux|kitty)
        apply_one "$1"
        ;;
    *)
        echo "Usage: $0 [nvim|tmux|kitty]"
        exit 1
        ;;
esac

echo "Done."
