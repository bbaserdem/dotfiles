#!/usr/bin/python
"""
Calendar listener for khal
"""

# Standart libraries
import subprocess
from pathlib import Path
import time

# Third party packages
import inotify.adapters

# User-written modules
import systeminfo as w

def get_display():
    """ Get the most recent khal event """
    args = ['khal', 'at', 'now', '--format', '"{title}"', '--day-format', '']
    text = subprocess.check_output(args).decode('utf-8').split('\n')[0]
    return text

def get_mute(text):
    """ Return true if no events """
    if text == 'No events':
        return True
    return False

def _main():
    """ Main watching function """
    # Inotify watcher
    watcher = inotify.adapters.InotifyTree(str(Path.home()) + '/Documents/Calendar')
    track_list = ('IN_CLOSE_WRITE', 'IN_CREATE', 'IN_DELETE')

    # Initialize bar
    mod = w.bar_info_init()
    mod.format['prefix'] = " "
    mod.format['output'] = get_display()
    mod.mute = get_mute(mod.format['output'])
    mod.display()

    while True:
        try:
            for _ in watcher.event_gen(yield_nones=False,
                    terminal_events=track_list):
                pass
        except inotify.adapters.TerminalEventException:
            mod.format['output'] = get_display()
            mod.mute = get_mute(mod.format['output'])
            mod.display()
            time.sleep(5)

if __name__ == '__main__':
    _main()
