yaml = require 'yaml'

describe 'Test a request with yaml format body', ->

    it 'should create a new entry in the database', ->
        request = require './mocks/data.yml'
        console.log request
