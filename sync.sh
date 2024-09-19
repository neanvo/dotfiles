#!/bin/bash
source ./console.sh

# 1. Nvim
if [ -d "$HOME/.config/nvim" ]; then
    if [ -d "./nvim" ]; then
        rm -rf ./nvim/
    fi

    cp -r "$HOME/.config/nvim/" ./nvim/ || display_error_and_exit "❌ Failed to copy nvim configuration."
    echo "✅ Nvim"
else
    echo "⚠️ Error: ~/.config/nvim/ directory not found. Nvim sync task is reverted."
fi

# 2. Tmux
if [ -f "$HOME/.tmux.conf" ]; then
    if [ -f "./.tmux.conf" ]; then
        rm -rf ./.tmux.conf
    fi

    cp "$HOME/.tmux.conf" "./.tmux.conf" || display_error_and_exit "❌ Failed to copy tmux configuration."
    echo "✅ Tmux"
else
    echo "⚠️ Error: ~/.tmux.conf not found. Tmux configuration was not synced."
fi

# 3. Alacritty
if [ -d "$HOME/.config/alacritty" ]; then
    if [ -f "./alacritty.toml" ]; then
        rm -rf ./alacritty.toml
    fi

    cp "$HOME/.config/alacritty/alacritty.toml" "./alacritty.toml" || display_error_and_exit "❌ Failed to copy alacritty configuration."
    echo "✅ Alacritty"
else
    echo "⚠️ Error: ~/.config/alacritty not found. Alacritty configuration was not synced."
fi

# 4. Zsh
if [ -d "$HOME/.config/zsh" ]; then
    if [ -f "./zsh/.zshrc" ]; then
        rm -rf ./zsh/.zshrc
    fi
    if [ -f "./zsh/.aliases" ]; then
        rm -rf ./zsh/.aliases
    fi
    if [ -f "./.zshenv" ]; then
        rm -rf ./.zshenv
    fi

    cp "$HOME/.config/zsh/.zshrc"   "./zsh/.zshrc"   || display_error_and_exit "❌ Failed to copy zsh configuration."
    cp "$HOME/.config/zsh/.aliases" "./zsh/.aliases" || display_error_and_exit "❌ Failed to copy zsh configuration."
    cp "$HOME/.zshenv"              "./.zshenv"      || display_error_and_exit "❌ Failed to copy zsh configuration."
    echo "✅ Zsh"
else
    echo "⚠️ Error: ~/.config/zsh not found. Zsh configuration was not synced."
fi

echo "Sync completed!"
