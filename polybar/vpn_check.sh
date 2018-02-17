#!/bin/sh
if [ "$(pgrep openvpn)" ]; then
    echo "$(nmcli con show --active | grep vpn | head -n1 | awk '{print $1;}')"
elif [ "$(pgrep openconnect)" ]; then
    echo "CSHL"
else
    echo "%{F${PB_MUTE}}N/A%{F-}"
fi
