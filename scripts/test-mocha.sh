#!/bin/sh

pid="$(pgrep $(basename $0))"
pprocess="$(ps -o comm= -p $(ps -o ppid= -p $pid))"
gpprocess="$(ps -o comm= -p $(ps -o ppid= -p $(ps -o ppid= -p $pid)))"
if [ "$gpprocess" != "node" ]; then
    echo 'error: cannot execute script\n' > /dev/stderr
    echo 'In order to run this script, you should rather use the following command:' > /dev/stderr
    echo '\033[32myarn test\033[00m' > /dev/stderr
    exit 10
fi

if [ -n "$1" ]; then
    mocha -g "$@"
else
    mocha 
fi
