#!/bin/sh

_dir="/etc/private-internet-access"
[ ! -d "${_dir}" ] && sudo mkdir -p "${_dir}"

echo "$(pass PIA|grep 'username:'|awk '{print $2}')" | sudo tee "${_dir}/login.conf"
echo "$(pass PIA | head -n 1)" | sudo tee -a "${_dir}/login.conf"

sudo chown root:root "${_dir}/login.conf"
sudo chmod 0600 "${_dir}/login.conf"

echo '[pia]
openvpn_auto_login = True

[configure]
hosts = US East, US West, Japan, UK London, UK Southampton, Turkey' | sudo tee "${_dir}/pia.conf"

sudo pia --auto-configure
