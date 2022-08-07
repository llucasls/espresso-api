#!/bin/sh

pid="$(pgrep $(basename $0))"
pprocess="$(ps -o comm= -p $(ps -o ppid= -p $pid))"
gpprocess="$(ps -o comm= -p $(ps -o ppid= -p $(ps -o ppid= -p $pid)))"

if test "$pprocess" != "node" -a "$gpprocess" != "node"; then
    yarn --silent coffee tasks/printMessage.coffee "$(basename ${0})"
    exit 10
fi

test_names="$(echo "${@}" | tr ' ' '|')"
test_files="$(find test -mindepth 2 -regextype awk \
    -iregex ".*(${test_names})\.spec.coffee")"

mocha ${test_files}
