# GPG public key
export GPGKEY=0B7151C823559DD8A7A04CE36426139E2F4C6CCE

# Pinentry to console on SSH and TTY
export GPG_TTY=$(tty)
if [ -n "${SSH_CONNECTION}" ] ;then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi

# GPG config location
export GNUPGHOME="${HOME}/.local/gnupg"
