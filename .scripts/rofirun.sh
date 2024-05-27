#!/bin/bash

# RJH: Fri 15 Jun 2018 14:08:58 BST

handleArgs() {
  # Parse options.
  while [[ "$#" -gt 0 ]]; do

    case $1 in

      -[wW]|--[wW])
        WIN="true";;

      -[rR]|--[rR])
        RUN="true";;

      *)
        usage "rofirun: unhandled flag -> '${1}'."
        exit 1;;

    esac;

    shift;

  done
}
handleArgs "${@}"

[[ -z $RUN && -z $WIN ]] && { echo "Error (neither arg supplied)"; exit 1; }
[[ -n $RUN && -n $WIN ]] && { echo "Error (both args supplied)"; exit 1; }

# Get wal color variables.
sc="${HOME}/.cache/wal/colors.sh"
[ -s "${sc}" ] && source "${sc}"

cmd="rofi -show"
if [ -n "$RUN" ]; then

  #echo "FILLING WITH RUN"
  cmd+=" run -location 6 -width 500 -yoffset -30 -lines 6"
  cmd+=" -display-run \"$ Run\""

elif [ -n "$WIN" ]; then

  #echo "FILLING WITH WIN"
  # Count windows - dynamically size the rofi window to hold them.
  wins=$(xlsclients -a | wc -l)
  cmd+=" window -location 2 -width 1000 -yoffset 30 -show-icons -lines $wins"
  cmd+=" -display-window \"$ Window\""

fi

# Colours, and misc identical conf.
conf=" -padding 10 -font \"Fira Code 12\" -separator-style none -line-margin 0"
conf+=" -hide-scrollbar -disable-history -sort -levenshtein-sort -bw 2"

cmd+=$conf
eval "$cmd"
