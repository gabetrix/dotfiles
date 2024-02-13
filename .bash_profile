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
 
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kaostrix/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kaostrix/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kaostrix/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kaostrix/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
