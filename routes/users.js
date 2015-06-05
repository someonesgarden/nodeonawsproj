var express 	= require('express');
var router 		= express.Router();
var model 		= require('./../lib/model/model-users');


/* GET users listing. */
router.get('/', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
    model.getAllUsers(function(err, obj){
        if(err){
            res.status(500).send({error: 'An unknown server error has occurred!'});
        } else {
            res.send(obj);
        }
    })
});

/* GET albums by user */
router.get('/user/:user', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
    var params= {
        username: req.param('user')
    }
    model.getUser(params, function(err, obj){
        if(err){
            res.status(500).send({error: 'An unknown server error has occurred!'});
        } else {
            res.send(obj);
        }
    });
});

/* GET user registration. */
router.get('/register', function(req, res) {
    res.header("Cache-Control","public,max-age=10");
    res.header("Expires",new Date(Date.now()+10000).toUTCString());
    if(req.param('username') && req.param('password') && req.param('email')){
        var email = unescape(req.param('email'));
        var emailMatch = email.match(/\S+@\S+\.\S+/);
        if (emailMatch !== null) {
            var params = {
                username: req.param('username').toLowerCase(),
                password: req.param('password'),
                email: req.param('email').toLowerCase()
            };

            model.createUser(params, function(err, obj){
                if(err){
                    res.status(400).send({error: 'Unable to register'});
                } else {
                    res.send(obj);
                }
            });
        } else {
            res.status(400).send({error: 'Invalid email'});
        }
    } else {
        res.status(400).send({error: 'Missing required field'});
    }
});


/* POST user login. */
router.post('/login', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
    if(req.param('username') && req.param('password') ){
        console.log("logiN");
        var params = {
            username: req.param('username').toLowerCase(),
            password: req.param('password')
        };

        model.loginUser(params, function(err, obj){
            if(err){
                res.status(400).send({error: 'Invalid login'});
            } else {
                res.send(obj);
            }
        });
    } else {
        res.status(400).send({error: 'Invalid login'});
    }
});

/* POST user logout. */
router.post('/logout', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
    if(req.param('userID')){
        model.logoutUser({}, function(err, obj){
            if(err){
                res.status(400).send({error: 'Invalid user'});
            } else {
                res.send(obj);
            }
        });
    } else {
        res.status(400).send({error: 'Invalid user'});
    }
});


/* POST user registration. */
router.post('/register', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
    if(req.param('username') && req.param('password') && req.param('email')){
        var email = unescape(req.param('email'));
        var emailMatch = email.match(/\S+@\S+\.\S+/);
        if (emailMatch !== null) {
            var params = {
                username: req.param('username').toLowerCase(),
                password: req.param('password'),
                email: req.param('email').toLowerCase()
            };

            model.createUser(params, function(err, obj){
                if(err){
                    res.status(400).send({error: 'Unable to register'});
                } else {
                    res.send(obj);
                }
            });
        } else {
            res.status(400).send({error: 'Invalid email'});
        }
    } else {
        res.status(400).send({error: 'Missing required field'});
    }
});

module.exports = router;
