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

export bodyParse = (input) ->
    [label] = Object.keys input
    output = { input[label]... }
    for key in Object.keys output
        console.log 'key', key
        output[key] = output[key][0]
    output

```
const xmlParse = (xmlData) => {
  const output = []
  const { elements: root } = xml2js(xmlData, { compact: false })
  const { elements: children } = root[0]
  children
    .map(({ elements: document }) => document)
    .forEach((data, index) => {
      output[index] = {}
      const document = { ...data
        .map(({ name, elements }) => ({ [name]: elements[0].text }))
      }
      for (const attribute of Object.values(document)) {
        const key = Object.keys(attribute)
        const [value] = Object.values(attribute)
        output[index][key] = value
      }
    })
  return output
};

const xmlStringify = (jsonData) => {
  const input = {
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

export parse = xmlParse
export stringify = xmlStringify

XML =
    parse: parse
    stringify: stringify

export default XML
