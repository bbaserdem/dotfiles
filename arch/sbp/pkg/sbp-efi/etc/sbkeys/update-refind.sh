#!/bin/sh

# REFIND install/update script
_esp="/efi"
_src="/usr/share/refind"
_tgt="${_esp}/EFI/rEFInd"

# Create directory if doesn't exist!
mkdir -p "${_tgt}"

# Copy over artwork
rm -rf "${_tgt}/images"
cp -r  "${_src}/images" "${_tgt}"
rm -rf "${_tgt}/icons"
cp -r  "${_src}/icons" "${_tgt}"
rm -rf "${_tgt}/fonts"
cp -r  "${_src}/fonts" "${_tgt}"

# Copy over theme files for the regula theme
git clone https://github.com/bobafetthotmail/refind-theme-regular.git /tmp/refind-theme
if [ -e "/tmp/refind-theme/icons" ] ; then
    [ -e "${_tgt}/regular-icons" ] && rm -rf "${_tgt}/regular-icons"
    cp -r "/tmp/refind-theme/icons" "${_tgt}/regular-icons"
fi
if [ -e "/tmp/refind-theme/fonts" ] ; then
    [ -e "${_tgt}/regular-fonts" ] && rm -rf "${_tgt}/regular-fonts"
    cp -r "/tmp/refind-theme/fonts" "${_tgt}/regular-fonts"
fi
rm -rf /tmp/refind-theme

# Copy the executable here, and sign it
cp "${_src}/refind_x64.efi" "${_tgt}/"
if [ -x /etc/sbkeys/sbsign.sh ] ; then
    /etc/sbkeys/sbsign.sh "${_src}/refind_x64.efi"
fi
