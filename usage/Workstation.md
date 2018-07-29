# Workstation

General information about setting up my workstation computer.

# Computer

At the moment, my work computer is
[Dell Precision T7500 Workstation](http://www.dell.com/en-us/work/shop/desktop-and-all-in-one-pcs/dell-precision-t7500-tower-workstation/spd/precision-t7500)
Motherboard does not support UEFI booting, have to use GRUB. 🙄
One time boot menu is opened by pressing F12 on the boot splash.

## Bootable USB

This computer does not have secure boot in it's BIOS (?) so did not set this up.
Using `dd` to write a usb works well.

## Partitioning

There is an 250 GB SSD, and 1 TB HDD on the system.
The HDD should have an encrypted home partition with XFS.
The SSD should house all linuxware, with a BTRFS filesystem, and swap space.
