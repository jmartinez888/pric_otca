/*GLOBALES*/
var PUERTO = 3000;
/*GLOBALES*/

var express = require('express');
var app = express();

var server_canvas = require('http').createServer(app);
var socket_canvas = require('./socket/main_v2')(server_canvas, true);

var script = require('./routes/script')(__dirname);
var style = require('./routes/style')(__dirname);
var views = require('./routes/views')(__dirname);

app.use('/', views);
app.use('/script', script);
app.use('/style', style);



server_canvas.listen(3001, function(){ console.log('\n\nProyecto PRIC: \nPuerto *:' + 3001); });
