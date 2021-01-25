#!/bin/sh

# RJH: Take a scrot screenshot, move it to screenshots folder, notify.
# For binding to a WM key.

scrot '%a_%s.png' -e 'mv $f ~/Documents/Screenshots/' &&
  notify-send "Scrot screenshot" "Saved to ~/Documents/Screenshots"
