#!/usr/bin/env sh

rm -rf build/*
coffee -o build/ -c src/
node .
