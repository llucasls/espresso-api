notFoundHandler = (_req, res) ->
  res
    .status 404
    .send error: 'Object not found'

export default notFoundHandler
