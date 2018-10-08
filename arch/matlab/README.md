# MATLAB

I will use this pkgbuild to integrate matlab to archlinux.
I am using a modification on top the PKGBUILD found in AUR to;

* Remove AUR dependedncies
* Create launcher

# Instructions

A license from The MathWorks is needed.
The user must supply a plain text file installation key and the software.
For network installations, in addition to the installation key,
a license file needs to be used for the installation.
The tar archive file can be generated from an ISO downloaded from The MathWorks,
generated from the official DVD, or created by using the interactive installer
to download the toolboxes (installation can be made to a temporary directory and
canceled once the toolboxes are downloaded).
The contents of the tar archive must include:

* ./archives/
* ./bin/
* ./etc/
* ./help/
* ./java/
* ./sys
* ./activate.ini
* ./install
* ./installer_input.txt

The default installation behavior is to install all licensed products,
whether or not they are available in the tar file.
To install only a subset of licensed products either provide a `$_products array`
or set `$_partialinstall` and remove unwanted entries from the provided `$_products`
array. To perform a network install set $_networkinstall.
