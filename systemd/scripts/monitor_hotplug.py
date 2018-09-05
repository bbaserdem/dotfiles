#!/usr/bin/python

# Following the tutorial here;
# https://blog.avichalp.me/an-introduction-to-dbus-e89ad93c874d
#   which doesn't tell much
# Official doc here; 
# https://dbus.freedesktop.org/doc/dbus-python/tutorial.html

import dbus

# We need a system bus to connect to the udev event
system_bus = dbus.SystemBus()
# And a session bus to manage session events
session_bus = dbus.SessionBus()



proxy_object = system_bus.get_object(
        'com.sbp.Hotplug',
        '/some/dir'
        )

# Define our signal handler callback.
def hotplug_change_handler(new_state):
    print(new_state)

system_bus.add_signal_receiver(
    hotplug_change_handler,
    signal_name='Change',
    dbus_interface='com.sbp.Hotplug'
)

loop.run()
