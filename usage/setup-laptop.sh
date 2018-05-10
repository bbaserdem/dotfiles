#!/bin/sh

# Go to home directory
cd ~

# ETC OPTIONS
sudo cp -R ~/.config/usage/etc/* /etc

# APPLICATIONS
mkdir -p ~/.local/share
ln -s $XDG_CONFIG_HOME/applications ~/.local/share/applications
sudo pacman -S - < ~/.config/usage/pkg-laptop
# Enable multi core compilation for AUR packages
sudo sed "\$iMAKEFLAGS=\"-j\$(nproc)\"" /etc/makepkg.conf
cd /tmp
git clone https://aur.archlinux.org/trizen.git
sudo sed -i '/# Misc options/aILoveCandy' /etc/pacman.conf
cd trizen
makepkg -si
cd ~
trizen -S - < ~/.config/usage/pkgaur-laptop

# TIMEZONE
sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
sudo timedatectl set-ntp true

# VPN
echo "$(pass PIA | grep uname | head -n 1 | sed 's|\(uname: \)\(.*\)|\2|g')\n$(pass PIA | head -n 1)" | sudo tee /etc/private-internet-access/login.conf
sudo chmod 0600 /etc/private-internet-access/login.conf
sudo chown root:root /etc/private-internet-access/login.conf
sudo pia -a

# Backlight
# Add user to video
sudo groupadd video
sudo gpasswd --add $USER video

# Bluetooth
# Add user to lp
sudo groupadd lp
sudo gpasswd --add $USER lp
# Enable bluetooth
sudo systemctl enable bluetooth.service

# REFIND
# Copy configs
sudo cp -R ~/.config/usage/boot/* /boot
# Install while signing
sudo refind-install --localkeys
# Add pacman hook for future updates
sudo cp $FILES_LOC/refind.hook /etc/pacman.d/hooks/

# NEOVIM
# Install python versions
pip install --user neovim
pip2 install --user neovim
# Clone over Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/,config/nvim/bundle/Vundle.vim
# Install plugins
nvim +PluginInstall +qall
# Compile YCM
~/.config/nvim/bundle/YouCompleteMe/install.py --clang-compiler --system-libclang
# Install neovim-remote
pip install --user neovim-remote

# ZIM
# Install powerlevel9k
sudo git clone https://github.com/bhilburn/powerlevel9k.git /usr/lib/zim/modules/prompt/external-themes/powerlevel9k
sudo ln -s /usr/lib/zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme /usr/lib/zim/modules/prompt/functions/prompt_powerlevel9k_setup

# FONTS
# Uncomment the en.US line
sudo sed -i '/en_US\.UTF-8 UTF-8/s/^#//' /etc/locale.gen
sudo locale-gen
sudo localectl set-locale LANG=en_US.UTF-8

# BROWSER
# Enable spellcheck
sudo python /usr/share/qutebrowser/scripts/dictcli.py install en-US

# KERNEL
# Remove default presets
sudo mkdir -p /boot/EFI/Arch
sudo rm /etc/mkinitcpio.d/linux*
sudo cp $FILES_LOC/linux* /etc/mkinitcpio.d/
sudo mv /boot/vmlinuz* /boot/EFI/Arch/
sudo mv /boot/initramfs* /boot/EFI/Arch/
# Sign kernels
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/EFI/Arch/vmlinuz-linux /boot/EFI/Arch/vmlinuz-linux
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/EFI/Arch/vmlinuz-linux-lts /boot/EFI/Arch/vmlinuz-linux-lts
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/EFI/Arch/vmlinuz-linux-zen /boot/EFI/Arch/vmlinuz-linux-zen
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/EFI/Arch/vmlinuz-linux-hardened /boot/EFI/Arch/vmlinuz-linux-hardened
# Copy the hook files around
sudo cp $FILES_LOC/99-secureboot.hook /etc/pacman.d/hooks/
sudo cp $FILES_LOC/98-secureltsboot.hook /etc/pacman.d/hooks/
sudo cp $FILES_LOC/97-securehardenedboot.hook /etc/pacman.d/hooks/
sudo cp $FILES_LOC/96-securezenboot.hook /etc/pacman.d/hooks/
sudo cp $FILES_LOC/95-securecustomboot.hook /etc/pacman.d/hooks/

# TLP
sudo sed -i -e '/SATA_LINKPWR_ON_BAT/s/=".*"/="max_performance"/' /etc/default/tlp

# LOGIN
sudo sed -i '/HoldoffTimeoutSec/s/^#//g' /etc/systemd/logind.conf
sudo sed -i -e '/HoldoffTimeoutSec/s/=.*/=10s/' /etc/systemd/logind.conf

# Create steam and matlab folder
sudo mkdir /opt/{Steam,Matlab}
sudo chown $USER:$USER /opt/*
