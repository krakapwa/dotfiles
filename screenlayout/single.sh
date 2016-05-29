#!/bin/bash

while [ $times -gt 0 ]; do
    xrandr 1> /dev/null
    sleep $seconds
    let times-=1
done

xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output DP2-1 --off --output DP2-2 --off --output DP2-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off
