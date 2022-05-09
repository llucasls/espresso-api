import { parseValue as parse } from 'query-types'

parseValue = (req, _res, next) ->
  req.body = parse req.body
  next()

export default parseValue
