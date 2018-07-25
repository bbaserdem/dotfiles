#!/usr/bin/sh

case "$1" in
    --open)
        # Launch terminal with newsboat
        $TERMINAL -e newsboat
        ;;
    --check)
        # Count unread
        NEW=$(newsboat -x print-unread | sed 's|\([0-9]*\).*|\1|')
        if [[ -z "$NEW" ]]
        then
            echo "N/A"
        else
            echo $NEW
        fi
        ;;
esac
