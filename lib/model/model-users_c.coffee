mysql       = require 'mysql'
globals 	  = require './../globals'
connection 	= mysql.createConnection globals.database

getAllUsers=(callback)->
  query='SELECT username, userID FROM users'
  connection.query(query, (err, rows, fields)-> if(err) then callback(err) else callback(null, rows))

getUser=(params, callback)->
  query='SELECT username, userID FROM users WHERE username=' + connection.escape(params.username)
  connection.query(query,
    (err, rows, fields)->
      if err
        callback(err)
      else
        if(rows.length > 0)
          userObject = rows[0]
          modelAlbums = require('./model-albums');
          modelAlbums.getAlbumsByUser({userID: userObject.userID},(err, obj)->
            if err then callback(err)
            else
              userObject.albums = obj
              callback(null, userObject)
          )
        else callback(null, [])
	)

createUser=(params, callback)->
	newUser = {
		username: params.username,
		password: params.password,
		email: params.email	
	}
	query = 'INSERT INTO users SET ? '
	connection.query(query, newUser,(err, rows, fields)->
	  	if err
        if(err.errno == 1062)
            error = new Error("This username has already been taken.")
            callback(error)
        else callback(err)
      else callback(null, {message:'Registration successful!'})
	)

loginUser=(params, callback)->
  query = 'SELECT username, password, userID FROM users WHERE username=' + connection.escape(params.username)
  connection.query(query,(err, rows, fields)->
		if err then callback(err)
		else if rows.length > 0
	  		response = {
	  			username: rows[0].username,
	  			userID: rows[0].userID
	  		}
	  		callback(null, response)
	  else
	  		error = new Error("Invalid login")
	  		callback(error)
	)

logoutUser=(params, callback)-> callback({message: 'You have logged out successfully'})

#=========================================================================

exports.getAllUsers = getAllUsers
exports.getUser = getUser
exports.createUser = createUser
exports.loginUser = loginUser
exports.logoutUser = logoutUser
