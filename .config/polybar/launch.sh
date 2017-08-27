#!/bin/zsh

# Terminate already running bar instances
echo "Terminate already running bar instances"
killall polybar

# Wait until the processes have been shut down
echo "Wait until the processes have been shut down"
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bars
echo "Launch bars"
polybar top -c ~/.config/polybar/config3 &
polybar bottom -c ~/.config/polybar/config3 &
if [[ -n `xrandr | grep "HDMI1 connected"` ]]; then
    echo "HDMI1 connected"
    polybar external_top -c ~/.config/polybar/config3 &
    polybar external_bottom -c ~/.config/polybar/config3 &
fi
