import { ObjectId } from 'mongodb'
import db from './connection.js'

# create = async (obj) ->
#   document = await connection
#     .collection 'products'
#     .insertOne obj
#   document

create = (obj) ->
  connection = await db
    .then (conn) ->
      conn.collection 'drinks'
        .insertOne obj
  connection

export { create }

export default create
#
# insertProduct = (product) =>
#   connection()
#     .then((conn) => conn.collection('products').insertOne(product))

# readOne
# readMany
# update
# destroy
