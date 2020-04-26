# Monitors
if [ "$(hostname)" = 'sbp-homestation' ] ; then
    export BRI_SCR="amdgpu_bl0"
    export BRI_KBD="asus::kbd_backlight"
elif [ "$(hostname)" = 'sbp-laptop' ] ; then
    export BRI_SCR="intel_backlight"
    export BRI_KBD="system76_acpi::kbd_backlight"
fi
