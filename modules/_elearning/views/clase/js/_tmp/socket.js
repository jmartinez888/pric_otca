InitSocket(USUARIO);

var DEFAULT_MENSAJE = { autor: USUARIO.id , msn: "", fecha: new Date().toString() };
var SOCKET_MENSAJE = SocketInstance("CHAT", function(){ //CONNECT
  $(".input-chat").prop("disabled", false);
  console.log("conectado");
}, function(){      //DISCONNECT
  $(".input-chat").prop("disabled", true);
}, function(msg){   //RECEIVE
  if(msg.id == USUARIO.id){
    insertChat("me", msg.msg, 0);
  }else{
    insertChat("you", msg.msg, 0);
    document.getElementById("audio-control").play();
  }
}, function(){      //RECONNECT
  $(".input-chat").prop("disabled", false);
});

var SOCKET_CONECTADOS = SocketInstance("CLASE", function(){

}, function(){
  $("#spConectados").html("---");
}, function(msg){
  $("#spConectados").html(msg.conectados);
}, function(){      //RECONNECT
  $("#spConectados").html("...");
});

AddSocketInstance(SOCKET_MENSAJE);
AddSocketInstance(SOCKET_CONECTADOS);
StartServer();
