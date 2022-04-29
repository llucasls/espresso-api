import { ObjectId } from 'mongodb'
import db from './connection.js'

class Model
  constructor: (@collection, @db = db) ->

  create: (document) ->
    table = @collection
    result = await @db
      .then (conn) ->
        conn
          .collection table
          .insertOne document
    result

  read: (query) ->
    table = @collection
    result = await @db
      .then (conn) ->
        conn
          .collection table
          .find query
          .toArray()
    result

  readOne: (id) ->
    table = @collection
    result = await @db
      .then (conn) ->
        conn
          .collection table
          .findOne new ObjectId id
    result



export default Model
