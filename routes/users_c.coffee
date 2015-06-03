express 	= require 'express'
router 		= express.Router()
model 		= require './../lib/model/model-users_c.coffee'

# GET users listing.
router.get '/', (req, res)->
    model.getAllUsers (err, obj)-> if err then res.status(500).send({error: 'An unknown server error has occurred!'}) else res.send(obj)

# GET albums by user
router.get '/user/:user',(req, res)->
    params= {username:req.param('user')}
    model.getUser params,(err, obj)-> if err then res.status(500).send({error: 'An unknown server error has occurred!'}) else res.send(obj)

# POST user login.
router.post '/login', (req, res)->
    if req.param('username') and req.param('password')
        params = {
            username: req.param('username').toLowerCase(),
            password: req.param('password')
        }
        model.loginUser params,(err, obj)-> if(err) then res.status(400).send({error: 'Invalid login'}) else res.send(obj)
    else res.status(400).send({error: 'Invalid login'})


# POST user logout.
router.post '/logout',(req, res)->
    if req.param('userID')
        model.logoutUser {},(err, obj)-> if err then res.status(400).send({error: 'Invalid user'}) else res.send(obj)
    else res.status(400).send({error: 'Invalid user'})


# GET user registration.
router.get '/register',(req, res)->
    if req.param('username') and req.param('password') and req.param('email')
        email = unescape(req.param('email'))
        emailMatch = email.match(/\S+@\S+\.\S+/)
        if emailMatch?
            params = {
                username: req.param('username').toLowerCase(),
                password: req.param('password'),
                email: req.param('email').toLowerCase()
            }
            model.createUser params,(err, obj)-> if err then res.status(400).send({error: 'Unable to register'}) else res.send(obj)

        else res.status(400).send({error: 'Invalid email'})
    else res.status(400).send({error: 'Missing required field'})

# POST user registration.
router.post '/register',(req, res)->
  if req.param('username') and req.param('password') and req.param('email')
    email = unescape(req.param('email'))
    emailMatch = email.match(/\S+@\S+\.\S+/)
    if emailMatch?
      params = {
        username: req.param('username').toLowerCase(),
        password: req.param('password'),
        email: req.param('email').toLowerCase()
      }
      model.createUser params,(err, obj)-> if err then res.status(400).send({error: 'Unable to register'}) else res.send(obj)
    else res.status(400).send({error: 'Invalid email'})
  else res.status(400).send({error: 'Missing required field'})

#===================================================
module.exports = router
