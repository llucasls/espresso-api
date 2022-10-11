#!/bin/sh

if [ -t 0 ]; then
    yarn --silent coffee tasks/printMessage.coffee "$(basename $0)"
    exit 10
fi

rm -rf build/*
coffee -o build/ -c src/
node -r dotenv/config .
