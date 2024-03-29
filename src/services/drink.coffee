import { ObjectId } from 'mongodb'
import YAML from 'yaml'
import XML from '../utils/xml.js'
import Drink from '../models/drink.js'
import HTTPError from '../utils/httpError.js'

IdFormatError = 'Argument passed in must be a string of 24 hex characters'
IdFormatRegex = /^[0-9a-f]{24}$/

drinks = new Drink

export create = (drink) ->
    drink._id = new ObjectId drink._id if drink._id?
    { acknowledged, insertedId } = await drinks.create drink
    throw new HTTPError 500, 'Data insertion failed' if not acknowledged
    result = await drinks.readOne insertedId
    result

export read = (query, format) ->
    switch format
        when 'json'
            data = await drinks.read query
            result = JSON.stringify data
        when 'yaml'
            data = await drinks.read query
            result = YAML.stringify data
        when 'xml'
            data = await drinks.read query
            result = XML.stringify data, 'drinks', 'drink'
        else
            throw new HTTPError 400, 'Format not recognized'
    result

export readOne = (id, format) ->
    switch format
        when 'json'
            data = await drinks.readOne id
            result = JSON.stringify data
        when 'yaml'
            data = await drinks.readOne id
            result = YAML.stringify data
        when 'xml'
            data = await drinks.readOne id
            data['_id'] = String data['_id']
            result = XML.stringify data, 'drink'
        else
            throw new HTTPError 400, 'Format not recognized'
    result

export update = (id, drink) ->
    { value } = await drinks.update id, drink
    value

export destroy = (id) ->
    { acknowledged } = await drinks.delete id
    throw new HTTPError 500, 'Data deletion failed' if not acknowledged
    null
