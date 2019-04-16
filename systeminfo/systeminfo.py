#!/bin/env python
"""
Wrapper around printing blocklet information
"""

# Standart libraries
import argparse
import json
import os
import re
import sys
from subprocess import Popen
from threading import Thread

# Third party packages

# Self modules

# Status bar colors: base16-default-dark
COLOR = {
    'base00': '181818',
    'base01': '282828',
    'base02': '383838',
    'base03': '585858',
    'base04': 'b8b8b8',
    'base05': 'd8d8d8',
    'base06': 'e8e8e8',
    'base07': 'f8f8f8',
    'base08': 'ab4642',
    'base09': 'dc9656',
    'base0A': 'f7ca88',
    'base0B': 'a1b56c',
    'base0C': '86c1b9',
    'base0D': '7cafc2',
    'base0E': 'ba8baf',
    'base0F': 'a16946'
}

# Needed stuff for namespace
DVNL = open(os.devnull, 'wb')
PRSR = argparse.ArgumentParser('Modules to print system info')
PRSR.add_argument('-c', '--color', help="Specify accent color")
PRSR.add_argument('-m', '--method', help="Specify output program")
PRSR.add_argument('-t', '--transparency', help="Specify background transparency")
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
    if output is None:
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
    elif method == 'console':
        output = ConsoleInfo()
    else:
        print('Defaulting to polybar style . . .')
        output = PolyBarInfo()
    return output

# base01 is status bar background
COLOR['background'] = COLOR['base01']
COLOR['bkg'] = COLOR['base01']
# base03 is comments, and silent text
COLOR['muted'] = COLOR['base03']
COLOR['mute'] = COLOR['base03']
# base04 is foreground for status bars
COLOR['foreground'] = COLOR['base04']
COLOR['frg'] = COLOR['base04']
# Colors
COLOR['red'] = COLOR['base08']
COLOR['crimson'] = COLOR['base08']
COLOR['ora'] = COLOR['base09']
COLOR['orange'] = COLOR['base09']
COLOR['yel'] = COLOR['base0A']
COLOR['yellow'] = COLOR['base0A']
COLOR['gre'] = COLOR['base0B']
COLOR['green'] = COLOR['base0B']
COLOR['cya'] = COLOR['base0C']
COLOR['cyan'] = COLOR['base0C']
COLOR['ind'] = COLOR['base0D']
COLOR['blue'] = COLOR['base0D']
COLOR['indigo'] = COLOR['base0D']
COLOR['vio'] = COLOR['base0E']
COLOR['pink'] = COLOR['base0E']
COLOR['violet'] = COLOR['base0E']
COLOR['purple'] = COLOR['base0E']
COLOR['bro'] = COLOR['base0F']
COLOR['brown'] = COLOR['base0F']
# ANSI colors
ANSI = {
    'red': '\u001b[31m',
    'orange': '\u001b[35m',
    'yellow': '\u001b[33m',
    'green': '\u001b[32m',
    'cyan': '\u001b[33m',
    'blue': '\u001b[34m',
    'violet': '\u001b[35m',
    'brown': '\u001b[36m',
    'bold': '\u001b[1m',
    'reset': '\u001b[0m'}

# Color printer with defaults and opacity capability
def color_picker(inp):
    """ Function to parse color strings """
    ans = ''
    # Do answer checking
    if inp in COLOR:
        ans += COLOR[inp]
    else:
        if re.search(r'^#(?:[0-9a-fA-F]{3}){1,2}$', inp):
            ans += inp
        else:
            print('Invalid color selection, defaulting to red')
            ans += COLOR['red']

    return ans

# Get opacity hex string
def get_opacity(inp=1):
    """ Function to parse opacity value """
    # Check if already hex
    if re.search(r'^(?:[0-9a-fA-F]{2})$', inp):
        return inp
    inp = float(inp)
    if inp == 1:
        return ''
    ans = hex(min(max(round(inp*255), 0), 255))[:2]
    ans = (2-len(ans))*'0' + ans
    return ans

# Main object
class BarInfo:
    """ Main class that contains common bar information """
    def __init__(self):
        # Initialize default variables
        self.foreground = color_picker('frg')
        self.background = color_picker('bkg')
        self.muteground = color_picker('mute')
        self.text = ''
        # Initialize the fields that will transform the format
        self.format = {
            'output' : '',
            'color' : color_picker(get_config('color', fallback='red')),
            'foreground' : self.foreground,
            'background' : self.background,
            'opacity' : get_opacity(get_config('transparency', fallback='1.0')),
            'prefix' : '',
            'suffix' : '',
            'act1' : '',
            'act2' : '',
            'act3' : '',
            'act4' : '',
            'act5' : ''}
        # Flag to see if text needs to be muted
        self.mute = False
        # Initialize click actions
        self.mouse_left = lambda *args: None
        self.mouse_middle = lambda *args: None
        self.mouse_right = lambda *args: None
        self.mouse_scroll_up = lambda *args: None
        self.mouse_scroll_down = lambda *args: None

    def add_action(self, command, button):
        """ Function to add command calls to click events """
        self.format['act'+str(button)] = command

    def display(self):
        """ Method to print information out, must be defined individually """
        sys.stdout.flush()

    def listen(self):
        """ Start a thread to listen for actions and execute them """
        def choice(stdin):
            for line in stdin:
                button = json.loads(line)['button']
                if button == 1:
                    self.mouse_left
                elif button == 2:
                    self.mouse_middle
                elif button == 3:
                    self.mouse_right
                elif button == 4:
                    self.mouse_scroll_up
                elif button == 5:
                    self.mouse_scroll_down
        self.thread = Thread(target=choice, args=(sys.stdin,))
        self.thread.start()

# Print to console
class ConsoleInfo(BarInfo):
    """ Class to format to console """
    def __init__(self):
        # Initialize fo the main class
        BarInfo.__init__(self)
        # Rename color
        self.format['color'] = ANSI[get_config('color', fallback='red')]
        # Set text style
        self.text += ANSI['bold'] + '{color}{prefix}' + ANSI['reset']
        self.text += '{output}'
        self.text += ANSI['bold'] + '{color}{suffix}' + ANSI['reset']

    def display(self):
        print(self.text.format_map(self.format))
        # Call the generic method
        BarInfo.display(self)

# Print to Polybar
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
        self.text += '%{{B#{opacity}{background} u#{color} +u}}'
        # Display prefix
        self.text += '%{{F#{color}}}{prefix}%{{F-}}'
        # Text display
        self.text += '%{{F#{foreground}}}{output}%{{F-}}'
        # Display postfix
        self.text += '%{{F#{color}}}{suffix}%{{F-}}'
        # Finalize text formatting
        self.text += '%{{B- -u u-}}'
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

# Print to i3bar
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

# Print to waybar
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
