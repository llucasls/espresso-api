import { ObjectId } from 'mongodb'
import db from './connection.js'

class Model
  constructor: (@collection, @db = db) ->

  create: (document) ->
    table = @collection
    result = await @db
      .then (conn) ->
        conn.collection table
          .insertOne document
    result

export default Model

###
{
  acknowledged: true,
  insertedId: new ObjectId("6266c07bf1aec1acfe6d3af7")
}
###

#   connection()
#     .then((conn) => conn.collection('products').insertOne(product))

# readOne
# readMany
# update
# destroy
