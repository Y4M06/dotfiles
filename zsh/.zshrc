export ZSH="$HOME/.oh-my-zsh"
export VAGRANT_HOME=/run/media/yamo/dev/.Vagrant.d/
export MANPAGER='nvim +Man!'

# Ctrl-T to fuzzy find files and paste into command line
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
# Ctrl-R for better history search
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"
# Alt-C to cd into subdirectories
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

fuzzy-history() {
  local selected_command=$(history -n 1 | fzf --height 40% --reverse --query="$LBUFFER")

  if [ -n "$selected_command" ]; then
    LBUFFER="$selected_command"
  fi

  zle redisplay
}

zle -N fuzzy-history
bindkey "^r" fuzzy-history

ZSH_THEME="zenblue"

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
zstyle ':vcs_info:git:*' formats '%b'

setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

# 256 color (only outside tmux — tmux.conf's default-terminal owns this inside a session)
[[ -z "$TMUX" ]] && export TERM=xterm-256color

plugins=(git)

source $ZSH/oh-my-zsh.sh

zstyle ':omz:update' mode auto

export EDITOR="nvim"
export VISUAL="code"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
eval "$(fnm env --use-on-cd --shell zsh)"

export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagaced

# History — explicit instead of relying on oh-my-zsh's defaults
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

export NPM_GLOBAL="$HOME/.npm-global"
export PATH="$NPM_GLOBAL/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin

export VITE_PORT=9266
export PORT=9266

# Aliases
alias dev='cd /run/media/yamo/dev'
alias storage='cd /run/media/yamo/storage/'
alias edu='cd /run/media/yamo/edu/'
alias grind='cd /run/media/yamo/storage/grind'
alias dotfiles="cd /run/media/yamo/dev/dotfiles"
alias ls='ls -G'
alias flatpak-u="$HOME/scripts/flatpak.sh"
alias cleanup="$HOME/scripts/cleanup.sh"
alias bluetoothRestart="$HOME/scripts/bluetoothRestart.sh"
alias dotsync="git -C /run/media/yamo/dev/dotfiles add . && git -C /run/media/yamo/dev/dotfiles commit -m 'sync' && git -C /run/media/yamo/dev/dotfiles push"
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."
alias yt-dlp="yt-dlp -f - "

# Git Shell Aliases
alias g="git"
alias gs="git status"
alias ga="git add -A ."
alias gc="git commit -m"
alias gcam="git commit -am"
alias gpsh="git push"
alias gpll="git pull"
alias gcout="git checkout"
alias gbr="git branch"

alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'
alias pn=pnpm

# eza replaces ls
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias lt='eza --tree --icons --level=2'

# zoxide replaces cd
eval "$(zoxide init zsh)"
alias cd='z'

# ripgrep / fd
alias grep='rg'
alias find='fd'

# funcs
mkcdir(){
  mkdir -p -- "$1" &&  cd -P -- "$1"
}

cpg++() {
    if [[ -z "$1" ]]; then
        echo "Usage: cpg++ <filename-without-extension>"
        return 1
    fi
    local file="$1"
    g++ -DLOCAL -std=c++17 -Wall -Wshadow -Wconversion -Wformat=2 \
        -fsanitize=address,undefined \
        -o "${file}" "${file}.cpp" && ./"${file}"
}

cpnew() {
    if [[ -z "$1" ]]; then
        echo "Usage: cpnew <filename-without-extension>"
        return 1
    fi
    cp ~/run/media/yamo/dev/cp/ecpc2026/template.cpp "${1}.cpp"
    nvim "${1}.cpp"   # or your editor of choice
}

export PNPM_HOME="/home/yamo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export FFMPEG_PATH=/usr/bin/ffmpeg

# Added by Antigravity CLI installer
export PATH="/home/yamo/.local/bin:$PATH"

# Must come after oh-my-zsh.sh sourcing — its emacs-mode setup resets the
# keymap and silently wipes any bindkey calls made earlier in this file.
clear-terminal() { tput reset; zle redisplay; }
zle -N clear-terminal
bindkey "^g" clear-terminal


# pnpm
export PNPM_HOME="/home/yamo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
