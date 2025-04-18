# rjh .bashrc file

[[ $- != *i* ]] && return

# if a file exists, source it
ifThenSource() {
  # shellcheck disable=SC1090
  [ -s "$1" ] && . "$1" ;
}
ifThenSource ~/.bin/.bash_aliases
ifThenSource ~/.bin/.bash_functions
ifThenSource ~/.bin/.machine_specifics

ifThenPath() { [ -d "$1" ] && export PATH="$1:$PATH" ;}
ifThenPath ~/.bin
#ifThenPath ~/.dotnet
ifThenPath ~/.scripts
ifThenPath ~/.local/bin

# bash binds
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind '"\e[B": history-search-forward'
bind '"\e[A": history-search-backward'
bind TAB:menu-complete

# disable bash default C-S search (it's crap...)
bind -r '\C-s'
stty -ixon

# shopts (check activity swith `shopt -p`)
shopt -s autocd
shopt -s checkjobs
shopt -s histappend

# prevent search annoyance
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="getpass *"

# PS1
git_ps1() { bn=$(git symbolic-ref --short -q HEAD 2>/dev/null) &&
  echo -e "-[\e[32;1m$bn\e[0m]" ;}
export PS1=$'[\[\e[35;1m\w\e[0m\]]$(git_ps1)\n $ '
PROMPT_DIRTRIM=4

# NVM
export NVM_DIR="${HOME}/.nvm"
ifThenSource "${NVM_DIR}"/nvm.sh
ifThenSource "${NVM_DIR}"/bash_completion
