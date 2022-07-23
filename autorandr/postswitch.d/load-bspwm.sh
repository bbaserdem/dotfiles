#!/bin/dash

# Execute the following if the window manager is bspwm
if [ "${XDG_CURRENT_DESKTOP}" = 'bspwm' ] ; then
    # Select the xrdb file to read
    case "${AUTORANDR_CURRENT_PROFILE}" in
        Homestation-Home|Server)
            xrdb "${XDG_CONFIG_HOME}/X11/uhd.resources"
            ;;
        * )
            xrdb "${XDG_CONFIG_HOME}/X11/resources"
    esac
    
    chill_file="${XDG_CACHE_HOME}/autorandr_chill"
    if [ -f "${chill_file}" ] ; then
        # Bspwm just loaded; don't mess wallpaper or layout, just undo the chill
        rm --force "${chill_file}"
    else
        # Refresh the window layout
        if [ -x "${HOME}/.local/bin/bspwm-layout.sh" ] ; then
            bspwm-layout.sh
        fi
        # Change wallpaper instances
        if [ -x "${HOME}/.local/bin/bspwm-wallpaper.sh" ] ; then
            bspwm-wallpaper.sh
        fi
    fi

    # Launch polybar instances
    if [ -x "${HOME}/.local/bin/bspwm-barlauncher.sh" ] ; then
        bspwm-barlauncher.sh
    fi

    # Send notification
    notify-send \
        "Autorandr" \
        "BSPWM: layout is ${AUTORANDR_CURRENT_PROFILE}"\
        --icon=display
fi
