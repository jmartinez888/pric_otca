

class AppSocket {
  constructor (values) {
    this._query = values
    this.success_connection = false
    this.OPES_SOCKET = [];
    // this.StartServer()
  }

  emit (name, value) {
      this._socket.emit(name, value)
  }
  init (callback = () => {}) {
    this._socket = io(_root_, this._query);
    this.StartServer(callback)
    // callback(this)

  }
  // SocketInstance(id, _connect, _disconnect, _receive, _reconnect){
  SocketInstance(id, opc = { _connect: () => {}, _disconnect: () => {}, _receive: () => {}, _reconnect: () => {}}){
    console.log('socket instance b')
    var ope = {
      ID: id,
      connect: opc._connect,
      disconnect: opc._disconnect,
      send: (msg) => {
        socket.emit(id, msg);
      },
      receive: opc._receive,
      reconnect: opc._reconnect
    }
    return ope;
  }
  on (name, callback) {
      this._socket.on(name, callback)
  }
  AddSocketInstance(ope){
    this.OPES_SOCKET.push(ope);
    this._socket.on(ope.ID, function(msg){
      if (ope.receive!=null){
        ope.receive(msg);
      }
    });

  }
  StartServer(initDefault = () => {}){
    this._socket.on('connect', () => {
      // setTimeout(()=> {

      //   console.log('conectado')
      // }, 2000)
      console.log('conectado')
      this.success_connection = true
      initDefault(this)
      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.connect!=null){
          row.connect();
        }
      });
    });
    this._socket.on('disconnect', () => {
      this.success_connection = false
      this.OPES_SOCKET.forEach((row) => {
          if (row!=null && row.ID!=null && row.disconnect!=null){
            row.disconnect();
          }
      });
    });
    this._socket.on('reconnect_attempt', () => {
      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.reconnect!=null){
          row.reconnect();
        }
      });
    });
    this._socket.on('connect_error', () => {

      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.disconnect!=null){
          row.disconnect();
        }
      });
      console.log("Error de conexion");
    });
    this._socket.on('reconnect_error', () => {
      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.disconnect!=null){
          row.disconnect();
        }
      });
      //console.log("Error de reconnect_error");
    });
    this._socket.on('reconnect_failed', () => {

      //alert("Error de reconnect_failed");
      console.log("Error de reconnect_failed");
    });
  }
}
