#!/bin/bash

# RJH: Fri 15 Jun 2018 14:08:58 BST

handleArgs() {
  # Parse options.
  while [[ "$#" -gt 0 ]]; do

    case $1 in

    -[wW] | --[wW])
      WIN="true"
      ;;

    -[rR] | --[rR])
      RUN="true"
      ;;

    *)
      usage "rofirun: unhandled flag -> '${1}'."
      exit 1
      ;;

    esac

    shift

  done
}
handleArgs "${@}"

[[ -z $RUN && -z $WIN ]] && {
  echo "Error (neither arg supplied)"
  exit 1
}
[[ -n $RUN && -n $WIN ]] && {
  echo "Error (both args supplied)"
  exit 1
}

cmd="rofi -show"
if [ -n "$RUN" ]; then

  cmd+=" drun -location 6 -width 400 -yoffset -30 -lines 5"
  cmd+=" -display-drun \"$ \" -show-icons"

elif [ -n "$WIN" ]; then

  # Count windows - dynamically size the rofi window to hold them.
  cmd+=" window -location 0 -width 400 -show-icons -no-fixed-num-lines"
  cmd+=" -display-window \"$ \" -kb-row-down \"Alt-Tab\" -kb-accept-entry \"!Alt-Tab,!Alt-Alt_L,!Alt_L\""

fi

# Colours, and misc identical conf.
conf=" -padding 10 -font \"JetBrainsMono Nerd Font 12\" -separator-style none"
conf+=" -hide-scrollbar -sort -levenshtein-sort -bw 2"

cmd+=$conf
eval "$cmd"
