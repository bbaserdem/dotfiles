Use this document as a rought guide for installation.
This version is meant for my laptop.

# Issues

* Fix problem with mounting FAT32 as root permissions only.
* Back up LUKS headers.

# Hardware


# System Partitioning

* sdb1: BTRFS - 234GB - Linux
* sdc1: LUKS - 900GB - Encrypted home
* sdc2: SWAP - 32GB - Swap file

## LUKS

Encrypted home partition with XFS

## BTRFS
The BTRFS has the following mounted subvolume structure;

* @: mounted at /
* @snapshots: mounted at /.snapshots

The following should be the nested subvolumes

* *@*/var/abs
* *@*/var/cache/pacman/pkg
* *@*/var/lib/machines
* *@*/var/tmp
* *@*/srv

## Preliminary

List existing devices with `lsblk`.
Now, run *fdisk <SSD>*, and type `onp` to write partition table and partition.
Do with the HDD as well.

## LVM on LUKS

Do the following on the HDD
```
cryptsetup luksFormat <HDD1>
cryptsetup open <HDD1> cryptohome
pvcreate /dev/mapper/cryptohome
vgcreate Arch /dev/mapper/cryptohome
lvcreate -L 32G Arch -n swap
lvcreate -l 100%FREE Arch -n home
```
Now make filesystems
```
mkfs.btrfs <SSD>1
mkfs.xfs /dev/mapper/Arch-me
mkswap /dev/mapper/Arch-swap
```
Prepare the btrfs system
```
mount <SSD>1 /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o rw,discard,noatime,compress=lzo,space_cache,ssd,subvol=@root <SSD>1 /mnt
mkdir /mnt/{home,.snapshots}
mount -o rw,discard,noatime,compress=lzo,space_cache,ssd,subvol=@snapshots <SSD>1 /mnt/.snapshots
mount /dev/mapper/Arch-home /mnt/home
swapon /dev/mapper/Arch-swap
mkdir -p /mnt/var/cache/pacman
mkdir /mnt/var/lib
btrfs subvolume create /mnt/var/abs
btrfs subvolume create /mnt/var/cache/pacman/pkg
btrfs subvolume create /mnt/var/lib/machines
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/srv
```
Subwolumes can be checked by running `btrfs subvolume list /mnt`

## Installation

Set up mirrors.
* Back up existing mirrors; `cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup`
* May have to run `pacman -Syu` before.
* Install reflector `pacman -S reflector`
* Rank the 6 fastest mirrors. `reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist`

After this, run the installation with `pacstrap /mnt base base-devel btrfs-progs`.
Run `genfstab -U /mnt >> /mnt/etc/fstab` and check fstab.
Chroot into system with `arch-chroot /mnt`.

# Setup

## Tools

Install the following to make life easier.

* zsh
* neovim
* sudo
* networkmanager
* linux-headers
* linux-lts-headers
* nvidia-340xx-dkms
* expac
* yajl
* reflector
* git
* gnupg
* ntp
* ntfs-3g
* lm_sensors
* grub
* openssh
* stow
* xorg-xinit

## Initramfs

Now mkinitcpio needs to be configured.
Add `consolefont` (after block) to **HOOKS** in */etc/mkinitcpio.conf*
and run `mkinitcpio -p linux`.

## GRUB

Run `grub-install <SSD>` to install.
Then run `grub-mkconfig -o /boot/grub/grub.cfg` to generate.
Add the following line to */etc/crypttab* to prompt the decryption prompt at boot;
```
cryptolvm   UUID=<HDD-LUKS partition>   none    luks
```
And edit the lines in **/etc/fstab** to reflect the changes, replacing UUIDs with mapper names.

## User
Use `passwd` to set root password.
Run `useradd -m -G wheel -s /bin/zsh USER`. Set password by running `passwd USER`
Run `EDITOR=nvim visudo`, and uncomment the line `%wheel    ALL=(ALL) ALL` and save.
This allows access for the wheel group to use sudo.
Reboot and login as the user, and confirm sudo works.
Run `sudo passwd -l root` to disable root login. (-u options enables it again)
(`su` loses functionality, but `sudo -i` allows for root login again)
Run `mkdir {Downloads,Documents,Pictures,Music,Videos,Configs}`
To set hostname, do the following; 
Set hostname by adding **hostname** to */etc/hostname*.
Add matching entry (**127.0.1.1 hostname.localdomain hostname**) to */etc/hosts*
To enable auto-login on tty1, run `sudo -E systemctl edit getty@tty1.service`.
This is a drop in script, (-E to use nvim as editor); and add these lines;
```
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin <user> --noclear %I $TERM
Type=simple
```

## Internet

Enable *NetworkManager.service*.
To rank mirrors, make a backup of previous mirrors, and run `reflector`.
```
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
```
Sytemd unit and timer are in *files* to do daily ranks.
Edit them as preferred and move them to */etc/systemd/system/*.
Then enable (and start) **reflector.timer**.

### AUR from Pacaur
To install pacaur do the following steps. (Try without the keys first)
```
cd /tmp
git clone https://aur.archlinux.org/pacaur.git
git clone https://aur.archlinux.org/cower.git
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
cd cower && makepkg -si %% cd -
cd pacaur && makepkg -si %% cd -
```

## Hardware and Configuration
Some hardware needs to be tweaked.

### Graphics Drivers
The workstation has a *NVIDIA G96GL [Quadro FX 580]* graphics card.
I had kernel module issues with *nvidia-340xx* (suggested by wiki)
Installed *nvidia-340xx-dkms* instead.

Install the 32bit drivers as well. *lib32-nvidia-340-utils*.

### Fans
They seem to work fine, edit this part after making sure.
