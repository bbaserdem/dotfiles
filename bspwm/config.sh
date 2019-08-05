#!/bin/sh

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

# Rules
bspc config border_width                2
bspc config window_gap                  12
bspc config merge_overlapping_monitors  true
bspc config remove_disabled_monitors    true
bspc config remove_unplugged_monitors   true
bspc config split_ratio                 0.52
bspc config borderless_monocle          true
bspc config gapless_monocle             true
bspc config automatic_scheme            longest_side
bspc config external_rules_command      $XDG_CONFIG_HOME/bspwm/external_rules.sh

# Monocle desktops
bspc desktop $ws1 --layout monocle
bspc desktop $ws4 --layout monocle
bspc desktop $ws7 --layout monocle
bspc desktop $ws8 --layout monocle

# Reassign monitors
$XDG_CONFIG_HOME/bspwm/monitors.sh --refresh
