#!/bin/bash
local times=2
local seconds=1

while [ $times -gt 0 ]; do
    xrandr 1> /dev/null
    sleep $seconds
    let times-=1
done


xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --off --output DP2-1 --off --output DP2-2 --mode 1920x1200 --pos 1680x0 --rotate normal --output DP2-3 --mode 1680x1050 --pos 0x0 --rotate normal --output HDMI2 --off --output HDMI1 --off --output DP2 --off
