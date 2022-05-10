export default class HttpError extends Error
    constructor: (@status = 500, @message = 'Internal Server Error') ->
        super message
