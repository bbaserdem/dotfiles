#!/bin/sh

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

# Rules
bspc config border_width                2
bspc config window_gap                  12
bspc config merge_overlapping_monitors  true
bspc config split_ratio                 0.52
bspc config borderless_monocle          true
bspc config gapless_monocle             true
bspc config automatic_scheme            longest_side
bspc config external_rules_command      $XDG_CONFIG_HOME/bspwm/external_rules.sh

# Reassign monitors
$XDG_CONFIG_HOME/bspwm/desktop_refresh.sh
