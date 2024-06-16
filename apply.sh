#!/bin/bash
source ./console.sh

WITH_BACKUP=false

read -p "Do you want to backup your local files? (y/N): " CONF
if [[ "$CONF" == "yes" || "$CONF" == "y" ]]; then
    WITH_BACKUP=true
fi

# 1. Nvim (NvChad)
# Check if Nvim is installed
if ! command -v nvim &>/dev/null; then
	display_error_and_exit "Nvim is not installed. Please install Nvim first."
fi

if [ -d "$HOME/.config/nvim/lua/custom" ]; then
  if [ $WITH_BACKUP == true ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_DIR="$HOME/.config/nvim__custom_backup_${TIMESTAMP}"

    mv "$HOME/.config/nvim/lua/custom" "$BACKUP_DIR" || display_error_and_exit "❌ Failed to create backup for nvim."
    echo "Nvim config backed up to $BACKUP_DIR"
  else
    rm -rf "$HOME/.config/nvim/lua/custom" 
  fi

	cp -r ./nvim/ "$HOME/.config/nvim/lua/custom/" || display_error_and_exit "❌ Failed to copy nvim config."
	echo "✅ Nvim patch applied"
else
	display_error_and_exit "⚠️ Error: ~/.config/nvim/lua/custom directory not found."
fi

# 2. Tmux
if [ -f "./.tmux.conf" ]; then
	if [ $WITH_BACKUP == true ]; then
		mv "$HOME/.tmux.conf" "$HOME/.tmux.conf__backup" || display_error_and_exit "Failed to create backup for .tmux.conf"
		echo "Tmux config backed up to ~/.tmux.conf__backup"
  else
    rm -rf "$HOME/.tmux.conf"
	fi

	cp "./.tmux.conf" "$HOME/.tmux.conf" || display_error_and_exit "Failed to copy tmux config."
	echo "✅ Tmux config applied."
else
	display_error_and_exit " ~/.tmux.conf not found."
fi

# 3. Alacritty
if [ -f "./alacritty.toml" ]; then
	if [ $WITH_BACKUP == true ]; then
		mv "$HOME/.config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty__backup.toml" || display_error_and_exit "Failed to create backup for alacritty.toml"
		echo "Alacritty config backed up to $HOME/.config/alacritty/alacritty__backup.toml"
  else
    rm -rf "$HOME/.config/alacritty/alacritty.toml"
	fi

	cp "./alacritty.toml" "$HOME/.config/alacritty/alacritty.toml" || display_error_and_exit "Failed to copy alacritty config."
	echo "✅ Alacritty config applied."
else
	display_error_and_exit " ./alacritty.toml not found."
fi

# 4. Zsh
if [ -d "./zsh" ]; then
	if [ $WITH_BACKUP == true ]; then
		mv "$HOME/.config/zsh/.zshrc"   "$HOME/.config/zsh/.zshrc__backup"   || display_error_and_exit "Failed to create backup for zshrc/.zshrc"
		mv "$HOME/.config/zsh/.aliases" "$HOME/.config/zsh/.aliases__backup" || display_error_and_exit "Failed to create backup for zshrc/.aliases"
		mv "$HOME/.zshenv"              "$HOME/.zshenv__backup"              || display_error_and_exit "Failed to create backup for ~/.zshenv"
		echo "Zsh config backed up to $HOME/.config/zsh"
  else
    rm -rf "$HOME/.config/zsh/.zshrc"
    rm -rf "$HOME/.config/zsh/.aliases"
    rm -rf "$HOME/.zshenv"
	fi

	cp -r "./zsh"     "$HOME/.config" || display_error_and_exit "Failed to copy zsh config."
	cp -r "./.zshenv" "$HOME/.zshenv" || display_error_and_exit "Failed to copy zsh config."
	echo "✅ Zsh config applied."
else
	display_error_and_exit " ./zsh not found."
fi

echo "All patches are applied."
