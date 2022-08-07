describe '(xml) Test the XML methods', ->

    it 'should turn a JavaScript object into a XML object', ->
        { default: XML } = await import('../../build/utils/xml.js')
        { readFile } = await import('fs/promises')

        expected = await readFile "#{__dirname}/../mocks/data.xml", 'utf-8'
        input = require "#{__dirname}/../mocks/data.json"

        output = XML.stringify input, 'drinks', 'drink'

        expect output
            .to.be.equal expected

    it 'should parse a XML object into a JavaScript object', ->
        { default: XML } = await import('../../build/utils/xml.js')
        { readFile } = await import('fs/promises')

        expected = require "#{__dirname}/../mocks/data.json"
        input = await readFile "#{__dirname}/../mocks/data.xml", 'utf-8'

        output = XML.parse input

        expect output
            .to.be.eql expected

    it 'test stringifyOne', ->
        { default: XML } = await import('../../build/utils/xml.js')
        { readFile } = await import('fs/promises')

        expected = await readFile "#{__dirname}/../mocks/whiteTea.xml", 'utf-8'
        data =
            _id: "627d236bc4df74966b2fddd4"
            name: "White Tea"
            price: 600
            description: "A favorite among tea lovers"

        output = XML.stringify data, 'drink'

        expect output
            .to.be.equal expected

    it 'test stringifyMany', ->
        { default: XML } = await import('../../build/utils/xml.js')
        { readFile } = await import('fs/promises')

        expected = await readFile "#{__dirname}/../mocks/data.xml", 'utf-8'
        data = []
        data[0] =
            _id: "627d22e5c4df74966b2fddd2"
            name: "Black Coffee"
            price: 500
            description: "A cup of our traditional coffee"
        data[1] =
            _id: "627d233cc4df74966b2fddd3"
            name: "Orange Juice"
            price: 500
            description: "
            A juice made from our homegrown oranges, directly from Florida"
        data[2] =
            _id: "627d236bc4df74966b2fddd4"
            name: "White Tea"
            price: 600
            description: "A favorite among tea lovers"

        output = XML.stringify data, 'drinks', 'drink'

        expect output
            .to.be.equal expected

    it 'test stringifyMany with another collection', ->
        { default: XML } = await import('../../build/utils/xml.js')
        { readFile } = await import('fs/promises')

        expected = await readFile "#{__dirname}/../mocks/data2.xml", 'utf-8'
        data = []
        data[0] =
            _id: "627d22e5c4df74966b2fddd2"
            name: "Green Tea"
            price: 700
            description: "A widely consumed flavor of tea"

        output = XML.stringify data, 'drinks', 'drink'
#         expected = """
# <drinks>
#   <drink>
#     <_id>627d22e5c4df74966b2fddd2</_id>
#     <name>Green Tea</name>
#     <price>700</price>
#     <description>A widely consumed flavor of tea</description>
#   </drink>
# </drinks>
#         """
        expect output
            .to.be.equal expected
