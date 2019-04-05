#!/bin/env python
"""
Wrapper around printing blocklet information
"""

import os
import argparse
import json
import sys
from subprocess import Popen
from threading import Thread
from color import colorPicker

# Needed stuff for namespace
DVNL = open(os.devnull, 'wb')
PRSR = argparse.ArgumentParser('Modules to print system info')
PRSR.add_argument('-c', '--color', help="Specify accent color")
PRSR.add_argument('-m', '--method', help="Specify output program")
NSPC = PRSR.parse_args()





def get_config(name, fallback='N/A'):
    """ Function to get specific config option from environment """
    # Force string type
    if not isinstance(name, str):
        name = str(name)
    # Get argument
    if name in vars(NSPC):
        output = vars(NSPC)[name]
    elif os.getenv(name):
        output = os.getenv(name)
    else:
        output = fallback
    # Random OS variable control
    if output == None:
        output = fallback
    return output





def bar_info_init():
    """ Returns the class for the specific bar type """
    # Get environment variable
    method = get_config('method', fallback='polybar')
    # Return the proper object
    if method == 'polybar':
        output = PolyBarInfo()
    elif method == 'i3bar':
        output = I3BarInfo()
    elif method == 'waybar':
        output = WayBarInfo()
    else:
        print('Defaulting to polybar style . . .')
        output = PolyBarInfo()
    return output












class BarInfo:
    """ Main class that contains common bar information """
    def __init__(self):
        # Initialize default variables
        self.foreground = colorPicker('frg')
        self.background = colorPicker('bkg')
        self.muteground = colorPicker('mute')
        self.text = ''
        # Initialize the fields that will transform the format
        self.format = {
            'output' : '',
            'color' : colorPicker(get_config('color', fallback='red')),
            'foreground' : self.foreground,
            'background' : self.background,
            'prefix' : '',
            'suffix' : '',
            'act1' : '',
            'act2' : '',
            'act3' : '',
            'act4' : '',
            'act5' : ''}
        # Flag to see if text needs to be muted
        self.mute = False

    def add_action(self, command, button):
        """ Function to add command calls to click events """
        self.format['act'+str(button)] = command

    def display(self):
        """ Method to print information out, must be defined individually """
        sys.stdout.flush()






class PolyBarInfo(BarInfo):
    """ Class to retain lemonbar formatting
        POLYBAR FORMATTING
            Colors are set by:
                %{F#XXXXXX} text %(F-}
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
    """
    def __init__(self):
        # Initialize fo the main class
        BarInfo.__init__(self)
        # Set actions
        self.text += '%{{A1:{act1}: A2:{act2}: A3:{act3}: A4:{act4}: A5:{act5}:}}'
        # Set colors, foreground, background and underline
        self.text += '%{{B{background} F{foreground} u{color} +u}}'
        # Display prefix
        self.text += '%{{F{color}}}{prefix}%{{F-}}'
        # Text display
        self.text += '{output}'
        # Display postfix
        self.text += '%{{F{color}}}{suffix}%{{F-}}'
        # Finalize text formatting
        self.text += '%{{B- F- -u u-}}'
        # Finalize action formatting
        self.text += '%{{A A A A A}}'

    def add_action(self, command, button):
        """ Need to overload to escape the string properly """
        BarInfo.add_action(self, command, button)
        # Need to escape colon in script for lemonbar tags
        ind = 'act'+str(button)
        self.format[ind] = self.format[ind].replace(':', r'\:')

    def display(self):
        if self.mute:
            self.format['foreground'] = self.muteground
        else:
            self.format['foreground'] = self.foreground

        print(self.text.format_map(self.format))
        # Call the generic method
        BarInfo.display(self)






class I3BarInfo(BarInfo):
    """ Class to output JSON format for i3blocks
    I3 FORMATTINC
        i3bar protocol uses the following fields.
        (Only full_text needs to be updated)
            'full_text' : '',
            'border': True,
            'min_width': 0,
            'align': 'left',
            'name': 'ticker',
            'instance': 'testing',
            'urgent': False,
            'seperator_block_width': 1,
            'markup': 'pango'
    """
    def __init__(self):
        # Initialize fo the main class
        BarInfo.__init__(self)
        # Define the formatting for i3bar protocol (color and background set)
        self.jlist = {
            'color' : self.foreground,
            'background' : self.format['background'],
            'full_text' : '',
            'min_width' : 0,
            'align' : 'left',
            'urgent' : False,
            'seperator' : True,
            'seperator_block_width' : 1,
            'markup' : 'pango'}
        # Display prefix
        self.text += "<span color='{color}'>{prefix}</span>"
        self.text += "{output}"
        self.text += "<span color='{color}'>{suffix}</span>"
        self.listen = False

    def display(self):
        # If was not already listening, start to listen to events
        if not self.listen:
            self.listen = Thread(target=self.i3_action_listen,
                    args=(sys.stdin, self.format,))
            self.listen.start()

        if self.mute:
            self.jlist['color'] = self.muteground
        else:
            self.jlist['color'] = self.foreground

        self.jlist['full_text'] = self.text.format_map(self.format)
        print(json.dumps(self.jlist))
        # Call the generic method
        BarInfo.display(self)

    def i3_action_listen(self, stdin, actions, isjson=False):
        """ Listen to stdin for JSON formatted string, and decide on action """
        while True:
            listen = stdin.readline()
            if isjson:
                button = str(json.loads(listen)['button'])
            else:
                button = str(listen)
            #endif
            key = 'act' + button[0]
            if key in actions:
                cmd = actions['act'+button[0]]
                # Make sure all self.fields['actN'] dont have spaces
                Popen(['sh','-c',cmd], stdout=DVNL)






class WayBarInfo(BarInfo):
    """ Class to output JSON format for i3blocks
        WAYBAR FORMATTING
            waybar uses the following fields:
            only text needs to be updated
    """
    def __init__(self):
        # Initialize fo the main class
        BarInfo.__init__(self)
        # Define the formatting for i3bar protocol (color and background set)
        self.jlist = {
            'color' : self.foreground,
            'background' : self.format['background'],
            'text' : '',
            'format' : '{}',
            'tooltip' : False}

        # Display prefix
        self.text += "<span color='{color}'>{prefix}</span>"
        self.text += "{output}"
        self.text += "<span color='{color}'>{suffix}</span>"

    def add_action(self, command, button):
        """ Overload this command to properly format actions """
        if button == 1:
            self.jlist['on-click'] = command
        elif button == 2:
            self.jlist['on-click-middle'] = command
        elif button == 3:
            self.jlist['on-click-right'] = command
        elif button == 4:
            self.jlist['on-scroll-up'] = command
        elif button == 5:
            self.jlist['on-scroll-down'] = command

    def display(self):
        if self.mute:
            self.jlist['color'] = self.muteground
        else:
            self.jlist['color'] = self.foreground

        self.jlist['full_text'] = self.text.format_map(self.format)
        json.dumps(self.jlist)
        # Call the generic method
        BarInfo.display(self)
