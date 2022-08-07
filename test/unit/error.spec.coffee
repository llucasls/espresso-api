describe 'Test error class HTTPError', ->

    it 'should throw an error', ->
        { default: HTTPError } = await import('../../build/utils/httpError.js')
        throwException = -> throw new HTTPError
        expect throwException
            .to.throwException()
    it 'should have status and message properties', ->
        { default: HTTPError } = await import('../../build/utils/httpError.js')
        httpError = new HTTPError
        expect httpError
            .to.have.property 'status', 500
        expect httpError
            .to.have.property 'message', 'Internal Server Error'
