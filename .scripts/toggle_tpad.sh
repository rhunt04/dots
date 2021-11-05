#!/bin/sh

# RJH: simple script for en(dis)abling laptop touchpad. Mine has a tendency to
# misbehave...

whinge() {
  echo "[ Touchpad toggle fail! ]" && exit 1;
}

if ! command -v xinput > /dev/null; then
  echo " [ Need xinput... ]"
  whinge
fi

# Touchpad ID (xinput) and status variables.
# On different machines - these lines may need to be altered!
id=$(xinput list | grep -oP "tm2964-001\s*id=\K([0-9]+)")
st=$(xinput list-props "${id}" | grep -oP "ce Enabled.*:\s*\K([0-9]+)")

[ -z "${id}" ] && whinge;
[ -z "${st}" ] && whinge;

# 'echo' always has exit code 0.
# -> Can use the <command> && echo || <command> one-liner safely here.

if [ "${st}" -eq "1" ] ; then
  # 1 => TP on => toggle will disable
  xinput disable "${id}" && echo "[ Touchpad disabled ]" || whinge;
else
  # 0 => TP off => toggle will enable
  xinput enable "${id}" && echo "[ Touchpad enabled ]" || whinge;
fi
