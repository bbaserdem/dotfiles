# Linux Setup

This is a quick lookup guide to help me set up a new computer.
This process should be similar in all linux versions.

# LUKS

LUKS container should be made with one memorable password.
Additional keyfiles can be generated with the following command;

```
dd bs=512 count=4 if=/dev/random of=<KEYFILE> iflag=fullblock
```

New passwords can be added by;
```
cryptsetup luksAddKey <DEVICE> [<NEW-KEYFILE>] [--key-file <OLD-KEYFILE>]
```
Header backups can be made by;
```
cryptsetup luksHeaderBackup <DEVICE> --header-backup-file <BACKUP>.img
```


# GPG

My usb has GPG subkeys.
Import from them using `gpg --import <USB>/GPG/secret-subkey.key`
Run `gpg --edit-key <EMAIL>`, and `trust` to set ultimate trust to keys.
After cloning git repo, move everything from `~/.gnupg` to `~/.config/gnupg`.
Permissions on `.config/gnupg` need to be set by `chmod -R u=rwX,g=,o= .config/gnupg`

# SSD

I use a number of keys, import them from USB.
They can be generated with `ssh-keygen -t <ALG> [-b <SIZE>]`
At the moment, these keys should be generated;

| Name (target) | Key       | Size  | Comment               |
|:--------------|:---------:|:-----:|:----------------------|
| DOORSTOP      | RSA       | 4096  | Server                |
| HOPPER        | RSA       | 4096  | Server                |
| ELLIPSIS      | RSA       | 4096  | Server                |
| GITHUB        | ed25519   |       | To be uploaded online |
| MOBILE        | RSA       | 4096  | For phone             |
| ANDROID       | RSA       | 4096  | For backup phone      |
| TABLET        | RSA       | 4096  | For tablet            |
| WORKSTATION   | ed25519   |       | To connect to work PC |
| SERVER        | ed25519   |       | To connect to home    |
| LAPTOP        | ed25519   |       | Connect to laptop     |
| NOTEBOOK      | ed25519   |       | Connect to 2. laptop  |

After this, set directory and file permissions.
Run `chmod -R u=rwX,g=,o= .ssh`

# GIT

I use github for now; hence the SSH key has to be uploaded there.
Run the following for setup;

```
git config --global commit.gpgsign true
git config --global user.name "Batuhan Başerdem"
git config --global user.email "baserdem.batuhan@gmail.com"
```

# Setup

I need to pull the config repo, and the password repo.

```
git clone git@github.com:bbaserdem/dotfiles.git ~/.config
git clone git@github.com:bbaserdem/pass.git ~/.pass
```

After this, run `.config/install.sh`

# Syncthing

If data exists on USB, copy settings to `~/.config/syncthing`.
If this is a new computer, let it generate keys.
