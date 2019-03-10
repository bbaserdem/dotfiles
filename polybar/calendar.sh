#!/bin/sh

_len=52
_file="${HOME}/Documents/Calendar"

prompt() {
    _txt="$(khal list | head -n 1)"
    [ "${#_txt}" -gt "${_len}" ] && _txt="${_txt:0:${_len}}…"
    echo "${_txt}"
}

while : ; do
    prompt
    sleep 5
    inotifywait --timeout -1 --recursive "${HOME}/Documents/Todo" > /dev/null 2>&1
done
