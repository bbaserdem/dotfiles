# Monitors
if [[ $(hostname) == 'sbplaptop' ]]
then
    export MON_0="eDP"
    export BRI_SCR="amdgpu_bl0"
    export BRI_KBD="asus::kbd_backlight"
elif [[ $(hostname) == 'sbpnotebook' ]]
then
    export MON_0="eDP-1"
    export BRI_SCR="intel_backlight"
    export BRI_KBD="asus::kbd_backlight"
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    export MON_0="DVI-I-1"
    export BRI_SCR=""
    export BRI_KBD=""
elif [[ $(hostname) == 'sbpserver' ]]
then
    export MON_0="HDMI-2"
    export BRI_SCR=""
    export BRI_KBD=""
fi
