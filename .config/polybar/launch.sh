#!/bin/bash

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
#FC_DEBUG=1 polybar top -c ~/.config/polybar/config3 &
#FC_DEBUG=1 polybar bottom -c ~/.config/polybar/config3 &

if [[ -n $(xrandr | grep "HDMI1 connected") ]]; then
    echo "HDMI1 connected"
    polybar external_top -c ~/.config/polybar/config3 &
    polybar external_bottom -c ~/.config/polybar/config3 &
    #FC_DEBUG=1 polybar external_top -c ~/.config/polybar/config3 &
    #FC_DEBUG=1 polybar external_bottom -c ~/.config/polybar/config3 &

    main="LVDS1"
    second="HDMI1"
    xrandr --output $main --auto --primary --output $second --auto --right-of $main
fi

#if [[ -n $(xrandr | grep "VGA1 connected") ]]; then
#    echo "HDMI1 connected"
#    FC_DEBUG=1 polybar external_top -c ~/.config/polybar/config3 &
#    FC_DEBUG=1 polybar external_bottom -c ~/.config/polybar/config3 &
#    main="LVDS1"
#    second="VGA1"
#    xrandr --output $main --auto --primary --output $second --auto --right-of $main
#fi

if command -v feh &> /dev/null; then
    feh --bg-fill ~/Dropbox/useful/config/wallpaper/frame.jpg
fi

if command -v compton &> /dev/null; then
    compton -Cf --config ~/.config/i3/compton.conf &
fi

if command -v dunst &> /dev/null; then
    bash ~/.config/dunst/Reload_dunst.sh
    dunst -config ~/.config/dunst/dunstrc &
fi
