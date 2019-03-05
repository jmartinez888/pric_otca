

class AppSocket {
  constructor (values, url = '') {
    this._query = values;
    this.success_connection = false;
    this.first_connection = false;
    this.OPES_SOCKET = [];
    this._url = url;
    this.listeners = [];
  }

  emit (name, value) {
    console.log(JSON.stringify(value).length)
      this._socket.emit(name, value)
  }
  init (callback = () => {}) {
    this._socket = io(this._url, this._query);
    this.StartServer(callback)
    // callback(this)

  }
  // SocketInstance(id, _connect, _disconnect, _receive, _reconnect){
  SocketInstance(id, opc = { _connect: () => {}, _disconnect: () => {}, _receive: () => {}, _reconnect: () => {}}){
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
    this.listeners.push(name)
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
      console.log('connect ' + this._url)
      this.success_connection = true
      initDefault(this);
      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.connect!=null){
          row.connect();
        }
      });
    });

    this._socket.on('disconnect', (ddd) => {
      console.log('disconnect')
      this.success_connection = false
      this.OPES_SOCKET.forEach((row) => {
          if (row!=null && row.ID!=null && row.disconnect!=null){
            row.disconnect();
          }
      });
      this.listeners.forEach(v => {
        this._socket.removeListener(v);
      })
    });
    this._socket.on('reconnect_attempt', () => {
      console.log('reconnect_attempt')
      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.reconnect!=null){
          row.reconnect();
        }
      });
    });
    this._socket.on('connect_error', (data) => {
      console.log('connect_error')
      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.disconnect!=null){
          row.disconnect();
        }
      });
      this.listeners.forEach(v => {
        this._socket.removeListener(v);
      })
      console.log("CONNECT_ERROR");
    });
    this._socket.on('reconnect_error', () => {
      console.log('reconnect_error')
      this.OPES_SOCKET.forEach((row) => {
        if (row!=null && row.ID!=null && row.disconnect!=null){
          row.disconnect();
        }
      });
      this.listeners.forEach(v => {
        this._socket.removeListener(v);
      })
      //console.log("Error de reconnect_error");
    });
    this._socket.on('reconnect_failed', () => {
      console.log('reconnect_failed')
      this.listeners.forEach(v => {
        this._socket.removeListener(v);
      })
      //alert("Error de reconnect_failed");
      console.log("RECONNECT_FAILED");
    });
  }
}
