# Server

This is an overview of my server.

# Hardware

It's a fitlet2 from Compulab.

# Services

I want to have multiple services running on this thing, and will do a breakdown
here.

* SSH access
* Router
* Git server
* Media streaming
* Software repository
* File synching
* Torrenting
* Mail server
* Web server
* VPN

# Admin user

## SSH access

* Enable sshd service for ssh access.
* Create a user to use server

## Router

Eventually, I want to be able to use the fitlet as a router, so I can implement
software firewall.

For now, I need to set up just the firewall. Ports that need enabling are;

* HTTP, HTTPS, DNS
* SSH
* MPD control (6600)
* Syncthing web interface (8384)
* Transmission web interface (???)

## Git

Want to use my own web address as a git repository.

* Need to setup user; `useradd -d /srv/git -m -g -s /usr/bin/git-shell git`
* SSH key folder: `mkdir /srv/git/.ssh`, `chown git:git /srv/git/.ssh`, `chmod 700 /srv/git/.ssh`
* Create authorized keys: `touch /srv/git/.ssh/authorized_keys`,
`chown git:git /srv/git/.ssh/authorized_keys`, `chmod 600 /srv/git/.ssh/authorized_keys`
* Need to send ssh keys: `ssh-copy-id git@sbpserver.EXAM.PL`

## Media

I want to use Kodi to stream my media in home, and maybe out of home as well.
I need to setup MariaDB and Apache on the server once I have the files.

* Generate config with `mysql_install_db --user=mysql --basedir=/usr --datadir=/srv/mysql`.
* Change `datadir=/srv/mysql` under `[mysqld]` in `/etc/mysql/my.cnf`
* Start thu mariadb service `systemctl enable mariadb.service`

Also, want to set up mpd;

* Change mpd user directory `usermod -d /srv/mpd -m mpd`.

## Software repository

There are two things I want. One is to build my own PKGBUILDS on the server.
Two is keeping the AUR packages prebuilt in my repository.
This will not work for everything; (lapack, etc.) but should be OK.

Need to;

* Enable ftp.
* Set up notifications for updates in AUR.
* Point repo to here

## File synching

Going to be using syncthing for this.

* Need to setup user; `useradd -d /srv/syncthing -m -g -s /usr/bin/nologin syncthing`
* Enable syncthing; `systemctl enable syncthing@syncthing.service`
* At `/srv/syncthing/.config/syncthing/config.xml` change IP from
`127.0.0.1:8384` to `0.0.0.0:8384`.
* Setup password and https.

## Torrenting

* Change transmission user directory `usermod -d /srv/transmission -m transmission`.
* Enable daemon `systemctl enable transmission.service`
* Allow remote access to web interface.
* Setup split tunneling, 

## Mail

Use dovecot, postfix and rspamd.

## Web server

For blog. Fill in later.

## VPN

I want to be able to VPN to US when I'm abroad.
