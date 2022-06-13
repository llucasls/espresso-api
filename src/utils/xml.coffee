import { xml2js, js2xml } from 'xml-js'
import { parseValue } from 'query-types'

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

export bodyParse = (input) ->
    parsedObj = xml2js input, compact: yes
    [label] = Object.keys parsedObj
    output = parsedObj[label]
    for attribute in Object.keys output
        output[attribute] = output[attribute]['_text']
    output = parseValue output
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

export stringifyMany = (input, root = 'collection') ->
    output = js2xml { [root]: input }, compact: no, spaces: 2
    output

export stringifyOne = (input, root = 'document') ->
    output = js2xml { [root]: input }, compact: yes, spaces: 2
    output

export stringifySelect = (input) ->
    if input instanceof Array
        output = stringifyMany input
    else
        output = stringifyOne input
    output

export parse = xmlParse
export stringify = xmlStringify

XML =
    parse: parse
    stringify: stringify
    stringifyMany: stringifyMany
    stringifyOne: stringifyOne
    stringifySelect: stringifySelect

export default XML
