# rjh .bashrc file

[[ $- != *i* ]] && return

# if a file exists, source it
ifThenSource() {
  # shellcheck disable=SC1090
  [ -s "$1" ] && . "$1"
}
ifThenPath() { [ -d "$1" ] && export PATH="$1:$PATH"; }

ifThenSource ~/.bin/.bash_aliases
ifThenSource ~/.bin/.bash_functions
ifThenSource ~/.bin/.machine_specifics
ifThenSource /usr/share/bash-completion/bash_completion
ifThenSource /usr/share/doc/fzf/examples/key-bindings.bash

ifThenPath ~/.bin
ifThenPath ~/.scripts
ifThenPath ~/.local/bin

# bash binds
bind TAB:menu-complete
bind -x '"\e[A": __fzf_history__'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind '"\e[B": history-search-forward'

# disable bash default C-S search (it's crap...)
bind -r '\C-s'
# turn off xon/xoff toggle.
stty -ixon

# shopts (check activity swith `shopt -p`)
shopt -s autocd
shopt -s checkjobs
shopt -s histappend

export EDITOR=/usr/local/bin/vim
export HISTCONTROL=ignoreboth:erasedups
export LESSHISTFILE=~/.local/.less_history
export FZF_DEFAULT_OPTS="--border='double' --color 'fg+:2,bg+:-1'"

# PS1
git_ps1() { bn=$(git symbolic-ref --short -q HEAD 2>/dev/null) &&
  echo -e "-[\e[32;1m${bn}\e[0m]"; }
export PS1=$'[\[\e[35;1m\w\e[0m\]]$(git_ps1)\n $ '
PROMPT_DIRTRIM=4

# NVM
export NVM_DIR="${HOME}/.nvm"
ifThenSource "${NVM_DIR}"/nvm.sh
ifThenSource "${NVM_DIR}"/bash_completion

# Rust
ifThenSource "~/.cargo/env"
