# BBASERDEM Arch installation

## Todo

* *Base* Check where to install snapper configc with what permissions
* *Laptop* do udev installations.

## AUR
These packages build from aur atm;

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

# Server setup

I want to have multiple services running in my computer.

* Enable sshd sercive for ssh access.
* Create a user to use server

## Git

* Need to setup user; `useradd -d /srv/git -m -g -s /usr/bin/git-shell git`
* SSH key folder: `mkdir /srv/git/.ssh`, `chown git:git /srv/git/.ssh`, `chmod 700 /srv/git/.ssh`
* Create authorized keys: `touch /srv/git/.ssh/authorized_keys`,
`chown git:git /srv/git/.ssh/authorized_keys`, `chmod 600 /srv/git/.ssh/authorized_keys`
* Need to send ssh keys: `ssh-copy-id git@sbpserver.EXAM.PL`

## Syncthing

* Need to setup user; `useradd -d /srv/syncthing -m -g -s /usr/bin/nologin syncthing`
* Enable syncthing; `systemctl enable syncthing@syncthing.service`
* At `/srv/syncthing/.config/syncthing/config.xml` change IP from
`127.0.0.1:8384` to `0.0.0.0:8384`.
* Setup password and https.

## Transmission

* Change transmission user directory `usermod -d /srv/transmission -m transmission`.
* Enable daemon `systemctl enable transmission.service`
* Allow remote access to web interface.
* Setup split tunneling, 

## MariaDB + Apache

* Generate config with `mysql_install_db --user=mysql --basedir=/usr --datadir=/srv/mysql`.
* Change `datadir=/srv/mysql` under `[mysqld]` in `/etc/mysql/my.cnf`
* Start thu mariadb service `systemctl enable mariadb.service`

## Mpd

Need to figure out how network outn to pulse audio for streaming.

* Change mpd user directory `usermod -d /srv/mpd -m mpd`.

## Mail

Use dovecot, postfix and rspamd.
