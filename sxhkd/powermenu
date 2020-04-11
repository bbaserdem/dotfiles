#!/usr/bin/bash

rofi_command="rofi -theme powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend="⏾"
hibernate=""
logout=""

# Variable passed to rofi
options="${shutdown}\n${reboot}\n${lock}\n${suspend}\n${hibernate}\n${logout}"

chosen="$(echo -e "${options}" |
    ${rofi_command} -p "祥  $uptime " -dmenu -selected-row 2)"

case $chosen in
    "${shutdown}")
        if [ -x '/bin/systemctl' ] ; then
            systemctl poweroff
        else
            echo 'Not configured'
        fi
        ;;
    "${reboot}")
        if [ -x '/bin/systemctl' ] ; then
            systemctl reboot
        else
            echo 'Not configured'
        fi
        ;;
    "${hibernate}")
        if [ -x '/bin/systemctl' ] ; then
            systemctl hibernate
        else
            echo 'Not configured'
        fi
        ;;
    "${lock}")
        /usr/bin/xset s activate
        ;;
    "${suspend}")
        mpc -q pause
        if [ -x '/bin/systemctl' ] ; then
            systemctl suspend
        else
            echo 'Not configured'
        fi
        ;;
    "${logout}")
        case "${XDG_CURRENT_DESKTOP}" in
            bspwm) "${XDG_CONFIG_HOME}"/bspwm/exit.sh ;;
            *) echo 'Not configured' ;;
        esac
        ;;
esac
