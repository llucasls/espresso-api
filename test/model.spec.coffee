expect = require 'expect.js'

describe 'compare different numbers', ->

  it 'will return an error', ->
    { default: Model } = await import('../build/models/model.js')
    drink = 0
    expect drink
