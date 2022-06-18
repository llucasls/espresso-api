{ resolve } = require 'path'
{ promisify } = require 'util'
{ exec } = require 'child_process'
run = promisify exec

module.exports =
    populate: resolve __dirname, 'populateDB.js'
    reset: resolve __dirname, 'resetDB.js'
    performTask: (task) -> await run "mongosh Espresso --quiet --norc < #{task}"
