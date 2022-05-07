expect = require 'expect.js'
axios = require 'axios'
require 'dotenv/config'

host = process.env.HOST or '127.0.0.1'
port = process.env.PORT or 3000

describe 'Test connection to server', ->

  it 'should return a response from "/" route', ->
    { data: response } = await axios.get "http://#{host}:#{port}"
    expect response
      .to.be 'Coffee Shop opening soon'
