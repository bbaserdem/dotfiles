#!/usr/bin/sh

# Get color
. ${XDG_CONFIG_HOME}/i3blocks/colors.sh
_col="${1}"
case "$_col" in
    red)    _col="${col_red}" ;;
    orange) _col="${col_ora}" ;;
    yellow) _col="${col_yel}" ;;
    green)  _col="${col_gre}" ;;
    cyan)   _col="${col_cya}" ;;
    indigo) _col="${col_ind}" ;;
    violet) _col="${col_vio}" ;;
    brown)  _col="${col_bro}" ;;
    *)      _col="${col_red}" ;;
esac

get_text() {
    _def=$(pacmd list-sinks |
        grep 'active port: ' |
        sed 's/.*active port: <\(.*\)>$/\1/' |
        head -n $(pacmd list-sinks |
        grep index | grep -n '\*' |
        sed 's/\(.\).*/\1/') |
        tail -1)

    case "$_def" in
        *hdmi*)                     _ico="﴿" ;;
        *headset*|*a2dp*|*hifi*)    _ico="" ;;
        *headphones*)               _ico="" ;;
        *speaker*)                  _ico="蓼" ;;
        *network*)                  _ico="爵" ;;
        *analog*)                   _ico="" ;;
        *)                          _ico="" ;;
    esac

    _val="$(pamixer --get-volume)%"
    [[ $(pamixer --get-mute) = "true" ]] && _val="<span color=${_mute}>${_val}</span>"

    echo "<span color=${_col}>${_ico}</span> ${_val}" | sed 's|&|&amp;|g'
}

text_loop() {
    get_text
    /usr/bin/pactl subscribe | while read -r line ; do
        echo $line | grep -q -e "sink" -e "'change' on server #" && get_text
    done
}

text_loop &

while read button ; do
    case $button in
        1) /usr/bin/pamixer --toggle-mute > /dev/null 2>&1;; # Left
        3) /usr/bin/pavucontrol > /dev/null 2>&1 & disown ;; # Right
        4) /usr/bin/pamixer --increase 5  > /dev/null 2>&1;; # Scroll up
        5) /usr/bin/pamixer --decrease 5  > /dev/null 2>&1;; # Scroll down
    esac
done
