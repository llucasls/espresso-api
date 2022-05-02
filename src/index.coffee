import 'dotenv/config'
import server from './api/server.js'

port = process.env.PORT or 3000

server.startServer port
