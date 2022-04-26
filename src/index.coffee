import 'dotenv/config'
import express from 'express'
import Model from './models/model.js'

app = express()
port = process.env.PORT or 3000
drinks = new Model 'drinks'

app.use express.json()

app.get '/', (req, res) ->
  res
    .status 200
    .send 'Coffee Shop opening soon'

create = (req, res) ->
  drinks.create req.body
    .then (drink) ->
      res
        .status 201
        .send drink

read = (req, res) ->
  drinks.read req.query
    .then (drinks) ->
      res
        .status 200
        .json drinks

app.post('/drinks', create)
app.get('/drinks', read)

app.listen port, () ->
  console.log "Application online on port #{port}."
