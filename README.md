# Unix Configuration

This repository contains my UNIX configuration.

All the files are built to be used on my working system.
This is more of a referance manual for me to build my system on other computers.
Some files are omitted due to security issues.
So this might not represent my complete setup.

* Installation to laptop.
* Installation to work PC.
* Setup
* Usage

This document contains information on how keybindings work with this system.

# Installation

I like distro hopping. Here is a breakdown for setup of each system;

* [Server](#server)
* [Laptop](#laptop), using Arch.
* [Workstation](#workstation), using Debian.
* [Homestation](#homestation), using Void.

# TMUX

* Ctrl + A: Activates commands.
* |: Splits window vertically
* -: Splits window horizantally
* Alt + <Movement>: Moves between panes (without command activation)

# SXHKD

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

# Packages

These packages are downloaded on my system.
The list contains brief descriptions on why the packages are there.

## AUR

* **rofi-pass-git**: Rofi plugin for password store.
* **brightnessctl**: Control brightness of LED backlights.
* **bdf-twei-git**: A bitmap font.
* **gohufont**: Nice terminal font.
* **mpdscribble**: Auto-scrobbler
* **networkmanager-dmenu-git**: Rofi plugin for NM.
* **openblas-lapack**: Linear algebra for numpy
* **polybar-git**: Statusbar
* **private-internet-access-vpn**: PIA implementation.
* **rtv-git**: Reddit terminal viewer.
* **siji-git**: Bitmap font.
* **stepmania-git**: DDR emulator.
* **terminess-powerline-font-git**: Fallback font for powerline symbols.
* **trizen**: AUR package manager
* **ttf-iosevka**: Nice font for info bar
* **ttf-weather-icons**: Icons for weather widget.
* **wmutils-git**: Needed to manipulate bspwm for now.
* **zsh-zim-git**: Shell configuration, mostly for syntax highlighting and completion.
* **steam-fonts**: Fonts for steam.

## Programming

* **arm-none-eabi-gcc, arm-none-eabi-newlib, avr-gcc, avr-libc, avrdude, dfu-programmer, dfu-util**: Need these for QMK (Arduino) projects.
* **bpython**: Interface for python interpreter.
* **yajl, jq**: JSON parser.
* **jre8-openjdk**: Open-source JAVA.
* **jupyter-nbconvert, jupyter-notebook, python-ipywidgets**: For Jupyter projects.
* **libmtp**: MTP protocol for phone.
* **python-matplotlib, python-pip, python2-service-identity, python-sympy, python-numpy, python-xdg**: Python stuff

## UI

* **arc-gtk-theme, gnome-theme-extra, gtk-engine-murrine**: Nice clean GTK themes and fallback.
* **awesome-terminal-fonts**: Powerline cons.
* **bspwm, sxhkd**: Window manager in X.
* **dunst**: Notification daemon.
* **elementary-icon-theme, papirus-icon-theme**: Icons.
* **feh**: Background utility for X.
* **i3lock**: Screen lock
* **noto-fonts-emoji**: Emoji fonts.
* **qt4, qt5-styleplugins**: QT stuff.
* **ttf-fira-mono, ttf-fira-sans, ttf-gentium, ttf-hack, ttf-liberation**: Fonts.

## Utilities

* **abcde, cdparanoia**: Audio encoding and CD ripping/burning.
* **arm**: Status for tor network.
* **atool, bzip2, gzip, p7zip, tar, unzip**: Archiving
* **blueberry, bluez, bluez-utils, bluez-libs, pulseaudio-bluetooth**: Bluetooth
* **calcurse**: Calender program
* **compton**: Compositor for X.
* **discount**: Markdown, text to html
* **efitools, sbsigntools**: For secure boot
* **freerdp**: Remote desktop protocol
* **git**: File versioning.
* **gtk2fontsel, gucharmap, xorg-xfontsel, xorg-xlsfonts**: Font selection
* **htop**: Process monitor
* **imagemagick**: Image editor.
* **mathjax**: For equation display in webpages (jupyter-notebook)
* **mpc, mpd, ncmpcpp**: MPD tools.
* **mpv**: Video player
* **msmtp, msmtp-mta, neomutt, notmuch, offlineimap**: Mailing tools.
* **neofetch**: Info displayer
* **neovim**: Text editor
* **ntp**: Network time
* **pass**: Password-store
* **pdfjs**: Javascript pdf viewer.
* **qemu**: Virtualization software
* **ranger, trash-cli**: File browser
* **redshift**: X screen dimmer.
* **reflector**: Package-base updater.
* **remind**: Calender
* **scrot**: Screenshot taker.
* **task**: Task list.
* **texlive-core, texlive-fontsextra, texlive-latexextra, texlive-pictures, texlive-pstricks, texlive-science**: LaTeX
* **tmux**: Multiplexer
* **tumbler**: Thumbnail requester.
* **w3m**: Terminal html parser.
* **weechat**: IRC client.
* **wireless_tools**: Helps Polybar
* **wmname**: Change name of window manager
* **xsel**: For copying emojis
* **xdg-user-dirs**: Handles linking of directories
* **youtube-dl**: Youtube downloader

## System

* **alsa-utils, lib32-alsa-plugins, lib32-libpulse, pamixer, pavucontrol, pulseaudio, pulseaudio-alsa**: Manipulate ALSA and PulseAudio.
* **bash-completion**: Something useful for OpenFOAM.
* **btrfs-progs**: Manipulate btrfs stuff.
* **gksu**: Prompt for sudo.
* **linux-headers, linux-lts-headers**: Headers for compilation.
* **linux-lts**: Long-term support kernel.
* **networkmanager, network-manager-applet, networkmanager-openconnect, networkmanager-openvpn, openconnect, openvpn**: Internet things.
* **polkit, polkit-gnome**: Policy manager, and authenticator.
* **refind-efi**: Bootloader.
* **snapper**: Btrfs snapshots
* **sshfs**: Mount through ssh
* **syncthing, syncthing-gtk**: File cloud
* **tlp**: Power management
* **udiskie, udisks2**: Automount manager.
* **wine**: Windows compatibility layer.
* **xfsprogs**: XFs utilitites
* **xorg-xinit, xorg-xinput, xorg-xprop, xorg-xsetroot, xorgproto**: X stuff.
* **zsh**: Shell


## Programs

* **audacity**: Sound editing.
* **biber**: Latex stuff
* **blender**: 3D graphics editor
* **cantata**: Music
* **deluge**: Torrent
* **GIMP**: Photoshop
* **gourmet**: Recipes
* **gparted**: Graphics frontend for parted.
* **inkscape**: Illustrator
* **libreoffice-fresh**: Office
* **nemo, nemo-python**: File browser
* **pdfsam**: PDF-manipulator
* **picard**: Music organizer
* **qutebrowser**: Internet browser
* **rofi**: Application launcher
* **smplayer**: Video player
* **steam, steam-native-runtime**: Gaming
* **stellarium**: Sky viewer
* **termite**: Terminal emulator
* **tor**: TOR network
* **virt-manager**: GUI for QEMU.
* **zathura-pdf-poppler**: PDF viewer
