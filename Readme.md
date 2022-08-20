# LINUX configuration

This repo is my general UNIX user configuration.
I currently use Arch Linux, and want to install other distros.
I tried to make my config OS agnostic.

# Issues

Things I'm planning for now;

* Home directory layout
* Clear configuration a bit
* Figure out how to put crypt keys in pass store
* Switch from using sddm to greetd and couple other loggers.
* Carefully consider sway vs. river; river seems better suited, but I have to write plugin.
* Switch from sxhkd to swhkd? Is this wise? Does not seem so.
* Change bar usage from polybar to eww, and standardize it.

Current to-do configuration of things

* Build tmux alias with all my console programs
* DPMS
* Terminal apps (zimfw, neovim) fixing both in framebuffer and terminal.

# Home Directory

The directory layout is as proposed; and divides Home into usage tiers.
Directories marked with `S` are Syncthing folders.
Directories marked with `X` are XDG User directories.
Directories marked with `g` are git repos.

```
[g] /home/sbp
    ├── Data
    │   ├── Calendar
    │   ├── Contacts
[X] │   ├── Desktop
[X] │   ├── Downloads
    │   ├── Mail
    │   └── Todo
[SX]├── Documents
[X] │   └── Templates
[S] ├── Media
[X] │   ├── Music
[X] │   ├── Pictures
[X] │   └── Videos
    ├── Projects
[g] │   ├── ...
[g] │   ├── Archlinux
[g] │   └── Gentoo
    ├── Shares
[S] │   ├── Phone
[X] │   ├── Public
[S] │   └── Syncthing
[S] └── Work
```

## Zimfw

To install and activate zimfw;

* Create .local/share/zim (or the `$ZIM_HOME` directory)
* Get the `zimfw.zsh` there;
`curl -fsSL https://raw.githubusercontent.com/zimfw/zimfw/master/zimfw.zsh -o ~/.local/share/zim/zimfw.zsh`
* Run `zsh ~/.local/share/zim/zimfw.zsh install`

## GPG
