#!/bin/sh

pid="$(pgrep $(basename $0))"
pprocess="$(ps -o comm= -p $(ps -o ppid= -p $pid))"
gpprocess="$(ps -o comm= -p $(ps -o ppid= -p $(ps -o ppid= -p $pid)))"

if test "$pprocess" != "node" -a "$gpprocess" != "node"; then
    yarn --silent coffee tasks/printMessage.coffee "$(basename ${0})"
    exit 10
fi

if test -n "$1" -a -z "$2"; then
    test_file="$1"
    mocha "test/${test_file}.spec.coffee"
elif test -n "$2"; then
    test_files="$(echo "$@" | tr \  ',')"
    mocha "test/{${test_files}}.spec.coffee"
else
    mocha "test/connection.spec.coffee" &&
    mocha --ignore "test/connection.spec.coffee"
fi
