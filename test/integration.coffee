expect = require 'expect.js'
axios = require 'axios'

host = process.env.HOST or '127.0.0.1'
port = process.env.PORT or 3000
baseUrl = "http://#{host}:#{port}"

describe 'Perform an integration test', ->

    it 'should return an empty array', ->
        # { status } = await axios.delete "http://#{host}:#{port}/drinks"
        { data, status } = await axios.get "#{baseUrl}/drinks"
        expect status
            .to.be 200
        expect data
            .to.eql []

    it 'should create and return a new entry in the drinks collection', ->
        data =
            _id: '123789456abc123789456abc'
            drink: 'Black Coffee'
            price: 500
        { data: response, status } = await axios.post "#{baseUrl}/drinks", data
        expect status
            .to.be 201
        expect response
            .to.be.equal data
