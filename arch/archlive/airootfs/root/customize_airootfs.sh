#!/bin/bash

set -e -u

# Locale
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Timezone
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Pull in config from repo
mkdir -p /etc/skel
git clone https://github.com/bbaserdem/dotfiles.git /etc/skel/.config

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
useradd --create-home --groups wheel --shell /usr/bin/zsh arch

# Do passwords
echo "root:iusearchbtw" | chpasswd
echo "arch:iusearchbtw" | chpasswd

# Enable NetworkManager services (LET ARCH USER SET NETWORKS)
systemctl enable NetworkManager.service
