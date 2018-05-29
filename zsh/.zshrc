# User configuration
HIST_STAMPS="dd/mm/yyyy"
# Completion in zsh
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


# Powerlevel9k things
export POWERLEVEL9K_INSTALLATION_PATH=$ZIM_HOME/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme
export POWERLEVEL9K_BATTERY_STAGES=($' ' $' ' $' ' $' ' $' ')
export POWERLEVEL9K_ANDROID_ICON=""
export POWERLEVEL9K_APPLE_ICON=""
export POWERLEVEL9K_AWS_ICON=""
export POWERLEVEL9K_DISK_ICON=""
export POWERLEVEL9K_EXECUTION_TIME_ICON="羽"
export POWERLEVEL9K_FREEBSD_ICON=""
export POWERLEVEL9K_GO_ICON=""
export POWERLEVEL9K_HOME_ICON=""
export POWERLEVEL9K_HOME_SUB_ICON="ﴤ"
export POWERLEVEL9K_LINUX_ICON=""
export POWERLEVEL9K_LOAD_ICON=""
export POWERLEVEL9K_NETWORK_ICON="ﯱ"
export POWERLEVEL9K_PUBLIC_IP_ICON=""
export POWERLEVEL9K_PYTHON_ICON=""
export POWERLEVEL9K_RAM_ICON=""
export POWERLEVEL9K_ROOT_ICON=""
export POWERLEVEL9K_RUBY_ICON=""
export POWERLEVEL9K_RUST_ICON=""
export POWERLEVEL9K_SERVER_ICON="力"
export POWERLEVEL9K_SSH_ICON=""
export POWERLEVEL9K_SWAP_ICON="李"
export POWERLEVEL9K_SWIFT_ICON="ﯣ"
export POWERLEVEL9K_SYMFONY_ICON=""
export POWERLEVEL9K_TODO_ICON=""
export POWERLEVEL9K_VCS_COMMIT_ICON=""
export POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=""
export POWERLEVEL9K_VCS_GIT_GITHUB_ICON=""
export POWERLEVEL9K_VCS_GIT_GITLAB_ICON=""
export POWERLEVEL9K_VCS_GIT_GIT_ICON=""
export POWERLEVEL9K_VCS_GIT_HG_ICON=""
export POWERLEVEL9K_VCS_GIT_SVN_ICON=""
export POWERLEVEL9K_VCS_GIT_TAG_ICON=""
export POWERLEVEL9K_VPN_ICON="廬"
export POWERLEVEL9K_WINDOWS_ICON=""
export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(history ssh context root_indicator host dir dir_writable vcs rbenv nvm virtualenv)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(battery time command_execution_time status background_jobs)

# ZIM
zmodules=(directory environment git git-info history input utility custom \
          syntax-highlighting history-substring-search prompt completion)
zprompt_theme='powerlevel9k'
ztermtitle='%~:%n@%m'
zhighlighters=(main brackets cursor)
source $ZIM_HOME/init.zsh
