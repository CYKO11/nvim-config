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

apply_gnome() {
    local src="$REPO_DIR/config/gnome/keybindings.dconf"

    if ! command -v dconf >/dev/null 2>&1; then
        echo "Error: dconf not installed — skipping gnome"
        return 1
    fi
    if [ ! -f "$src" ]; then
        echo "Error: $src does not exist"
        exit 1
    fi

    local backup="$REPO_DIR/config/gnome/keybindings.bak.$(date +%Y%m%d%H%M%S).dconf"
    echo "Backing up current GNOME keybindings to $backup"

    dump_section() {
        local path="$1" base="$2"
        dconf dump "$path" | awk -v base="$base" '
            /^\[\/\]$/ { print "[" base "]"; next }
            /^\[.*\]$/ { sub(/^\[/, "[" base "/"); print; next }
            { print }
        '
        echo
    }

    {
        dump_section /org/gnome/desktop/wm/keybindings/        desktop/wm/keybindings
        dump_section /org/gnome/shell/keybindings/             shell/keybindings
        dump_section /org/gnome/mutter/keybindings/            mutter/keybindings
        dump_section /org/gnome/settings-daemon/plugins/media-keys/ settings-daemon/plugins/media-keys
    } > "$backup"

    echo "Loading GNOME keybindings..."
    dconf load /org/gnome/ < "$src"
}

case "${1:-}" in
    "")
        apply_one nvim
        apply_one tmux
        apply_one kitty
        apply_gnome
        ;;
    nvim|tmux|kitty)
        apply_one "$1"
        ;;
    gnome)
        apply_gnome
        ;;
    *)
        echo "Usage: $0 [nvim|tmux|kitty|gnome]"
        exit 1
        ;;
esac

echo "Done."
