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

export default Model



