errorHandler = (err, _req, res, _next) ->
    res
        .status err.status
        .send error: err.message

export default errorHandler
