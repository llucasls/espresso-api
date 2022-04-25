class Service
  constructor: (@model) ->

  create: (document) ->
    @model.create document

export default Service
