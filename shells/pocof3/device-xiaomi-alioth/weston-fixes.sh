#!/bin/sh
echo "sourcing /etc/X11/xinit/xinitrc.d/00-xiaomi-alioth-weston-fixes.sh" | logger -t "$(whoami):xiaomi-alioth-weston-fixes"
export WESTON_DISABLE_ATOMIC=1
export MESA_LOADER_DRIVER_OVERRIDE=msm
