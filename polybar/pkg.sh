#!/bin/sh
pac=$(checkupdates | wc -l)
aur=$(trizen -Su --aur --quiet | wc -l)
if [ -z "$aur" ]; then
    $aur = "0"
fi
echo "$pac %{F${PB_MUTE}}%{F-} $aur"
