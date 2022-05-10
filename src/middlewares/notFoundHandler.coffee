notFoundHandler = (_req, res) ->
    res
        .status 404
        .send error: 'Resource not found'

export default notFoundHandler
