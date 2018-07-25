#!/bin/sh

if [[ $(hostname) == 'sbplaptop' ]]
then
    speed=""
    # speed=$(cat /sys/class/drm/card0/device/hwmon/hwmon2/pwm1)
else
    speed=$(sensors | grep "CPU Fan:" | sed -n "s/CPU Fan: *\([0-9]*\) RPM.*/\1/p")
fi
if [ "$speed" != "" ]; then
    speed_round=$(LANG=C printf "%.1fk\\n" "$(echo "$speed/1000" | bc -l )")
    echo "${speed_round}"
else
    echo ""
fi
