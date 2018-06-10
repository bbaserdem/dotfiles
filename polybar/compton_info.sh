#!/bin/sh

case "$1" in
    --toggle)
        if (systemctl is-active --user --quiet compton@${DISPLAY}.service)
        then
            systemctl --user stop  compton@${DISPLAY}.service
        else
            systemctl --user start compton@${DISPLAY}.service
        fi
        ;;
    *)
        if (systemctl is-active --user --quiet compton@${DISPLAY}.service)
        then
            echo "%{F${PB_INDG}}%{F-}"
        else
            echo "%{F${PB_MUTE}}%{F-}"
        fi
        ;;
esac
