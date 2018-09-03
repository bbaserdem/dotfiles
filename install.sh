#!/bin/sh
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'

# Configuration installer script

# Add to user groups
sudo usermod -a -G lock sbp

# Place symlinks
echo 'Symlinking...\n'

[ -e '~/.abcde.conf' ] && rm ~/.abcde.conf
ln -s ~/.config/abcde.conf ~/.abcde.conf

[ -e '~/.bashrc' ] && rm ~/.bashrc
ln -s ~/.config/bash/bashrc ~/.bashrc

[ -e '~/.bash_profile' ] && rm ~/.bash_profile
[ -e '~/.bash_login' ] && rm ~/.bash_login
ln -s ~/.config/bash/login ~/.bash_profile

[ -e '~/.bash_logout' ] && rm ~/.bash_logout
ln -s ~/.config/bash/logout ~/.bash_logout

[ -e '~/.gtkrc-2.0' ] && rm ~/.gtkrc-2.0
ln -s ~/.config/gtk2rc ~/.gtkrc-2.0

[ -e '~/.tmux.conf' ] && rm ~/.tmux.conf
ln -s ~/.config/tmux.conf ~/.tmux.conf

[ -e '~/.zshenv' ] && rm ~/.zshenv
[ -e '~/.zprofile' ] && rm ~/.zprofile
[ -e '~/.zshrc' ] && rm ~/.zshrc
[ -e '~/.zlogin' ] && rm ~/.zlogin
[ -e '~/.zlogout' ] && rm ~/.zlogout
ln -s ~/.config/zsh/zshenv ~/.zshenv

[ -e '~/.xinitrc' ] && rm ~/.xinitrc
[ -e '~/.xserverrrc' ] && rm ~/.xserverrc
[ -e '~/.Xresources' ] && rm ~/.Xresources
ln -s ~/.config/X11/clientrc ~/.xinitrc
ln -s ~/.config/X11/serverrc ~/.xserverrc
ln -s ~/.config/X11/resources ~/.Xresources

[ -e '~/.octaverc' ] && rm ~/.octaverc
ln -s ~/.config/octave/octaverc ~/.octaverc

[ -e '~/Documents/MATLAB/startup.m' ] && rm ~/Documents/MATLAB/startup.m
mkdir -p ~/Documents/MATLAB
ln -s ~/.config/matlabrc.m ~/Documents/MATLAB/startup.m

[ -e '~/.local/share/applications' ] && rm -r ~/.local/share/applications
mkdir -p ~/.local/share
ln -s ~/.config/applications ~/.local/share/applications

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
[ -d ~/.dropbox-dist ] && rm -rf ~/.dropbox-dist
install --mode 0 --directory ~/.dropbox-dist
read -rsp $'Press any key to continue...' -n1 key

# MPD
mkdir -p ~/.cache/mpd
