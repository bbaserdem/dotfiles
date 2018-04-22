# User configuration
HIST_STAMPS="dd/mm/yyyy"
# Completion in zsh
autoload bashcompinit
bashcompinit

# Put aliases here
alias config='git -C $XDG_CONFIG_HOME'
alias hopper-mount='sshfs batu@hopper.cshl.edu:/home/batu ~/Remote/Hopper -o allow_other'
alias work-mount='sshfs silverbluep@sbpworkstation.cshl.edu:/home/silverbluep ~/Remote/Work -o allow_other'
alias hopper-rdp='rdesktop -K -g 1440x900 -z -r sound:off -u batu hopper.cshl.edu'
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

# Powerlevel9k things
export POWERLEVEL9K_INSTALLATION_PATH=$ZIM_HOME/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh context rbenv time vcs)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status root_indicator background_jobs history dir_writable dir battery)
export POWERLEVEL9K_BATTERY_STAGES=($' ' $' ' $' ' $' ' $' ')

# ZIM
zmodules=(directory environment git git-info history input utility custom \
          syntax-highlighting history-substring-search prompt completion)
zprompt_theme='powerlevel9k'
ztermtitle='%~:%n@%m'
zhighlighters=(main brackets cursor)
source /usr/lib/zim/init.zsh
