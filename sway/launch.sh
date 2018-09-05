#!/usr/bin/sh

# Launch sway
exec /usr/bin/systemd-inhibit --what=handle-power-key /usr/bin/sway
