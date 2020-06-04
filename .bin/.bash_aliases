#!/bin/bash
# Ryan's bash aliases file.

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo -p "$(tput setaf 3)[sudo] pwd → $(tput sgr0)"'
alias update='sudo apt-get update && sudo apt-get upgrade'

# stupid tmux...
alias tmux="tmux -f ~/.config/tmux/.tmux.conf"

# Git
alias gbl='git branch --list'

# Editing configs
alias vv='vim ~/.vimrc'
alias vb='vim ~/.bashrc'
alias vba='vim ~/.bin/.bash_aliases'
alias vbf='vim ~/.bin/.bash_functions'

alias config='/usr/bin/git --git-dir=$HOME/.rjh/ --work-tree=$HOME'