#!/usr/bin/sh

_col="'$(xgetres i3.brown)'"
_file="/tmp/tw_i3blocks_id"
_ico="省"

case $BLOCK_BUTTON in 
    1) $TERMINAL -e task ;;         # Left:  Open taskwarrior in terminal
    3) task "$(cat $_file)" done ;; # Right: Mark task as done
esac

_des=$(TASKDATA="${HOME}/Documents/Tasks/" TASKRC="${HOME}/.config/taskrc" task rc.verbose: rc.report.next.columns:description  rc.report.next.labels:1 limit:1 next)
_idn=$(TASKDATA="${HOME}/Documents/Tasks/" TASKRC="${HOME}/.config/taskrc" task rc.verbose: rc.report.next.columns:id           rc.report.next.labels:1 limit:1 next)
_due=$(TASKDATA="${HOME}/Documents/Tasks/" TASKRC="${HOME}/.config/taskrc" task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next)
echo "${_idn}" > $_file

echo '<span color='"$_col"'>'"$_ico"'</span> '"$_des"
