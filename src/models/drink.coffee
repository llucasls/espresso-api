import Model from './model.js'
import db from './connection.js'

class Drink extends Model
    constructor: (@collection = 'drinks', @db = db) ->
        super db


export default Drink
