#!/usr/bin/env node

#Module dependencies.
debug   = require('debug')('photoalbums')
app     = require '../app_c.coffee'
globals = require '../lib/globals'
mysql   = require 'mysql'

#Get port from environment and store in Express.
app.set 'port', globals.applicationPort
server = app.listen app.get('port')

server.on 'listening',()->
    debug('Express server listening on port ' + server.address().port)
    connection  = mysql.createConnection(globals.database())
    connection.connect (err)->
        if err then console.log 'ERROR:DB_CONNECTION' else console.log 'DB:CONNECTED'
