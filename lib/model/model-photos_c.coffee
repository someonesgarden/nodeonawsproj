mysql       = require('mysql')
globals 	= require('./../globals')
connection 	= mysql.createConnection(globals.database())

createPhoto=(params, callback)->
	query = 'INSERT INTO photos SET ? '
	connection.query(query, params,(err, rows, fields)->
		if err
			callback(err)
		else
			response = {id:rows.insertId}
			callback(null, response)
	)

getPhotoByID=(params, callback)->
	query = 'SELECT photoID, caption, albumID, userID FROM photos WHERE published=1 AND photoID=' + connection.escape(params.photoID)
	connection.query(query,(err, rows, fields)->
		if err
			callback(err)
		else
			if rows.length>0
				callback(null, rows)
			else
				callback(null, [])
	)

getPhotosByAlbumID=(params, callback)->
	query = 'SELECT photoID, caption, albumID, userID FROM photos WHERE published=1 AND albumID=' + connection.escape(params.albumID)
	connection.query(query,(err, rows, fields)->
		if(err)
			callback(err)
		else
			if(rows.length > 0)
				callback(null, rows)
			else
				callback(null, [])
	)

deletePhotoByID=(params, callback)->
	query = 'UPDATE photos SET published=0 WHERE photoID=' + connection.escape(params.photoID)
	connection.query(query,(err, rows, fields)->
		if(rows.length > 0)
			callback(null, rows)
		else
			callback(null, [])
	)

exports.createPhoto = createPhoto;
exports.getPhotoByID = getPhotoByID;
exports.getPhotosByAlbumID = getPhotosByAlbumID;
exports.deletePhotoByID = deletePhotoByID;