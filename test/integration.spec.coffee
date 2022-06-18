fs = require 'fs'
axios = require 'axios'
{ performTask, reset } = require '../tasks/performTask.coffee'

host = process.env.HOST or '127.0.0.1'
port = process.env.PORT or 3000
baseUrl = "http://#{host}:#{port}"

describe 'integration', ->
    before await -> performTask reset

    describe 'Perform an integration test', ->
        it 'should return an empty array', ->
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
                .to.have.property 'name', 'Black Coffee'
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
                .to.have.property 'name', 'Orange Juice'
            expect response.data
                .to.have.property 'price', 500

        it 'should create a third entry by sending url encoded data', ->
            request = 'name=Green%20Tea&price=700'
            requestConfig =
                headers: 'Content-Type': 'application/x-www-form-urlencoded'
            response = await axios
                .post "#{baseUrl}/drinks", request, requestConfig
            expect response
                .to.have.property 'status', 201
            expect response.data
                .to.have.property 'name', 'Green Tea'
            expect response.data
                .to.have.property 'price', 700

        it.skip 'should create a fourth entry by sending XML formatted data', ->
            request = fs.readFileSync 'test/mocks/whiteTea.xml', 'utf-8'
            requestConfig =
                headers: 'Content-Type': 'application/xml'
            response = await axios
                .post "#{baseUrl}/drinks", request, requestConfig
            expect response
                .to.have.property 'status', 201
            expect response.data
                .to.have.property 'name', 'White Tea'
            expect response.data
                .to.have.property 'price', 600

        it 'should get the inserted drinks', ->
            { data, status } = await axios.get "#{baseUrl}/drinks"
            expect status
                .to.be 200
            expect data
                .to.be.an Array
            expect data[0]
                .to.have.property 'name', 'Black Coffee'
            expect data[0]
                .to.have.property 'price', 500
            expect data[1]
                .to.have.property 'name', 'Orange Juice'
            expect data[1]
                .to.have.property 'price', 500
            expect data[2]
                .to.have.property 'name', 'Green Tea'
            expect data[2]
                .to.have.property 'price', 700
            expect data[3]
                .to.have.property 'name', 'White Tea'
            expect data[3]
                .to.have.property 'price', 600
