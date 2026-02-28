#!/bin/sh
xrandr \
    --output HDMI-0 --mode 3840x2160 --dpi 163 --pos 200x0 --rotate normal \
    --output DP-0 --mode 3840x2160 --dpi 163 --pos 4040x0 --rotate normal \
    --output DP-1 --off \
    --output DP-2 --mode 2560x1440 --scale 1.5x1.5 --dpi 109 --pos 4493x2160 --rotate normal \
    --output DP-3 --off \
    --output DP-4 --primary --mode 3840x2160 --scale 1.17x1.17 --dpi 139 --pos 0x2160 --rotate normal \
    --output DP-5 --off
