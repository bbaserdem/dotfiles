#!/bin/sh

# ETC OPTIONS
echo "Adding files to /etc . . ."
sudo cp -R ~/.config/usage/Debian-etc/* /etc

# Update GRUB
echo "Updating grub . . ."
sudo update-grub

# Installing software
echo "Installing software . . ."
sudo apt update
sudo apt install $(grep -vE "^\s*#" ~/.config/usage/work-packagelist.txt | tr "\n" " ")

# Enable ssh
echo "Enabling SSH . . ."
sudo systemctl enable ssh
sudo systemctl start ssh

# NEOVIM
echo "Installing Neovim plugins . . ."
# Install python versions
pip install --user neovim
pip3 install --user neovim
# Clone over Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
# Install plugins
nvim +PluginInstall +qall
# Compile YCM
~/.config/nvim/bundle/YouCompleteMe/install.py --clang-compiler --system-libclang
# Install neovim-remote
pip install --user neovim-remote

# Set up Flatpak
echo "Setting up flatpak . . ."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "Installing Neovim-GTK . . ."
flatpak install flathub org.gnome.Platform//3.24
flatpak install nvim-gtk_x86_64.flatpak

# Install ZIM
echo "Installing ZIM . . ."
git clone --recursive https://github.com/zimfw/zimfw ~/.config/zsh/zimfw
# Install powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k
ln -s ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme ~/.config/zsh/zimfw/modules/prompt/functions/prompt_powerlevel9k_setup

# Install Nerdfonts
echo "Installing Nerdfonts"
cd /tmp
git clone https://github.com/ryanoasis/nerd-fonts.git nerdfont
cd nerdfont
./install.sh FiraCode FiraMono

# Installing Gohufont
echo "Installing Gohufont . . ."
cd /tmp
wget -q http://font.gohu.org/gohufont-2.0.tar.gz
tar xzf gohufont-2.0.tar.gz
cd gohufont-2.0
gunzip -f *.gz
sudo mv *.pcf /usr/share/fonts
sudo xset fp+ /usr/share/fonts

# Installing Iosevka
echo "Installing Iosevka . . ."
cd /tmp
wget -q https://github.com/be5invis/Iosevka/releases/download/v1.14.3/01-iosevka-1.14.3.zip
mkdir ~/.local/share/fonts/Iosevka
unzip 01-iosevka-1.14.3.zip -d ~/.local/share/fonts/Iosevka

fc-cache -f

# Installing rofi-pass
echo "Installing rofi-pass . . ."
cd /tmp
git clone https://github.com/carnager/rofi-pass.git rofi-pass
cd rofi-pass
export DESTDIR="$HOME"
export PREFIX="/.local"
make install

# Install nvidia
echo "Installing NVIDIA driver . . ."
sudo apt install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') nvidia-legacy-340xx-driver nvidia-xconfig
sudo nvidia-xconfig

