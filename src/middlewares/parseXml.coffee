import { bodyParse as parse } from '../utils/xml.js'

parseXml = (req, _res, next) ->
    req.body = parse req.body if req
        .headers['content-type'] is 'application/xml'
    next()

export default parseXml
