#!/usr/bin/sh

_title="⏼"

_log="﫼 Log out"
_con=" Return to Console"
_gra=" Refresh Window Manager"
_pow=" Shutdown"
_reb=" Restart"
_sus=" Suspend"
_hib=" Hibernate"
_hyb="落 Hybrid Suspend-Hibernate"

_opt="${_pow}\n${_reb}\n${_sus}\n${_hib}\n${_hyb}\n${_gra}\n${_con}"
_num="$(echo -e ${_opt} | wc -l)"

_theme="Pop-Dark"
_launcher="rofi -theme ${_theme} -lines ${_num} -width 27 -dmenu -i -p ${_title}"

_choice="$(echo -e ${_opt} | ${_launcher} | awk '{print $1}' | tr -d '\r\n')"
if [ "${#o_choice}" -gt 0 ]
then
    case $_choice in
      $_log) /usr/bin/swaymsg exit ;;
      $_con) /usr/bin/swaymsg exit  ;;
      $_con) $XDG_CONFIG_HOME/i3/parse_config.sh ; /usr/bin/swaymsg reload ;;
      $_pow) /usr/bin/systemctl poweroff ;;
      $_reb) /usr/bin/systemctl reboot ;;
      $_sus) $XDG_CONFIG_HOME/sway/lock.sh & /usr/bin/systemctl suspend ;;
      $_hib) $XDG_CONFIG_HOME/sway/lock.sh & /usr/bin/systemctl hibernate ;;
      $_hyb) $XDG_CONFIG_HOME/sway/lock.sh & /usr/bin/systemctl suspend-then-hibernate ;;
      *)
        ;;
    esac
fi
