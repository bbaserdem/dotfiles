# Gentoo Installation

I'm documenting here, and following from the handbook.


# Prepreation

I will be chrooting from another OS (Arch).
So I won't be including any prepatory work yet.
Also, I assume partitioning is done, and things are mounted at `/gentoo`.

# Portage

As I am speaking, I'm putting all the packages I install into set files
Organiving them with spaces for now, but will fix it later.
if emerge wants changes, run `etc-update` afterwards.

## Tarball

After setting up partitions, all I did was unpack it.

```
cd /gentoo
sudo tar xpvf /home/sbp/Downloads/stage3-amd64-20190124T214501Z.tar.xz --xattrs-include='*.*' --numeric-owner
```

Then chrooting (my chroot-os script needs /bin/bash as second argument) works.

## World Set

I picked `default/linux/amd64/17.0` even though I know it wont work on my comp.
Will get the latest kernel later.

```
emerge --sync
eselect profile list
eselect profile set 12
emerge --ask --verbose --update --deep --newuse @world
```

## USE

`emerge --info | grep ^USE` gives me

```
USE="acl amd64 berkdb bzip2 cli crypt cxx dri fortran gdbm iconv ipv6 libtirpc multilib ncurses nls nptl openmp pam pcre readline seccomp ssl tcpd unicode xattr zlib"
```

along with some other variables.

I set mine in `/etc/portage/make.conf` (From `/usr/portage/profiles/use.desc`)

```
...
# Use flags
USE="X acpi alsa apache2 bash-completion blas bluetooth branding calendar crypt cups curl cxx djvu exif fftw flac ftp geoip geolocation gif gibp git gtk imagemagick imap inotify javascript jpeg jpeg2k -kde lapack latex libcaca libnotify lm_sensors lzo maildir matroska mp3 mp4 mpeg mysql mtp multilib musicbrainz ncurses mysqli nas nntp pdf -plasma png policykit posix pulseaudio python raw rdp rss sound ssl tiff udev udisks unicode upower usb vdpau vim-syntax vorbis wavpack wayland wifi xft xscreensaver zip zsh-completion"
```

## Locale

Edited `/etc/timezone` and `/etc/locale.gen`.

## Kernel

To allow installation of production not-ready kernel; I have in `/etc/portage/package.accept_keywords`

```
# Kernel
sys-kernel/gentoo-sources ~amd64
```

Then I installed `genkernel` and changed `/etc/genkernel.conf`

```
# Run 'make menuconfig' before compiling this kernel?
MENUCONFIG="yes"
```

## Boot

So far keymap during decryption and then LVM does not work!

* Added `keymap="dvorak"` in `/etc/conf.d/keymaps`
* `rc-update add keymaps boot` is already run.
* `rc-update add consolefont boot` added.
* Merged `sys-fs/lvm2`
* `rc-update add lvm boot` added.
* Adding `dolvm` in kernel parameters.
* Running `genkernel --no-splash --keymap --luks --lvm --disklabel --microcode --keymap --menuconfig all`
* Actually modified `/etc/genkernel.conf` and enabled all the above.
* Removed the Logo from Driver/Graphics options
* Adding keymap=dvorak to kernel options.


## Configuration

In `/etc/conf.d/hostname`

```
# Set the hostname variable to the selected host name
hostname="sbplaptop"
```

And in `/etc/conf.d/net`

```
# Set the dns_domain_lo variable to the selected domain name
dns_domain_lo="selfnetwork"
config_wifi="dhcp"
config_ethernet="dhcp"
```

Ran `passwd` to set up password.
Put `dvorak` in `/etc/conf.d/keymaps`


## Network

Ran `emerge --ask --noreplace net-misc/netifrc`

To have the network interfaces activated at boot,
they need to be added to the default runlevel.

```
cd /etc/init.d
ln -s net.lo net.ethernet
ln -s net.lo net.wifi
rc-update add net.ethernet default
rc-update add net.wifi default
```

Put in `/etc/hosts`

```
127.0.0.1   sbplaptop.selfnetwork sbplaptop localhost
```

Besides that have not configured the network stuff yet.
Copying over dhcpd config.
For DNS, i want to use unbound, copied config from arch, fixing some systemd stuff.
Put in udev rules for network; same as arch.
Wifi was not detected, need r8822be driver, in `Device Drivers > Staging Drivers`
Wifi works after adding as a module.
Apparently unbound can automatically update the root-anchor file.
Run `su -s /bin/sh -c '/usr/sbin/unbound-anchor -a /etc/unbound/var/root-anchors.txt' unbound`

## Config

I am dropping some config files from Arch to Gentoo.
The following is a list of what I have done so far;

* `/etc/timezone`
* `/etc/locale.gen`
* `/etc/udev/rules.d/99-network.rules`
* `/etc/udev/rules.d/89-pulseaudio-usb.rules`

And here are some Gentoo specific configs

* `/etc/portage/make.conf`
* `/etc/genkernel.conf`
* `/etc/conf.d/keymaps`
* `/etc/portage/make.conf`
* `/etc/portage/sets/sbp-*`
* `/etc/sddm.conf`

And some scripts I have written to be put in /usr/bin or /bin

* <PLACEHOLDER>

## Graphical Interface

Evdev needs to be enabled in kernel.
I followed the X page, then followed the AMDGPU page; lots of kernel options.
Added to portage config `VIDEO_CARDS="amdgpu radeonsi"` and `INPUT_DEVICES="libinput"`
Installed SDDM (switching), added to `/etc/conf.d/xdm` `DISPLAYMANAGER="sddm"`
Touchpad not working.

Message `CONFIG_KEY_DH_OPERATIONS:	 is not set when it should be.`

## Applications

For logging. I'm using syslog-ng.

```
rc-update add consolefont boot
rc-update add udev sysinit
rc-update add udev-trigger sysinit
rc-update add syslog-nd default
rc-update add fcron default
rc-update add iwd default
rc-update add dhcpcd default
rc-update add unbound default
rc-update add xdm default
rc-update add dbus default
rc-update add consolekit default
rc-update add bluetooth default
rc-update add acpid default
rc-update add laptop_mode default
```

## Latest emerge what to do

```
SetUID: [chmod go-r] /usr/bin/sudo ...                                                            [ ok ]
 * To use the -A (askpass) option, you need to install a compatible
 * password program from the following list. Starred packages will
 * automatically register for the use with sudo (but will not force
 * the -A option):
 *
 *  [*] net-misc/ssh-askpass-fullscreen
 *      net-misc/x11-ssh-askpass
 *
 * You can override the choice by setting the SUDO_ASKPASS environmnent
 * variable to the program you want to use.

 * Messages for package sys-firmware/intel-microcode-20180807a_p20190204:

 * To avoid automounting and auto(un)installing with /boot,
 * just export the DONT_MOUNT_BOOT variable.

iwd
 *   CONFIG_KEY_DH_OPERATIONS:	 is not set when it should be.
 *   CRYPTO_DES3_EDE_X86_64: enable for increased performance
 * Please check to make sure these options are set correctly.
 * Failure to do so may cause unexpected problems.

 * Messages for package sys-kernel/linux-firmware-20190221-r1:

 * Your configuration for sys-kernel/linux-firmware-20190221-r1 has been saved in
 * /etc/portage/savedconfig/sys-kernel/linux-firmware-20190221-r1 for your editing pleasure.
 * You can edit these files by hand and remerge this package with
 * USE=savedconfig to customise the configuration.
 * You can rename this file/directory to one of the following for
 * its configuration to apply to multiple versions:
 * ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/
 * [${CTARGET}|${CHOST}|""]/${CATEGORY}/[${PF}|${P}|${PN}]
 * If you are only interested in particular firmware files, edit the saved
 * configfile and remove those that you do not want.

 * Messages for package app-shells/bash-completion-2.8:

 *
 * If you are interested in using the provided bash completion functions with
 * zsh, valuable tips on the effective use of bashcompinit are available:
 *   http://www.zsh.org/mla/workers/2003/msg00046.html

 * Messages for package sys-boot/refind-0.11.3:

 * rEFInd has been built and installed into /usr/share/refind-0.11.3
 * You will need to use the command 'refind-install' to install
 * the binaries into your EFI System Partition
 *
 * The new refind-mkdefault script requires >=dev-lang/python-3
 * to be installed
 *
 * Note that this installation will not update any EFI binaries
 * on your EFI System Partition - this needs to be done manually

 * Messages for package net-misc/youtube-dl-2019.03.09:

 * youtube-dl(1) / https://bugs.gentoo.org/355661 /
 * https://github.com/rg3/youtube-dl/blob/master/README.md#faq :
 *
 * youtube-dl works fine on its own on most sites. However, if you want
 * to convert video/audio, you'll need avconf (media-video/libav) or
 * ffmpeg (media-video/ffmpeg). On some sites - most notably YouTube -
 * videos can be retrieved in a higher quality format without sound.
 * youtube-dl will detect whether avconv/ffmpeg is present and
 * automatically pick the best option.
 *
 * Videos or video formats streamed via RTMP protocol can only be
 * downloaded when rtmpdump (media-video/rtmpdump) is installed.
 * Downloading MMS and RTSP videos requires either mplayer
 * (media-video/mplayer) or mpv (media-video/mpv) to be installed.
 *
 * If you want youtube-dl to embed thumbnails from the metadata into the
 * resulting MP4 files, consider installing media-video/atomicparsley

 * Messages for package sys-kernel/gentoo-sources-5.0.1:

 * Note: Even though you have successfully unmerged
 * your kernel package, directories in kernel source location:
 * /usr/src/linux-5.0.1-gentoo
 * with modified files will remain behind. By design, package managers
 * will not remove these modified files and the directories they reside in.
 * For more detailed kernel removal instructions, please see:
 * https://wiki.gentoo.org/wiki/Kernel/Removal

 * Messages for package sys-kernel/gentoo-sources-5.0.1:

 * If you are upgrading from a previous kernel, you may be interested
 * in the following document:
 *   - General upgrade guide: https://wiki.gentoo.org/wiki/Kernel/Upgrade

 * Messages for package sys-process/htop-2.2.0:

 * To use lsof features in htop(what processes are accessing
 * what files), you must have sys-process/lsof installed.

 * ERROR: net-vpn/openvpn-2.4.7-r2::gentoo failed (prepare phase):
 *   patch -p1  failed with /var/tmp/portage/net-vpn/openvpn-2.4.7-r2/files/openvpn-2.4.7-libressl.patch
 *
 * Call stack:
 *               ebuild.sh, line  124:  Called src_prepare
 *             environment, line 3821:  Called default
 *      phase-functions.sh, line  868:  Called default_src_prepare
 *      phase-functions.sh, line  933:  Called __eapi6_src_prepare
 *             environment, line  290:  Called eapply '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/files/openvpn-external-cmocka.patch' '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/files/openvpn-2.4.5-libressl-macro-fix.patch' '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/files/openvpn-2.4.7-libressl.patch'
 *             environment, line 1260:  Called _eapply_patch '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/files/openvpn-2.4.7-libressl.patch'
 *             environment, line 1198:  Called __helpers_die 'patch -p1  failed with /var/tmp/portage/net-vpn/openvpn-2.4.7-r2/files/openvpn-2.4.7-libressl.patch'
 *   isolated-functions.sh, line  119:  Called die
 * The specific snippet of code:
 *   		die "$@"
 *
 * If you need support, post the output of `emerge --info '=net-vpn/openvpn-2.4.7-r2::gentoo'`,
 * the complete build log and the output of `emerge -pqv '=net-vpn/openvpn-2.4.7-r2::gentoo'`.
 * The complete build log is located at '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/temp/build.log'.
 * The ebuild environment file is located at '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/temp/environment'.
 * Working directory: '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/work/openvpn-2.4.7'
 * S: '/var/tmp/portage/net-vpn/openvpn-2.4.7-r2/work/openvpn-2.4.7'

 * Messages for package sys-apps/mlocate-0.26-r2:

 * The database for the locate command is generated daily by a cron job,
 * if you install for the first time you can run the updatedb command manually now.
 *
 * Note that the /etc/updatedb.conf file is generic,
 * please customize it to your system requirements.

 * Messages for package app-shells/zsh-completions-0.30.0:

 *
 * If you happen to compile your functions, you may need to delete
 * ~/.zcompdump{,.zwc} and recompile to make the new completions available
 * to your shell.

 * Messages for package net-misc/dhcpcd-7.1.1-r1:

 *
 * If you activate the lookup-hostname hook to look up your hostname
 * using the dns, you need to install net-dns/bind-tools.


 * Messages for package sys-power/powertop-2.9:

 *   CONFIG_CPU_FREQ_STAT:	 is not set when it should be.
 * Please check to make sure these options are set correctly.
 * Failure to do so may cause unexpected problems.

 * Messages for package dev-embedded/dfu-programmer-0.7.2-r1:

 * To update device firmware as user you must be in the plugdev group:
 *
 * usermod -aG plugdev <user>

 * Messages for package app-backup/snapper-0.8.2:

 * In order to use Snapper, you need to set up
 * at least one config first. To do this, run:
 * snapper create-config <subvolume>
 * For more information, see man (8) snapper or
 * http://snapper.io/documentation.html

 * Messages for package app-emulation/qemu-3.1.0-r3:

 * If you don't have kvm compiled into the kernel, make sure you have the
 * kernel module loaded before running kvm. The easiest way to ensure that the
 * kernel module is loaded is to load it on boot.
 * For AMD CPUs the module is called 'kvm-amd'.
 * For Intel CPUs the module is called 'kvm-intel'.
 * Please review /etc/conf.d/modules for how to load these.
 *
 * Make sure your user is in the 'kvm' group. Just run
 * $ gpasswd -a <USER> kvm
 * then have <USER> re-login.
 *
 * For brand new installs, the default permissions on /dev/kvm might not let
 * you access it.  You can tell udev to reset ownership/perms:
 * $ udevadm trigger -c add /dev/kvm
 *
 * If you want to register binfmt handlers for qemu user targets:
 * For openrc:
 * # rc-update add qemu-binfmt
 * For systemd:
 * # ln -s /usr/share/qemu/binfmt.d/qemu.conf /etc/binfmt.d/qemu.conf
 *
 * (Note: Above message is only printed the first time package is
 * installed. Please look at /usr/share/doc/qemu-3.1.0-r3/README.gentoo*
 * for future reference)

 * Messages for package app-admin/sudo-1.8.27-r1:

 * To use the -A (askpass) option, you need to install a compatible
 * password program from the following list. Starred packages will
 * automatically register for the use with sudo (but will not force
 * the -A option):
 *
 *  [*] net-misc/ssh-askpass-fullscreen
 *      net-misc/x11-ssh-askpass
 *
 * You can override the choice by setting the SUDO_ASKPASS environmnent
 * variable to the program you want to use.

 * Messages for package media-fonts/droid-113-r5:

 * The following fontconfig configuration files have been installed:
 *
 *   59-google-droid-sans-mono.conf
 *   59-google-droid-sans.conf
 *   59-google-droid-serif.conf
 *
 * Use `eselect fontconfig` to enable/disable them.

 * Messages for package media-fonts/roboto-2.138:

 * The following fontconfig configuration files have been installed:
 *
 *   90-roboto-regular.conf
 *
 * Use `eselect fontconfig` to enable/disable them.

 * Messages for package x11-wm/i3-4.16:

 * There are several packages that you may find useful with i3 and
 * their usage is suggested by the upstream maintainers, namely:
 *   x11-misc/dmenu
 *   x11-misc/i3status
 *   x11-misc/i3lock
 * Please refer to their description for additional info


 * blas has been eselected to reference

 * Messages for package sci-libs/lapack-reference-3.7.0:

 * lapack has been eselected to reference

 * Messages for package media-fonts/source-pro-20170111:

 * The following fontconfig configuration files have been installed:
 *
 *   63-source-pro.conf
 *
 * Use `eselect fontconfig` to enable/disable them.

 * Messages for package app-office/libreoffice-bin-6.1.5.2:

 * If you plan to use lbase application you should enable java or you will get various crashes.

 * Messages for package media-fonts/terminus-font-4.47:

 * The following fontconfig configuration files have been installed:
 *
 *   75-yes-terminus.conf
 *
 * Use `eselect fontconfig` to enable/disable them.

 * Messages for package media-video/mpv-0.29.1-r1:

 * If you want to have command-line completion via bash-completion,
 * please install app-shells/mpv-bash-completion.
 * If you want URL support, please install net-misc/youtube-dl.

 * Messages for package dev-python/PyQt5-5.10.1-r1:

 * ERROR: dev-python/PyQt5-5.10.1-r1::gentoo failed (compile phase):
 *   emake failed
 *
 * If you need support, post the output of `emerge --info '=dev-python/PyQt5-5.10.1-r1::gentoo'`,
 * the complete build log and the output of `emerge -pqv '=dev-python/PyQt5-5.10.1-r1::gentoo'`.
 * The complete build log is located at '/var/tmp/portage/dev-python/PyQt5-5.10.1-r1/temp/build.log'.
 * The ebuild environment file is located at '/var/tmp/portage/dev-python/PyQt5-5.10.1-r1/temp/environment'.
 * Working directory: '/var/tmp/portage/dev-python/PyQt5-5.10.1-r1/work/PyQt5_gpl-5.10.1-python2_7'
 * S: '/var/tmp/portage/dev-python/PyQt5-5.10.1-r1/work/PyQt5_gpl-5.10.1'

 * Messages for package dev-python/qtconsole-4.3.1:

 * emerge --keep-going: dev-python/qtconsole-4.3.1 dropped because it requires
 * dev-python/PyQt5[python_targets_python2_7(-),python_targets_python3_6(-),-p
 * ython_single_target_python2_7(-),-python_single_target_python3_4(-),-python
 * _single_target_python3_5(-),-python_single_target_python3_6(-),-python_sing
 * le_target_python3_7(-),svg]

 * Messages for package dev-python/spyder-4.0.0_beta1:

 * emerge --keep-going: dev-python/spyder-4.0.0_beta1 dropped because it
 * requires dev-python/qtconsole[python_targets_python2_7(-),python_targets_py
 * thon3_6(-),-python_single_target_python2_7(-),-python_single_target_python3
 * _5(-),-python_single_target_python3_6(-)], dev-python/QtPy[python_targets_p
 * ython2_7(-),python_targets_python3_6(-),-python_single_target_python2_7(-),
 * -python_single_target_python3_5(-),-python_single_target_python3_6(-),svg,w
 * ebengine], dev-python/PyQt5[python_targets_python2_7(-),python_targets_pyth
 * on3_6(-),-python_single_target_python2_7(-),-python_single_target_python3_5
 * (-),-python_single_target_python3_6(-),svg,webengine], dev-python/PyQt5[pyt
 * hon_targets_python2_7(-),python_targets_python3_6(-),-python_single_target_
 * python2_7(-),-python_single_target_python3_5(-),-python_single_target_pytho
 * n3_6(-),svg,webengine]

 * Messages for package dev-python/QtPy-1.4.0-r1:

 * emerge --keep-going: dev-python/QtPy-1.4.0-r1 dropped because it requires
 * dev-python/PyQt5[python_targets_python2_7(-),python_targets_python3_6(-),-p
 * ython_single_target_python2_7(-),-python_single_target_python3_4(-),-python
 * _single_target_python3_5(-),-python_single_target_python3_6(-),svg,webkit,w
 * ebengine]


 * Messages for package app-emulation/libvirt-5.0.0:

 * Important: The openrc libvirtd init script is now broken up into two
 * separate services: libvirtd, that solely handles the daemon, and
 * libvirt-guests, that takes care of clients during shutdown/restart of the
 * host. In order to reenable client handling, edit /etc/conf.d/libvirt-guests
 * and enable the service and start it:
 *
 * $ rc-update add libvirt-guests
 * $ service libvirt-guests start
 *
 *
 * For the basic networking support (bridged and routed networks) you don't
 * need any extra software. For more complex network modes including but not
 * limited to NATed network, you can enable the 'virt-network' USE flag. It
 * will pull in required runtime dependencies
 *
 *
 * If you are using dnsmasq on your system, you will have to configure
 * /etc/dnsmasq.conf to enable the following settings:
 *
 * bind-interfaces
 * interface or except-interface
 *
 * Otherwise you might have issues with your existing DNS server.
 *
 *
 * For openrc users:
 *
 * Please use /etc/conf.d/libvirtd to control the '--listen' parameter for
 * libvirtd.
 *
 * Use /etc/init.d/libvirt-guests to manage clients on restart/shutdown of
 * the host. The default configuration will suspend and resume running kvm
 * guests with 'managedsave'. This behavior can be changed under
 * /etc/conf.d/libvirt-guests
 *
 *
 * For systemd users:
 *
 * Please use /etc/systemd/system/libvirtd.service.d/00gentoo.conf
 * to control the '--listen' parameter for libvirtd.
 *
 * The configuration for the 'libvirt-guests.service' is found under
 * /etc/libvirt/libvirt-guests.conf"
 *
 *
 * If you have built libvirt with policykit support, a new group "libvirt" has
 * been created. Simply add a user to the libvirt group in order to grant
 * administrative access to libvirtd. Alternatively, drop a custom policykit
 * rule into /etc/polkit-1/rules.d.
 *
 * If you have built libvirt without policykit support (USE=-policykit), you
 * must change the unix sock group and/or perms in /etc/libvirt/libvirtd.conf
 * in order to allow normal users to connect to libvirtd.
 *
 *
 * If libvirtd is built with USE=caps, libvirt will now start qemu/kvm VMs
 * with non-root privileges. Ensure any resources your VMs use are accessible
 * by qemu:qemu.
 *
 * (Note: Above message is only printed the first time package is
 * installed. Please look at /usr/share/doc/libvirt-5.0.0/README.gentoo*
 * for future reference)

 * The following 5 packages have failed to build, install, or execute
 * postinst:
 *
 *  (dev-python/PyQt5-5.10.1-r1:0/0::gentoo, ebuild scheduled for merge), Log file:
 *   '/var/tmp/portage/dev-python/PyQt5-5.10.1-r1/temp/build.log'
 *  (dev-python/qtconsole-4.3.1:0/0::gentoo, ebuild scheduled for merge)
 *  (dev-python/spyder-4.0.0_beta1:0/0::gentoo, ebuild scheduled for merge)
 *  (dev-python/QtPy-1.4.0-r1:0/0::gentoo, ebuild scheduled for merge)
 *  (media-sound/tuxguitar-1.3.2:0/0::gentoo, ebuild scheduled for merge), Log file:
 *   '/var/tmp/portage/media-sound/tuxguitar-1.3.2/temp/build.log'
```
