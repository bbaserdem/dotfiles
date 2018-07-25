#!/bin/sh
if [[ $(hostname) == 'sbplaptop' ]]
then
    cat /sys/class/drm/card0/device/hwmon/hwmon2/temp1_input | sed 's|\(.*\)000|\1°C|'
else
    sensors | grep Core | awk '{print substr($3, 2, length($3)-5)}' | tr "\\n" " " | sed 's/ /°C  /g' | sed 's/  $//'
fi
