{ resolve } = require 'path'
{ execSync: exec } = require 'child_process'
fs = require 'fs/promises'
axios = require 'axios'

host = process.env.HOST or '127.0.0.1'
port = process.env.PORT or 3000
baseUrl = "http://#{host}:#{port}"

populate = resolve 'tasks/populateDB.js'
performTask = (task) -> exec "mongosh Espresso < #{task}"

describe 'Test GET /drinks endpoint (read)', ->
    performTask populate

    it 'should return a JSON formatted list', ->
        { data } = await axios.get "#{baseUrl}/drinks?format=json"
        jsonFile = resolve __dirname, 'mocks/data.json'
        jsonData = require jsonFile
        expect data
            .to.be.eql jsonData

    it 'should return a YAML formatted list', ->
        { data } = await axios.get "#{baseUrl}/drinks?format=yaml"
        yamlFile = resolve __dirname, 'mocks/data.yml'
        yamlData = await fs.readFile yamlFile, 'utf-8'
        expect data
            .to.be.equal yamlData

    it 'should return a XML formatted list', ->
        { data } = await axios.get "#{baseUrl}/drinks?format=xml"
        xmlFile = resolve __dirname, 'mocks/data.xml'
        xmlData = await fs.readFile xmlFile, 'utf-8'
        expect data
            .to.be.equal xmlData

    it 'should return an error', ->
        { data, status } = await axios.get "#{baseUrl}/drinks?format=zml"
        error = error: 'Format not recognized'
        expect status
            .to.be 400
        expect data
            .to.be.equal error
