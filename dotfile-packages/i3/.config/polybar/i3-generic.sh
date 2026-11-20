
#!/usr/bin/env sh

# Kill running polybar instance
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.1; done

screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)

for m in ${screens}; do 
    MONITOR=$m polybar --reload voz &
done
