#!/bin/sh
# Dead simple: print battery quickly
echo -n "$(cat /sys/c*s/po*y/B*[0-1]/c*y)% "
