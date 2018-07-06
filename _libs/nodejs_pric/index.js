/*GLOBALES*/
var PUERTO = 3000;
/*GLOBALES*/

var express = require('express');
var app = express();
var server = require('http').createServer(app);
var socket = require('./socket/main')(server, true);

var script = require('./routes/script')(__dirname);
var style = require('./routes/style')(__dirname);
var views = require('./routes/views')(__dirname);

app.use('/', views);
app.use('/script', script);
app.use('/style', style);

server.listen(PUERTO, function(){ console.log('\n\nProyecto PRIC: \nPuerto *:' + PUERTO); });
