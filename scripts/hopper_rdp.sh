#!/usr/bin/sh

# Get screen dimensions
DIM="$(xrandr | grep \* | awk '{print $1}' | head -n 1)"
XDIM=$(echo \"${DIM}\" | sed 's/\([0-9]\)x[0-9]*/\1/' | bc)
YDIM=$(echo \"${DIM}\" | sed 's/[0-9]*x\([0-9]\)/\1/' | bc)

HEI=$(( ${YDIM} - 2 * ( ${BORDER_GAP} + ${BAR_SIZE} ) ))
WID=$(( ${XDIM} - 2 * ${BORDER_GAP} ))

rdesktop -K -g ${WID}x${HEI} -z -r sound:off -u batu hopper.cshl.edu
