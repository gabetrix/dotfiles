#!/bin/bash

# Only run on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # needed for brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi
export BASH_SILENCE_DEPRECATION_WARNING=1

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh" 
 
