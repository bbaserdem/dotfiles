# Play login sound
paplay $XDG_CONFIG_HOME/sounds/login.oga
# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh
