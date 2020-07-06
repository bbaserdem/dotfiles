# LINUX CONFIG FILES

This repo is my general unix configuration.
This is my `.config` folder, but scripts regarding system setup are also kept here.
I currently use Arch Linux, and Gentoo, and tried to make my config OS agnostic.

# Issues

Current to-do items, with no order

* Fix the multiple loadings of autorandr; and fix feh autoset files.
* Opening terminal switches desktop under all conditions. (???)
* Build tmux alias with all my console programs
* Fix DPMS cluster-fuck.
* Zimfw theme change does not work well in framebuffer
* Install & restore script needs to be bulletproof.
* Keys, etc backup script

# Restoration

If restoring from a backup; run the `restore.sh`,
either with the `~/$(hostname).tar.gz`,
or by supplying the path to the argument.

The following are restored;

* GPG directory
* Syncthing configuration
* SSH keys

# Installation

Couple stuff needs to be setup before the full config is working.
These steps are followed in the [install script](/install.sh).

* Repo should be cloned to `~/.config`.
* Zimfw needs to be installed.
* GPG keys needs to be imported.
* SSH keys needs to be imported.
* Clone the password repo to `~/.pass`.
* Syncthing config should be generated.
* Run `~/.config/install.sh`

To update certain modules, run the installation script again.

## SSH

This directory is defaulted to `~/.ssh` since it is expected there.
Either copy the keys, or generate new keys.

## Zimfw

To install and activate zimfw;

* Create .local/share/zim (or the `$ZIM_HOME` directory)
* Get the `zimfw.zsh` there;
`curl -fsSL https://raw.githubusercontent.com/zimfw/zimfw/master/zimfw.zsh -o ~/.local/share/zim/zimfw.zsh`
* Run `zsh ~/.local/share/zim/zimfw.zsh install`

## GPG

# TMUX

Ctrl + A is the leader key.
Alt and arrows allow navigation, without needing the command key.

* | and -: Splits window vertically/horizontally.
* hjkl: Move between panes
* Left Right: Move between windows
* O: Create new window.

# Shortcuts

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
