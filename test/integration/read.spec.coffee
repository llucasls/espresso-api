fs = require 'fs/promises'
axios = require 'axios'
YAML = require 'yaml'
{ resolve } = require 'path'
{ performTask, populate, reset } = require '../../tasks/performTask.coffee'

host = process.env.HOST or '127.0.0.1'
port = process.env.PORT or 3000
baseUrl = "http://#{host}:#{port}"

describe 'read', ->

    before ->
        await performTask reset
        await performTask populate

    after -> await performTask reset

    describe 'Test GET /drinks endpoint (read)', ->
        it 'should return a JSON formatted list', ->
            { data } = await axios.get "#{baseUrl}/drinks?format=json"
            jsonFile = resolve __dirname, '..', 'mocks/data.json'
            jsonData = require jsonFile
            expect data
                .to.be.eql jsonData

        it 'should return a YAML formatted list', ->
            { data } = await axios.get "#{baseUrl}/drinks?format=yaml"
            yamlFile = resolve __dirname, '..', 'mocks/data.yml'
            yamlData = await fs.readFile yamlFile, 'utf-8'
            expect data
                .to.be.equal yamlData

        it 'should return a XML formatted list', ->
            { data } = await axios.get "#{baseUrl}/drinks?format=xml"
            xmlFile = resolve __dirname, '..', 'mocks/data.xml'
            xmlData = await fs.readFile xmlFile, 'utf-8'
            expect data
                .to.be.equal xmlData

        it 'should return an error', ->
            try
                { data, status } = await axios
                    .get "#{baseUrl}/drinks?format=zml"
                response = { data, status }
                throw { response }
            catch error
                { status, data } = error.response
                expect status
                    .to.be 400
                expect data
                    .to.be.eql error: 'Format not recognized'

        it 'should return a database document', ->
            id = '627d233cc4df74966b2fddd3'
            { data } = await axios.get "#{baseUrl}/drinks/#{id}?format=json"
            document =
                _id: "627d233cc4df74966b2fddd3"
                name: 'Orange Juice'
                price: 500
                description: "
                A juice made from our homegrown oranges, directly from Florida"
            expect data
                .to.be.eql document

        it 'should return a YAML formatted document', ->
            id = '627d22e5c4df74966b2fddd2'
            { data } = await axios.get "#{baseUrl}/drinks/#{id}?format=yaml"
            document = YAML.stringify
                _id: '627d22e5c4df74966b2fddd2',
                name: 'Black Coffee',
                price: 500,
                description: 'A cup of our traditional coffee'
            expect data
                .to.be.equal document

        it 'should return a XML formatted document', ->
            XML = await import('../../build/utils/xml.js')
            id = '627d236bc4df74966b2fddd4'
            { data } = await axios.get "#{baseUrl}/drinks/#{id}?format=xml"
            xmlFile = resolve __dirname, '..', 'mocks/whiteTea.xml'
            document = await fs.readFile xmlFile, 'utf-8'
            expect data
                .to.be.equal document
