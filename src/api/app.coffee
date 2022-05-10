import express from 'express'
import db from '../models/connection.js'

class App
    constructor: ->
        @app = express()
        @app.use express.json()

    startServer: (port) ->
        @app.listen port, () ->
            console.log "Server listening on port \x1b[03;94m#{port}\x1b[00m!"

    addRouter: (router) ->
        @app.use router

    getApp: ->
        @app

    handleError: (middleware) ->
        @app.use middleware

export default App
