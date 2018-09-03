#!/usr/bin/sh

# This script watches for inotify events on monitors from card*
# I decided not to use udev, because I want;
#   - distributable (udev rules are dist. on package, while sytemd is config)
#   - user-agnostic (udev rules require specifying user explicitly)
#   - non-root      (X11 runs without root, shouldn't depend on administrator)
#   - wm-agnostic   (udev needs hard coding a script path, which is inflexible)
