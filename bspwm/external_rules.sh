#!/usr/bin/sh

wid=$1
class=$2
instance=$3
title="$(xwininfo -id $1 | awk 'NR==2' | sed 's|.*"\(.*\)"$|\1|')"
drop_padding=120
drop_height=420

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

# Dropdown implementation
if [ "$title" = 'dropdown' ] ; then
    width="$(bspc wm --dump-state|jq -r '.monitors[].rectangle.width'|head -n1)"
    height="$(bspc wm --dump-state|jq -r '.monitors[].rectangle.height'|head -n1)"
    drop_width="$((width-drop_padding))"
    x_cor="$((drop_padding/2))"
    y_cor="$((height-drop_height))"
    drop_geom="${drop_width}x${drop_height}+${x_cor}+${y_cor}"
    echo "sticky=on state=floating hidden=on rectangle=${drop_geom}"
# Desktop 1: is communication
elif [ "$class" = 'Skype' ] ; then                  echo "desktop=${ws1}"
elif [ "$class" = 'Rambox' ] ; then                 echo "desktop=${ws1}"
elif [ "$class" = 'Qemu-system-x86_64' ] ; then     echo "desktop=${ws1}"
elif [ "$class" = 'org.remmina.Remmina' ] ; then    echo "desktop=${ws1} state=monocle"
elif [ "$class" = 'Thunar' ] ; then                 echo "desktop=${ws1}"
# Desktop 2: is for internet
elif [ "$class" = 'qutebrowser' ] ; then            echo "desktop=${ws2}"
elif [ "$class" = 'Firefox' ] ; then                echo "desktop=${ws2}"
# Desktop 3: is for terminal
elif [ "$class" = 'Termite' ] ; then        echo "desktop=${ws3}"
elif [ "$class" = 'kitty' ] ; then          echo "desktop=${ws3}"
elif [ "$class" = 'Xfce4-terminal' ] ; then echo "desktop=${ws3}"
elif [ "$class" = 'Konsole' ] ; then        echo "desktop=${ws3}"
# Desktop 4: Science
elif [ echo "$class" | grep -q 'MATLAB' ] ; then    echo "desktop=${ws4} state=monocle"
elif [ "$class" = 'GNU Octave' ] ; then             echo "desktop=${ws4}"
elif [ "$class" = 'Spyder' ] ; then                 echo "desktop=${ws4}"
# Desktop 5: Reading
elif [ "$class" = 'Zathura' ] ; then        echo "desktop=${ws5} state=tiled"
elif [ "$class" = 'Evince' ] ; then         echo "desktop=${ws5}"
# Desktop 6: Writing
elif [ echo "$class" | grep -Eq 'libreoffice*' ] ; then 
    echo "desktop=${ws6} state=tiled"
elif [ "$class" = 'Soffice' ] ; then    echo "desktop=${ws6} state=pseudotiled"
# Desktop 7: Media
elif [ "$class" = 'mpv' ] ; then            echo "desktop=${ws7} state=monocle"
elif [ "$class" = 'smplayer' ] ; then       echo "desktop=${ws7} state=monocle"
elif [ "$class" = 'cantata' ] ; then        echo "desktop=${ws7}"
elif [ "$class" = 'vlc' ] ; then            echo "desktop=${ws7} state=monocle"
# Desktop 8: Images
elif [ "$class" = 'pdfsam' ] ; then                 echo "desktop=${ws8}"
elif [ echo "$class" | grep -Eq 'Gimp*' ] ; then    echo "desktop=${ws8} state=monocle"
elif [ "$class" = 'inkscape' ] ; then               echo "desktop=${ws8} state=monocle"
elif [ "$class" = 'Blender' ] ; then                echo "desktop=${ws8} state=monocle"
elif [ "$class" = 'openscad' ] ; then               echo "desktop=${ws8} state=monocle"
elif [ "$class" = 'Ristretto' ] ; then              echo "desktop=${ws8}"
# Desktop 9: Games
elif [ "$class" = 'Steam' ] ; then                              echo "desktop=${ws9} state=monocle"
elif [ "$class" = 'Stepmania' ] ; then                          echo "desktop=${ws9}"
elif [ echo "$class" | grep -E 'Binding of Isaac' ] ; then      echo "desktop=${ws9}"
elif [ echo "$class" | grep -E 'Slay the Spire' ] ; then        echo "desktop=${ws9}"
elif [ echo "$class" | grep -E 'Oxygen not Included' ] ; then   echo "desktop=${ws9}"
# Desktop 0: Settings
elif [ "$class" = 'Pavucontrol' ] ; then                echo "desktop=${ws0}"
elif [ "$class" = 'Syncthing GTK' ] ; then              echo "desktop=${ws0}"
elif [ "$class" = 'QDBusViewer' ] ; then                echo "desktop=${ws0}"
elif [ "$class" = 'Pamac-updater' ] ; then              echo "desktop=${ws0}"
elif [ "$class" = 'Pamac-manager' ] ; then              echo "desktop=${ws0}"
elif [ "$class" = 'System-config-printer.py' ] ; then   echo "desktop=${ws0}"
elif [ "$class" = 'Scp-dbus-service.py' ] ; then        echo "desktop=${ws0}"
fi
