#!/bin/sh

# RJH - 27.12.16 : This little script enables sane scrolling on a Logitech
# trackman marble mouse. Below the trackball on this mouse, there are 4 buttons
# in a row. They are as follows:
# ----------------------------------------------------------------------------
#    1(L-click)  |  2*(browser back?) |  3*(browser forward?) |  4(R-click).
# (xinput listing below)
#    B1          |  B8                |  B9                   |  B3
# * these buttons are small, and are centrally located.
# ----------------------------------------------------------------------------
# After execution of this script, button 2 will allow the marble to scroll when
# it is held. The acceleration will also be maxed.

mouse="Logitech USB Trackball"

# NB: Could get ID and do with that
# mouseID=$(xinput list --id-only "${mouse}")
# But no need..

# Only run the important commands if mouse detected
if xinput list | grep -lq "${mouse}"; then

  xinput set-prop "${mouse}" "libinput Accel Speed" 1
  xinput set-int-prop "${mouse}" "Evdev Wheel Emulation" 8 1
  xinput set-int-prop "${mouse}" "Evdev Wheel Emulation Button" 8 8

  # remap the old back key to regular middle click
  xinput set-button-map "${mouse}" 1 2 3 4 5 6 7 2 9

else

  echo "Mouse ${mouse} not found."
  exit 1

fi


# NB: xorg conf entry for making this automatic (in Debian-based distros I use) is below.
# Named "50-marblemouse.conf" @ /usr/share/X11/xorg.conf.d on ega.
#
# FILE START:
#
# Section "InputClass"
#     Identifier   "Marble Mouse"
#     MatchProduct "Logitech USB Trackball"
#     Driver       "libinput"
#     Option       "ScrollMethod"          "button"
#     Option       "ScrollButton"          "8"
#     Option       "ButtonMapping"         "1 8 3 4 5 6 7 2 9"
# EndSection
