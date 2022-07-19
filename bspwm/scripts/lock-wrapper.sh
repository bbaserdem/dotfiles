#!/bin/bash
# Make sure locker is killed if we get killed
trap 'kill %%' TERM INT

# Command to start the locker (should not fork)
locker="${HOME}/.config/bspwm/scripts/lock.sh"

# Delay in seconds. (Max 5 in systemd)
sleep_delay=1

# Things to run before the locker
pre_lock() {
    #mpc pause
    return
}

# Things to run after the locker
post_lock() {
    return
}

# Run pre-lock hooks
pre_lock

# Run the lock with the lock
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    # Lock fd is open
    # Make sure the locker does not inherit a copy
    $locker {XSS_SLEEP_LOCK_FD}<&- &
    # Wait for delay
    sleep $sleep_delay
    # Close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-
else
    # Just run the lock
    $locker &
fi

# Wait until the locking script exits
wait 

post_lock
