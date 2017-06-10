#!/bin/sh
# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

TOGGLE=$HOME/bin/.toggle

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    if [ ! -e $TOGGLE ]; then
        touch $TOGGLE
        $HOME/.screenlayout/single.sh
        conky -c ~/.conky/conky_maia 
    else
        rm $TOGGLE
        $HOME/.screenlayout/t430.sh
        conky -c ~/.conky/conky_maia 
    fi
else
    $HOME/.screenlayout/single.sh
    conky -c ~/.conky/conky_maia 
fi
