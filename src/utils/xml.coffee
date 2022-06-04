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
    inputObj =
        declaration:
            version: '1.0'
            encoding: 'utf-8'
        elements: [
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

```
const xmlStringify = (jsonData) => {
  const input = {
    declaration: {
      attributes: {
        version: '1.0',
        encoding: 'utf-8'
      }
    },
    elements: [{
      type: 'element',
      name: 'drinks',
      elements: [],
  }] }
  for (const index in jsonData) {
    input.elements[0].elements[index] = {
      type: 'element',
      name: 'drink',
      elements: []
    }
    for (const entry of Object.entries(jsonData[index])) {
      const [key, value] = entry
      input.elements[0].elements[index].elements.push({
        type: 'element',
        name: key,
        elements: [
          { type: 'text', text: value }
        ]
      })
    }
  }
  const output = js2xml(input, { compact: false, spaces: 2 })
  return output
};
```

export parse = parseMany
export stringify = xmlStringify

XML =
    parse: parse
    stringify: stringify

export default XML
