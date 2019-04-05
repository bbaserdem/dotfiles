#!/usr/bin/python

import wrapper

test = wrapper.bar_info_init()
test.add_action('mpc next',1)
test.add_action('pavucontrol',2)
test.format['prefix'] = ''
test.format['suffix'] = ''
test.format['output'] = 'Batuhan'
test.display()
test.mute = True
test.format['output'] = 'Nahutab'
test.display()
