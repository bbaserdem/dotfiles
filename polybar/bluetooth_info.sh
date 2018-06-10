#!/bin/sh
if [ "$(systemctl is-active bluetooth.service)" = "active" ]; then
	echo "%{F${PB_INDG}}%{F-}"
else
	echo "%{F${PB_MUTE}}%{F-}"
fi
