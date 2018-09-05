#!/usr/bin/sh

rm $XDG_CONFIG_HOME/i3/config

# Get i3-specific stuff
cp $XDG_CONFIG_HOME/i3/config.i3 $XDG_CONFIG_HOME/i3/config

# Get Colors
cat $XDG_CONFIG_HOME/sway/config.generic | \
    grep -v 'set $bl0' | sed 's|\$base00|\$bl0|g' | \
    grep -v 'set $bl1' | sed 's|\$base01|\$bl1|g' | \
    grep -v 'set $bl2' | sed 's|\$base02|\$bl2|g' | \
    grep -v 'set $bl3' | sed 's|\$base03|\$bl3|g' | \
    grep -v 'set $wh3' | sed 's|\$base04|\$wh3|g' | \
    grep -v 'set $wh2' | sed 's|\$base05|\$wh2|g' | \
    grep -v 'set $wh1' | sed 's|\$base06|\$wh1|g' | \
    grep -v 'set $wh0' | sed 's|\$base07|\$wh0|g' | \
    grep -v 'set $red' | sed 's|\$base08|\$red|g' | \
    grep -v 'set $ora' | sed 's|\$base09|\$ora|g' | \
    grep -v 'set $yel' | sed 's|\$base0A|\$yel|g' | \
    grep -v 'set $gre' | sed 's|\$base0B|\$gre|g' | \
    grep -v 'set $cya' | sed 's|\$base0C|\$cya|g' | \
    grep -v 'set $ind' | sed 's|\$base0D|\$ind|g' | \
    grep -v 'set $vio' | sed 's|\$base0E|\$vio|g' | \
    grep -v 'set $bro' | sed 's|\$base0F|\$bro|g' | \
    grep -v 'pango_markup' | \
    sed 's|swaybar_command|i3bar_command|g' | \
    sed 's|"swaybar"|"i3bar -t"|g' | \
    sed 's|tray_output all|tray_output primary|g' | \
    grep -v 'icon_theme' | \
    grep -v 'wrap_scroll' | \
    sed 's|sway-wallpaper|i3-wallpaper|g' | \
    sed 's|sway-lock|i3-lock|g' | \
    sed 's|swaymsg|i3-msg|g' | \
    sed 's|sway@|i3@|g' >> \
    $XDG_CONFIG_HOME/i3/config

exec /usr/bin/systemd-inhibit --what=handle-power-key /usr/bin/i3
