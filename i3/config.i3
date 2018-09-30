# vim:filetype=i3

#--------------------#
#-----CONFIG: i3-----#
#--------------------#

# This document containst items specific to i3

# Layout parser
exec --no-startup-id "$XDG_CONFIG_HOME/i3/layout.pl"

# Redshift
exec --no-startup-id "/usr/bin/redshift-gtk"

# Monitors
exec --no-startup-id "$XDG_CONFIG_HOME/i3/monitors.sh"

# Need these for gaps
# for_window [class="^.*"] border pixel 0

#--------------------#
#-----KEYMAP: i3-----#
#--------------------#
# Screenshot
bindsym Print                   exec --no-startup-id "maim ${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png"
bindsym Shift+Print             exec --no-startup-id "maim -i $(xdotool getactivewindow) ${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png"
bindsym Mod1+Print              exec --no-startup-id "maim -s {HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png"
bindsym $Meta+Shift+Escape      exec "$XDG_CONFIG_HOME/i3/parse_config.sh ; /usr/bin/i3-msg reload"
