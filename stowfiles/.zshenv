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

# Polybar colors
export PB_BKGR="#1B1918" # Black
export PB_FRGR="#A8A19F" # White
export PB_MUTE="#766E6B" # Gray
export PB_CRMS="#F22C40" # Red
export PB_GREN="#5AB738" # Green
export PB_ORNG="#D5911A" # Orange
export PB_INDG="#407EE7" # Indigo
export PB_VIOL="#AE81FF" # Violet
export PB_CYAN="#00AD9C" # Cyan
export PB_TIME="%{F${PB_VIOL}}%{F-}%time%"
export PB_DATE="%{F${PB_VIOL}}%{F-}%date%"
export PB_MPDA="%{u${PB_CRMS} +u}%{F${PB_CRMS}}%{F-} <label-song> <bar-progress> <label-time> <icon-prev> <toggle> <icon-next> <icon-random>%{u-}"
export PB_MPDI="%{u${PB_CRMS} +u}%{F${PB_CRMS}}%{F-} %{F${PB_MUTE}}%{F- u-}"
export PB_ETHC="%local_ip% %{F${PB_GREN}}%{F-} %linkspeed% %{F${PB_GREN}}%{F-} %upspeed% %{F${PB_GREN}}%{F-} %downspeed%"
export PB_WIFI="%essid% %{F${PB_GREN}}%{F-} %signal%% %{F${PB_GREN}} %{F-} %upspeed% %{F${PB_GREN}}%{F-} %downspeed% %{F${PB_GREN}}%{F-} %local_ip%"
export PB_NOFI="%{F${PB_MUTE}}%{F-}"
export PB_BCKL="%{u${PB_INDG} +u}%{F${PB_INDG}} %{F-}<label>%{u-}"
