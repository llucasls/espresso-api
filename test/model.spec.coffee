expect = require 'expect.js'

describe 'Test drinks model', ->

  it 'should be a model', ->
    { default: Model } = await import('../build/models/model.js')
    drink = new Model 'drinks', 'test'
    expect drink
      .to.be.a Model

  it 'should have the basic CRUD methods', ->
    { default: Model } = await import('../build/models/model.js')
    drink = new Model 'drinks', 'test'
    expect drink
      .to.have.property 'create'
    expect drink
      .to.have.property 'read'
    expect drink
      .to.have.property 'readOne'
    expect drink
      .to.have.property 'update'
    expect drink
      .to.have.property 'delete'
