# Installation guide (Work)

Work computer should have Debian, as it is pretty stable.
Some other experimental stuff can work well too, but that is later down the line.

* [Debian](#debian)

# Computer

At the moment, my work computer is
[Dell Precision T7500 Workstation](http://www.dell.com/en-us/work/shop/desktop-and-all-in-one-pcs/dell-precision-t7500-tower-workstation/spd/precision-t7500)
which is what I used to have here previously.
Motherboard does not support UEFI booting.
One time boot menu is opened by pressing F12 on the boot splash.

# Debian

## Bootable USB

This computer does not have secure boot in it's BIOS (?) so did not set this up.
Using `dd` to write a usb works well.

## Partitioning

There is an 250 GB SSD, and 1 TB HDD on the system.
The HDD should have an encrypted home partition with XFS.
The SSD should house all linuxware, with an EXT4 filesystem. And swap space.

## Installation

Follow the graphical installer, doing the partitioning etc.

* Existing LUKS volumes cannot be added as far as I can tell. Set them up later.
* For some reason, `/etc/apt/sources.list` ends up missing the non-updates repos.

Afterwards boot into the system.
