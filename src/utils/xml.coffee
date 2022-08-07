import { xml2js, js2xml } from 'xml-js'
import { parseValue } from 'query-types'


expandCollection = (input, root, child) ->
    output =
        elements: [
            type: 'element'
            name: root
            elements: []]

    elements = output['elements'][0]['elements']

    for index in [0...input.length]
        document =
            type: 'element'
            name: child
            elements: []

        for entry in Object.entries input[index]
            [key, value] = entry
            attribute =
                type: 'element'
                name: key
                elements: [{
                    type: 'text'
                    text: value
                }]

            document['elements'].push attribute

        elements.push document

    output


stringifyMany = (input, root = 'collection', child = 'document') ->
    newCollection = expandCollection input, root, child
    output = js2xml newCollection, compact: no, spaces: 2
    output += "\n"
    output


stringifyOne = (input, root = 'document') ->
    output = js2xml { [root]: input }, compact: yes, spaces: 2
    output += "\n"
    output


export stringify = (input, root, element) ->
    if input instanceof Array
        output = stringifyMany input, root, element
    else
        output = stringifyOne input, root
    output


export parse = (input) ->
    try
        output = []
        { elements: root } = xml2js input, compact: no
        { elements: children } = root[0]
        children
            .map ({ elements: document }) -> document
            .forEach (data, index) ->
                output[index] = {}
                document = { ...data
                    .map ({ name, elements }) -> ({ [name]: elements[0].text })
                }
                for attribute in Object.values document
                    key = Object.keys attribute
                    [value] = Object.values attribute
                    output[index][key] = value
    catch
        parsedDoc = xml2js input, compact: yes
        [root] = Object.keys parsedDoc
        output = parsedDoc[root]
        for key in Object.keys output
            output[key] = output[key]['_text']
        output = parseValue output

    output


XML =
    parse: parse
    stringify: stringify


export default XML
