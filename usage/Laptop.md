# Laptop

General information about setting up my laptop.

# Hardware

[*ASUS ROG Strix GL702ZC*](https://www.asus.com/us/Laptops/ROG-Strix-GL702ZC/),
chosen for its AMD hardware, and a nice cooling solution.

# Secure Boot

Currently, the BIOS freezes when I try to import my own keys, ~~so will have to
use `KeyTool` to add my keys.~~ (Bricked computer, DO NOT ATTEMPT.)

## Partitioning

* ***sdX1***: EFI System Partition, should be 551 MiB.
* ***sdX2***: LUKS container for LVM. (LVM is ***Linux***)
* ***Linux-Swap***: Swap partition. 20 GB
* ***Linux-Gentoo***: Future partition to install Gentoo, as btrfs 30 GB
* ***Linux-Arch***: Arch root partition as btrfs; 50 GB
* ***Linux-Virtual***: Store virtual images as ext4; 70GB
* ***Linux-Home***: Home partition, as xfs. ~700GB.

The root should also have; besides main installation, *@opt* mounted at /opt.
