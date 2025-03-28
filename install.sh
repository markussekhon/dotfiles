#!/usr/bin/env bash

# Variables
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

install_package(){
	echo "Installing packages..."
	sudo apt update
	sudo apt install -y i3 dmenu alacritty neovim
}

setup_dotfiles(){
	echo "Moving dotfiles..."
	mkdir -p "$CONFIG_DIR/i3"
	mkdir -p "$CONFIG_DIR/i3status"
	mkdir -p "$CONFIG_DIR/alacritty"
	mkdir -p "$CONFIG_DIR/nvim"

	echo "Moving i3 dotfiles..."
	ln -sf "$DOTFILES_DIR/.config/i3/config" "$CONFIG_DIR/i3/config"

	echo "Moving i3bar dotfiles..."
	ln -sf "$DOTFILES_DIR/.config/i3status/config" "$CONFIG_DIR/i3status/config"
	ln -sf "$DOTFILES_DIR/.config/i3status/small" "$CONFIG_DIR/i3status/small"
	
	echo "Moving alacritty dotfiles..."
	ln -sf "$DOTFILES_DIR/.config/alacritty/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"

	echo "Moving nvim dotfiles..."
	ln -sf "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR/nvim"
}

reload_i3() {
	if pgrep i3 > /dev/null; then
		echo "Reloading i3..."
		i3-msg reload
		i3-msg restart
	fi
}

# Main
setup_dotfiles
install_packages
reload_i3
