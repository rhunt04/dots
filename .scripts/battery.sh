#!/bin/sh

src=$(cat /sys/class/power_supply/BAT[0-1]/capacity)

printf "%s%%" "$src"
