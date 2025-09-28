#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Set to superior editing mode
set -o vi
bind -x '"\C-l":clear'
export REPOS="$HOME/repos"
export GITUSER="gabetrix"
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$HOME/.scripts/"
source ~/.git-prompt.sh
export PY_BIN="$HOME/Library/Python/3.9/bin"
export GO_BIN="/Users/gabriel/go/bin"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
# export JAVA_HOME="/opt/homebrew/Cellar/openjdk/23/libexec/openjdk.jdk/Contents/Home"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/graalvm-jdk-23+37.1/Contents/Home/"
export PATH=$PATH:$PY_BIN:$GO_BIN:$JAVA_HOME
export REGISTRY_AUTH_FILE="$HOME/.config/containers/auth.json"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias ..="cd .."
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'
alias t='tmux'
alias la='ls -la'
alias ll='ls -l'
alias k='kubectl'
alias v='nvim'
alias repos='cd $HOME/repos/'
alias d='podman'
alias tf='tofu'

#  export REGISTRY_AUTH_FILE="~/.config/podman/auth.json"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="autot"
PROMPT_COMMAND='__git_ps1 "\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\$(scutil --get ComputerName 2>/dev/null)\[\e[0m\]:\[\e[35m\]\W\[\e[0m\]" " \n$ "'

# Load Angular CLI autocompletion.
source <(ng completion script)
