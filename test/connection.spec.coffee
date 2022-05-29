axios = require 'axios'

host = process.env.HOST or '127.0.0.1'
port = process.env.PORT or 3000

describe 'Test connection to server', ->

    it 'should return OK status', ->
        try
            { status, statusText } =
                await axios.get "http://#{host}:#{port}"
            expect status
                .to.be 200
            expect statusText
                .to.be 'OK'
        catch error
            delete error.stack
            throw error
