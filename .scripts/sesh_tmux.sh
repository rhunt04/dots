#!/bin/sh

# RJH: a script for managing a persistent tmux session.

# Supposed to be executed as terminal startup command: when it is, if a session
# called ${session} exists, we attach to it. Else, we create it.

# Catting the wal sequences is a colour fix for a terminal bug I experience,
# but am yet to get around to investigating (life, right?).

session="le_sesh"

# Can we find my config file? If so, add it to tmux launch cmd.
tm="tmux"
tmc="${HOME}/.config/tmux/.tmux.conf"
[ -f "${tmc}" ] && tm="tmux -f ${tmc}"

# Set colours regardless of attaching or creating the session.
wseq="${HOME}/.cache/wal/sequences"
[ -f "${wseq}" ] && cat "${wseq}"

# If a tmux session "the_sesh" exists, attach to it. Otherwise, start it.
if ! ${tm} attach -t "${session}"; then
  # The attach has failed - doesn't exist, let's create it.
  ${tm} new -s "${session}"
fi
