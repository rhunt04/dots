# rjh bash aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo -p "$(tput setaf 3)[sudo] pwd → $(tput sgr0)"'

# git
alias gbl='git branch --list'

# editing configs
alias vv='vim ~/.vimrc'
alias vb='vim ~/.bashrc'
alias vba='vim ~/.bash_aliases'
alias vbf='vim ~/.bash_functions'

# bare repo management
alias config='/usr/bin/git --git-dir=$HOME/.rjh/ --work-tree=$HOME'
