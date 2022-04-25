class Controller
  constructor: (@service) ->

  create: (req, res, next) ->
    @service
      .create req.body
      .then (document) ->
        res
          .status 201
          .json document
      .catch next

export default Controller
