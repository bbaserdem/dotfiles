#!/usr/bin/python
"""
color.py: Color scheme for the daemons, and a nice import function
"""

import re

# Status bar colors: base16-default-dark
col = {
    'base00': '#181818',
    'base01': '#282828',
    'base02': '#383838',
    'base03': '#585858',
    'base04': '#b8b8b8',
    'base05': '#d8d8d8',
    'base06': '#e8e8e8',
    'base07': '#f8f8f8',
    'base08': '#ab4642',
    'base09': '#dc9656',
    'base0A': '#f7ca88',
    'base0B': '#a1b56c',
    'base0C': '#86c1b9',
    'base0D': '#7cafc2',
    'base0E': '#ba8baf',
    'base0F': '#a16946'
}

# Add all the base descriptors here
COLOR = {**col}

# base01 is status bar background
COLOR['background'] = COLOR['base01']
COLOR['bkg'] = COLOR['base01']
# base03 is comments, and silent text
COLOR['muted'] = COLOR['base03']
COLOR['mute'] = COLOR['base03']
# base04 is foreground for status bars
COLOR['foreground'] = COLOR['base01']
COLOR['frg'] = COLOR['base01']

# Colors range from 8-F
COLOR['red'] =      COLOR['base08']
COLOR['crimson'] =  COLOR['base08']
COLOR['ora'] =      COLOR['base09']
COLOR['orange'] =   COLOR['base09']
COLOR['yel'] =      COLOR['base0A']
COLOR['yellow'] =   COLOR['base0A']
COLOR['gre'] =      COLOR['base0B']
COLOR['green'] =    COLOR['base0B']
COLOR['cya'] =      COLOR['base0C']
COLOR['cyan'] =     COLOR['base0C']
COLOR['ind'] =      COLOR['base0D']
COLOR['blue'] =     COLOR['base0D']
COLOR['indigo'] =   COLOR['base0D']
COLOR['vio'] =      COLOR['base0E']
COLOR['pink'] =     COLOR['base0E']
COLOR['violet'] =   COLOR['base0E']
COLOR['purple'] =   COLOR['base0E']
COLOR['bro'] =      COLOR['base0F']
COLOR['brown'] =    COLOR['base0F']

# Color printer with defaults and opacity capability
def colorPicker(inp, opacity=1 ):
    ans = ''
    # Do answer checking
    if inp in COLOR:
        ans += COLOR[inp]
    else:
        if re.search(r'^#(?:[0-9a-fA-F]{3}){1,2}$',inp):
            ans += inp
        else:
            print('Invalid color selection, defaulting to red')
            ans += COLOR['red']

    # Check if transparency is enabled
    if opacity < 1:
        sto = hex(min(max(round(opacity*255), 0), 255))[:2]
        sto = (2-len(sto))*'0' + sto
        ans += sto
    
    return ans
