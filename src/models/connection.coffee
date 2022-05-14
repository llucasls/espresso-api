import { MongoClient as client } from 'mongodb'

MONGODB_URL = "mongodb://#{process.env.HOST or 'mongodb'}:27017"
DB_NAME = 'Espresso'

options =
    useNewUrlParser: yes
    useUnifiedTopology: yes

dbConnection = ->
    client.connect MONGODB_URL, options
        .then (conn) ->
            conn.db DB_NAME
        .catch (err) ->
            console.error err.message
            process.exit 1

db = dbConnection()

export default db
