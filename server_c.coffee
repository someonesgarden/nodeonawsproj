express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
debug = require('debug')('photoalbums')
routes = require('./routes/index')
users = require('./routes/users')
photos = require('./routes/photos')
albums = require('./routes/albums')
globals = require('./lib/globals')
mysql       = require('mysql')
app = express()

#view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

#uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);
app.use('/photos', photos);
app.use('/albums', albums);

# catch 404 and forward to error handler
app.use((req, res, next)->
    err = new Error('Not Found')
    err.status = 404
    next(err)
)

# error handlers
# development error handler
#will print stacktrace
if (app.get('env') is 'development')
    app.use((err, req, res, next)->
        res.status(err.status || 500);
        res.render({
            message: err.message,
            error: err
        })
    )

# production error handler
# no stacktraces leaked to user
app.use((err, req, res, next)->
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    })
)

app.set('port', globals.applicationPort)

server = app.listen(app.get('port'),()->
    debug('Express server listening on port ' + server.address().port)
    connection  = mysql.createConnection(globals.database)
    connection.connect((err)->
        if err
            console.log('error connecting to database:');
        else
            console.log('connected to database!');
    )
)