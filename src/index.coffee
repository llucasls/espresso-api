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

insert = (req, res) ->
  drinks.create req.body
    .then (drink) ->
      res
        .status 201
        .send drink

app.post('/drinks', insert)

app.listen port, () ->
  console.log "Application online on port #{port}."
