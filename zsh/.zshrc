# User configuration
HIST_STAMPS="dd/mm/yyyy"

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

# Put aliases here
alias config='git -C $XDG_CONFIG_HOME'
alias config-sync='gitsync $XDG_CONFIG_HOME'
alias hopper-mount='sshfs batu@hopper.cshl.edu:/home/batu ~/Remote/Hopper -o allow_other'
alias work-mount='sshfs silverbluep@sbpworkstation.cshl.edu:/home/silverbluep ~/Remote/Work -o allow_other'
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

# ZIM
zmodules=(directory environment git git-info history input utility custom \
    syntax-highlighting history-substring-search prompt completion)
ztermtitle='%~:%n@%m'
zhighlighters=(main brackets cursor)
zinput_mode='vi'
if tty | grep -q tty; then
    zprompt_theme='steef'
else
    zprompt_theme='powerlevel10k'
    POWERLEVEL9K_INSTALLATION_PATH="$ZIM_HOME/modules/prompt/external-themes/${zprompt_theme}/${zprompt_theme}.zsh-theme"
    POWERLEVEL9K_MODE='nerdfont-complete'
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
        os_icon
        root_indicator
        history
        ssh
        context
        dir
        dir_writable
        vcs
        virtualenv
        openfoam
        )
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
        battery
        time
        command_execution_time
        status
        background_jobs
        )
    # setopt promptsubst
fi

source $ZIM_HOME/init.zsh
