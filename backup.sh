#! /bin/bash

FILENAME=".git-prompt.sh"

cp ~/.alacritty.toml .alacritty.toml
cp ~/.bashrc .bashrc
cp ~/.bash_profile .bash_profile
cp ~/.tmux.conf .tmux.conf
cp ~/.vimrc .vimrc


if test -f "$FILENAME"; then 
	echo "GIT PROMPT FILE ALREADY EXISTS"
else 
	echo "MISSING FILE"
	cp ~/.git-prompt.sh .git-prompt.sh
fi
