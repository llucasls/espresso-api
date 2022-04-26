notFoundHandler = (_req, res) ->
  res
    .status 404
    .send message: 'Object not found'

export default notFoundHandler
