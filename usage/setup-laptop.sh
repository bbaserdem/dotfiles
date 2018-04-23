#!/bin/sh

# LAPTOP SETUP SCRIPT
REPO=~/.config
FILES_LOC=$REPO/usage/files

# APPLICATIONS
mkdir -p ~/.local/share
ln -s $XDG_CONFIG_HOME/applications ~/.local/share/applications

# TIMEZONE
sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
sudo timedatectl set-ntp true
sudo hwclock --systohc

# SWAP
echo 'vm.swappiness=1' | sudo tee /etc/sysctl.d/99-sysctl.conf

# VPN
pass Privacy/pia > /tmp/login.conf
sudo mv /tmp/login.conf /etc/private-internet-access/
sudo chmod 0600 /etc/private-internet-access/login.conf
sudo chown root:root /etc/private-internet-access/login.conf
sudo cp $FILES_LOC/pia.conf /etc/private-internet-access/
sudo pia -a

# Touchpad
sudo cp $FILES_LOC/touchpad.conf /etc/X11/xorg.conf.d/

# Backlight
# Add user to video
sudo groupadd video
sudo gpasswd --add $USER video
# Copy the udev rules that makes the backlight writable
sudo cp $FILES_LOC/backlight.rules /etc/udev/rules.d/

# Bluetooth
# Add user to lp
sudo groupadd lp
sudo gpasswd --add $USER lp
# Enable bluetooth
sudo systemctl enable bluetooth.service
# Enable audio sink
sudo cp $FILES_LOC/audio.conf /etc/bluetooth/

# REFIND
# Install while signing
sudo refind-install --localkeys
# Add pacman hook for future updates
sudo cp $FILES_LOC/refind.hook /etc/pacman.d/hooks/
# Copy over configuration
sudo rm /boot/EFI/refind/refind.conf
sudo cp -r $REPO/refind /boot/EFI/refind

# NEOVIM
# Install python versions
pip install --user neovim
pip2 install --user neovim
# Clone over Vundle
git clone https://github.com/VundleVim/Vundle.vim.git $REPO/nvim/bundle/Vundle.vim
# Install plugins
nvim +PluginInstall +qall
# Compile YCM
$REPO/nvim/bundle/YouCompleteMe/install.py --clang-compiler --system-libclang
# Install neovim-remote
pip install --user neovim-remote

# ZIM
# Install powerlevel9k
sudo git clone https://github.com/bhilburn/powerlevel9k.git /usr/lib/zim/modules/prompt/external-themes/powerlevel9k
sudo ln -s /usr/lib/zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme /usr/lib/zim/modules/prompt/functions/prompt_powerlevel9k_setup

# FONTS
# Uncomment the en.US line
sudo sed -i '/en_US\.UTF-8 UTF-8/s/^#//' /etc/locale.gen
# Generate locale
sudo locale-gen
# Set language
sudo localectl set-locale LANG=en_US.UTF-8
# Fix fc-match
sudo cp $FILES_LOC/69-fixed-bitmaps.conf /etc/fonts/conf.avail/
# Font in TTY
echo 'FONT=ter-powerline-v14n' | sudo tee /etc/vconsole.conf

# BROWSER
# Enable spellcheck
sudo python /usr/share/qutebrowser/scripts/install_dict.py en-US

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


