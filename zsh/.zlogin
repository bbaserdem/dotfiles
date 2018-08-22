# Import environment to systemd
systemctl --user import-environment PATH DISPLAY XAUTHORITY XDG_CONFIG_HOME
# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh
