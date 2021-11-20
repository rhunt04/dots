#!/bin/bash
# Ryan's bash aliases file.

alias q='htop'
alias top='htop'
alias ls='ls --color=auto'
alias diff='diff -y --suppress-common-lines --color=always'
alias ll='ls -l'
alias lla='ll -a'
alias grep='grep --color=auto'
alias icat="kitty +kitten icat"
alias sizes='du -sh * | sort -rh'
alias update='sudo apt-fast update && sudo apt-fast upgrade'
alias sudo='sudo -p "$(tput setaf 3)[sudo] pwd → $(tput sgr0)"'

# stupid tmux...
alias tmux="tmux -f ~/.config/tmux/.tmux.conf"
# stupid xclip...
alias xclip="xclip -selection c"

# Git
alias gbl='git branch --list'

# Editing configs
# alias vim='nvim'
alias vv='vim ~/.vimrc'
alias vb='vim ~/.bashrc'
alias vba='vim ~/.bin/.bash_aliases'
alias vn='vim ~/.config/nvim/init.vim'
alias vbf='vim ~/.bin/.bash_functions'
alias bc='bc -q -l ~/.bin/.bc_extensions'
alias ius='ssh -X -i ~/.ssh/id_ecdsa -4 huntr3@ius.lancs.ac.uk'
alias hec='ius -t "ssh -X huntr3@wayland.hec.lancs.ac.uk"'
alias cori='ssh -i ~/.ssh/id_ecdsa huntr3@cori.nersc.gov'
alias archer='ssh -X -i ~/.ssh/id_ecdsa -4 huntr3@login-4c.archer2.ac.uk'

alias config='/usr/bin/git --git-dir=$HOME/.rjh/ --work-tree=$HOME'
