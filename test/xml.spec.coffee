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

    it 'test stringifyOne', ->
        { default: XML } = await import('../build/utils/xml.js')
        { readFile } = await import('fs/promises')
        data =
            _id: "627d236bc4df74966b2fddd4"
            name: "White Tea"
            price: 600
            description: "A favorite among tea lovers"
        output = XML.stringifyOne data, 'drink'
        expected = """
<drink>
  <_id>627d236bc4df74966b2fddd4</_id>
  <name>White Tea</name>
  <price>600</price>
  <description>A favorite among tea lovers</description>
</drink>
        """
        expect output
            .to.be.eql expected

    it 'test stringifyMany', ->
        { default: XML } = await import('../build/utils/xml.js')
        { readFile } = await import('fs/promises')
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
        output = XML.stringifyMany data, 'drinks'
        expected = """
<drinks>
  <drink>
    <_id>627d22e5c4df74966b2fddd2</_id>
    <name>Black Coffee</name>
    <price>500</price>
    <description>A cup of our traditional coffee</description>
  </drink>
  <drink>
    <_id>627d233cc4df74966b2fddd3</_id>
    <name>Orange Juice</name>
    <price>500</price>
    <description>A juice made from our homegrown oranges, directly from Florida</description>
  </drink>
  <drink>
    <_id>627d236bc4df74966b2fddd4</_id>
    <name>White Tea</name>
    <price>600</price>
    <description>A favorite among tea lovers</description>
  </drink>
</drinks>
        """
        expect output
            .to.be.eql expected
