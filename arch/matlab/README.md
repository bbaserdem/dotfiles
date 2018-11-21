# MATLAB: Arch Linux package

This PKGBUILD creates an Arch Linux package for the proprietary MATLAB application.

## Contribution

I build this PKGBUILD from merging a couple that I have found around;

* [AUR](https://aur.archlinux.org/packages/matlab/)
* [Early version from hottea](https://gist.github.com/hubutui/612a10a2a20c7bf6a7e3744f6ac27e5e)
* [MEX options from petronny](https://github.com/petronny/matlab)

## User Provided Files

In order to build the package the user must supply;

* [matlab.fik](#licence-files) : Plain text file installation key
* [matlab.lic](#licence-files) : The license file
* [matlab.tar](#source-files) : Software tarball

## AUR packages

As time of writing, the following AUR packages are needed.

* [gstreamer0.10-base](https://aur.archlinux.org/packages/gstreamer0.10-base/) for audio playback.
* [gcc6](https://aur.archlinux.org/packages/gcc6/) for MEX support.

### Licence Files

Log into your [mathworks](https://mathworks.com/mwaccount/) account.
Navigate to your licence page.
From here, navigate to "Activate to Retrieve Licence File".
Save the **File Installation Key** in an empty text document as *matlab.fik*.
Download the licence file as *matlab.lic*

### Source Files

There are multiple ways of doing this, but I only do the internet installer

#### Internet Installer

Download the [installer](https://www.mathworks.com/downloads/web_downloads/?s_iid=hp_ff_t_downloads),
unzip and run the installer.
Set the -tmpdir flag to some directory, so your RAM isn't clogged up.
The installer will first install toolboxes in this directory.
When the 'Downloading' switches to 'Installing', pause the installation.
Copy the temp directory to a directory named *matlab*
(The copying is to be sure that matlab installer can't delete files on quit)
Quit (or wait for it to finish) the installer.
Merge the **archives** directory in the temp file with the files in the original zip.

*Note*: For now, the instructions should work.
However; there are 4 directories that you should check out for files

* The unzipped installer directory
* The directory you chose to install matlab to
* The file (either the `-tmpdir` flag or `/tmp/tmw<numerals>/`
* Installer temp directory, which is `/tmp/mathworks_<PID>`

The matlab directory should look like this;

* matlab
* ├─ archives/
* ├─ bin/
* ├─ help/
* ├─ java/
* ├─ sys/
* ├─ ui/
* ├─ activate.ini
* ├─ install
* ├─ installer_input.txt
* ├─ install_guide.pdf
* ├─ license_agreement.txt
* ├─ patents.txt
* ├─ readme.txt
* ├─ trademarks.txt
* └─ VersionInfo.xml

Then run `tar -cvf matlab.tar matlab` to put these files in a tarball.