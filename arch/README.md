# Arch packages

This directory contains my packages for maintaining arch

## System

Packages to build the operating system
This directory contains `sbp-sys`, which have;

* **sbp-sys-base**: Common package to get system running.
* **sbp-sys-uefi**: Boot stuff for UEFI compliant systems.
* **sbp-sys-bios**: Boot stuff for BIOS compliant systems.
* **sbp-sys-arch**: Systemd based dependencies.
* **sbp-sys-artix**: OpenRC based system (incomplete).

All the packages here are dependent on the base one.
Base package requites a boot and an init implementation.
The implementations themselves are mutually exclusive.

## Desktop

This directory contains `sbp-gui`, which has;

* **sbp-gui-base**: Common gui programs and libraries
* **sbp-gui-xfce**: The XFCE desktop
* **sbp-gui-sway**: Sway desktop (for wayland)
* **sbp-gui-bspwm**: Bspwm desktop
* **sbp-gui-pantheon**: Pantheon desktop (incomplete)

All packages are dependent on the base one.
Between themselves, they have no interdependence.

## Hardware

Packages to auto-configure the computers that I have.
This directory contains `sbp-cmp`, which has;

* **sbp-cmp-laptop**: My main laptop; which is
[ASUS ROG Strix GL702ZC](https://www.asus.com/us/Laptops/ROG-Strix-GL702ZC/)
* **sbp-cmp-notebook**: My laptop on the go; which is
[ASUS N550JK](https://www.asus.com/us/Laptops/N550JK/)
* **sbp-cmp-workstation**: My PC at work; which is
[Dell Precision T7500 Tower Workstation](https://www.dell.com/en-us/work/shop/desktop-and-all-in-one-pcs/dell-precision-t7500-tower-workstation/spd/precision-t7500)
* **sbp-cmp-server**: My small form PC meant to be my server; which is
[CompuLab fitlet2]([https://fit-iot.com/web/products/fitlet2/) (WIP)

As understandable, they are mutually exclusive with each other.

## Archlinux Server

This repoesitory is a documentation and a how-to into hosting my own services on my old laptop. Don't know if viable or going over my head. These are in an order of importance

### Syncthing
Use syncthing as a file synching service.

### Deluge
Mostly setting up VPN-split tunneling.

So, from what I understand, I can follow [this](https://www.htpcguides.com/force-torrent-traffic-vpn-split-tunnel-debian-8-ubuntu-16-04/) guide. However, I rather use nftables, and arch wiki suggests [this](https://github.com/jonathanio/update-systemd-resolved) script for integrating openvpn and systemd-resolved. So I am on my own on this one.

### Kodi
Use this to stream media accross my devices.

### MPD
Have central access to my music collection, and stream my own music library.

### Router
Should not need routers in the future, and have more control over internet security.

### Mailserver
Hosts my mail address.

### Webserver
Host a rudimentary website with blogposts and some files.

### Kodi

## AUR
List of AUR packages that I build here

* aurutils
* bdf-tewi-git
* dfu-programmer
* dropbox
* fdroidserver
* gohufont
* libwm-git
* mpdscribble
* nemo-dropbox
* openvpn-update-systemd-resolved
* otf-nerd-fonts-fira-code
* polybar-git
* rofi-pass
* rofi-emoji
* siji-git
* terminess-powerline-font-git
* ttf-iosevka
* wmutils-git
* libwm-git
* brightnessctl
* steam-fonts
* wpa\_supplicant\_gui
* tzupdate
* xgetres
* taskopen
* rasdaemon
* skypeforlinux-stable-bin
* rambox-bin
* lightdm-webkit2-greeter
* lightdm-webkit2-theme-aether
* neovim-gtk-git
* otf-hasklig
