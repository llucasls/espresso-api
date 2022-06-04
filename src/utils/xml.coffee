import { xml2js, js2xml } from 'xml-js'

parseMany = (input) ->
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
            for attribute of Object.values document
                key = Object.keys attribute
                [value] = Object.values attribute
                output[index][key] = value
    output

stringifyMany = (input) ->
    inputObj = elements: [
        type: 'element'
        name: 'drinks'
        elements: []
    ]
    for index in input
        inputObj.elements[0].elements[index] =
            type: 'element'
            name: 'drink'
            elements: []
    for entry of Object.entries input[index]
        [key, value] = entry
        inputObj.elements[0].elements[index].elements.push
            type: 'element'
            name: key
            elements: [{ type: 'text', text: value }]
    output = js2xml inputObj, compact: no, spaces: 2
    output
