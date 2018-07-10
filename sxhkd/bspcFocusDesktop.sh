#!/usr/bin/sh

monitor_no=$(/usr/bin/bspc query --monitors | wc -l)
echo $(( $monitor_no == 2 ))
echo $monitor_no
if [[ $monitor_no == '2' ]]
then 
    echo true
else 
    echo false 
fi

if [[ $monitor_no == '2' ]]
then
    desktop_cur=$(/usr/bin/bspc query --desktops --desktop focused --names)
    desktop_cur_odd=$(( ($desktop_cur - ( ($desktop_cur +1)%2)+10) %10 ))
    case $1 in
        next)
            desktop_new_odd=$(( ( $desktop_cur_odd + 2 ) % 10 ))
        ;;
        prev)
            desktop_new_odd=$(( ( $desktop_cur_odd + 8 ) % 10 ))
            ;;
    esac
    desktop_new_even=$(( ( $desktop_new_odd + 1 ) % 10 ))
    bspc desktop --focus $desktop_new_odd
    bspc desktop --focus $desktop_new_even
else
    bspc desktop --focus $1
fi
