#!/usr/bin/python
"""
Just testing
"""

import json
import time
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

with pulsectl.Pulse('event-printer') as pulse:
    # print('Event types:', pulsectl.PulseEventTypeEnum)
    # print('Event facilities:', pulsectl.PulseEventFacilityEnum)
    # print('Event masks:', pulsectl.PulseEventMaskEnum)

    def print_events(ev):
        print('Pulse event:', ev)
        ### Raise PulseLoopStop for event_listen() to return before timeout (if any)
        # raise pulsectl.PulseLoopStop

    pulse.event_mask_set('all')
    pulse.event_callback_set(print_events)
    pulse.event_listen(timeout=10)
