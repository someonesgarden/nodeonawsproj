express      = require 'express'
path         = require 'path'
favicon      = require 'serve-favicon'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
routes       = require './routes/index_c.coffee'
users        = require './routes/users_c.coffee'
photos       = require './routes/photos_c.coffee'
albums       = require './routes/albums_c.coffee'
globals      = require './lib/globals'
app = express()

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
#============================================

#uncomment after placing your favicon in /public
#app.use favicon(__dirname + '/public/favicon.ico')
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: false })
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

app.use '/users', users
app.use '/photos', photos
app.use '/albums', albums
app.use '/', routes

# catch 404 and forward to error handler
app.use (req, res, next)->
  err = new Error('Not Found!!!!')
  err.status = 404
  next(err)

#======== error handlers
#development error handler will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next)->
    res.status(err.status || 500)
    res.render 'error', {message:err.message, error:err}

#production error handler
app.use (err, req, res, next)->
  res.status(err.status || 500)
  res.render 'error', {message: err.message,error: {}}

#=========================================================
module.exports = app