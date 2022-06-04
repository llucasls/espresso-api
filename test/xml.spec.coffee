describe '(xml) Test the XML methods', ->

    it 'should turn a JavaScript object into a XML object', ->
        { default: XML } = await import('../build/utils/xml.js')
        { readFile } = await import('fs/promises')
        input = require "#{__dirname}/mocks/data.json"
        output = await readFile "#{__dirname}/mocks/output.xml", 'utf-8'
        expect output
            .to.be.equal XML.stringify input
