#!/usr/bin/env sh

if [ -n "$1" ]; then
    mocha -r coffeescript/register test/**/*.spec.coffee --exit -t 60000 -g "$@"
else
    mocha -r coffeescript/register test/**/*.spec.coffee --exit -t 60000
fi
