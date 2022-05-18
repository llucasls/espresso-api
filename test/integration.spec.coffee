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
        request =
            drink: 'Black Coffee'
            price: 500
        response = await axios.post "#{baseUrl}/drinks", request
        expect response
            .to.have.property 'status', 201
        expect response.data
            .to.have.property 'drink', 'Black Coffee'
        expect response.data
            .to.have.property 'price', 500

    it 'should get the inserted drink', ->
        { data, status } = await axios.get "#{baseUrl}/drinks"
        expect status
            .to.be 200
        expect data
            .to.be.an Array
        expect data[0]
            .to.have.property 'drink', 'Black Coffee'
        expect data[0]
            .to.have.property 'price', 500
