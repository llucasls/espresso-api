#!/bin/sh

pid="$(pgrep $(basename $0))"
pprocess="$(ps -o comm= -p $(ps -o ppid= -p $pid))"
gpprocess="$(ps -o comm= -p $(ps -o ppid= -p $(ps -o ppid= -p $pid)))"

if test "$pprocess" != "node" -a "$gpprocess" != "node"; then
    yarn --silent coffee tasks/printMessage.coffee "$(basename ${0})"
    exit 10
fi

if [ -n "$1" ]; then
    mocha -g "$@"
else
    mocha
fi
