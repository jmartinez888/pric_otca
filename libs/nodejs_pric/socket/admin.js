module.exports = function(io, socket, admin){
  var _ = require('lodash');	

  socket.on('CHAT', function(msg){
  	var result = { id: get(socket).id, msg: msg.msn, fecha: msg.fecha }
    io.emit('CHAT', result);
  });
  function get(socket){ return socket.handshake.query; }
  return socket;
}
