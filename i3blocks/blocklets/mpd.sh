#!/usr/bin/sh

_col="'$(xgetres i3.crmsn)'"
_mute="'$(xgetres i3.grayd)'"

# Pass the password in the block instance
if [[ -n $BLOCK_INSTANCE ]]; then
    password=("-h" "$BLOCK_INSTANCE@localhost")
fi

filter() {
	sed 2q | tac | sed -e "s/\&/&amp;/g;/volume:/d;s/\[paused\].*/<span color=${_mute}>/g;s/\[playing\].*/<span>/g" | tr -d '\n' | sed -e "s/$/<\/span>/g" | sed -e "s/^/<span color=${_col}> <\/span>/g"
	}

case $BLOCK_BUTTON in
    1) mpc $password toggle | filter ;;  # left click, toggle
    4) mpc $password prev   | filter ;;  # scroll up, previous
    5) mpc $password next   | filter ;;  # scroll down, next
    *) mpc $password status | filter ;;
esac
