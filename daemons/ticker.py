#!/usr/bin/python
"""
Just testing
"""

import json
import sys
import pulsectl

OUTPUT = {
    'full text': 'haven\'t initialized yet',
    'short text': 'haven\'t initialized yet',
    'color': '#FFFFFF',
    'background': '#000000',
    'border': True,
    'min_width': 10,
    'align': 'left',
    'name': 'ticker',
    'instance': 'testing',
    'urgent': False,
    'seperator_block_width': 1,
    'markup': 'pango'}

i = 0
while False:
    print( json.dumps(OUTPUT) )
    sys.stdout.flush()
    OUTPUT['full text'] = 'Tick no ' + str(i)
    OUTPUT['short text'] = str(i)
    i+=1
    time.sleep(1)

with pulsectl.Pulse('listener') as pulse:
  for sink in pulse.sink_list():
    # Volume is usually in 0-1.0 range, with >1.0 being soft-boosted
    pulse.volume_change_all_chans(sink, 0.1)
