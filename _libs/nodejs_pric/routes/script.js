module.exports = function(route){
  var express = require('express');
  var router = express.Router();

  router.get('/jquery.js', function(req, res) { res.sendFile(route + '/public/js/jquery/jquery.js'); });
  router.get('/bootstrap.js', function(req, res) { res.sendFile(route + '/public/js/bootstrap/bootstrap.js'); });
  router.get('/socket.io.js', function(req, res) { res.sendFile(route + '/public/js/socket.io/socket.io.js'); });

  return router;
};
