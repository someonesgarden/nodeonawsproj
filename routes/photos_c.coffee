express 	= require('express');
router 		= express.Router();
model 		= require('./../lib/model/model-photos');
#================================================================================================
# GET photo by ID
router.get '/id/:id',(req, res)->
	if req.param('id')
		params = {photoID : req.param('id')}
		model.getPhotoByID params, (err, obj)-> if err then res.status(400).send({error: 'Invalid photo ID'})else res.send(obj)
	else res.status(400).send {error: 'Invalid login'}

# POST create photo.
router.post '/upload', (req, res)->
 	if req.param('albumID') and req.param('userID')
 		params = {userID:req.param('userID'), albumID:req.param('albumID')}
 		if req.param('caption') then params.caption = req.param('caption')
 		model.createPhoto params,(err, obj)-> if(err) then res.status(400).send({error: 'Invalid photo data'}) else res.send(obj)
  else res.status(400).send {error: 'Invalid photo data'}

# POST delete photo.
router.post '/delete',(req, res)->
	if req.param('id')
		params = {photoID : req.param('id')}
		model.deletePhoto params,(err, obj)-> if(err) then res.status(400).send({error: 'Photo not found'}) else res.send(obj)
	else res.status(400).send {error: 'Invalid photo ID'}

#================================================================================================
module.exports = router
