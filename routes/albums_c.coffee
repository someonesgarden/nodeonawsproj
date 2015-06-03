express 	= require('express')
router 		= express.Router()
model 		= require('./../lib/model/model-albums')

# GET album by ID
router.get '/id/:albumID', (req, res)->
	if req.param('albumID')
		params = {albumID : req.param('albumID')}
		model.getAlbumByID(params,(err, obj)->
			if(err) then res.status(400).send({error: 'Invalid album ID'}) else res.send(obj)
		)
	else res.status(400).send({error: 'Invalid album ID'})

# POST create album.
router.post '/upload', (req, res)->
 	if req.param('title') and req.param('userID')
 		params = {userID:req.param('userID'),title:req.param('title')}
 		model.createAlbum params,(err, obj)-> if(err) then res.status(400).send({error: 'Invalid album data'}) else res.send(obj)
  else res.status(400).send({error: 'Invalid album data'})

# POST delete album. */
router.post '/delete', (req, res)->
	if req.param('albumID')
		params = {albumID : req.param('albumID')}
		model.deleteAlbum params, (err, obj)-> if(err) then res.status(400).send({error: 'Album not found'}) else res.send(obj)
	else res.status(400).send({error: 'Invalid album ID'})

#========================================
module.exports = router