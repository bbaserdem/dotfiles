# Arch installation

## Todo

* *Base* Check where to install snapper configc with what permissions
* *Laptop* do udev installations.

## AUR
These packages are built from aur atm;

* bdf-tewi-git
* breeze-hacked-cursor-theme
* dfu-programmer
* dropbox
* gohufont
* libwm-git
* mpdscribble
* nemo-dropbox
* openvpn-update-systemd-resolved
* otf-nerd-fonts-fira-code
* pcmciautils
* polybar-git
* rofi-pass
* siji-git
* st
* terminess-powerline-font-git
* ttf-iosevka
* wmutils-git

No aur packages should be included within the base package.

# Archlinux Server

This repoesitory is a documentation and a how-to into hosting my own services on my old laptop. Don't know if viable or going over my head. These are in an order of importance

# Services
I'm probably stupid and all these should not end up on the same machine? Anyways . . .

## Syncthing
Use syncthing as a file synching service.

## Deluge
Mostly setting up VPN-split tunneling.

So, from what I understand, I can follow [this](https://www.htpcguides.com/force-torrent-traffic-vpn-split-tunnel-debian-8-ubuntu-16-04/) guide. However, I rather use nftables, and arch wiki suggests [this](https://github.com/jonathanio/update-systemd-resolved) script for integrating openvpn and systemd-resolved. So I am on my own on this one.

## Kodi
Use this to stream media accross my devices.

## MPD
Have central access to my music collection, and stream my own music library.

## Router
Should not need routers in the future, and have more control over internet security.

## Mailserver
Hosts my mail address.

## Webserver
Host a rudimentary website with blogposts and some files.

## Kodi
