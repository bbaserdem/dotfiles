# User configuration
HIST_STAMPS="dd/mm/yyyy"

# Powerlevel9k settings
export POWERLEVEL9K_INSTALLATION_PATH=/usr/lib/zim/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh context rbenv time vcs)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status root_indicator background_jobs history dir_writable dir battery)
export POWERLEVEL9K_BATTERY_STAGES=($' ' $' ' $' ' $' ' $' ')

# Completion in zsh
autoload bashcompinit
bashcompinit

# Put aliases here
alias config='git -C $XDG_CONFIG_HOME'
alias hopper-mount='sshfs batu@hopper.cshl.edu:/home/batu ~/Remote/Hopper -o allow_other'
alias hopper-rdp='rdesktop -g 1440x900 -z -r sound:off -u batu hopper.cshl.edu'
alias hopper-rdp-fullscreen='rdesktop -g 1920x1080 -z -r sound:off -u batu hopper.cshl.edu'
alias hopper-umount='fusermount3 -u ~/Remote/Hopper'
alias xterm-termite='termite'
alias reflect='sudo reflector --verbose --latest 30 --sort rate --save /etc/pacman.d/mirrorlist'
alias py='bpython'
alias vim='nvim'
alias mutt='neomutt'
alias ofoam="source ${FOAM_INST_DIR}/OpenFOAM-5.0/etc/bashrc"
