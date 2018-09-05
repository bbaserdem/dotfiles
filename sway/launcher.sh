#!/usr/bin/sh

# Parse i3 config into sway
rm $XDG_CONFIG_HOME/sway/config
touch $XDG_CONFIG_HOME/sway/config
cat $XDG_CONFIG_HOME/sway/config.colors >> $XDG_CONFIG_HOME/sway/config
cat $XDG_CONFIG_HOME/sway/config.sway   >> $XDG_CONFIG_HOME/sway/config
cat $XDG_CONFIG_HOME/i3/config.generic | grep -v 'i3bar_command' >> $XDG_CONFIG_HOME/sway/config
cat $XDG_CONFIG_HOME/i3/config.keymap | sed \
    's/i3-msg/swaymsg/g; s/i3-/sway-/g' >> $XDG_CONFIG_HOME/sway/config

# Launch sway
exec /usr/bin/sway
