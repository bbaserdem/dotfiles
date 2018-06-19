#!/bin/sh
dpi=$(LC_ALL=C xdpyinfo|sed -rn 's/^\s*resolution:\s*(.*) dots per inch$/\1/p')
xrdb -merge <<<"Xft.dpi: ${dpi}"
