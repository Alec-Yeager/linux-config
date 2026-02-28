#!/bin/sh
xrandr \
    --output HDMI-0 --mode 3840x2160 --pos 200x0 --rotate normal \
    --output DP-0 --off \
    --output DP-1 --off \
    --output DP-2 --mode 2560x1440 --pos 4493x2160 --rotate normal \
    --output DP-3 --off \
    --output DP-4 --primary --mode 3840x2160 --pos 0x2160 --rotate normal \
    --output DP-5 --off
