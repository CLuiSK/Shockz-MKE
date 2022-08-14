#!/bin/sh
 
echo "%{F#00BFFF}%{F#FFFFFF}$(/usr/sbin/ifconfig eth0 | grep "inet " | awk '{print $2}')%{u-}"
