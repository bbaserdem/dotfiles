#!/bin/sh
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'

# Configuration installer script

# Add to user groups
sudo usermod -a -G lock sbp

# Place symlinks
echo 'Symlinking...\n'
ln -s ~/.config/abcde.conf ~/.abcde.conf
ln -s ~/.config/gtk2rc ~/.gtkrc-2.0
ln -s ~/.config/tmux.conf ~/.tmux.conf
ln -s ~/.config/Xresources ~/.Xresources
ln -s ~/.config/zsh/zshenv ~/.zshenv
ln -s ~/.config/mpdscribble ~/.mpdscribble
ln -s ~/.config/X11/initrc ~/.Xinitrc
ln -s ~/.config/X11/serverrc ~/.xserverrc
ln -s ~/.config/octave/octaverc ~/.octaverc
mkdir -p ~/.local/share
ln -s ~/.config/applications ~/.local/share/applications
read -rsp $'Press any key to continue...\n' -n1 key

# Neovim
echo 'Setting up neovim...\n'
pip install --user neovim
pip install --user neovim-remote
pip2 install --user neovim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
nvim +PluginInstall +qall
~/.config/nvim/bundle/YouCompleteMe/install.py --clang-completer --system-libclang
read -rsp $'Press any key to continue...\n' -n1 key

# ZIM
echo 'Setting up ZIM...\n'
git clone --recursive https://github.com/zimfw/zimfw ~/.config/zsh/zimfw
git clone https://github.com/bhilburn/powerlevel9k.git ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k
ln -s ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme ~/.config/zsh/zimfw/modules/prompt/functions/prompt_powerlevel9k_setup
read -rsp $'Press any key to continue...\n' -n1 key

# Nemo
gsettings set org.cinnamon.desktop.default-applications.terminal exec termite
