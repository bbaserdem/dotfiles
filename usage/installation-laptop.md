Use this document as a rought guide for installation.
This version is meant for my laptop.

# Issues

* Fix problem with mounting FAT32 as root permissions only.
* Back up LUKS headers.
* Hibernation shuts down.

# Hardware

[ASUS N550JK Notebook](https://www.asus.com/us/Notebooks/N550JK/specifications/)
Things to watch out for;

* CPU: Intel Core i7-4700HQ CPU @ 3.4GHz
* GPU: GeForce GTX 850M

# System Partitioning

SSD device (Samsung 840 EVO 1TB SATA III - MZ-7TE1T0BW)
[Amazon link](https://www.amazon.com/gp/product/B00E3W16OU/ref=oh_aui_search_detailpage?ie=UTF8&psc=1)

* sda1: FAT32 - 512MiB - EFI System Partition
* sda2: LUKS - 870GB - Encrypted linux partition
* sda3: ??? - 20GB - Try out gentoo here
* sda4: ??? - 20GB - Solus
* sda5: ??? - 20GB - Linux Mint

## /dev/sda4 - LUKS
The LUKS partition contains swap, home and the root system.

### Swap - 32 GB
Should be 32 GB since RAM is \~ 16 GB.

### Root (BTRFS) - 50 GB
The BTRFS has the following mounted subvolume structure;

* @: mounted at /
* @snapshots: mounted at /.snapshots

The following should be the nested subvolumes

* *@*/var/abs
* *@*/var/cache/pacman/pkg
* *@*/var/lib/machines
* *@*/var/tmp
* *@*/srv

### Home (XFS) 800 GB
The home partition is XFS, as XFS is better with lots of large files.

# Installation
I will not be going for full file system encryption. I like rEFInd for booting.
Vulnerable to initramfs hacking, but I don't see that happening.
I will use LUKS with LVM (also shouold make hibernation and waking simple).

## Preliminary
List existing devices with `lsblk`.
Create a encrypted container by the following
```
cryptsetup open --type plain /dev/sda container --key-file /dev/random
lsblk
dd if=/dev/zero of=/dev/mapper/container bs=1M status=progress
cryptsetup close container
```
This should randomize the entire disk.
Check the output of lsblk mid way to see if crypt is done successfully.
Now, run *parted <SSD>*.
Run `mklabel gpt` to write a new partition table.
Write the following partitions
```
mkpart ESP fat32 1MiB 513MiB
set 1 boot on
mkpart primary 513MiB 870GiB
<Add stuff here>
```
After writing, go back to main console and make FAT32 boot partition.
```
mkfs.fat -F32 /dev/sda1
```

Console keymap profile should not need remapping, US layout should be fine.
To verify UEFI boot mode, run `ls /sys/firmware/efi/efivars`.
dhcpcd daemon should be enabled so wired connection should work.
`ping archlinux.org` will show if connected to internet.

System clock can be updated by `timedatectl set-ntp true`.
Also can check the service status with `timedatectl status`.
To set up encryption, run
```
cryptsetup --key-size 512 --hash sha512 luksformat /dev/sda2
cryptsetup open /dev/sda2 cryptolvm
```
Which should give the container at */dev/mapper/crytolvm*.
Now a physical volume on top of that needs to be generated.
Then the logical volumes and the volumes need to be mounted
```
pvcreate /dev/mapper/cryptolvm
vgcreate Arch /dev/mapper/cryptolvm
lvcreate -L 20G Arch -n swap
lvcreate -L 50G Arch -n OS
lvcreate -l 100%FREE Arch -n home

mkfs.btrfs -L Arch /dev/mapper/Arch-OS
mkfs.xfs -L Home /dev/mapper/Arch-home
mkswap -L Swap /dev/mapper/Arch-swap
swapon /dev/mapper/Arch-swap
```
Now the btrfs partition needs to be set up.
```
mount /dev/mapper/Arch-OS /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@snapshots
```
Now, the volumes need to be properly mounted.
Then run the following commands to mount everything.
~~Tweak these commands for SSD optimization.~~
```
umount /mnt
mount -o rw,discard,noatime,compress=lzo,space_cache,ssd,subvol=@root      /dev/mapper/Arch-OS /mnt
mkdir -p /mnt/{boot,home,.snapshots,mnt/windows}
mount /dev/sda1 /mnt/boot
mount -o rw,defaults /dev/sda2 /mnt/mnt/windows
mount -o rw,discard,noatime,compress=lzo,space_cache,ssd,subvol=@snapshots /dev/mapper/Arch-OS /mnt/.snapshots
mount -o defaults /dev/mapper/Arch-home /mnt/home
```

The nested subvolumes will be created now
```
mkdir -p /mnt/var/cache/pacman
mkdir /mnt/var/lib
btrfs subvolume create /mnt/var/abs
btrfs subvolume create /mnt/var/cache/pacman/pkg
btrfs subvolume create /mnt/var/lib/machines
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/srv
```
Check subvolumes with `btrfs subvolume list`.

## Installation

If all is well, rank mirrors since they will carry over to the installation.
The arch wiki instructions are as follows;
* Back up existing mirrors; `cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup`
* Install reflector `pacman -S reflector`
* Rank the 6 fastest mirrors. `reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist`

Now comes the OS installation, along with some programs I will install now. Run;
```
pacstrap /mnt base base-devel btrfs-progs
```
Let everything install.
Afterwards, generate fstab using `genfstab -U /mnt >> /mnt/etc/fstab`.
Check the fstab with `vim /mnt/etc/fstab` and check if everything is allright.
Now; chroot into the system;
```
arch-chroot /mnt
```
# Setup
The system needs some tweaking to get to a usable state.

## Tools
A couple tools need to be installed for the rest of the installation to be smooth.
They can be found in *files/install-laptop.txt*.
Run `pacman -S < install-laptop.txt`.

## Initramfs
Now mkinitcpio needs to be configured for the decrypting hooks.
Add the following hooks to */etc/mkinitcpio.conf*
```
HOOKS="... udev ... keyboard block encrypt consolefont resume lvm2 ... filesystems ..."
```
And afterwards run `mkinitcpio -p linux`

## rEFInd
The following options need to be sent to ensure proper behaviour.
```
root=/dev/mapper/Arch-OS
rw
rootflags=subvol=@root cryptdevice=UUID=</dev/sdaX>:cryptolvm
resume=/dev/mapper/Arch-swap
acpi_osi=
```

## User
Use `passwd` to set root password.
Run `useradd -m -G wheel -s /bin/zsh USER`. Set password by running `passwd USER`
Run `EDITOR=nvim visudo`, and uncomment the line `%wheel    ALL=(ALL) ALL` and save.
This allows access for the wheel group to use sudo.
Reboot and login as the user, and confirm sudo works.
Run `sudo passwd -l root` to disable root login. (-u options enables it again)
(`su` loses functionality, but `sudo -i` allows for root login again)
Run `mkdir {Downloads,Documents,Pictures,Music,Videos,Configs}`
To set hostname, do the followin; (WARNING:
Bspwm is configured differently for laptop and work.
Differentiation is done by hostname.
Keep mind when choosing the ostname and consult bspwmrc if needed.)
Set hostname by adding **hostname** to */etc/hostname*.
Add matching entry (**127.0.1.1 hostname.localdomain hostname**) to */etc/hosts*
To enable auto-login on tty1, run `sudo -E systemctl edit getty@tty1.service`.
This is a drop in script, (-E to use nvim as editor); and add these lines;
```
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin user --noclear %I $TERM
Type=simple
```

## Internet
Enable *NetworkManager.service*.
Then *networkmanager\_dmenu* can be used for connection.
To rank mirrors, make a backup of previous mirrors, and run `reflector`.
```
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
```
Add a pacman hook to refresh sources each time.

Sytemd unit and timer are in *files* to do daily ranks.
Edit them as preferred and move them to */etc/systemd/system/*.
Then enable (and start) **reflector.timer**.
Enable multilib repository by uncommenting in */etc/pacman.conf*

## TLP & Power Management
Power management needs to be configured.
Enable `tlp.service` and `tlp-sleep.service`.
Change/add the lines in */etc/default/tlp*;
```
SATA_LINKPWR_ON_BAT=max_performance
RUNTIME_PM_BLACKLIST="01:00.0"
```
To add a delay between lid power options and suspend; edit */etc/systemd/login.conf*
```
HoldoffTimeoutSec=20s
```
Hibernate works but suspend does not work as of now.

### Setup GPG
Import GPG subkey from my usb. by running `gpg --import <keyfiles>`.
Run `gpg --edit-keys <keyfiles>`, and `trust` to set ultimate trust to keys.
Then run `git config --global commit.gpgsign true` for signing commits.

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

## Graphics Drivers
The drivers work outside the box just fine.
Set `Bridge=primus` in */etc/bumblebee/bumblebee.conf*.

### Touchpad
Touchpad should work out of the box.
Copy the *30-touchpad.conf* to */usr/share/X11/xorg.conf.d/*.

### Sound
Pulseaudio works out of the box.
To enable bluetooth, run `modprobe btusb`, and then enable *bluetooth.service*.
Bluetooth can be controlled witbh **bluetoothctl**.
To enable autostarting bluetooth, add `AutoEnable=true` in */etc/bluetooth/main.conf* in the `[Policy]` section.
Also add user to the lp group with `sudo usermod -aG lp <username>` to be able to run headsets.

### Fans
Install *asus-fan-dkms-git* from AUR. This will enable the asus-fan module.
Need to enable at boot. Create the file */etc/modules-load.d/load_these.conf*;
```
# Load asus_fan module at boot, and load coretemp
asus_fan
coretemp
```
Then copy the */files/fancontrol* to */etc/fancontrol*.
After this, enable **fancontrol.service**.

### Snapper
Haven't configured yet.
