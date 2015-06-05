var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
    res.header('Cache-Control','no-cache, no-store');
    res.render('index', { title: 'FUNWITHDATA:' });
});

module.exports = router;
