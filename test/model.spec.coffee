expect = require 'expect.js'
axios = require 'axios'
require 'dotenv/config'

host = process.env.HOST or '127.0.0.1'
port = process.env.PORT or 3000

describe 'Test drinks model', ->

  it 'should be a model', ->
    { default: Model } = await import('../build/models/model.js')
    drink = new Model 'drinks', 'test'
    expect drink
      .to.be.a Model
