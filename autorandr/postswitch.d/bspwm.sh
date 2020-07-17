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
    # Refresh the window layout
    if [ -x "${XDG_CONFIG_HOME}/bspwm/scripts/layout.sh" ] ; then
        "${XDG_CONFIG_HOME}/bspwm/scripts/layout.sh"
    fi
    # Launch polybar instances
    if [ -x "${XDG_CONFIG_HOME}/bspwm/scripts/polybars.sh" ] ; then
        "${XDG_CONFIG_HOME}/bspwm/scripts/barlauncher.sh"
    fi
    # Change wallpaper instances
    if [ -x "${XDG_CONFIG_HOME}/bspwm/scripts/wallpaper.sh" ] ; then
        "${XDG_CONFIG_HOME}/bspwm/scripts/wallpaper.sh"
    fi
    # Send notification
    notify-send \
        "Autorandr" \
        "BSPWM: Changed layout to ${AUTORANDR_CURRENT_PROFILE}"\
        --icon=display
fi
