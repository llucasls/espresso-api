import express from 'express'
import bodyParser from 'body-parser'
import yaml from 'yaml'
import Drink from './models/drink.js'
import * as service from './services/service.js'
import errorHandler from './middlewares/errorHandler.js'
import notFoundHandler from './middlewares/notFoundHandler.js'
import parseData from './middlewares/parseData.js'
import parseYaml from './middlewares/parseYaml.js'
import format from './middlewares/format.js'

app = express()
port = process.env.PORT or 3000
drinks = new Drink

app.use bodyParser.json()
app.use bodyParser.urlencoded extended: yes
app.use bodyParser.text type: 'text/yaml'

app.use parseData
app.use parseYaml

app.get '/', (req, res, next) ->
    res
        .status 200
        .send 'Coffee Shop opening soon'

create = (req, res, next) ->
    service.create req.body
        .then (drink) ->
            res
                .status 201
                .send drink
        .catch(next)

# read = (req, res, next) ->
#     switch req.format
#         when 'json'
#             drinks.read req.query
#                 .then (drinks) ->
#                     res
#                         .status 200
#                         .type 'json'
#                         .send drinks
#         when 'yaml'
#             drinks.read req.query
#                 .then (drinks) ->
#                     res
#                         .status 200
#                         .type 'yaml'
#                         .send yaml.stringify drinks
#         else
#             drinks.read req.query
#                 .then (drinks) ->
#                     res
#                         .status 200
#                         .json drinks

read = (req, res, next) ->
    drinks.read req.query
        .then (drinks) ->
            res
                .status 200
                .json drinks
        .catch(next)

readOne = (req, res, next) ->
    drinks.readOne req.params.id
        .then (drink) ->
            res
                .status 200
                .json drink
        .catch(next)

update = (req, res, next) ->
    drinks.update req.params.id, req.body
        .then (drink) ->
            res
                .status 200
                .json drink
        .catch(next)

destroy = (req, res, next) ->
    drinks.delete req.params.id
        .then (drink) ->
            res
                .status 200
                .json drink
        .catch(next)

app.post('/drinks', create)
app.get('/drinks', format, read)
app.get('/drinks/:id', readOne)
app.put('/drinks/:id', update)
app.delete('/drinks/:id', destroy)

app.use errorHandler
app.use notFoundHandler

app.listen port, ->
    console.log "Server listening on port \x1b[03;94m#{port}\x1b[00m."
