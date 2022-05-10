import Service from '../services/service.js'

class Controller
    constructor: (@route, @service = new Service) ->

    create: (req, res, next) ->
        @service
            .create req.body
            .then (document) ->
                res
                    .status 201
                    .json document
            .catch next

    read: (req, res, next) ->
        @service
            .read req.query
            .then (drinks) ->
                res
                    .status 200
                    .json drinks
            .catch next

    readOne: (req, res, next) ->
        @service
            .readOne req.params.id
            .then (drink) ->
                res
                    .status 200
                    .json drink
            .catch next

    update: (req, res, next) ->
        @service
            .update req.params.id, req.body
            .then (drink) ->
                res
                    .status 200
                    .json drink
            .catch next

    delete: (req, res, next) ->
        @service
            .delete req.params.id
            .then (drink) ->
                res
                    .status 200
                    .json drink
            .catch next


export default Controller
