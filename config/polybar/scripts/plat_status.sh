#!/bin/sh
 
IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')
IFACE1=$(/usr/sbin/ifconfig | grep tun1 | awk '{print $1}' | tr -d ':') 

if [ "$IFACE" = "tun0" ]; then
#    sed -i '253 s///' ~/.config/polybar/current.ini
    echo "$(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')%{u-}"
elif [ "$IFACE1" = "tun1" ]; then
#   sed -i '253 s///' ~/.config/polybar/current.ini
    echo "$(/usr/sbin/ifconfig tun1 | grep "inet " | awk '{print $2}')%{u-}"
else
 #   sed -i '253 s///' ~/.config/polybar/current.ini
    echo " Disconnected"
fi
