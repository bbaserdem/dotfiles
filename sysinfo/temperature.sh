#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT


###################################################
#  _                             _                #
# | |_ ___ _____ ___ ___ ___ ___| |_ _ _ ___ ___  #
# |  _| -_|     | . | -_|  _| .'|  _| | |  _| -_| #
# |_| |___|_|_|_|  _|___|_| |__,|_| |___|_| |___| #
#               |_|                               #
###################################################
# Temperature module
#  * Can specify chip with instance; or picks a sane default
#  * Also takes keywords CPU and GPU
if [ -z "${SYSINFO_TEMP_POLL}" ] ; then
  SYSINFO_TEMP_POLL=10
fi
print_info () {
  chiplist="$(/usr/bin/sensors | awk '{if(NF==1){print $1}}')"
  # Try to find a CPU sensor
  if [ "${instance}" = 'default' ] || [ "${instance}" = 'cpu' ] ; then
    # Try some sane defaults
    chip="$(echo "${chiplist}" | awk '/coretemp/ {print $1}' | head -n 1)"
    if [ -z "${chip}" ] ; then
      chip="$(echo "${chiplist}" | awk '/k10temp/ {print $1}' | head -n 1)"
    fi
  # Try to find a GPU sensor
  elif [ "${instance}" = 'gpu' ] ; then
    # Try some sane defaults
    chip="$(echo "${chiplist}" | awk '/amdgpu/ {print $1}' | head -n 1)"
  else # Check if instance is a recognized interface
    if echo "${chiplist}" | grep --quiet "${chip}" ; then
      chip="${instance}"
    else
      empty_output
      exit 1
    fi
  fi
  # If chip was not found; quit
  if [ -z "${chip}" ] ; then
    empty_output
    exit 1
  fi
  # Try to get information on the chip
  temp="$(/usr/bin/sensors "${chip}" 2>/dev/null)"
  if echo "${temp}" | grep --quiet 'for more information' ; then
    empty_output
    exit 1
  fi
  # Try to read temperatures in a known chipsets;
  case "${chip}" in
    coretemp*) # INTEL CPU
      suf=' ﬙'
      # If there is package id; get that entry
      temp="$(echo "${temp}" | awk '/Package id 0:/
        {print substr($4, 2, length($4)-3)}')"
      # If there was no package id; calculate core averages
      if [ -z "${temp}" ] ; then
        temp="$(echo "${temp}" | awk '/Core/ {sum+=substr($3, 2, length($3)-3)}
          END {if(NR>0) printf("%.1f",sum/NR)}')"
      fi
      ;;
    k10temp*) # AMD CPU
      suf=' ﬙'
      # Tctl apparently is the true temperature
      temp="$(echo "${temp}" | awk '/Tctl/ {print substr($2, 2, length($2)-3)}')"
      ;;
    amdgpu*) # AMD GPU
      suf=' '
      # If there is junction temperature; get that
      temp="$(echo "${temp}" | awk '/junction/ {print substr($2, 2, length($2)-3)}')"
      # Try the edge temperature, if you could not find it
      if [ -z "${temp}" ] ; then
        temp="$(echo "${temp}" | awk '/edge/ {print substr($2, 2, length($2)-3)}')"
      fi
      ;;
  esac
  # If this failed; give up
  if [ -z "${temp}" ] ; then
    empty_output
    exit 1
  fi
  # Check and adjust things to high temperature
  txt="${temp}°C"
  pre=' '
  feature=''
  temp_int="$(echo "${temp}" | awk '{printf("%d", $1)}')"
  if   [ "${temp_int}" -lt 30 ] ; then pre=' '
  elif [ "${temp_int}" -lt 40 ] ; then pre=' '
  elif [ "${temp_int}" -lt 50 ] ; then pre=' '
  elif [ "${temp_int}" -lt 60 ] ; then pre=' '
  elif [ "${temp_int}" -lt 70 ] ; then pre=' '
  else
      feature='urgent'
      txt="${txt}  "
  fi
  # Print string
  formatted_output
}

print_loop () {
  while : ; do
    print_info || exit
    sleep "${SYSINFO_TEMP_POLL}"
  done
}
