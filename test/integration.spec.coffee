fs = require 'fs'
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
        request = fs.readFileSync 'test/mocks/blackCoffee.json', 'utf-8'
        requestConfig =
            headers: 'Content-Type': 'application/json'
        response = await axios
            .post "#{baseUrl}/drinks", request, requestConfig
        expect response
            .to.have.property 'status', 201
        expect response.data
            .to.have.property 'drink', 'Black Coffee'
        expect response.data
            .to.have.property 'price', 500

    it 'should create another entry by sending YAML formatted data', ->
        request = fs.readFileSync 'test/mocks/orangeJuice.yml', 'utf-8'
        requestConfig =
            headers: 'Content-Type': 'text/yaml'
        response = await axios
            .post "#{baseUrl}/drinks", request, requestConfig
        expect response
            .to.have.property 'status', 201
        expect response.data
            .to.have.property 'drink', 'Orange Juice'
        expect response.data
            .to.have.property 'price', 500

    it 'should create a third entry by sending url encoded data', ->
        request = 'drink=White%20Tea&price=700'
        requestConfig =
            headers: 'Content-Type': 'application/x-www-form-urlencoded'
        response = await axios
            .post "#{baseUrl}/drinks", request, requestConfig
        expect response
            .to.have.property 'status', 201
        expect response.data
            .to.have.property 'drink', 'White Tea'
        expect response.data
            .to.have.property 'price', 700

    it 'should get the inserted drinks', ->
        { data, status } = await axios.get "#{baseUrl}/drinks"
        expect status
            .to.be 200
        expect data
            .to.be.an Array
        expect data[0]
            .to.have.property 'drink', 'Black Coffee'
        expect data[0]
            .to.have.property 'price', 500
        expect data[1]
            .to.have.property 'drink', 'Orange Juice'
        expect data[1]
            .to.have.property 'price', 500
        expect data[2]
            .to.have.property 'drink', 'White Tea'
        expect data[2]
            .to.have.property 'price', 700
