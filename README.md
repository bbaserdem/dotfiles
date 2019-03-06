This is outdated, fix

# Unix Configuration

This repository contains my UNIX user configuration.

* Do hotplug monitor with udev for laptop
* Do hibernation below 10% battery.
* Create QEMU launchers, and fix QEMU monitor sizing issues.
* Migrate from rdesktop to freerdp.
* GPU temperatures using AMDGPU, its on the fancontrol page.
* Fix no permission on bluetooth-applet
* Make it so graphical prompts launch kitty instead of termite
* Build tmux alias with all my console programs
* Fix pulseaudio sink type detection on i3blocks
* Clean packages and fonts
* Set up Conky for start page.

# TMUX

Ctrl + A is the leader key.
Alt and arrows allow navigation, without needing the command key.

* | and -: Splits window vertically/horizontally.
* hjkl: Move between panes
* Left Right: Move between windows
* O: Create new window.

# i3

Everything but the **XF86** keys require the **_Super_** modifier.

| Ctrl | Alt | Shft |  Keypress  | Action                                   |
|:----:|:---:|:----:|:----------:|:-----------------------------------------|
|      |     |      | AudioPlay  | Toggles playback on/off                  |
|      |     |      | AudioStop  | Stops playback                           |
|      |     |      | AudioPrev  | Rewinds song, then plays previous song   |
|      |     |      | AudioNext  | Plays next song                          |
|      |     |      | Vol Up/Dn  | Modulate volume by 5%                    |
|      |     |      | Mute       | Toggles mute.                            |
|      |     |      | Light Up/Dn| Modulates brightness                     |
|      |     |      | Calculator | Opens an interactive python window       |
|      |     |      | HomePage   | Launches browser                         |
|      |  X  |   X  | Escape     | Reloads SXHKD                            |
|      |  X  |      | Escape     | Quits BSPWM                              |
|      |     |      | Return     | Launches terminal                        |
|      |     |      | Space      | Launches Rofi                            |
|      |     |      | Escape     | Lock screen                              |
|      |     |      | ←→         | Move to desktop                          |
|      |     |      | ↑          | Dropdown (keyboard layout)               |
|      |     |      | ↓          | Change wallpaper                         |
|      |     |      | 1 - 0      | Move to the specified desktop            |
|      |     |      | Tab        | Move to the last desktop                 |
|      |     |   X  | ←→         | Move selected window to desktop          |
|      |     |   X  | 1 - 0      | Move selected window to specified desktop|
|      |     |      | Q          | Close current window                     |
|      |     |   X  | Q          | Kill current window                      |
|   X  |     |      | Space      | Cancel preselection for the node         |
|   X  |  X  |      | Space      | Cancel preselection for the desktop      |
|   X  |     |      | H J K L    | Preselect split direction                |
|   X  |     |      | 1 - 0      | Preselect split ratio                    |
|      |     |      | G          | Swap the biggest and selected window     |
|      |     |   X  | T          | Set window as tiled                      |
|      |     |   X  | S          | Set window as pseudo-tiled               |
|      |     |   X  | F          | Set window as floating                   |
|      |     |   X  | M          | Set window as fullscreen                 |
|   X  |     |      | X          | Set window flag as locked                |
|   X  |     |      | Y          | Set window flag as sticky                |
|   X  |     |      | Z          | Set window flag as private               |
|      |     |      | H J K L    | Change focus to the window in direction  |
|      |     |   X  | H J K L    | Swap the focused and directed node       |
|      |     |      | C          | Focus next node                          |
|      |     |   X  | C          | Focus previous node                      |
|      |     |      | \`         | Focus the last node                      |
|      |  X  |      | H J K L    | Expand window size                       |
|      |  X  |   X  | H J K L    | Contract window size                     |
|   X  |     |      | ←→↑↓       | Move floating window                     |
