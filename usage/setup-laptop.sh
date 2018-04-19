#!/bin/sh

# LAPTOP SETUP SCRIPT
REPO=~/.config
FILES_LOC=$REPO/usage/files

# SECURE BOOT
# Copy the hook files around
sudo cp $FILES_LOC/99-secureboot.hook /etc/pacman.d/hooks/
sudo cp $FILES_LOC/98-secureltsboot.hook /etc/pacman.d/hooks/
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/vmlinuz-linux /boot/vmlinuz-linux
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/vmlinuz-linux-lts /boot/vmlinuz-linux-lts

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
cd $REPO/nvim/bundle/YouCompleteMe
./install.py --clang-compiler --system-libclang
# Install neovim-remote
pip instal --user neovim-remote

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
