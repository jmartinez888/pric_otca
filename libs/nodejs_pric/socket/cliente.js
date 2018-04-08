module.exports = function(io, socket, cliente){
  var _ = require('lodash');	

  socket.on('PIZARRA', function(msg){
    var result = JSON.parse(JSON.stringify(msg));
    io.emit('PIZARRA', result);
  });

  socket.on('INICIO_CLASE', function(msg){
    var result = JSON.parse(JSON.stringify(msg));
    io.emit('INICIO_CLASE', result);
  });

  socket.on('SOLI', function(msg){
    console.log(msg);
    var result = JSON.parse(JSON.stringify(msg));
    io.emit('SOLI', result);
  });

  socket.on('CHAT', function(msg){
  	var result = { id: get(socket).id, msg: msg.mensaje, usuario: msg.usuario/*, fecha: msg.fecha*/ }
    io.emit('CHAT', result);
  });
  function get(socket){ return socket.handshake.query; }
  return socket;
}