# Import .local/bin
if [ -d "$HOME/.local/bin" ]
then
    PATH="$HOME/.local/bin:$PATH"
fi
# import vim-live-latex
if [ -d "$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin" ]
then
    PATH="$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin:$PATH"
fi

# Load environment variables to systemd
for var in $(compgen -e)
do
    systemctl --user import-environment $var
done

# Start things
if   [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  1 ]
then
    # Set cursor theme
    export XDG_CURRENT_DESKTOP="i3"
    systemctl --user import-environment XDG_CURRENT_DESKTOP
    exec startx
fi
