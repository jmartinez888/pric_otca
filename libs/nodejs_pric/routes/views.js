module.exports = function(route){
  var express = require('express');
  var router = express.Router();

  router.get('/', function(req, res) { res.sendFile(route + '/views/index.html'); });
  router.get('/cliente.js', function(req, res) { res.sendFile(route + '/views/cliente.js'); });
  return router;
};
