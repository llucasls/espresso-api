import { parseValue as parse } from 'query-types'

parseData = (req, _res, next) ->
    req.body = parse req.body
    next()

export default parseData
