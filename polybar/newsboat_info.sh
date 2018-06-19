#!/usr/bin/sh

case "$1" in
    --open)
        # Launch terminal with newsboat
        $TERMINAL -e newsboat
        ;;
    --check)
        # Count unread
        echo $(newsboat -x print-unread | sed 's|\([0-9]*\).*|\1|')
        ;;
esac
