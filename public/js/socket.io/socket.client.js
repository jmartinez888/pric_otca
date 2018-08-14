var socket;
var OPES_SOCKET = [];

function SocketInstance(id){
	var ope = { ID: id, connect: null, disconnect: null
		, send: function(msg){ socket.emit(id, msg); },
		receive: null, reconnect: null
	}
	return ope;
}
function SocketInstance(id, _connect, _disconnect, _receive, _reconnect){
	var ope = { ID: id, connect: _connect, disconnect: _disconnect
		, send: function(msg){ socket.emit(id, msg); },
		receive: _receive, reconnect: _reconnect
	}
	return ope;
}
function AddSocketInstance(ope){
  OPES_SOCKET.push(ope);
	socket.on(ope.ID, function(msg){
		if (ope.receive!=null){
			ope.receive(msg);
		}
	});
}
function InitSocket(objeto){
  socket = io('http://35.198.18.102:3000/', { query: "id=" + objeto.id + "&curso=" + objeto.curso + "&tipo=2" });

  // socket = io('http://local.github:3000/', { query: "id=" + objeto.id + "&curso=" + objeto.curso + "&tipo=2" });

}
function StartServer(){
  socket.on('connect', function(){
    OPES_SOCKET.forEach(function(row){
      if (row!=null && row.ID!=null && row.connect!=null){
        row.connect();
      }
    });
  });
  socket.on('disconnect', function(){
    OPES_SOCKET.forEach(function(row){
        if (row!=null && row.ID!=null && row.disconnect!=null){
          row.disconnect();
        }
    });
  });
  socket.on('reconnect_attempt', function(){
  	OPES_SOCKET.forEach(function(row){
      if (row!=null && row.ID!=null && row.reconnect!=null){
        row.reconnect();
      }
    });
  });
  socket.on('connect_error', function(){
		OPES_SOCKET.forEach(function(row){
      if (row!=null && row.ID!=null && row.disconnect!=null){
        row.disconnect();
      }
    });
		console.log("Error de conexion");
  });
  socket.on('reconnect_error', function(){
		OPES_SOCKET.forEach(function(row){
      if (row!=null && row.ID!=null && row.disconnect!=null){
        row.disconnect();
      }
    });
		//console.log("Error de reconnect_error");
  });
  socket.on('reconnect_failed', function(){
  	//alert("Error de reconnect_failed");
		console.log("Error de reconnect_failed");
  });
}
