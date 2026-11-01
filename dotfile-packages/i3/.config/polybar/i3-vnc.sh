#!/usr/bin/zsh

# Kill running polybar instance
pkill -f "polybar --reload vnc"

# Wait until the processes have been shut down
while pgrep -f "polybar --reload vnc" >/dev/null; do sleep 0.1; done

polybar --reload vnc &
