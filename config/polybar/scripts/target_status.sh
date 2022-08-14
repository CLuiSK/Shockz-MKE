#!/bin/sh

target=$(cat /home/shockz/.config/polybar/scripts/target)

if [ $target ]; then
	echo "${F#FE2E2E}%{F#ffffff}$target%{u-}"
else
	echo "${F#E73D3D}%{u-}%{F#ffffff} No target"
fi
