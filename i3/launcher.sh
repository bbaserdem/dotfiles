#!/usr/bin/sh
$XDG_CONFIG_HOME/i3/parse_config.sh
exec /usr/bin/systemd-inhibit --what=handle-power-key /usr/bin/i3
