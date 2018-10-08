#!/bin/bash

set -e -u

# Locale
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Timezone
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

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

# Enable lightdm and auto-login
systemctl enable lightdm.service
sed -i 's|^greeter-session = .*|greeter-session = lightdm-webkit2-greeter|g' /etc/lightdm/lightdm.conf
echo '
[branding]
background_images = /usr/share/lightdm-webkit/themes/lightdm-webkit-theme-aether/src/img/wallpapers/
logo              = /usr/share/lightdm-webkit/themes/lightdm-webkit-theme-aether/src/img/arch-logo.png
user_image        = /usr/share/lightdm-webkit/themes/lightdm-webkit-theme-aether/src/img/default-user.png
' >> /etc/lightdm/lightdm-webkit2-greeter.conf

# Create arch user
useradd --create-home --groups wheel --shell /usr/bin/zsh archiso

# Do passwords
echo    "root:iusearchbtw" | chpasswd
echo "archiso:iusearchbtw" | chpasswd

# Enable NetworkManager services (LET ARCH USER SET NETWORKS)
systemctl enable NetworkManager.service
