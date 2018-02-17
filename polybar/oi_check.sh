#!/bin/sh
case "$1" in
    --toggle)
        # Toggle offlineimap on or off
        if [ "$(pgrep offlineimap)" ]; then
            pkill -f offlineimap
        else
            nohup offlineimap > /tmp/offlineimap.log &
        fi
        ;;
    *)
        OI_NEW=$(find $HOME/.mail/Gmail/INBOX/new | wc -l)
        if [ "${OI_NEW}" -eq "0" ]; then
            OI_ICON="%{F${PB_VIOL}}%{F-}"
        else
            OI_ICON="%{F${PB_VIOL}}%{F-}"
        fi

        if [ "$(pgrep offlineimap)" ]; then
            echo "${OI_ICON} ${OI_NEW}"
        else
            echo "${OI_ICON} %{F${PB_MUTE}}${OI_NEW}%{F-}"
        fi
        ;;
esac
