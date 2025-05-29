#!/bin/sh
# Dead simple: print battery quickly
echo -n "$(cat /sys/class/power_supply/BAT0/capacity)% "
