import express from 'express'
import bodyParser from 'body-parser'
import bodyParserXML from 'body-parser-xml'
import DrinkController from './controllers/drink.js'
import errorHandler from './middlewares/errorHandler.js'
import notFoundHandler from './middlewares/notFoundHandler.js'
import parseData from './middlewares/parseData.js'
import parseYaml from './middlewares/parseYaml.js'
import parseXml from './middlewares/parseXml.js'
import format from './middlewares/format.js'
bodyParserXML bodyParser

app = express()
port = process.env.PORT or 3000
controller = new DrinkController

app.use bodyParser.json()
app.use bodyParser.urlencoded extended: yes
app.use bodyParser.text type: 'text/yaml'
app.use bodyParser.xml()

app.use parseData
app.use parseYaml
app.use parseXml

app.get '/', (req, res, next) ->
    res
        .status 200
        .send 'Coffee Shop opening soon'

app.post('/drinks', controller.create)
app.get('/drinks', format, controller.read)
app.get('/drinks/:id', format, controller.readOne)
app.put('/drinks/:id', controller.update)
app.delete('/drinks/:id', controller.delete)

app.use errorHandler
app.use notFoundHandler

app.listen port, ->
    console.log "Server listening on port \x1b[03;94m#{port}\x1b[00m."
