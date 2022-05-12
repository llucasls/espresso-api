format = (req, _res, next) ->
    if req.query.format?
        { format: reqFormat, query... } = req.query
        req.query = query
        req.format = reqFormat
    next()

export default format
