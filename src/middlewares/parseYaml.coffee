import { parse } from 'yaml'

parseYaml = (req, _res, next) ->
    req.body = parse req.body if req.headers['content-type'] is 'text/yaml'
    next()

export default parseYaml
