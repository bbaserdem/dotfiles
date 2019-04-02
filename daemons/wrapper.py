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
COLOR = {
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

def colorPicker( x ):
    switcher = {
        'foreground':   'base04',
        'frg':          'base04',
        'background':   'base01',
        'bkg':          'base01',
        'muted':        'base03',
        'red':          'base08',
        'crimson':      'base08',
        0:              'base08',
        'orange':       'base09',
        'ora':          'base09',
        1:              'base09',
        'yellow':       'base0A',
        'yel':          'base0A',
        2:              'base0A',
        'green':        'base0B',
        'gre':          'base0B',
        3:              'base0B',
        'cyan':         'base0C',
        'cya':          'base0C',
        4:              'base0C',
        'blue':         'base0D',
        'ind':          'base0D',
        'indigo':       'base0D',
        5:              'base0D',
        'violet':       'base0E',
        'vio':          'base0E',
        'purple':       'base0E',
        'pink':         'base0E',
        6:              'base0E',
        'brown':        'base0F',
        'bro':          'base0F',
        7:              'base0F'}
    if re.search(r'^#(?:[0-9a-fA-F]{3,4}){1,2}$', x):
        return x
    else:
        return COLOR.get(switcher.get(x, 'nomap'), '#FFFFFF')

class BarInfo:
    """ Class that contains bar information, and can print to stdout """
    display
    color
    icon
    text
    mute
    action
    json

    def displayToPolybar(self):
        """ Wraps polybar tags around the text. """
        output = ''
        # Insert the text
        for i in range( len( self.text ) ):
            output += '%{F'+self.color+'}'+self.icon[i]+'%{F-'+self.text[i]+' '
        # Insert underline
        output = '%{u'+self.color+' u+}'+output+'%{-u u-}'
        # Insert the commands
        for i in range( len( self.action ) ):
            if self.action[i] != '':
                output = '%{A'+str(i)+':'+self.action+':}'+output+'%{A}'
        print(output)

