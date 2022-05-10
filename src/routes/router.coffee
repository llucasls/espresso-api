import express from 'express'

class Router
    constructor: ->
        @router = express.Router()

    addRoute: (controller, route = controller.route) ->
        @router.get route, controller.read
        @router.get "#{route}/:id", controller.readOne
        @router.post route, controller.create
        @router.put "#{route}/:id", controller.update
        @router.delete "#{route}/:id", controller.delete
        null

export default Router
