#!/bin/sh

if [ -t 0 ]; then
    echo 'error: cannot execute script\n' > /dev/stderr
    echo 'In order to run this script, you should rather use the following command:' > /dev/stderr
    echo '\033[32myarn run dev\033[00m' > /dev/stderr
    exit 10
fi

rm -rf build/*
coffee -o build/ -c src/
node .
