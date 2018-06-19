#!/bin/sh

case "$1" in 
    --done)
        task "$(cat /tmp/tw_polybar_id)" done
        ;;
    --show)
        DSC=$(task rc.verbose: rc.report.next.columns:description  rc.report.next.labels:1 limit:1 next)
        IDN=$(task rc.verbose: rc.report.next.columns:id           rc.report.next.labels:1 limit:1 next)
        DUE=$(task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next)
        echo "${IDN}" > /tmp/tw_polybar_id
        echo "${DSC}"
        ;;
esac
