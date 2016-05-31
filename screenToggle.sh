#!/bin/sh
# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

TOGGLE=$HOME/bin/.toggle

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    $HOME/.screenlayout/single.sh
else
    rm $TOGGLE
    $HOME/.screenlayout/artorg.sh
fi
