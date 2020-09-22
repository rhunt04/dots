#!/bin/bash

# RJH: Fri 15 Jun 2018 14:08:58 BST

sc="${HOME}/.cache/wal/colors.sh"
[ -s "${sc}" ] && source "${sc}"

rofi -show run -location 5 -padding 10 -width 500 \
  -yoffset -30 -xoffset -30 \
  -font "Fira Code 12" -separator-style none \
  -line-margin 0 -lines 6 -hide-scrollbar -disable-history \
  -display-run "$ Run" -sort -levenshtein-sort -bw 2 \
  -color-window "$background, $foreground, $color0" \
  -color-normal "$background, $foreground, $background, $background, $color4" \
  -color-active "$background, $background, $background, $background, $color4"
