#!/bin/sh
 
IFACE=$(/usr/sbin/ifconfig | grep tun1 | awk '{print $1}' | tr -d ':')
 
if [ "$IFACE" = "tun1" ]; then
    echo "%{F#ffdc143c} %{F#ffffff}$(/usr/sbin/ifconfig tun1 | grep "inet " | awk '{print $2}')%{u-}"
else
    echo "%{F#ffdc143c} %{F#000000}Disconnected%{u-}"
fi