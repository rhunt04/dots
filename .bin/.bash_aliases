#!/bin/bash
# Ryan's bash aliases file.

alias q='btop'
alias top='btop'
alias ls='eza'
alias ll='eza -lh --icons --no-user'
alias lla='ll -a'
alias nb='newsboat'
alias icat='kitten icat'
alias tree='eza -T --icons'
alias grep='grep --color=auto'
alias sizes='du -sh * | sort -rh'
alias lock='mate-screensaver-command -l'
alias bc='bc -q -l ~/.bin/.bc_extensions'
alias cat='batcat --style=full'
alias diff='diff -y --suppress-common-lines --color=always'
alias update='sudo apt-fast update && sudo apt-fast upgrade'
alias sudo='sudo -p "$(tput setaf 3)[sudo] pwd → $(tput sgr0)"'

alias xclip='xclip -selection c' # stupid xclip

# Git
alias gs='git status -sb' # who uses ghostscript ...
alias gc='git commit -a'
alias gl='git log --oneline'
alias gbl='git branch --list -a'

# Terraform
alias tf="terraform"

# Editing configs
# alias vim='nvim'
alias vv='vim ~/.vimrc'
alias vb='vim ~/.bashrc'
alias sb='source ~/.bashrc'
alias va='vim ~/.bin/.bash_aliases'
alias vf='vim ~/.bin/.bash_functions'
alias vn='vim ~/.config/nvim/init.vim'
alias vc='vim -c "if @+ != \"\" | execute \"normal! i\<C-r>+\" | endif"'

alias bc='bc -q -l ~/.bin/.bc_extensions'
alias wget='wget --hsts-file="~/.config/wget-hsts"'
alias config='/usr/bin/git --git-dir=$HOME/.rjh/ --work-tree=$HOME'
