#!/usr/bin/bash

_col="$(xgetres i3.lblue)"
_mut="$(xgetres i3.grayd)"

echo "<span color='${_col}'>$(if [ "$(pgrep openvpn)" ]; then echo ""; elif [ "$(pgrep openconnect)" ]; then echo "ﮂ"; else echo "</span><span color='${_mut}'>廬"; fi;)</span>"
