#!/usr/bin/env sh

if [ -n "$1" ]; then
    mocha -g "$@"
else
    mocha 
fi
