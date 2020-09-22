#!/bin/sh

# RJH: I use a really basic tiling window manager in my day-to-day computing.
# This script populates my 'taskbar' with basic information that I need.

# Missing items:
# networking: I use nm-applet.
# audio: I use volumeicon.

while true
do
  BAT="[$(cat /sys/class/power_supply/BAT0/capacity)%]"
  DAT=$(date '+[%d/%m] [%H:%M]')
  echo "${BAT} ${DAT}"
  sleep 5;
done
