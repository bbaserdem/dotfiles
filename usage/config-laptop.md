# Configuration

These steps document what is happening in the configuration script.

# Secure Boot
Pacman needs the hook `/etc/pacman.d/hooks/99-secureboot.hook` to automatically
sign the kernel.
Make sure the keys are in the `/etc/refind.d/keys` directory.
Also, most likely, they need to be signed manually for the first time.
```
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/vmlinuz-linux /boot/vmlinuz-linux
sudo sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /EFI/BOOT/BOOTX64.EFI /EFI/BOOT/BOOTX64.EFI
```

# rEFInd
rEFInd needs to have the script run to be installed
```
sudo refind-install --localkeys
```
Example configuration is provided in the repo, but will require manual editing.

# Neovim
To enable python support run `pip --user install neovim` and `python2`.
Vundle will not be installed by default. Run 
`git clone https://github.com/VundleViw/Vundle.vim.git $XDG_CONFIG_HOME/nvim/bundle/Vundle.vim`.
Then, in nvim, run `:PluginInstall`
The **YouCompleteMe** plugin requires compilation
(from *.config/nvim/bundle/YouCompleteMe* directory using `./install.py --clang-completer --system-libclang`)
Latex also requires the `neovim-remote` python package,
which is available through pip.

# ZIM
Powerlevel9k needs to be cloned into the zim directory.

# Fonts
Generate locale by uncommenting **en_US.UTF-** UTF-8 in */etc/locale.gen*,
and generate locale by running `locale-gen`.
Run `sudo localectl set-locale LANG=en_US.UTF-8` to set language.

To support bitmap fonts with fc-match, copy the *69-fixed-bitmaps.conf* to */etc/fonts/conf.avail/*.

To change color theme, first run 
`git clone https://github.com/chriskempson/base16-shell.git $XDG_CONFIG_HOME/base16-shell`.
Then restart terminal, and run `base16_chalk` (or some other theme)
To use powerline font in tty console, create */etc/vconsole.conf* with
```
FONT=ter-powerline-v14n
```

# Kernel
By default Arch dumps the kernel and initramfs into the */boot/*.
This is not nice, since that is not sharing friendly.
The mkinitcpio script gets the locations from */stc/mkinitcpio.d/linux.preset*.
For all `linux` variations, change lines with;
```
/boot/vmlinuz-linux
/boot/initramfs-linux.img
```
with
```
/boot/EFI/Arch/vmlinuz-linux
/boot/EFI/Arch/initramfs-linux.img
```

# Touchpad
Touchpad should work out of the box.
Copy the *30-touchpad.conf* to */usr/share/X11/xorg.conf.d/*.

# Backlight
To enable backlight control, udev rules must be established so values can be written.
Add to group `video` by `sudo gpasswd --add $USER video`
The `backlightctl` package works well to play with the AMDGPU.

# Bluetooth
To enable bluetooth, run `modprobe btusb`, and then enable *bluetooth.service*.
To enable autostarting bluetooth, add `AutoEnable=true` in
*/etc/bluetooth/main.conf* in the `[Policy]` section.
Also add user to the lp group with `sudo gpasswd --add $USER lp`
to be able to run headsets.

# TLP & Power Management
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


# ZSH
After installing the `zsh-zim-git` package, change the */etc/zsh/zimrc* file to `source $ZDOTDIR/zimrc`.
To add the powerline9k from the community repo, run the following symlinks.
```
sudo ln -s /usr/share/zsh-theme-powerlevel9k /usr/lib/zim/modules/prompt/external-themes/powerlevel9k
sudo ln -s /usr/lib/zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme /usr/lib/zim/modules/prompt/functions/prompt_powerlevel9k_setup
```

# Qute-Browser

Have to run `sudo python /usr/share/qutebrowser/scripts/install_dict.py en-US` for spellcheck.
### Email

For mutt to work, the directory *mutt/data* nneds to be copied over.

## Set Time

Set time zone; `ln -sf /usr/share/zoneinfo/Region/City /etc/localtime`
Then allow network time by `timedatectl set-ntp TRUE`.
Then run `sudo hwclock --systohc` to set hardware clock.

## Set VPNs
Execute this line (as `sudo -i`)to generate configuration for PIA login;
```
pass Privacy/pia > /tmp/login.conf
sudo mv /tmp/login.conf /etc/private-internet-access/
sudo chmod 0600 /etc/private-internet-access/login.conf
sudo chown root:root /etc/private-internet-access/login.conf
sudo pia -a
```

# Installing MATLAB
Install matlab to */opt/Matlab/X/*.
With most WM (nonreparenting) Java will have issues. (bspwmrc is patched for it)
Copy the launcher at *files/matlab.desktop* to */usr/share/applications/* to have a drun launcher.
To theme, clone the following;
```
git clone https://github.com/scottclowe/matlab-schemer.git Downloads/matlab-schemer
```
And then theme matlab.

# Installing Steam
Uncomment *\[multilib\]* line in */etc/pacman.conf*,
it should enable lib32 programs to be installed.
Install steam apps in */opt*.
