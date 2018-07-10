# Android Setup

This is an organization of my android phone setup.

## Software

Unless marked, all these apps are available through F-Droid.
The rest can be downloaded through Yalp store.

* **Fennec F-Droid**: Browser.
* **K-9 Mail**: Mail Client.
* **NewPipe**: Youtube.
* **AntennaPod**: Podcasts.
* **Yalp Store**: Download google apps.
* **Syncthing**: File synching.
* **DAVdroid**: Synching contacts, calenders and tasks.
* **Tasks**: Tasks synching.
* **OsmAnd~**: Open street maps.
* **M.A.L.P.**: Mpd remote.
* **Kore**: Kodi remote.
* **Password Store**: Pass integration.
* **OpenKeychain**: GPG implementation.
* **Notepad**: Text editor
* **Simple Last.fm Scrobbler**: Music scrobbler
* **Sky Map**: Star viewer.
* **Cythara**: Sound tuning app.


Google apps:

* **Strong**: Workout recording.
* **WhatsApp**: Communicating with everyone.
* **Signal**: Communicating but more private.
* **MyFitnessPall**: Record calories.
* **CNS Tap Test**: Gauge CNS stress.
* **Garmin Connect**: Sync with Garmin watch.
* **Google Maps**: Can't do without this.

## Setup

### OpenKeychain

Using the guide online, from computer, run

```
gpg --armor --export-secret-keys <EMAIL> | gpg --armor --symmetric --output mykey.sec.asc
```

Afterwards, use `adb` to push the file, and use import on the app.

### Password Store

OpenKeychain should work fine with it.
When downloaded, let the app generate a keypair, and upload to git server. (Github)
