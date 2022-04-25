import 'dotenv/config'
import { MongoClient as client } from 'mongodb'

MONGODB_URL = "mongodb://#{process.env.HOST or 'mongodb'}:27017"
DB_NAME = 'CoffeeShop'

options =
  useNewUrlParser: yes
  useUnifiedTopology: yes

dbConnection = () ->
  client.connect MONGODB_URL, options
    .then (connection) ->
      connection.db DB_NAME
    .catch (err) ->
      console.error err.message
      process.exit 1

export default dbConnection
