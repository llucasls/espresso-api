import 'dotenv/config'
import express from 'express'
import Model from './models/model.js'
import errorHandler from './middlewares/errorHandler.js'
import notFoundHandler from './middlewares/notFoundHandler.js'

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

readOne = (req, res) ->
  drinks.readOne req.params.id
    .then (drink) ->
      res
        .status 200
        .json drink

update = (req, res) ->
  drinks.update req.params.id, req.body
    .then (drink) ->
      res
        .status 200
        .json drink

destroy = (req, res) ->
  drinks.delete req.params.id
    .then (drink) ->
      res
        .status 200
        .json drink

app.post('/drinks', create)
app.get('/drinks', read)
app.get('/drinks/:id', readOne)
app.put('/drinks/:id', update)
app.delete('/drinks/:id', destroy)

app.use errorHandler
app.use notFoundHandler

app.listen port, () ->
  console.log "Server listening on port \x1b[03;94m#{port}\x1b[00m."
