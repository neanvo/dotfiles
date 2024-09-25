# OMZ path
export ZSH=$HOME/.oh-my-zsh

if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s workspace
fi
# Theme
ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

# Import
source $HOME/.zshenv
source $ZDOTDIR/.aliases 
source $ZSH/oh-my-zsh.sh

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# FPATH 
fpath=($DOTFILES/zsh/plugins/zsh-completions $fpath)
# Should be called before compinit
zmodload zsh/complist

# Plugins
plugins=(git,zsh-completions)

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# Surrounding
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# +--------+
# | PROMPT |
# +--------+

#fpath=($DOTFILES/zsh/prompt $fpath)
#autoload -Uz gruvbox ; gruvbox 

# +------------+
# |  OPTIONS   |
# +------------+

setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Use cache for commands which use it

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' keep-prefix true
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Autoload colors (for prompt)
##autoload -U colors && colors
# Prompt theme
##[ -f $HOME/.config/zsh/themes/prompt.zsh ] && source $HOME/.config/zsh/themes/prompt.zsh

# vi mode
bindkey -v
# export KEYTIMEOUT=1

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

# Directory stack
#alias d='dirs -v'
#for index ({1..9}) alias "$index"="cd +${index}"; unset index

# macOS vs. Linux
if [[ $(uname) == "Darwin" ]]; then
	ZSH_PLUGINS_DIR="/opt/homebrew/share"
elif [[ $(uname -n) == "lakka" ]]; then
	ZSH_PLUGINS_DIR="$HOME/.local/share"
else
	# i.e. Linux
	ZSH_PLUGINS_DIR="/usr/share/zsh/plugins"
fi

# Syntax highlighting
[ -f "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] &&
	source "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# Autosuggestions
[ -f "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ] &&
	source "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

# If not TMUX session and neofetch is installed, show system info
[ -z "$TMUX" ] && which neofetch 1>/dev/null 2>&1 && echo " " && neofetch

# Zoxide
mkdir -p "$HOME/.cache/zoxide"
_ZO_DATA_DIR="$HOME/.cache/zoxide"
_ZO_RESOLVE_SYMLINKS=1
eval "$(zoxide init zsh)"

# Enable nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add locally installed fzf to path - if found
[ -d "$HOME/.fzf/bin" ] && export PATH="$HOME/.fzf/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# +-----+
# | WSL |
# +-----+

# Check if running in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
  export DISPLAY=$(grep -oP "(?<=nameserver ).+" /etc/resolv.conf):0.0
  export LIBGL_ALWAYS_INDIRECT=1
fi

tmux_sessionizer() {
    ~/.config/tmux/tmux-sessionizer
}

zle -N tmux_sessionizer
bindkey '^F' tmux_sessionizer
