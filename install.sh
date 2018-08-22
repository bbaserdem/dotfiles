#!/bin/sh
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'

# Configuration installer script

# Add to user groups
sudo usermod -a -G lock sbp

# Place symlinks
echo 'Symlinking...\n'

if [ -e '~/.abcde.conf' ]
then
    ln -s ~/.config/abcde.conf ~/.abcde.conf
fi

if [ -e '~/.gtkrc-2.0' ]
then
    ln -s ~/.config/gtk2rc ~/.gtkrc-2.0
fi

if [ -e '~/.tmux.conf' ]
then
    ln -s ~/.config/tmux.conf ~/.tmux.conf
fi

if [ -e '~/.Xresources' ]
then
    ln -s ~/.config/X11/resources ~/.Xresources
fi

if [ -e '~/.zshenv' ]
then
    ln -s ~/.config/zsh/zshenv ~/.zshenv
fi

if [ -e '~/.mpdscribble' ]
then
    ln -s ~/.config/mpdscribble ~/.mpdscribble
fi

if [ -e '~/.Xinitrc' ]
then
    ln -s ~/.config/X11/initrc ~/.xinitrc
fi

if [ -e '~/.xserverrrc' ]
then
    ln -s ~/.config/X11/serverrc ~/.xserverrc
fi

if [ -e '~/.octaverc' ]
then
    ln -s ~/.config/octave/octaverc ~/.octaverc
fi

if [ -e '~/Documents/MATLAB/startup.m' ]
then
    mkdir -p ~/Documents/MATLAB
    ln -s ~/.config/matlabrc.m ~/Documents/MATLAB/startup.m
fi

if [ -e '~/.local/share/applications' ]
then
    mkdir -p ~/.local/share
    ln -s ~/.config/applications ~/.local/share/applications
fi

read -rsp $'Press any key to continue...\n' -n1 key

# Neovim
echo 'Setting up neovim...'
pip install --user neovim
pip install --user neovim-remote
pip2 install --user neovim
if [ -d '~/.config/nvim/bundle/Vundle.vim' ]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
    nvim +PluginInstall +qall
fi
~/.config/nvim/bundle/YouCompleteMe/install.py --clang-completer --system-libclang
read -rsp $'Press any key to continue...' -n1 key

# ZIM
echo 'Setting up ZIM...\n'
git clone --recursive https://github.com/zimfw/zimfw ~/.config/zsh/zimfw
git clone https://github.com/bhilburn/powerlevel9k.git ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k
ln -s ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme ~/.config/zsh/zimfw/modules/prompt/functions/prompt_powerlevel9k_setup
read -rsp $'Press any key to continue...' -n1 key

# Dropbox
echo 'Preventing dropbox auto updates...'
if [ -d ~/.dropbox-dist ]
then
    rm -rf ~/.dropbox-dist
fi
install --mode 0 --directory ~/.dropbox-dist
read -rsp $'Press any key to continue...' -n1 key

# MPD
mkdir -p ~/.cache/mpd

# Nemo
gsettings set org.cinnamon.desktop.default-applications.terminal exec termite
