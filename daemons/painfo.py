#!/usr/bin/python
"""
Pulseaudio listener
"""

import pulsectl as pa
import wrapper as w

ICONLIST = {
        'hdmi': "﴿",
        'headset': "", 'a2dp': "", 'hifi': "",
        'headphones': "",
        'speaker': "蓼",
        'network': "爵",
        'analog': ""}
ICONFALLBACK = ""

# Initialize bar
MOD = w.bar_info_init()
# Initialize callback scripts

# Left click toggles mute
MOD.format['act1'] = 'pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null 2>&1'
# Right-click launches pavucontrol
MOD.format['act3'] = 'pavucontrol > /dev/null 2>&1 &'
# Scroll-up/down modulates volume
MOD.format['act4'] = 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
MOD.format['act5'] = 'pactl set-sink-volume @DEFAULT_SINK@ -5%'

with pa.Pulse('event-printer') as PUL:

    # Set events to sink changes
    PUL.event_mask_set('sink')
    # Stop the loop when something changes
    def pause_loop(inp):
        raise pa.PulseLoopStop
    PUL.event_callback_set(pause_loop)

    while True:
        # Get information
        dflt = PUL.server_info().default_sink_name
        sink = PUL.get_sink_by_name(dflt)
        name = sink.port_active.name
        volm = round(100*sink.volume.value_flat)
        mute = sink.mute
        # Write icon to module
        MOD.format['prefix'] = ICONFALLBACK
        for key, value in ICONLIST.items():
            if key in name:
                MOD.format['prefix'] = value
                break
        # Write volume to module
        MOD.format['output'] = ' ' + str(volm) + ''
        MOD.mute = mute
        # Print output
        MOD.display()
        # Sleep until next event
        PUL.event_listen()
