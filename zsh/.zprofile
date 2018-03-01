# Import scripts path
if [ -d "$XDG_CONFIG_HOME/scripts" ]; then
    PATH="$XDG_CONFIG_HOME/scripts:$PATH"
fi
# Import .local/bit
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
# Import variables into systemd

systemctl --user import-environment {HOME,XDG_CONFIG_HOME,PATH}

if   [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  1 ]
then
#    exec startx $XDG_CONFIG_HOME/login/i3.sh
#elif [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  2 ]
#then
#    exec startx $XDG_CONFIG_HOME/login/i3.sh
#elif [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  3 ]
#then
#    exec startx $XDG_CONFIG_HOME/login/rdp.sh
#elif [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  4 ]
#then
#    exec startx $XDG_CONFIG_HOME/login/steambigpicture.sh
fi
