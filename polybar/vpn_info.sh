#!/bin/sh
if [ "$(pgrep openvpn)" ]
then
    echo "PIA"
elif [ "$(pgrep openconnect)" ]; then
    echo "CSHL"
else
    echo "%{F${PB_MUTE}}N/A%{F-}"
fi
