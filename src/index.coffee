import 'dotenv/config'
import express from 'express'

app = express()
port = process.env.PORT or 3000

app.get '/', (req, res) ->
  res
    .status 200
    .send 'Coffee Shop opening soon'

app.listen port, () ->
  console.log "Application online on port #{port}."
