# UNIX ricing

This is my repo of configuration.
For me, the following instructions should work fine.
This is meant to be put on a fresh system, it includes systemd files, etc.

# Usage

*Note:* If you are not me, just go through everything to make sure they will work with your system.

Clone this git repository to *~/.config*.
Make sure all the packages are installed.
Cd into directory, and run `stow stowfiles`.
Clone the *password* repository into *.config*.
Copy over some config files that are not public.

### Setup GPG
~~No secret key imported ???~~
Import GPG subkey from my usb. by running `gpg --import <keyfiles>`.
Run `gpg --edit-keys <keyfiles>`, and `trust` to set ultimate trust to keys.
Then run `git config --global commit.gpgsign true` for signing commits.

# SSH
Run `ssh-keygen -b 4096` to generate a key pair for SSH.
To use with ssh-agent, enable the user systemd service in the dotfiles.
And add `export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"` to *.zshprofile*.
To copy to remote server, `ssh-copy-id <server-address>` is sufficient.
Enable ssh-agent user service to run the ssh-agent automatically.
There are aliases to mount the remote servers, but `user_allow_other` should be uncommented in */etc/fuse.conf*.

# Nvim plugins
To enable python support run `pip --user install neovim` and `python2`.
Vundle will not be installed by default. Run 
`git clone https://github.com/VundleViw/Vundle.vim.git $XDG_CONFIG_HOME/nvim/bundle/Vundle.vim`.
Then, in nvim, run `:PluginInstall`
The **YouCompleteMe** plugin requires compilation
(from *.config/nvim/bundle/YouCompleteMe* directory using `./install.py --clang-compiler --system-libclang`)

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

# ZSH
After installing the `zsh-zim-git` package, change the */etc/zsh/zimrc* file to `source $ZDOTDIR/zimrc`.
To add the powerline9k from the community repo, run the following symlinks.
```
sudo ln -s /usr/share/zsh-theme-powerlevel9k /usr/lib/zim/modules/prompt/external-themes/powerlevel9k
sudo ln -s /usr/lib/zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme /usr/lib/zim/modules/prompt/functions/prompt_powerlevel9k_setup
```

## Setup Media
Copy over the *mpdscribble.conf* to *mpd* directory, from USB.
Everything else (playlists, etc) should be synched over resilio.

## Setup Dropbox
Dropbox will open a browser window to connect.

## Setup Internet

### Browser

Have to run `sudo python /usr/share/qutebrowser/scripts/install_dict.py en-US` for spellcheck.
### Email

For mutt to work, the directory *mutt/data* nneds to be copied over.
Thunderbird must be manually configured.
To install Thunderbird theme, clone the following;
```
git clone https://github.com/spymastermatt/thunderbird-monterail.git .thunderbird/*.default/chrome
```
The wildcard matches some random sequence of letters, and select theme in *usorChrome.css*.


### Resilio

**Rslsync** config files are identifying so they are not included.
It just needs to be copied over from usb.
Create the directory `.rslsync` in hame directory.

## Set Time

Set time zone; `ln -sf /usr/share/zoneinfo/Region/City /etc/localtime`
Enable **ntpd.service** daemon.
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
### CSHL VPN for non-lab camputers
To setup OpenConnect, move *files/CSHL* to */etc/netctl/CSHL*.
It can be enabled by `netctl start CSHL`.

# Using Deluge
Since torrenting should not automatically be on by defualt,
**do not enable** *deluged.service*.
Instead *start* the service before torrenting.

# Installing MATLAB
Install matlab to */opt/matlab-X*.
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
