expect = require 'expect.js'

describe 'Test drinks model', ->

  it 'should be a model', ->
    { default: Model } = await import('../build/models/model.js')
    drink = new Model 'drinks'
    expect drink
      .to.be.a Model
