#!/bin/bash


# 1. Nvim (NvChad)

# Check if Nvim is installed
if ! command -v nvim &>/dev/null; then
  display_error_and_exit "Nvim is not installed. Please install Nvim first."
fi

# Create backup
if [ -d "$HOME/.config/nvim" ]; then
  # Backup ~/.config/nvim/ directory if it exists
  if [ -d "$HOME/.config/nvim__backup" ]; then
    echo "Backup directory already exists. Skipping backup."
  else
    mv "$HOME/.config/nvim" "$HOME/.config/nvim__backup/" || display_error_and_exit "Failed to create backup."
    echo "Nvim configuration backed up to ~/.config/nvim__backup/"
  fi
fi

# Copy content from ./nvim/ to ~/.config/nvim/
cp -r ./nvim/ "$HOME/.config/" || display_error_and_exit "Failed to copy nvim configuration."


# 2. Tmux

if [ -f "./tmux.conf" ]; then
  # Create backup for ~/.tmux.conf if it exists
  if [ -f "$HOME/.tmux.conf" ]; then
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf__backup" || display_error_and_exit "Failed to create backup for .tmux.conf"
    echo "Tmux configuration backed up to ~/.tmux.conf__backup"
  fi

  # Copy content from ./tmux.conf to ~/.tmux.conf
  cp "./tmux.conf" "$HOME/.tmux.conf" || display_error_and_exit "Failed to copy tmux configuration."
  echo "Tmux configuration applied."
else
  echo "Warning: ./tmux.conf not found. Tmux configuration was not applied."
fi

echo "Apply completed."
