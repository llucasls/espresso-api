describe 'Test error class HttpError', ->

    it 'should throw an error', ->
        { default: HttpError } = await import('../build/utils/httpError.js')
        throwException = -> throw new HttpError
        expect throwException
            .to.throwException()
    it 'should have status and message properties', ->
        { default: HttpError } = await import('../build/utils/httpError.js')
        httpError = new HttpError
        expect httpError
            .to.have.property 'status', 500
        expect httpError
            .to.have.property 'message', 'Internal Server Error'
