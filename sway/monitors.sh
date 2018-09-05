#!/usr/bin/sh

# Reloading monitors program, coded for each setup
reload_monitors () {
    # LAPTOP and NOTEBOOK: has eDP-1 (lid) DP-1 and DP-2 ports
    case "$(hostname)" in
        sbplaptop|sbpnotebook)
            # Get names of monitor and the embedded screen
            _lid="$(swaymsg -t output | grep    "eDP")"
            _sta="$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')"
            # If lid is open, screen monitor should be on
            if [ "${_sta}" == 'open' ]
            then
                # If lid is open, screen monitor should be on
                swaymsg output "${_lid}" pos 0 0 res 1920x1080
                _x=1920
            else
                # If lid is closed, turn off the lid screen
                swaymsg output "${_lid}" disable
                _x=0
            fi
            # Set up the rest of the monitors
            for _mon in $(swaymsg -t output | grep -v "eDP")
            do
                # Get resolution here somehow
                _res="1920x1080"
                _xr="$(echo $_res | sed 's|\([0-9]*\)x[0-9]*|\1|g')"
                case $_res in
                    3840x2160) # Scaling by 2 resolutions
                        swaymsg output "${_mon}" scale 2
                        _xr="(( $_xr / 2 ))" ;;
                esac

                swaymsg output "${_lid}" pos "${_x}" 0 res "${_res}"
                _x="(( $_x + $_xr ))"
            done
            ;;
    # WORKSTATION: Monitors are static
    sbpworkstation)
        swaymsg output DVI-I-1  pos    0 0 res 1920x1080
        swaymsg output DP-2     pos 1920 0 res 1920x1080
        ;;
    # DEFAULT: Should be good enough
    *)
        for _mon in $(swaymsg -t output)
        do
            # Get resolution here somehow
            _res="1920x1080"
            _xr="$(echo $_res | sed 's|\([0-9]*\)x[0-9]*|\1|g')"
            case $_res in
                3840x2160) # Scaling by 2 resolutions
                    swaymsg output "${_mon}" scale 2
                    _xr="(( $_xr / 2 ))" ;;
            esac

            swaymsg output "${_lid}" pos "${_x}" 0 res "${_res}"
            _x="(( $_x + $_xr ))"
        done
    esac
}

# Start by performing a monitor setup once
reload_monitors

# Get /proc files to watch with inotifywait
_displays=($(find /sys/class/drm/* -name 'card[0-9]-*' | sed 's|$|/status|'))
[ -z "${_displays}" ] && exit

# Set infinite loop
while :
do
    inotifywait $_displays
    sleep .1
    reload_monitors
done
