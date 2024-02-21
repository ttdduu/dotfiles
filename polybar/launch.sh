#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done



# Launch Polybar, using default config location
~/.config/polybar/config
#/etc/polybar/config.ini
#/usr/share/doc/polybar/config

polybar eDP1 &

if [[ $(xrandr -q | grep 'HDMI1 connected') ]]; then
	xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output HDMI1 --noprimary --mode 1920x1080 --rotate normal --left-of eDP1

    polybar HDMI1 &
	bspc monitor HDMI1 -d 1 2 3 4 5
	bspc monitor eDP1 -d 6 7 8 9 0
else
#	xrandr --output eDP1 --primary --mode 2736x1824 --rotate normal
	polybar eDP1 &
#	~/Documents/scripts/misc/monitor.sh off
	bspc monitor eDP1 -d 1 2 3 4 5 6 7 8 9 0
fi
echo "Polybar launched..."

