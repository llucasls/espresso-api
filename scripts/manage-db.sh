#!/bin/sh

pid="$(pgrep $(basename $0))"
gpprocess="$(ps -o comm= -p $(ps -o ppid= -p $(ps -o ppid= -p $pid)))"
if [ "$gpprocess" != "node" ]; then
    echo 'error: cannot execute script\n' > /dev/stderr
    echo 'This script is meant to automate database tasks' > /dev/stderr
    echo 'It is not for using directly from the shell' > /dev/stderr
    exit 10
fi

getopts :pr option
case $option in
    p) mongosh < tasks/populateDB.js ;;
    r) mongosh < tasks/resetDB.js ;;
    *)
        echo 'error: no valid option was given\n' > /dev/stderr
        echo 'valid options: -r -p'
        echo '\tr\treset database'
        echo '\tp\tpopulate database'
        exit 11
    ;;
esac
