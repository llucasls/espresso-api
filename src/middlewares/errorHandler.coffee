errorHandler = (err, _req, res, _next) ->
  res
    .status err.status
    .send err.message

export default errorHandler
