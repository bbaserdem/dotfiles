#!/usr/bin/sh

_ydf=62
_xdf=0

# Get screen dimensions
_dim="$(xrandr | grep \* | awk '{print $1}' | head -n 1)"
_xdm="$(echo "${_dim}" | sed 's/\([0-9]*\)x[0-9]*/\1/')"
_ydm="$(echo "${_dim}" | sed 's/[0-9]*x\([0-9]*\)/\1/')"
_res="$(( $_xdm - $_xdf ))x$(( $_ydm - $_ydf ))"

_inf="$(pass Hopper)"
_psw="$(echo "${_inf}" | head -n 1)"
_una="$(echo "${_inf}" | grep )"
_srv="$(echo "${_inf}" | grep )"

xfreerdp /u:"${_res}" /size:"${_res}" -grab-keyboard /v:"${_res}"
