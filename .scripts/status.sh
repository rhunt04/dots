#!/bin/sh

# RJH: I use a really basic tiling window manager in my day-to-day computing.
# This script populates my 'taskbar' with basic information that I need.

while :;do
  echo "[$(cat /sys/c*s/po*y/B*[0-1]/c*y)%] $(date '+[%d/%m] [%H:%M]')";
  sleep 5;
done
