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

devStr="Logitech USB Trackball"

# Only run the important commands if mouse detected
if xinput list | grep -lq "${devStr}"; then

  xinput set-prop "${devStr}" "libinput Accel Speed" 1
  xinput set-int-prop "${devStr}" "Evdev Wheel Emulation" 8 1
  xinput set-int-prop "${devStr}" "Evdev Wheel Emulation Button" 8 8

  # remap the old back key to regular middle click
  xinput set-button-map "${devStr}" 1 2 3 4 5 6 7 2 9

else

  echo "Mouse not found"
  exit 1

fi

exit 0
