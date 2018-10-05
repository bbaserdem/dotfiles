#!/usr/bin/sh

_ydf=20
_xdf=0

if pgrep -x "i3" > /dev/null
then
    _dim="$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).rect | "\(.width)x\(.height)"')"
    echo "Getting i3 geometry... ${_dim}"
elif pgrep -x "sway" > /dev/null
then
    _dim="$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).rect | "\(.width)x\(.height)"')"
    echo "Getting sway geometry... ${_dim}"
elif pgrep -x "Xorg" > /dev/null
then
    _dim="$(xrandr | grep \* | awk '{print $1}' | head -n 1)"
    echo "Using xrandr... ${_dim}"
else
    _dim="1920x1080"
    echo "Using default... ${_dim}"
fi

# Get screen dimensions
_xdm="$(echo "${_dim}" | sed 's/\([0-9]*\)x[0-9]*/\1/')"
_ydm="$(echo "${_dim}" | sed 's/[0-9]*x\([0-9]*\)/\1/')"
_res="$(( $_xdm - $_xdf ))x$(( $_ydm - $_ydf ))"

_inf="$(pass Hopper)"
_psw="$(echo "${_inf}" | head -n 1)"
_una="$(echo "${_inf}" | grep 'username:' | awk '{print $2}')"
_srv="$(echo "${_inf}" | grep 'domain:'   | awk '{print $2}')"
_prt="$(echo "${_inf}" | grep 'port:'     | awk '{print $2}')"

_cmd="xfreerdp /u:${_una} /p:${_psw} /size:${_res} /wm-class:'Hopper-RDP' /title:'' -grab-keyboard -wallpaper -themes /v:${_srv}"
echo "${_cmd}"
"${_cmd}"
