import Model from '../models/model.js'
import HttpError from '../utils/httpError.js'

IdFormatError = 'Argument passed in must be a string of 24 hex characters'
IdFormatRegex = /^[0-9a-f]{24}$/

class Service
    constructor: (@model = new Model 'drinks') ->

    create: (document) ->
        @model.create document

    read: (query) ->
        @model.read query

    readOne: (id) ->
        if not IdFormatRegex.test id
        then throw new HttpError 400, IdFormatError
        @model.readOne id

    update: (id, document) ->
        @model.update id, document

    delete: (id) ->
        @model.delete id


export default Service
