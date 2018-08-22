#!/bin/sh
case "$1" in
    --toggle)
        # Toggle offlineimap on or off
        if (systemctl is-active --user --quiet offlineimap.service)
        then
            systemctl --user stop  offlineimap.service
        else
            systemctl --user start offlineimap.service
        fi
        ;;
    *)
        OI_NEW=$(find $HOME/.mail/Gmail/INBOX/new | wc -l)
        if [ "${OI_NEW}" -eq "0" ]
        then
            OI_ICON="%{F${PB_CYAN}}%{F-}"
        else
            OI_ICON="%{F${PB_CYAN}}%{F-}"
        fi

        if (systemctl is-active --user --quiet offlineimap.service)
        then
            echo "${OI_ICON} ${OI_NEW}"
        else
            echo "${OI_ICON} %{F${PB_MUTE}}${OI_NEW}%{F-}"
        fi
        ;;
esac
