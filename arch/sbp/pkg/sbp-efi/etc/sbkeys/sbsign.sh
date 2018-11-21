#!/bin/sh
# Maintained by sbp-efi
_loc="/etc/sbkeys"
_key="${_loc}/DB.key"
_cer="${_loc}/DB.crt"
if [ -e "$_key" ] && [ -e "$_cer" ] ; then
    for _var in "$@" ; do
        /usr/bin/sbsign --key $_key --cert $_cer --output $_var $_var
    done
else
    echo "SB keys not found in ${_loc}"
fi
