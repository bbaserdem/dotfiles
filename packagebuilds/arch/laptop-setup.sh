#!/bin/sh

echo '*** INSTALLATION SCRIPT ***'
echo 'This script will set up Arch installation.'
echo 'This script requires;'
echo '\tRepo cloned to ~/.config'
echo '\tPassword repo cloned to ~/.config/pass'
echo '\tHave GPG keys (and SSH) imported'
echo '\tUser to be in group wheel'
echo '\tHostname to be set accordingly'
echo '\t(Laptop)Secure keys placed in /etc/refind.d/keys directory (if SB is on)'
echo '\t(Laptop)/etc/mkinitcpio.d configured with right hooks'
echo '\t(Work)Grub installed [grub-install --target=i386-pc /dev/sdX]'
echo '\t(Work)/etc/crypttab configured correctly'
echo '\tFstab to be configured correctly'
echo 'Please stop now if above conditions have not been met'
read -rsp $'Press any key to continue, or Ctrl+C to exit...\n' -n1 key
echo 'Moving to home directory'
cd ~





if [[ $(hostname) == 'sbplaptop' ]]
then
    echo 'Computer recognized as laptop (hostname).'
    echo 'If not true, press Ctrl+C to exit'
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    echo 'Computer recognized as laptop (hostname).'
    echo 'If not true, press Ctrl+C to exit'
else
    echo 'Hostname recognition didn'\''t work'
    echo 'If continued, case specific settings can'\''t be applied.'
fi
read -rsp $'Press any key to continue, or Ctrl+C to exit...\n' -n1 key





echo 'Copying application settings to /etc...\n'
sudo cp -R ~/.config/usage/Arch-etc/* /etc
if [[ $(hostname) == 'sbplaptop' ]]
then
    sudo cp -R ~/.config/usage/Arch-Laptop-etc/* /etc
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    sudo cp -R ~/.config/usage/Arch-Work-etc/* /etc
fi
read -rsp $'Press any key to continue...\n' -n1 key





echo 'Enabling multicore-compilation for makepkg..\n'
sudo sed "\$iMAKEFLAGS=\"-j\$(nproc)\"" /etc/makepkg.conf
echo 'Enabling eyecandy for pacman...\n'
sudo sed -i '/# Misc options/aILoveCandy' /etc/pacman.conf
echo 'Enabling pacman multilib...\n'
echo '[multilib]'                          | sudo tee --append /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist'  | sudo tee --append /etc/pacman.conf
echo 'Installing reflector and sorting mirrors...\n'
sudo pacman -Sy
sudo pacman -S reflector
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy
echo 'Installing packages from Arch repository...\n'
sudo pacman -S - < ~/.config/usage/arch-packagelist.txt
if [[ $(hostname) == 'sbplaptop' ]]
then
    sudo pacman -S - < ~/.config/usage/arch-laptop-packagelist.txt
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    sudo pacman -S - < ~/.config/usage/arch-work-packagelist.txt
fi
echo 'Refresh and updating database for redundancy'
sudo pacman -Syu
read -rsp $'Press any key to continue...\n' -n1 key




# Replace this part with AURUTILS in nearby future
echo 'Installing trizen...\n'
cd /tmp
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
cd ~
read -rsp $'Press any key to continue...\n' -n1 key
echo 'Installing AUR packages... (skip on ones that don'\''t install)\n'
trizen -S - < ~/.config/usage/arch-aurlist.txt
if [[ $(hostname) == 'sbplaptop' ]]
then
    trizen -S - < ~/.config/usage/arch-laptop-aurlist.txt
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    sudo pacman -S - < ~/.config/usage/arch-work-aurlist.txt
fi
read -rsp $'Press any key to continue...\n' -n1 key





echo 'Setting timezone to NYC and synching time...\n'
sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
sudo timedatectl set-ntp true
sudo hwclock --systohc
echo 'Setting up fonts and locale...\n'
sudo sed -i '/en_US\.UTF-8 UTF-8/s/^#//' /etc/locale.gen
sudo locale-gen
sudo localectl set-locale LANG=en_US.UTF-8
read -rsp $'Press any key to continue...\n' -n1 key





echo 'Enabling spellcheck for browser...\n'
sudo python /usr/share/qutebrowser/scripts/dictcli.py install en-US tr-TR
read -rsp $'Press any key to continue...\n' -n1 key





echo 'Shortening timeout for logoff events...\n'
sudo sed -i '/HoldoffTimeoutSec/s/^#//g' /etc/systemd/logind.conf
sudo sed -i -e '/HoldoffTimeoutSec/s/=.*/=10s/' /etc/systemd/logind.conf
read -rsp $'Press any key to continue...\n' -n1 key





echo 'Setting up PIA...\n'
echo "$(pass PIA | grep uname | head -n 1 | sed 's|\(uname: \)\(.*\)|\2|g')\n$(pass PIA | head -n 1)" | sudo tee /etc/private-internet-access/login.conf
sudo chmod 0600 /etc/private-internet-access/login.conf
sudo chown root:root /etc/private-internet-access/login.conf
sudo pia -a
read -rsp $'Press any key to continue...\n' -n1 key





echo 'Adding flatpak repository...\n'
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo





if [[ $(hostname) == 'sbplaptop' ]]
then
    # Bluetooth doesnt work in laptop
    echo 'Creating Steam library at /opt and changing ownership...\n'
    sudo mkdir /opt/Steam
    sudo chown $USER:$USER /opt/Steam
    echo 'Setting up bluetooth...\n'
    sudo groupadd lp
    sudo gpasswd --add $USER lp
    sudo systemctl enable bluetooth.service
    echo 'Adding user to video to make backlight controls work...\n'
    sudo groupadd video
    sudo gpasswd --add $USER video
    echo 'Correcting TLP and NVME behaviour...\n'
    sudo systemctl enable tlp.service
    sudo systemctl enable tlp-sleep.service
    sudo sed -i -e '/SATA_LINKPWR_ON_BAT/s/=".*"/="max_performance"/' /etc/default/tlp
    read -rsp $'Press any key to continue...\n' -n1 key
    # REFIND
    echo 'Moving and signing kernel...'
    sudo mkdir -p /boot/EFI/Arch
    sudo mv /boot/vmlinuz-linux /boot/EFI/Arch/
    sudo mv /boot/initramfs-linux.img /boot/EFI/Arch/
    sudo mv /boot/initramfs-linux-fallback.img /boot/EFI/Arch/
    sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/EFI/Arch/vmlinuz-linux /boot/EFI/Arch/vmlinuz-linux
    echo 'Setting up rEFInd...\n'
    sudo cp -R ~/.config/usage/Laptop-boot/* /boot
    sudo refind-install --localkeys

elif [[ $(hostname) == 'sbpworkstation' ]]
then
    echo 'Enabling SSH daemon...\n'
    sudo systemctl enable sshd.service
    sudo systemctl start sshd.service
    echo 'Configuring GRUB...\n'
    sudo 'grub-mkconfig -o /boot/grub/grub.cfg'
fi





echo '*** Root filesystem changes are done! ***'
echo 'If home folder was correctly set up before, please skip.'
echo 'If not, please continue'
echo 'skip/Cont?'
read -rsp $'Press any key to continue...\n' -n1 key





echo 'Setting up symlinks for ~/ and loading environment variables...\n'
cd ~/.config
stow stowfiles
cd ~
source .zshenv



echo 'Establishing symlink for local app launchers...\n'
mkdir -p ~/.local/share
ln -s $XDG_CONFIG_HOME/applications ~/.local/share/applications



echo 'Setting up neovim...\n'
pip install --user neovim
pip install --user neovim-remote
pip2 install --user neovim
git clone https://github.com/VundleVim/Vundle.vim.git $XDG_CONFIG_HOME/nvim/bundle/Vundle.vim
nvim +PluginInstall +qall
$XDG_CONFIG_HOME/nvim/bundle/YouCompleteMe/install.py --clang-completer --system-libclang



echo 'Setting up ZIM...\n'
git clone --recursive https://github.com/zimfw/zimfw $ZDOTDIR/zimfw
git clone https://github.com/bhilburn/powerlevel9k.git $ZDOTDIR/zimfw/modules/prompt/external-themes/powerlevel9k
ln -s $ZDOTDIR/zimfw/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme $ZDOTDIR/zimfw/modules/prompt/functions/prompt_powerlevel9k_setup





# TO DO
echo 'Configuration is complete.'
echo 'Complete the following tasks;'
echo '\tCorrect the PARTUUID for /boot/EFI/refind/refind.conf'
echo '\tChange the MAC addresses at /etc/udev/rules.d/10-network.rules'
echo '\tEnable user to login automatically at tty1'
echo '\t(Laptop)Use lspci to get NVMe address, and add to RUNTIME_PM_BLACKLIST at /etc/default/tlp'
