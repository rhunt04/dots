# rjh .bashrc file

case $- in
    *i*) ;;
      *) return;;
esac

export EDITOR='vim'
export VISUAL='vim'

# personal bin directory
[ -d ~/.bin ] && export PATH="$HOME/.bin:$PATH"

# if a file exists, source it
ifThenSource() { [ -s "$1" ] && . "$1" ;}

ifThenSource ~/.bin/.bash_aliases
ifThenSource ~/.bin/.bash_functions
ifThenSource ~/.bin/.machine_specifics

# bash binds
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set show-all-if-unmodified on"
bind '"\e[B": history-search-forward'
bind '"\e[A": history-search-backward'

# shopts
shopt -s autocd
shopt -s extglob
shopt -s cdable_vars

# PS1
git_ps1_branch() {
  bn=$(git symbolic-ref --short -q HEAD 2>/dev/null) &&
  echo -e "-[\e[32;1m$bn\e[0m]"
}

export PS1=$'[\[\e[35;1m\w\e[0m\]]$(git_ps1_branch)\n~> '
PROMPT_DIRTRIM=4

# NVM
export NVM_DIR="$HOME/.nvm"
ifThenSource $NVM_DIR/nvm.sh
ifThenSource $NVM_DIR/bash_completion
