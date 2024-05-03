#!/bin/sh

if [ ! -d "$HOME/.config/nvim" ]; then
	mkdir -p "$HOME/.config/nvim"
	echo "Created nvim folder successfully"
fi

stow -d dotfiles/.config nvim -t /home/tarek/.config/nvim
