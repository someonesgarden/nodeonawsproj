var express 	= require('express');
var router 		= express.Router();
var model 		= require('./../lib/model/model-albums');

/* GET album by ID */
router.get('/id/:albumID', function(req, res) {
    res.header("Cache-Control","public,max-age=10");
    res.header("Expires",new Date(Date.now()+10000).toUTCString());

	if(req.param('albumID')){
		var params = {
			albumID : req.param('albumID')
		}
		model.getAlbumByID(params, function(err, obj){
			if(err){
				res.status(400).send({error: 'Invalid album ID'});
			} else {
				res.send(obj);
			}
		});
	} else {
		res.status(400).send({error: 'Invalid album ID'});		
	}
});

/* POST create album. */
router.post('/upload', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
 	if(req.param('title') && req.param('userID')){
 		var params = {
 			userID 		: req.param('userID'),
 			title 		: req.param('title')
 		}
 		model.createAlbum(params, function(err, obj){
			if(err){
				res.status(400).send({error: 'Invalid album data'});
			} else {
				res.send(obj);
			}
 		});
	} else {
		res.status(400).send({error: 'Invalid album data'});				
	}
});

/* POST delete album. */
router.post('/delete', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
	if(req.param('albumID')){
		var params = {
			albumID : req.param('albumID')
		}
		model.deleteAlbum(params, function(err, obj){
			if(err){
				res.status(400).send({error: 'Album not found'});
			} else {
				res.send(obj);
			}
		});
	} else {
		res.status(400).send({error: 'Invalid album ID'});		
	}
});

module.exports = router;
