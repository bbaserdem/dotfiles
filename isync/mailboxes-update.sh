#!/bin/dash
# Run an isync update; and send a notification if there is new mail.

# Mailboxes location
mailbox_dir="${HOME}/Mail"

# Prepare directories for file-lock
if [ -z "${XDG_DATA_HOME}" ] ; then
  timestamp_file="${HOME}/.local/share/isync/timestamp"
else
  timestamp_file="${XDG_DATA_HOME}/isync/timestamp"
fi
if [ ! -x "$(dirname "${timestamp_file}")" ] ; then
  mkdir -p "$(dirname "${timestamp_file}")"
fi

# Get config location
if [ -z "${XDG_CONFIG_HOME}" ] ; then
  confloc="${HOME}/.config/isync/config"
else
  confloc="${XDG_CONFIG_HOME}/isync/config"
fi

# Do this in a file lock so that multiple instances don't run together
( flock --nonblock --exclusive 5 || exit 1
  for account in "${mailbox_dir}"/* ; do
    account_name="$(basename "${account}")"
    if [ "${account_name}" = 'Search' ] ; then
      continue
    fi
    # Sync this account
    /usr/bin/mbsync --config "${confloc}" --all "${account_name}" \
      || true
    # Get number of newly created mail
    if [ -d "${account}/Inbox/new" ] ; then
      new_mail="$(find "${account}/Inbox/new/" \
        -type f -newer "${timestamp_file}" 2>/dev/null | wc -l)"
      # Send notification
      if [ "${new_mail}" -gt 0 ] ; then
        /usr/bin/notify-send "Email (${account_name})" \
          "${new_mail} new mails in ${account_name}" \
          --icon=email || true
      fi
    fi
  done
) 5>"${timestamp_file}"
