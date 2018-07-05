module.exports = function(app, test){
  var io = require('socket.io')(app);
  var _ = require('lodash');
  var CLIENTES = [];
  var ADMIN = [];
  var TEST = test;

  io.sockets.on('connection', function (socket) {
    addSocket(socket);
    console.log("Usuario conectado ID: " + get(socket).tipo);

    if(get(socket).tipo==1){
      require('./admin')(io, socket, ADMIN);
      var resultado = { conectados : ADMIN.length }
    }else{
      require('./cliente')(io, socket, CLIENTES);
      
      var resultado = { conectados : CLIENTES.length }
    }
    
    send('CONN', resultado);
    socket.on('disconnect', function(){
      removeSocket(socket, CLIENTES, ADMIN);
      send('CONN', resultado);
    });
  });

  function addSocket(socket){
    var tipo = get(socket).tipo;
    var item = { SOCKET: socket.id, ID: get(socket).id, CURSO: get(socket).curso };

    if(tipo==1){
      ADMIN.push(item);
    }else{
      CLIENTES.push(item);
      var alumnos = _.find(CLIENTES, function(o){ return o.CURSO === get(socket).curso; });
      send("CLASE", alumnos);
      socket.on('disconnect', function(){
        var alumnos = _.find(CLIENTES, function(o){ return o.CURSO === get(socket).curso; });
        send('CLASE', alumnos);
      });
    }
  }
  
  function removeSocket(socket, cli, adm){
    if(socket.id!=null){
      if(get(socket).tipo == 1){
        _.remove(adm, function(o){ return o.SOCKET === socket.id; });
      }else{
        _.remove(cli, function(o){ return o.SOCKET === socket.id; });
      }
    }
  }

  function debug(msn){ if(TEST){ console.log(msn); } }
  function get(socket){ return socket.handshake.query; }
  function send(method, value){ io.emit(method, value); }
  return io;
};
