# Import environment to systemd
systemctl --user import-environment PATH DISPLAY XAUTHORITY XDG_CONFIG_HOME
# Play login sound
paplay $XDG_CONFIG_HOME/sounds/login.oga
# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh
