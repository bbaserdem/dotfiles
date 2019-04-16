#!/usr/bin/python
"""
Pulseaudio listener
"""

# Import external modules
import pulsectl as pa

# Import sel modules
import systeminfo as si

ICONLIST = {
        'hdmi': "﴿",
        'headset': "", 'a2dp': "", 'hifi': "",
        'headphones': "",
        'speaker': "蓼",
        'network': "爵",
        'analog': ""}
ICONFALLBACK = ""

# Initialize bar
mod = si.bar_info_init()
mod.format['act1'] = 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
#mod.format['act2'] = 'pactl set-default-sink @OTHER_SINK@'
mod.format['act3'] = 'pavucontrol > /dev/null 2>&1 &'
mod.format['act4'] = 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
mod.format['act5'] = 'pactl set-sink-volume @DEFAULT_SINK@ -5%'

def pause_loop(inp):
    """ Function to pause the PA listen loop """
    raise pa.PulseLoopStop

def get_text(server):
    """ Function to modify text and print it """
    dflt = server.server_info().default_sink_name
    sink = server.get_sink_by_name(dflt)
    name = sink.port_active.name
    volm = round(100*sink.volume.value_flat)
    # Determine muteness
    mod.mute = sink.mute
    # Write icon to module
    mod.format['prefix'] = ICONFALLBACK
    for key, value in ICONLIST.items():
        if key in name:
            mod.format['prefix'] = value
            break
    # Write volume to module
    mod.format['output'] = ' ' + str(volm) + ''
    mod.display()

def volume_up():
    with pa.Pulse('volume-up') as pul:
        sink = pul.get_sink_by_name(pul.server_info().default_sink_name)

def _main():
    # Initialize callback scripts
    with pa.Pulse('event-printer') as pul:
        # Set events to sink changes
        pul.event_mask_set('sink')
        # Stop the loop when something changes
        pul.event_callback_set(pause_loop)

        while True:
            get_text(pul)
            # Sleep until next event
            pul.event_listen()

if __name__ == "__main__":
    _main()
