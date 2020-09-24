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
        usage "unhandled flag: '${1}'."
        exit 1;;

    esac;

    shift;

  done
}
handleArgs "${@}"

[[ -z $RUN && -z $WIN ]] && { echo "Not doing anything (neither)"; exit 1; }
[[ ! -z $RUN && ! -z $WIN ]] && { echo "Not doing anything (both)"; exit 1; }

sc="${HOME}/.cache/wal/colors.sh"
[ -s "${sc}" ] && source "${sc}"

cmd="rofi -show"
if [ ! -z "$RUN" ]; then

  #echo "FILLING WITH RUN"
  cmd+=" run -location 6 -width 500 -yoffset -30 -lines 6"
  cmd+=" -display-run \"$ Run\""

elif [ ! -z "$WIN" ]; then

  #echo "FILLING WITH WIN"
  wins=$(xlsclients -a | wc -l)
  cmd+=" window -location 2 -width 1000 -yoffset 30 -show-icons -lines $wins"
  cmd+=" -display-window \"$ Window\""

fi

# Colours, and misc identical conf.
conf=" -padding 10 -font \"Fira Code 12\" -separator-style none -line-margin 0"
conf+=" -hide-scrollbar -disable-history -sort -levenshtein-sort -bw 2"
conf+=" -color-window \"$background, $foreground, $color0\""
conf+=" -color-normal"
conf+=" \"$background, $foreground, $background, $background, $color4\""
conf+=" -color-active"
conf+=" \"$background, $background, $background, $background, $color4\""

cmd+=$conf
eval "$cmd"
