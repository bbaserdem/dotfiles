# Apps Usage

This document contains information on how keybindings work with this system.

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

A list of packages in my installation and justifications for them.

Bolded are required by all installations. Bolded and italic are optional.

Aur packages are marked as AUR.

## Laptop specific
* **asus-fan-dkms-git**_[AUR]_: Fan DKMS modules for ASUS (laptop).
* **bbswitch**: Switched GPU depending on usage with bumblebee.
* **bluez**: Bluetooth implementation.
* **bluez-utils**: Bluetooth control.
* **bumblebee**: GPU switcher.
* **lib32-nvidia-utils**: Nvidia utils for 32bit apps.
* **lib32-primus**: Primusrun for 32bit applications. (Bumblebee)
* **lib32-virtualgl**: VirtualGL for 32bit apps. (Bumblebee)
* **networkmanager-openconnect**: Networkmanager integration for openconnect.
* **openconnect**: VPN protocol. (For CSHL)
* **primus**: Bridge for OpenGL.
* **pulseaudio-bluetooth**: Bluetooth module for pulseaudio.
* **refind**: Bootloader
* **tlp**: Power management.

## Workstation specific
* **grub**: Bootloader
* **os-prober**: Probes other OS's.

## System packages
* **clang**: C languages interpreter
* **gtk-engine-murrine**: Gui for apps.
* **lib32-alsa-plugins**: Alsa module for 32bit applications. (Games)
* **lib32-libpulse**: Pulse module for 32bit applications. (Games)
* **libmtp**: Used in communicating with android device.
* **mesa-demos**: Tests for GPU.
* **openssh**: SSH.
* **pulseaudio**: Sound mixer.
* **pulseaudio-alsa**: Integrates pulseaudio to ALSA mixer.
* **qt4**: GUI for apps.
* **qt5-base**: Qt5 qui.
* **sshfs**: Mount file systems through SSH using FUSE.
* **udisks2**: External device mounter

## Services
* **deluge**: Bittorrent client.
* **dropbox**_[AUR]_: Office file sharing software.
* **mpc**: Command line utility to control mpd.
* **mpd**: Daemon for music playback.
* **mpdscribble**_[AUR]_: Tool to scribble MPD playback to Last.fm.
* **mpv**: Video playback.
* **rslsync**_[AUR]_: Resilio sync.
* **tor**: Onion network.
* **sxhkd**: Keyboard shortcut daemon.

## Console Apps
* **abcde**: CD ripping utility
* **arm**: Tor status indicator.
* **atool**: Archive manager.
* **htop**: System resource viewer.
* **mutt**: Console email manager.
* **ncmpcpp**: MPD console client.
* **neofetch**_[AUR]_: Tool that displays system info.
* **oh-my-zsh-git**_[AUR]_: ZSH enhancer.
* **pass**: Password manager.
* **ranger**: Console based file manager.
* **tmux**: Terminal multiplexer.

## X Dependent Apps
* **blender**: 3D modelling program.
* **bspwm**: Tiling window manager.
* **dunst**: DBus notification daemon.
* **feh**: Image viewer and wallpaper manager.
* **i3lock**: Screen locker.
* **networkmanager-dmenu-git**_[AUR]_: Rofi-like network manager interface.
* **polybar-git**_[AUR]_: Status bar.
* **rdesktop**: Remote desktop.
* **redshift**: Screen dimmer for night time.
* **rofi-git**_[AUR]_: Application launcher.
* **rofi-pass-git**_[AUR]_: Pass integration for rofi.
* **rofi-top-git**_[AUR]_: System manager for rofi.
* **rxvt-unicode**: URxvt, terminal.
* **scrot**: Screenshot utility.
* **steam**: Steam for gaming.
* **steam-native-runtime**: Steam runtime helper.
* **tdrop-git**_[AUR]_: Tool to make a dropdown thing.
* **zathura-pdf-poppler**: PDF viewer.

### GTK
* **audacity**: Sound editing software.
* **blueberry**: Frontend for bluetooth.
* **firefox**: Web browser.
* **gimp**: Image editing program.
* **gtk2fontsel**: Font viewing program.
* **inkscape**: Vector image program.
* **pavucontrol**: Pulse control client
* **thunderbird**: Mail client.

### QT
* **picard**: Music tagging utility.
* **virtualbox**: Virtualization from Oracle.
* **virtualbox-host-modules-arch**: Virtualbox modules.
* **virtualbox-guest-iso**: Virtualbox guest OS helper CD.
* **smplayer**: Video player for mpv.

### X Tools
* **gcolor2**: Color selector
* **xclip**: Clipboard manager.
* **xdotool**: Mouse management.
* **xorg-xwininfo**: Window information utility.
* **xorg-xprop**: Displays information about X windows.

### Wayland Compatible
* **libreoffice-fresh**: Libreoffice for office stuff.
* **libreoffice-extension-languagetool**_[AUR]_: Spellcheck for libreoffice

## Internet
* **networkmanager-openvpn**: Networkmanager integration for openvpn.
* **openvpn**: VPN protocol. (For PIA)
* **private-internet-access-vpn**_[AUR]_: PIA client to use with openvpn.
* **python2-service-identity**: Used by deluge.
* **wireless\_tools**: Needed for internet interfaces

## Utilities
* **cdparanoia**: Utility for CD ripping.
* **flac**: Lossless audio codec.
* **hunspell-en**: Spellcheck for libreoffice.
* **imagemagick**: Command line tool for image manipulation.
* **rsync**: Directory copying.
* **stow**: Symlink maintainer.
* **tar**: Library for atool
* **w3m**: Used to render images in ranger.
* **wmname**: Used to make JAVA play nice.
* **unzip**: Library for atool

## Flair

### Fonts
* **awesome-terminal-fonts**: Glyphs for status bar.
* **ttf-gentium**: Proportional serif font.
* **ttf-hack**: Main sans-serif font.
* **ttf-iosevka**_[AUR]_: Thin sans-serif font.
* **gohufont**_[AUR]_: Used for terminal.
* **terminess-powerline-font-git**_[AUR]_: Console font, and powerline.
* **steam-fonts**_[AUR]_: Used for steam.

### Themes
* **arc-gtk-theme**: GTK3 theme.
* **gnome-themes-standard**: For GTK2 integration of Arc theme.
* **hicolor-icon-theme**: Most apps deposit their default icons here.
* **papirus-icon-theme-git**_[AUR]_: Icon set.
* **qt5-styeplugins**: GTK theme enabler for QT5.

## Developement
* **arm-none-eabi-gcc**: For QMK projects
* **arm-none-eabi-newlib**: For QMK projects
* **avr-dude**: Flashing utility for atmega chips.
* **avr-gcc**: For QMK
* **avr-libc**: For QMK
* **dfu-programmer**: For QMK.
* **jq**: JSON parser
* **jre8-openjdk**: Java library (for Matlab).
* **markdown**: Typesets markdown 
* **python-pip**: Python package manager.
* **python2-pip**: Python (old) package manager.
* **python-service-identity**: Python library. (deluge)
* **python2-service-identity**: Python library. (deluge)
* **texlive-most**: LaTeX implementation. 
