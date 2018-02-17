#!/bin/sh

if grep -q ON /proc/acpi/bbswitch; then
      echo "NVIDIA"
else
    echo "Intel"
fi
