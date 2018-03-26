# Set XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"
# Z directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# SSH agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# GPG public key
export GPGKEY=0B7151C823559DD8A7A04CE36426139E2F4C6CCE
# Password store location
export PASSWORD_STORE_DIR=$XDG_CONFIG_HOME/pass
export PASSWORD_STORE_GIT=$XDG_CONFIG_HOME/pass

# Just MATLAB/Java things
export MATLAB_DIR=/opt/matlab-2017b/
export _JAVA_AWT_WM_NONPARENTING=1
export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
export LD_PRELOAD=/usr/lib/libstdc++.so
export LD_LIBRARY_PATH=/usr/lib/xorg/modules/dri/

# Monitors
export MON_WORK_0="DP-2"
export MON_WORK_1="DVI-I-0"
export MON_HOME_0="eDP-1"
export MON_HOME_1="HDMI-2"


# QT5 theme
export QT_STYLE_OVERRIDE="gtk2"
# Set neovim as editor
export EDITOR=nvim
# Set firefox as browser
export BROWSER=qutebrowser
# Set terminal
export TERM=xterm-termite
export TERMINAL=termite
# Notmuch
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/neomutt/notmuch-config
# OpenFOAM
export FOAM_INST_DIR=/opt/OpenFOAM
# Weechat
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
# Taskwarrior
export TASKRC=$XDG_CONFIG_HOME/taskwarrior/taskrc
export TASKDATA=$XDG_CONFIG_HOME/taskwarrior/
# Rofi-pass
export ROFI_PASS_CONFIG=$XDG_CONFIG_HOME/rofi/rofi-pass.conf
