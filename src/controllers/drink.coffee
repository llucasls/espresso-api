import * as service from '../services/drink.js'

class DrinkController
    create: (req, res, next) ->
        service.create req.body
            .then (drink) ->
                res
                    .status 201
                    .send drink
            .catch(next)

    read: (req, res, next) ->
        switch req.format
            when 'json'
                service.read req.query, 'json'
                    .then (drinks) ->
                        res
                            .status 200
                            .type 'json'
                            .send drinks
                    .catch(next)
            when 'yaml'
                service.read req.query, 'yaml'
                    .then (drinks) ->
                        res
                            .status 200
                            .type 'yaml'
                            .send drinks
                    .catch(next)
            else
                service.read req.query
                    .then (drinks) ->
                        res
                            .status 200
                            .send drinks
                    .catch(next)

    readOne: (req, res, next) ->
        service.readOne req.params.id
            .then (drink) ->
                res
                    .status 200
                    .json drink
            .catch(next)

    update: (req, res, next) ->
        service.update req.params.id, req.body
            .then (drink) ->
                res
                    .status 200
                    .json drink
            .catch(next)

    delete: (req, res, next) ->
        service.destroy req.params.id
            .then ->
                res
                    .status 204
                    .end()
            .catch(next)


export default DrinkController
