#!/bin/zsh
# Slow Gnome Apps Fix
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

"$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
