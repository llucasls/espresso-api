import App from './app.js'
import Controller from '../controllers/controller.js'
import Router from '../routes/router.js'
import errorHandler from '../middlewares/errorHandler.js'
import notFoundHandler from '../middlewares/notFoundHandler.js'

server = new App

controller = new Controller

router = new Router
Router.addRoute controller

server.addRouter controller.router

server.handleError(errorHandler)
server.handleError(notFoundHandler)

export default server
