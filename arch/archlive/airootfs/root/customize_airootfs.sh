#!/bin/bash

set -e -u

# Pull in config from repo
mkdir -p /etc/skel
git clone https://github.com/bbaserdem/dotfiles.git /etc/skel/.config
mv /etc/skel/.fonts.conf /etc/skel/.config/fontconfig/fonts.conf

# Switch to zsh
usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

# Some default stuff
sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service
systemctl set-default graphical.target

# Create arch user
[ "$(getent passwd | grep -c '^sbp')" == "1" ] && userdel sbp
useradd --create-home --groups wheel --shell /usr/bin/zsh arch

# Do passwords
echo "root:iusearchbtw" | chpasswd
echo "arch:iusearchbtw" | chpasswd

# Enable NetworkManager services (LET ARCH USER SET NETWORKS)
systemctl disable systemd-networkd.service
systemctl disable systemd-resolved.service
systemctl disable systemd-networkd-wait-online.service
systemctl disable iwd.service
systemctl enable NetworkManager.service
