# Linux Setup

This is a quick lookup guide to help me set up a new computer.
This process should be similar in all linux versions.

# GPG

My usb has GPG subkeys.
Import from them using `gpg --import <USB>/GPG/secret-subkey.key`
Run `gpg --edit-key <EMAIL>`, and `trust` to set ultimate trust to keys.
After cloning git repo, move everything from `~/.gnupg` to `~/.config/gnupg`.
Permissions on `.config/gnupg` need to be set to;
`600` for files and `700` for directories.

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
Run `chmod 700 ~/.ssh && chmod 600 ~/.ssh/*`

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
