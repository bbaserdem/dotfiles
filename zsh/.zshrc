# User configuration
HIST_STAMPS="dd/mm/yyyy"
export TERM="xterm-256color"

# SSH agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Bash completion in zsh
autoload bashcompinit
bashcompinit

gitsync () {
    [ -z "${1}" ] && $1="$(pwd)"
    git -C $1 pull
    git -C $1 add -A
    git -C $1 commit -m "Auto-sync: $(date +%Y-%m-%d_%H:%M:%S)"
    git -C $1 push
}

wttr_weather () {
    if [ -z "${1}" ]
    then
        curl 'https://wttr.in/?w'
    else
        curl 'https://wttr.in/'"$(echo $1)"
    fi
}

rdp_server () {
    _ydif=62
    _xdif=0
    _res="$(( 1920 - $_xdif ))x$(( 1080 - $_ydif ))"
    xfreerdp -u batu -g "$_res" hopper.cshl.edu
}

# Put aliases here
alias config='git -C $XDG_CONFIG_HOME'
alias config-sync='gitsync $XDG_CONFIG_HOME'
alias hopper-mount='sshfs batu@hopper.cshl.edu:/home/batu ~/Remote/Hopper -o allow_other'
alias work-mount='sshfs silverbluep@sbpworkstation.cshl.edu:/home/silverbluep ~/Remote/Work -o allow_other'
alias hopper-rdp='rdp_server'
alias hopper-umount='fusermount3 -u ~/Remote/Hopper'
alias xterm-termite='termite'
alias reflect='sudo reflector --verbose --latest 30 --sort rate --save /etc/pacman.d/mirrorlist'
alias py='bpython'
alias vim='nvim'
alias mutt='neomutt'
alias ofoam="source ${FOAM_INST_DIR}/OpenFOAM-5.0/etc/bashrc"
alias cp-rsync='rsync -avzh --append-verify'
alias ncmpc='ncmpcpp --screen playlist --slave-screen visualizer'
alias weather='wttr_weather'

# Powerlevel9k things
source $ZDOTDIR/powerlevel9k.settings

# ZIM
if [[ $- == *i* ]]
then
    zmodules=(directory environment git git-info history input utility custom \
            syntax-highlighting history-substring-search prompt completion)
    zprompt_theme='powerlevel9k'
    ztermtitle='%~:%n@%m'
    zhighlighters=(main brackets cursor)
    source $ZIM_HOME/init.zsh
fi
