# Installation guide

Generic installation guide for my systems.

Click to jump to a section

* [Server](#server)
* [Laptop](#laptop), using Arch.
* [Workstation](#workstation), using Debian.
* [Homestation](#homestation), using Void.

# Preamble

## Host name

In all my computers, the host name should correspond to `sbp<COMPUTER>`, as in
my laptop host name would be `spblaptop`, and so on. (SBP being the acronym for
my screen-name)
This is quite vital, as my configs do computer detection by resolving the
hostname, 


## Bootable USB

For creating a bootable media, `dd` is common to use.
In fact for BIOS compatibility, it is exactly what I will use;
```
dd bs=4M if=XXX.iso of=/dev/sd? status=progress oflag=sync
```

I will need to sign the bootloaders for secure boot purposes,
and `dd` will create read only disks (not good).
Here are the steps that should be followed for a GPT with my secureboot keys.

* Install the ISO
* Write new partition table to USB disk. (`parted /dev/sd? mktable gpt`)
* Put a single partiton to USB disk. (`parted /dev/sd? mkpart primary fat32 1MiB 100%`)
* Change partition name to appropriate (`parted /dev/sd? name 1 'XXXXISO_20YYZZ'`)
* Make partition bootable (`parted /dev/sd? set 1 boot on`)
* Copy the contents of the iso to the new USB (`7z x XXX.iso -o/mnt/`)
* Sign the EFI bootloaders (`sbsign --key db.key --cert db.crt --output BLA BLA`)

For the archiso, the required files to sign are following;
```
vmlinuz
loader.efi
```

# Server

Currently, I do not have any servers set up.
If I do, I'll document setup here.
For configuration of a server account, check out [server configuration](conf-server.md).

# Laptop

My laptop is the
[ASUS ROG Strix GL702ZC](https://www.asus.com/us/Laptops/ROG-Strix-GL702ZC/),
chosen for its AMD hardware, and a nice cooling solution.
For setting up the system after installation, check out [laptop configuration](conf-laptop.md).

## Secure Boot

Currently, the BIOS freezes when I try to import my own keys, so will have to
use `KeyTool` to add my keys.

## Partitioning

* ***sdX1***: EFI System Partition, should be 512 MiB.
* ***sdX2***: LUKS container for LVM. (LVM is ***Linux***)
* ***Linux-Swap***: Swap partition. 30 GB
* ***Linux-Gentoo***: Future partition to install Gentoo, as ext4. 20 GB
* ***Linux-Arch***: Arch root partition as btrfs; 100 GB
* ***Linux-Home***: Home partition, as xfs. ~700GB.

For the btrfs root partition, the following subvolumes should be created;

* @: mounted at /
* @snapshots: mounted at /.snapshots

The following should be the nested subvolumes

* *@*/var/abs
* *@*/var/cache/pacman/pkg
* *@*/var/lib/machines
* *@*/var/tmp
* *@*/srv

## Installation

List existing devices with `lsblk`.
Randomize the drive;
```
cryptsetup open --type plain /dev/sdX container --key-file /dev/random
lsblk
dd if=/dev/zero of=/dev/mapper/container bs=1M status=progress
cryptsetup close container
```
Check the output of lsblk mid way to see if crypt is done successfully.
Now, run *parted <SSD>*.
Run `mklabel gpt` to write a new partition table.
Write the following partitions
```
parted /dev/sdX
mklabel gpt
mkpart ESP fat32 1MiB 513MiB
set 1 boot on
mkpart primary 513MiB 870GiB
quit
mkfs.fat -F32 /dev/sdX1
cryptsetup --key-size 512 --hash sha512 luksformat /dev/sdX2
cryptsetup open /dev/sdX2 cryptolvm
pvcreate /dev/mapper/cryptolvm
vgcreate Linux /dev/mapper/cryptolvm
lvcreate -L 30G Linux -n Swap
lvcreate -L 20G Linux -n Gentoo
lvcreate -L 100G Linux -n Arch
lvcreate -l 100%FREE Linux -n Home
mkfs.btrfs -L Arch /dev/mapper/Linux-Arch
mkfs.ext4 -L Gentoo /dev/mapper/Linux-Gentoo
mkfs.xfs -L Home /dev/mapper/Linux-Home
mkswap -L Swap /dev/mapper/Linux-Swap
swapon /dev/mapper/Linux-Swap
mount /dev/mapper/Linux-Arch /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o rw,discard,noatime,compress=lzo,space_cache,ssd,subvol=@root /dev/mapper/Linux-Arch /mnt
mkdir -p /mnt/{boot,home,.snapshots,backup}
mount /dev/sdX1 /mnt/boot
mount -o rw,discard,noatime,compress=lzo,space_cache,ssd,subvol=@snapshots /dev/mapper/Linux-Arch /mnt/.snapshots
mount -o defaults /dev/mapper/Linux-Home /mnt/home
mkdir -p /mnt/var/cache/pacman
mkdir /mnt/var/lib
btrfs subvolume create /mnt/var/abs
btrfs subvolume create /mnt/var/cache/pacman/pkg
btrfs subvolume create /mnt/var/lib/machines
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/srv
```
This whole overhaul should have taken care of the partitioning.

## Installation

Check internet connection; this part is a bit involved so I usually hook up an
ethernet cable.
Run `pacman -Sy` to refresh database, then install reflector `pacman -S reflector`
Rank mirrors, then install OS, generate fstab and chroot.
```
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel btrfs-progs xfs-progs git zsh neovim
genfstab -U /mnt >> /mnt/etc/fstab`.
arch-chroot /mnt
```

## Setup
Do the following steps to ensure that the system is bootable.

### Secure Boot
Put the `db.key`, `db.crt` and `db.cer` for secure boot in `etc/refind.d/keys`
and rename the `db` to `refind_local`.
These will be used both for signing the boot loader and the kernels.

### Initramfs
Now mkinitcpio needs to be configured for the decrypting hooks.
Add the following hooks to */etc/mkinitcpio.conf*
```
HOOKS="... udev ... keyboard block encrypt consolefont resume lvm2 ... filesystems ..."
```
And afterwards run `mkinitcpio -p linux`

### Hostname
Set hostname by adding **hostname** to */etc/hostname*.
Add matching entry (**127.0.1.1 hostname.localdomain hostname**) to */etc/hosts*

### User
Use `passwd` to set root password.
Run `useradd -m -G wheel -s /bin/zsh silverbluep`. Set password by running `passwd USER`
Run `EDITOR=nvim visudo`, and uncomment the line `%wheel ALL=(ALL) ALL` and save
for sudo access.
Login as user with `su - silverbluep`.
Run `mkdir {Downloads,Documents,Pictures,Music,Videos,Configs,Phone,Research}`
Copy the dotfiles git directory with `git clone git@github.com:bbaserdem/dotfiles.git .config`

### Setup
Enable multilib repository by uncommenting the corresponding line in
`/etc/pacman.conf`. Install trizen by
```
cd /tmp
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
cd ~
```
Install packages with
```
sudo pacman -S < .config/usage/pkg-laptop
trizen -S < .config/usage/pkgaur-laptop
```

Run the `setup-laptop.sh` after all the steps to finish setting up.
Check `rEFInd` config to make sure and fix the UUID's.

To enable auto-login on tty1, run `sudo -E systemctl edit getty@tty1.service`,
This is a drop in script, (-E to use nvim as editor); and add these lines
```
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin user --noclear %I $TERM
Type=simple
```

### GPG and SSH
Import GPG subkey from my usb. by running `gpg --import <keyfiles>`
for both the public and the secret subkey.
Run `gpg --edit-key <keyfiles>`, and `trust` to set ultimate trust to keys.
Then run `git config --global commit.gpgsign true` for signing commits.
Copy the SSH directory to `.config/stwofiles`.


