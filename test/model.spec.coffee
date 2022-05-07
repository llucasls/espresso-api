expect = require 'expect.js'
axios = require 'axios'
require 'dotenv/config'

describe 'Test drinks model', ->

  it 'should be a model', ->
    { default: Model } = await import('../build/models/model.js')
    drink = new Model 'drinks', 'test'
    expect drink
      .to.be.a Model
