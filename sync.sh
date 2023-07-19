#!/bin/bash
source ./console.sh


# 1. Nvim (NvChad)

if [ -d "$HOME/.config/nvim" ]; then
    # Remove ./nvim/ directory if exists
    if [ -d "./nvim" ]; then
        rm -rf ./nvim/
    fi

    # Copy contents from ~/.config/nvim/ to ./nvim/
    cp -r "$HOME/.config/nvim/" ./nvim/ || display_error_and_exit "Failed to copy nvim configuration."
    echo "Sync completed."
else
    echo "Error: ~/.config/nvim/ directory not found. Nvim sync reverted."
fi


# 2. Tmux

if [ -f "$HOME/.tmux.conf" ]; then
    # Remove ./.tmux.conf if exists 
    if [ -f "./.tmux.conf" ]; then
        rm -rf ./.tmux.conf
    fi

    # Copy content from ~/.tmux.conf to ./.tmux.conf
    cp "$HOME/.tmux.conf" "./.tmux.conf" || display_error_and_exit "Failed to copy tmux configuration."
    echo "Tmux sync completed."
else
    echo "Warning: ~/.tmux.conf not found. Tmux configuration was not synced."
fi
