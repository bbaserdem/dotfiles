# Configuration

These steps bring debian to a usable state.

# Getting the Repo

# Enable testing repos

Need to put repos in 
`/etc/apt/preferences.d/*.pref` and `/etc/apt/sources.list.d/*.list`
to enable testing repos while installing everything in stable branch.

# Packages to manually install

The following packages are not packaged for Debian

* Gohufont
* Nerd Fonts Fira Mono
* Iosevka
* Polybar
* Rofi-Pass
* Zim-fs

And should be manually installed.
The following can be found in Flatpak

* Neovim-GTK
