#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch

## Left bar
polybar log -c ~/.config/polybar/current.ini &
polybar third -c ~/.config/polybar/current.ini &
polybar fourth -c ~/.config/polybar/current.ini &
#polybar fifth -c ~/.config/polybar/current.ini &
polybar sixth -c ~/.config/polybar/current.ini &

## Right bar
#polybar top -c ~/.config/polybar/current.ini &
polybar first -c ~/.config/polybar/current.ini &
polybar second -c ~/.config/polybar/current.ini &
polybar seventh -c ~/.config/polybar/current.ini &
polybar eighth -c ~/.config/polybar/current.ini &

## Center bar
polybar primary -c ~/.config/polybar/workspace.ini &
