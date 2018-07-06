module.exports = function(route){
  var express = require('express');
  var router = express.Router();

  router.get('/jquery.css', function(req, res) { res.sendFile(route + '/public/js/jquery/jquery.js'); });
  router.get('/bootstrap.css', function(req, res) { res.sendFile(route + '/public/js/bootstrap/bootstrap.js'); });
  router.get('/socket.io.css', function(req, res) { res.sendFile(route + '/public/js/socket.io/socket.io.js'); });

  return router;
};


/*
app.get('/script/mensaje-1.0.0.js', function(req, res) { res.sendFile(__dirname + '/script/mensaje-1.0.0.js'); });
app.get('/script/ventana-1.0.0.js', function(req, res) { res.sendFile(__dirname + '/script/ventana-1.0.0.js'); });

app.get('/css/main.css', function(req, res) { res.sendFile(__dirname + '/css/main.css'); });
app.get('/css/bootstrap.css', function(req, res) { res.sendFile(__dirname + '/css/bootstrap.css'); });*/
