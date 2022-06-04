format = (req, _res, next) ->
    if req.query.format?
        { format, query... } = req.query
        req.query = query
        req.format = format
    else
        req.format = 'json'
    next()

export default format
