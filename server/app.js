var express = require('express'),
    bodyParser = require('body-parser'),
    methodOverride = require('method-override'),
    routes = require('./routes'),
    app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));

// simulate DELETE and PUT
app.use(methodOverride());

// CORS (Cross-Origin Resource Sharing) headers to support Cross-site HTTP requests
app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    next();
});

app.get('/items', routes.getAll);
app.get('/item/:id', routes.getOne);
app.get('/new', routes.getNew);
app.post('/add', routes.add);
app.post('/find', routes.find);
app.put('/item/:id', routes.update);

app.set('port', process.env.PORT || 5000);

app.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});