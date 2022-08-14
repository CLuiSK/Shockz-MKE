#!/usr/bin/env sh

# Terminar las instancias de barra que ya se están ejecutando
killall -q polybar

# Espere hasta que los procesos se hayan cerrado.
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Barra superior
polybar apagado -c ~/.config/polybar/current.ini &
polybar kali -c ~/.config/polybar/current.ini &
polybar platform -c ~/.config/polybar/current.ini &
polybar target -c ~/.config/polybar/current.ini &
polybar menu -c ~/.config/polybar/current.ini &
polybar files -c ~/.config/polybar/current.ini &
polybar browser -c ~/.config/polybar/current.ini &
polybar burp -c ~/.config/polybar/current.ini &
polybar escritorios -c ~/.config/polybar/current.ini &

# Barra inferior
polybar icono -c ~/.config/polybar/current.ini &
polybar hora -c ~/.config/polybar/current.ini &
polybar procesador -c ~/.config/polybar/current.ini &
polybar memoria -c ~/.config/polybar/current.ini &
polybar network-trafic -c ~/.config/polybar/current.ini &
polybar volumen -c ~/.config/polybar/current.ini &
