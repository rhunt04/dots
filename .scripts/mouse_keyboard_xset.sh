#!/bin/sh

# RJH: set mouse and keyboard options.

# These are the pointers I use and configure on startup.
xinput --set-prop 'TPPS/2 IBM TrackPoint' 'libinput Accel Speed' 1
xinput --set-prop 'Logitech USB Trackball' 'libinput Accel Speed' 1
xinput --set-prop 'Synaptics tm2964-001' 'libinput Accel Speed' 1
xinput --set-prop 'PixArt HP USB Optical Mouse' 'libinput Accel Speed' 1

# Tapping to click on touchpad.
xinput --set-prop 'Synaptics tm2964-001' 'libinput Tapping Enabled' 1

# This is the keyboard rate I've gotten used to.
xset r rate 200 100

# This will fix a touchpad scrolling issue after suspend.
# sudo modprobe -r psmouse && sudo modprobe psmouse
