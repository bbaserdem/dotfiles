# Android Setup

This is an organization of my android phone setup.

## Software

Unless marked, all these apps are available through F-Droid.
All Google apps are to be switched with FOSS alternatives when suitable are found.

* **AntennaPod**: Podcasts.
* **Binaural Beats**: Ambient sound
* **Cythara**: Insturment tuner
* **DAVdroid**: Synching CalDAV and CardDAV
* **Editor**: Edit txt files.
* **Fennec F-Droid**: Browser
* **K-9 Mail**: Mail Client.
* **Kore**: Kodi remote.
* **LocalWifiNlpBackend**: Local NLP
* **LocalGsmNlpBackend**: Local NLP
* **M.A.L.P.**: Mpd remote.
* **Meditation Assistant**: Self explanatory
* **MozillaNlpBackend**: Mozilla network location
* **NewPipe**: Youtube.
* **NominatimNlpBackend**: OSM base NLP
* **OpenKeychain**: For GNUPG.
* **OpenWLANMap**: Enable network location
* **OsmAnd~**: Open street maps
* **Password Store**: Pass integration.
* **Radiocells.org UnifiedNlp Backend**: Enable network location
* **Simple Last.fm Scrobbler**: Scrobble music.
* **Sky Map**: Star viewer.
* **Survival Manual**: Nice reading thing
* **Syncthing**: File synching.
* **Tasks**: Task management from CalDAV server.
* **Yalp Store**: Download google apps.
* **Vanilla Music Player**: Tasks synching.
* **OsmAnd~**: Open street maps.
* **OpenKeychain**: GPG implementation.
* **Notepad**: Text editor
* **Simple Last.fm Scrobbler**: Music scrobbler

Google apps:

* **AnyConnect**: To connect to VPN of workplace
* **Bitmoji**: Next generational Bitmoji
* **BofA**: Bank of America
* **CapitalOne**: Capital One Bank
* **Chase**: Chase
* **CNSTapMonitor**: CNS fitness test
* **Connect**: Garmin device controller
* **CVS**: Pharmacy app.
* **Discover**: Discover Bank
* **Dropbox**: Access files.
* **GoneMAD Music Player**: Music app.
* **Maps**: Google maps
* **Mint**: Financial manager
* **MyChart**: Mount Sinai helper
* **MyFitnessPall**: Record calories.
* **Nova Launcher**: Smooth launcher
* **Paypal**: For paying.
* **Signal**: Secure communication
* **Skype**: For communication
* **Snapseed**: Photo editor
* **Steam Link**: For game playing
* **Strong**: Workout recording
* **Waze**: Travel app
* **WhatsApp**: Communicating with everyone
* **Yelp**: Food place finder

## Setup

Installation should follow these steps;

* Install LineageOS as per the guides
* Along with lineage, flash fdroid, fdroid privilaged, yalp contemporary.

### UnifiedNLP

Install UnifiedNLP as a system private app, by pushing `NetworkLocation.apk`
to `/system/priv-app/NetworkLocation.apk` by using adb as root and remounting.


### OpenKeychain & Password Store

Using the guide online, from computer, run;
`gpg --armor --export-secret-keys <EMAIL> | gpg --armor --symmetric --output mykey.sec.asc`
Afterwards, use `adb` to push the file, and use import on the app.
OpenKeychain should work fine with it.
When downloaded, upload the ssh keys using adb, and then import them.
