#!/usr/bin/python

"""
DATA WRAPPER:
    A wrapper around printing methods
    Properties are;
        display:        Either polybar, i3 or waybar
        color:          Accent color
        icons:          List of icon(s) to be printed
        text:           List of text to be printed afte the icon(s)
        mute:           List of text indices to mute
        action:         Strings of shell commands to be launched
    Basically, wraps polybar output with lemontags

PROCESS WRAPPER
    A wrapper to handle click events.
    For i3bar, click events are given back as JSON in stdin
    For polybar, the text output needs to be decorated
    For waybar, the JSON output needs to have the respective fields

POLYBAR FORMATTING
    Colors are set by:
        %{F#XXXXXX} text %(F}
    Background is set by %{B}
        %{B#XXXXXX} text %{B-}
    Colors can be reversed with %{R}
    Actions are set as
        %{AN:command: AM:command:} %{A A}
        1: left click
        2: middle click
        3: right click
        4: scroll up
        5: scroll down
        6: double left click
        7: double middle click
        8: double right click
    Underline is set by
        %{u#XXXXXX +u} text %{-u u-}

I3 FORMATTINC
    i3bar protocol uses the following fields:
        * 'full text'
        * 'short text'
        * 'name'
        * 'instance'
        'color'
        'background'
        'border'
        'min_width'
        'align'
        'urgent'
        'seperator_block_width'
        'markup'

WAYBAR FORMATTING
    waybar uses the following fields: (do this formatting later)
    
"""

import os
import argparse
import re
import json
from collections import defaultdict,ChainMap

I3BAR = {
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

# Status bar colors: base16-default-dark
COL = {
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
    'base0F': '#a16946'}

COLOR = defaultdict(str)
COLOR['base00'] = COL['base00']
COLOR['base01']
COLOR['background']
'bkg'] = COL['base01']
COLOR['base02'] = COL['base02']
COLOR['base03', 'muted', 'mute'] = COL['base03']
COLOR['base04', 'foreground', 'frg'] = COL['base04']
COLOR['base05'] = COL['base05']
COLOR['base06'] = COL['base06']
COLOR['base07'] = COL['base07']
COLOR['base08', 'red', 'crimson'] = COL['base08']
COLOR['base09', 'orange', 'ora'] = COL['base09']
COLOR['base0A', 'yellow', 'yel'] = COL['base0A']
COLOR['base0B', 'green', 'gre'] = COL['base0B']
COLOR['base0C', 'cyan', 'cya'] = COL['base0C']
COLOR['base0D', 'blue', 'ind', 'indigo'] = COL['base0D']
COLOR['base0E', 'violet', 'vio', 'purple', 'pink'] = COL['base0E']
COLOR['base0F', 'brown', 'bro'] = COL['base0F']

# Pick a color with fallback
def colorPicker(x):
    return COLOR[x]

print(COLOR['base01', 'background', 'bkg'])
print(COLOR['base01'])

# Class that contains bar information, and general methods"""
class BarInfo:

    # Init method to initialize most things
    def __init__(self):
        self.fields = defaultdict(lambda: '')
        
        # Parse the command line arguments to draw out method and color
        defaults = {'color':'red','method':'polybar'}
        parser = argparse.ArgumentParser()
        parser.add_argument('-c', '--color')
        parser.add_argument('-m', '--method')
        namespace = parser.parse_args()
        command_line_args = {k:v for k, v in vars(namespace).items() if v}
        # Get the environment
        environ_args = {}
        for x in 'color','method':
            if os.getenv(x):
                environ_args[x] = os.getenv(x)
        # Get the combined version
        args = ChainMap(command_line_args, os.environ, defaults)

        # Get accent color, and sane defaults
        self.fields['accent'] = colorPicker(args['color'])
        self.fields['color'] = colorPicker('frg')
        self.fields['background'] = colorPicker('bkg')

        # Get print method
        self.method = args['method']

a=BarInfo()
print(a.method)
print(a.fields['accent'])
print(a.fields['color'])
print(a.fields['background'])
