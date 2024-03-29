import Model from '../models/model.js'
import HTTPError from '../utils/httpError.js'

IdFormatError = 'Argument passed in must be a string of 24 hex characters'
IdFormatRegex = /^[0-9a-f]{24}$/

drinks = new Model 'drinks'

export create = (drink) ->
    { acknowledged, insertedId } = await drinks.create drink
    throw new HTTPError 500, 'Data insertion failed' if not acknowledged
    result = await drinks.readOne insertedId
    result

export update = (id, drink) ->
    { value } = await drinks.update id, drink
    value

export destroy = (id) ->
    { acknowledged } = await drinks.delete id
    throw new HTTPError 500, 'Data deletion failed' if not acknowledged
    null
