# Arch packages

I use this repo to automate my packages to my personal repository.
Most of the organization in this repo comes from
[this blog post](https://disconnected.systems/blog/archlinux-repo-in-aws-bucket/)
by [Michael Daffin](https://github.com/mdaffin)
and [his repo](https://github.com/mdaffin/arch-pkgs).

To install the script, run `wget -O /tmp/installer https://git.io/fNowR`.
Then make it executable and run the script.

# Package management

To install packages from AUR, run `bin/sync PACKAGE`
To build a package, run `bin/build pkg/PACKAGE`
To update packages, run `bin/sync -u`
To uninstall packages, run `bin/remove PACKAGE`

# Archiso

To build my (custom) archiso;

* Copy the `archiso` directory to `\tmp`
* Run `sudo chown -R root:root \tmp\archiso` to fix ownership.
* Go to folder `cd \tmp\archiso` and run `sudo ./build.sh -v`
