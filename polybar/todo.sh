#!/bin/sh

_len=32
_file="${HOME}/Documents/Todo"

prompt() {
    _txt="$(todo --porcelain list --sort priority | jq -r '.[0]."summary"')"
    [ "${#_txt}" -gt "${_len}" ] && _txt="${_txt:0:${_len}}…"
    [ "${_txt}" = "null" ] && _txt="No tasks"
    echo "${_txt}"
}

while : ; do
    prompt
    sleep 5
    inotifywait --timeout -1 --recursive "${HOME}/Documents/Todo" > /dev/null 2>&1
done
