export default class HTTPError extends Error
    constructor: (@status = 500, message = 'Internal Server Error') ->
        super message
