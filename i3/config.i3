# vim:filetype=i3

#--------------------#
#-----CONFIG: i3-----#
#--------------------#

# This document containst items specific to i3

# Need these for gaps
for_window [class="^.*"] border pixel 0

#--------------------#
#-----KEYMAP: i3-----#
#--------------------#
# Screenshot
bindsym Print                   exec --no-startup-id "maim ${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png"
bindsym Shift+Print             exec --no-startup-id "maim -i $(xdotool getactivewindow) ${HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png"
bindsym Mod1+Print              exec --no-startup-id "maim -s {HOME}/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png"
# Compton
bindsym Mod4+c                  exec --no-startup-id "if (systemctl is-active --user --quiet compton@${DISPLAY}.service); then systemctl --user stop compton@${DISPLAY}.service; else systemctl --user start compton@${DISPLAY}.service; fi"
