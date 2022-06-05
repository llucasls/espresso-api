describe '(xml) Test the XML methods', ->

    it 'should turn a JavaScript object into a XML object', ->
        { default: XML } = await import('../build/utils/xml.js')
        { readFile } = await import('fs/promises')
        input = require "#{__dirname}/mocks/data.json"
        output = await readFile "#{__dirname}/mocks/data.xml", 'utf-8'
        expect output
            .to.be.equal XML.stringify input

    it 'should parse a XML object into a JavaScript object', ->
        { default: XML } = await import('../build/utils/xml.js')
        { readFile } = await import('fs/promises')
        input = await readFile "#{__dirname}/mocks/data.xml", 'utf-8'
        output = require "#{__dirname}/mocks/data.json"
        expect output
            .to.be.eql XML.parse input
