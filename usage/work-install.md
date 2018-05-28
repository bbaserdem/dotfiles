# Installation guide (Work)

Work computer should have Arch, as it has good packages, and is fairly stable.
Be careful about lts kernel and graphics drivers.

* [Arch](#debian)

# Computer

At the moment, my work computer is
[Dell Precision T7500 Workstation](http://www.dell.com/en-us/work/shop/desktop-and-all-in-one-pcs/dell-precision-t7500-tower-workstation/spd/precision-t7500)
which is what I used to have here previously.
Motherboard does not support UEFI booting.
One time boot menu is opened by pressing F12 on the boot splash.

# Arch

## Bootable USB

This computer does not have secure boot in it's BIOS (?) so did not set this up.
Using `dd` to write a usb works well.

## Partitioning

There is an 250 GB SSD, and 1 TB HDD on the system.
The HDD should have an encrypted home partition with XFS.
The SSD should house all linuxware, with a BHRFS filesystem, and swap space.

## Installation

Copy the process from laptop, but install seperate packages.
