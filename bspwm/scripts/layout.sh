#!/bin/dash

# Fallmack workspace names
if [ -z "${ws1}" ] ; then ws0='I'  ; fi
if [ -z "${ws2}" ] ; then ws1='II'   ; fi
if [ -z "${ws3}" ] ; then ws2='III'  ; fi
if [ -z "${ws4}" ] ; then ws3='IV'   ; fi
if [ -z "${ws5}" ] ; then ws4='V'  ; fi
if [ -z "${ws6}" ] ; then ws5='VI'   ; fi
if [ -z "${ws7}" ] ; then ws6='VII'  ; fi
if [ -z "${ws8}" ] ; then ws7='VIII' ; fi
if [ -z "${ws9}" ] ; then ws8='IX'   ; fi
if [ -z "${ws0}" ] ; then ws9='X'  ; fi

_monnum="$(bspc query --monitors | wc --lines)"
case $_monnum in
  1)  bspc monitor --reset-desktops $ws1 $ws2 $ws3 $ws4 $ws5 $ws6 $ws7 $ws8 $ws9 $ws0 ;;
  2)  bspc monitor "$(bspc query --monitors|awk NR==1)" \
      --reset-desktops $ws1 $ws2 $ws3 $ws4 $ws5
    bspc monitor "$(bspc query --monitors|awk NR==2)" \
      --reset-desktops $ws6 $ws7 $ws8 $ws9 $ws0 ;;
  3)  bspc monitor "$(bspc query --monitors|awk NR==1)" \
      --reset-desktops $ws1 $ws2 $ws3 $ws4
    bspc monitor "$(bspc query --monitors|awk NR==2)" \
      --reset-desktops $ws5 $ws6 $ws7
    bspc monitor "$(bspc query --monitors|awk NR==3)" \
      --reset-desktops $ws8 $ws9 $ws0 ;;
  *)  _primary="$(bspc query --monitors --monitor primary)"
    i=1
    for monitor in $(bspc query --monitors); do
      if [ "${monitor}" = "${_primary}" ] ; then
        bspc monitor "${monitor}" --reset-desktops \
          $ws1 $ws2 $ws3 $ws4 $ws5 $ws6 $ws7 $ws8 $ws9 $ws0
      else
        bspc monitor "${monitor}" --reset-desktops "${i}"
        i=$((i + 1))
      fi
    done ;;
esac
