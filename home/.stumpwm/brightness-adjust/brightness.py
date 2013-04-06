#!/usr/bin/python
#################################################################################
#
# Joel Agnel Fernandes (agnel.joel@gmail.com)
# Adapted KDE's guidance power manager python module
# to change Brightness of Laptop Panel.
#
# Usage:
# 1. Add the following to your .stumprc
# ;; Brightness Adjust (Fn + Up/Down)
# (run-shell-command "xmodmap -e \'keycode 212 = XF86LaunchE'")
# (run-shell-command "xmodmap -e \'keycode 101 = XF86LaunchD'")
# (define-key stumpwm:*top-map* (stumpwm:kbd "XF86LaunchE") "exec brightness.py +")
# (define-key stumpwm:*top-map* (stumpwm:kbd "XF86LaunchD") "exec brightness.py -")
#
# 2. Symlink brightness.py to /usr/bin/ and chmod +x
# 3. Use Fn brightness keys to change brightness
#
###################################################################################

import sys
from brightadjust import BrightAdjust

br = BrightAdjust()

if '+' in sys.argv:
    new = br.getBrightness() + 1
else:
    new = br.getBrightness() - 1

br.adjustBrightness(new)
