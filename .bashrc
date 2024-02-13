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

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias ..="cd .."
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'
alias t='tmux'
alias la='ls -la'
alias ll='ls -l'
alias k='kubectl'
alias v='nvim'
alias repos='cd $HOME/repos/'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"
PROMPT_COMMAND='__git_ps1 "\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\]:\[\e[35m\]\W\[\e[0m\]" " \n$ "'
