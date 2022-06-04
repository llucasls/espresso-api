format = (req, _res, next) ->
    if req.query.format?
        { format, query... } = req.query
        req.query = query
        req.format = format
    next()

export default format
