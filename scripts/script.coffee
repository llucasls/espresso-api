#!/usr/bin/env coffee

{ execSync: exec } = require 'child_process'

[parent] = exec "ps -o comm= -p #{process.ppid}", encoding: 'utf-8'
    .split('\n')

if parent isnt 'node'
    console.error 'error: cannot execute script\n'
    console.error "In order to run this script,
        you should rather use the following command:"
    console.error '\x1b[32myarn run dev\x1b[00m'
    process.exit 10
