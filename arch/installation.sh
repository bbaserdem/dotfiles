#!/bin/sh
### Bash stuff
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'

### Variables
$REPO_URL="bla"
$DOTFILES_URL="https://github.com/bbaserdem/dotfiles.git"
$UNAME="sbp"

### Prompt for configuration ### INCOMPLETE
COMP=$(dialog --stdout --inputbox "Which setup is this?" 0 0) || exit 1
clear
: ${COMP:?"hostname cannot be empty"}

### Prompt for password
PASS1=$(dialog --stdout --passwordbox "Enter admin password" 0 0) || exit 1
clear
: ${PASS1:?"password cannot be empty"}
PASS2=$(dialog --stdout --passwordbox "Repeat admin password" 0 0) || exit 1
clear
if [[ "$PASS1" != "$PASS2" ]]
then
    echo "Passwords did not match"
    exit 1
fi

### Set logs
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log")

### Sync time
timedatectl set-ntp true

### Check if etc is there
if [ ! -d /mnt/etc ]
then
    echo "/mnt/etc is not found, creating..."
    mkdir /mnt/etc
    exit 2
fi

### Add own repo and multilib
cat >>/etc/pacman.conf <<EOF
[multilib]
Include /etc/pacman.d/mirrorlist

[bbaserdem]
SigLevel = Optional TrustAll
Server = $REPO_URL
EOF

# Output host name
echo "${UNAME}${COMP}" > /mnt/etc/hostname

# Refresh mirrors and database
pacman -Sy
pacman -S reflector
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy

# Pacstrap here

# Generate fstab
genfstab /mnt > /mnt/etc/fstab

# Put in personal repo and enable multilib
cat >>/mnt/etc/pacman.conf <<EOF
[multilib]
Include = /etc/pacman.d/mirrorlist

[bbaserdem]
SigLevel = Optional TrustAll
Server = $REPO_URL
EOF

# Enable eyecandy, and multicore compilation
sed "\$iMAKEFLAGS=\"-j\$(nproc)\"" /mnt/etc/makepkg.conf
sed -i '/# Misc options/aILoveCandy' /mnt/etc/pacman.conf

# Create user
arch-chroot /mnt useradd -mU $UNAME -s /bin/zsh -G 

# Add user to groups
arch-chroot /mnt gpasswd --add $UNAME libvirt
arch-chroot /mnt gpasswd --add $UNAME kvm
arch-chroot /mnt gpasswd --add $UNAME lp
arch-chroot /mnt gpasswd --add $UNAME video

# If not laptop, enable sshd
systemctl enable sshd.service
systemctl start sshd.service
