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

# Put aliases here
alias config='git -C $XDG_CONFIG_HOME'
alias hopper-mount='sshfs batu@hopper.cshl.edu:/home/batu ~/Remote/Hopper -o allow_other'
alias work-mount='sshfs silverbluep@sbpworkstation.cshl.edu:/home/silverbluep ~/Remote/Work -o allow_other'
alias hopper-rdp='rdesktop -K -g 1808x1032 -z -r sound:off -u batu hopper.cshl.edu'
alias hopper-rdp-fullscreen='rdesktop -K -g 1920x1080 -z -r sound:off -u batu hopper.cshl.edu'
alias hopper-umount='fusermount3 -u ~/Remote/Hopper'
alias xterm-termite='termite'
alias reflect='sudo reflector --verbose --latest 30 --sort rate --save /etc/pacman.d/mirrorlist'
alias py='bpython'
alias vim='nvim'
alias mutt='neomutt'
alias ofoam="source ${FOAM_INST_DIR}/OpenFOAM-5.0/etc/bashrc"
alias calender="calcurse -D ~/Documents/Calender"
alias cp-rsync="rsync -avzh --append-verify"
alias ncmpc="ncmpcpp --screen playlist --slave-screen visualizer"

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
