#!/bin/sh
if [ "$(pgrep openvpn)" ]
then
    echo "PIA"
elif [ "$(pgrep openconnect)" ]; then
    echo "CSHL"
else
    echo ""
fi
