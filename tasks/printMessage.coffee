{ error } = console
[_, _, fileName] = process.argv

switch fileName
    when 'manage-db.sh'
        error 'error: cannot execute script\n'
        error 'This script is meant to automate database tasks'
        error 'It is not for using directly from the shell'
    when 'run-server.sh'
        error 'error: cannot execute script\n'
        error 'In order to run this script,
            you should rather use the following command:'
        error '\x1b[32myarn run dev\x1b[00m'
    when 'test-mocha.sh'
        error 'error: cannot execute script\n'
        error 'In order to run this script,
            you should rather use the following command:'
        error '\x1b[32myarn test\x1b[00m'
    else null
