#!/usr/bin/bash

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_cya}"

echo "<span color=${_col}>$(if [ "$(pgrep openvpn)" ]; then echo ""; elif [ "$(pgrep openconnect)" ]; then echo "ﮂ"; else echo "</span><span color=${_mute}>廬"; fi;)</span>" | sed 's|&|&amp;|g'
