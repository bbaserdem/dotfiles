# Installation guide

I have multiple linux installations. This is my notes for installation.

# Computers

* [**Workstation**](#./Workstation.md) 
* [**Laptop**](#./Laptop.md)
* [**Server**](#./Server.md)
* [**Server**](#./Server.md)

# Bootable USB

`dd` will create read only disks (not good).
for now I'm having trouble setting up secureboot, but nontheless;
here are the steps that should be followed for a GPT with my secureboot keys.

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

# Partitioning

Tho exact partitioning changes from computer to computer.
However. I generally use btrfs for the root partition.
For the btrfs root partition; I use the following setup

* @root: mounted at /
* @snapshots: mounted at /.snapshots

The following should be the nested subvolumes

* *@root*/var/abs
* *@root*/var/cache/pacman/pkg
* *@root*/var/lib/machines
* *@root*/var/tmp
* *@root*/var/log
* *@root*/srv

For dual booting purposes, have */efi* point to ESP,
and have */boot* as a bind mount to */efi/EFI/Arch*.

## Installation

List existing devices with `lsblk`.
Randomize the drive;
```
cryptsetup open --type plain /dev/xxx container --key-file /dev/random
lsblk
dd if=/dev/zero of=/dev/mapper/container bs=1M status=progress
cryptsetup close container
```
Check the output of lsblk mid way to see if crypt is done successfully.
Now, run *parted xxx*.
Run `mklabel gpt` to write a new partition table.
Write the following partitions
```
gdisk /dev/xxx
o
n
1

+550M
ef00
n
2


8309
p
w
mkfs.fat -F32 /dev/xxx1
cryptsetup --key-size 512 --hash sha512 luksformat /dev/xxx2
cryptsetup open /dev/xxx2 cryptolvm
pvcreate /dev/mapper/cryptolvm
vgcreate Linux /dev/mapper/cryptolvm
lvcreate -L NG Linux -n Root
lvcreate -L NG Linux -n Swap
lvcreate -L NG Linux -n Home

mkfs.btrfs -L Arch /dev/mapper/Linux-Root
mkfs.xfs -L Home /dev/mapper/Linux-Home
mkswap -L Swap /dev/mapper/Linux-Swap
swapon /dev/mapper/Linux-Swap
mount /dev/mapper/Linux-Root /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o rw,nodiscard,noatime,nodiratime,compress=lzo,space_cache,subvol=@root /dev/mapper/Linux-Root /mnt
mkdir -p /mnt/{boot,efi,home,.snapshots,opt/VM}
mount /dev/xxx1 /mnt/efi
mkdir -p /mnt/efi/EFI/Arch
mount --bind /mnt/efi/EFI/Arch /mnt/boot
mount -o rw,nodiscard,noatime,nodiratime,compress=lzo,space_cache,subvol=@snapshots /dev/mapper/Linux-Root /mnt/.snapshots
mount -o /dev/mapper/Linux-Home /mnt/home
mkdir -p /mnt/var/cache/pacman
mkdir /mnt/var/lib
btrfs subvolume create /mnt/var/abs
btrfs subvolume create /mnt/var/cache/pacman/pkg
btrfs subvolume create /mnt/var/lib/machines
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/var/log
btrfs subvolume create /mnt/srv
```
This whole overhaul should have taken care of the partitioning.

## Installation

Check internet connection; this part is a bit involved so I rather get ethernet.
`wifi-menu` can help with wireless connection.
Run `pacman -Sy` to refresh database, then install reflector `pacman -S reflector`
Rank mirrors, then install OS, generate fstab and chroot.
```
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base
genfstab -U /mnt >> /mnt/etc/fstab`.
arch-chroot /mnt
```
Alternatively, add my repo to mirrors, and install the meta packages.

## Setup
Do the following steps to ensure that the system is bootable.

### Secure Boot
Put the `DB.key`, `DB.crt` and `DB.cer` for secure boot in `etc/sbkeys`.
These will be used both for signing the boot loader and the kernels.

### Initramfs
Now mkinitcpio needs to be configured for the decrypting hooks.
Change hooks to */etc/mkinitcpio.conf*
```
base systemd keyboard autodetect modconf block sd-vconsole sd-encrypt sd-lvm2 fsck filesystems
```
And afterwards run `mkinitcpio -P`

### Hostname
Set hostname by adding **sbpBLABLABLA** to */etc/hostname*.
Add matching entry (**127.0.1.1 sbplaptop.localdomain sbplaptop**) to */etc/hosts*

### User
Use `passwd` to set root password.
Run `useradd -m -G wheel -s /bin/zsh sbp`. Set password by running `passwd USER`
Login as user with `su - sbp`.
Copy the dotfiles git directory with `git clone git@github.com:bbaserdem/dotfiles.git .config`

### Setup
Enable multilib repository by uncommenting the corresponding line in `/etc/pacman.conf`.
Add my personal repo `WIP`.

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
Copy the SSH directory to home.
Run ssh-add on each key to add them to gpg-agent.
