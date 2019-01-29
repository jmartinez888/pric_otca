module.exports = function(app, test){
  var io = require('socket.io')(app);
  var sequelize_dos = require('../models/db');
  var ModLeccionAsistencia = require('../models/leccion_asistencia');
  
  // var sequelize = require('../models/db');
  
  var _ = require('lodash');
  var CLIENTES = [];
  var ADMIN = [];
  var TEST = test;
  var CONECTADOS = [];
  var countInterval = 0;
  //tipo = 10:chat, 2:canvas

  var TIPO = {CHAT: 10, CANVAS: 2};

  setInterval(() => {

    console.log('------------------------------------')
    console.log(countInterval++ + '\n')
    console.log(CLIENTES)
    console.log(ADMIN)
    console.log(TEST)
    console.log(CONECTADOS)
    CONECTADOS.forEach(v => {
      console.log(v.leccion)
      if (typeof v.usuarios != 'undefined') {
        v.usuarios.forEach(u => {
          console.log(u)
        })
      }
    })
  }, 15000)
  function buscar_leccion (leccion_id) {
    console.log(CONECTADOS)
    return CONECTADOS.find(function(v) {
      console.log(leccion_id);
      return v.leccion == leccion_id;
    })
  }
  io.on('connection', socket => {
    let mi_nombre = 'ALUMNO-' + get(socket).id
    console.log('CHAT SOCKET-ID : ' + socket.id)
    console.log('---------------------------------------------------------------');
    console.log("************USUARIO >>> [ID:" + get(socket).id + '-' + (get(socket).docente == 1 ? 'DOC' : 'ALU') + '], [TIPO:' + get(socket).tipo + "], [LECCION:" + get(socket).leccion + "]");
    console.log('---------------------------------------------------------------');
    
    let tipo = get(socket).tipo;
    let alumno_id = get(socket).id;
    let leccion_id = get(socket).leccion;
    var leccion = buscar_leccion(leccion_id);
    ModLeccionAsistencia.registrarAsistencia(alumno_id, leccion_id, 2222).then(res => {
      console.log(res)
    })
    let ut = {
      id: alumno_id, 
      nombre: '', 
      hora: Date.now()
    };
    if (leccion == undefined) {
      leccion = {leccion: get(socket).leccion, usuarios: [ut]}
      CONECTADOS.push(leccion);
    } else{
      // leccion.count = leccion.count + 1;
      ut = leccion.usuarios.find(v => {
        return v.id == alumno_id
      })
      if (ut == undefined) {
        ut = {id: alumno_id, hora: Date.now(), nombre: ''}
        leccion.usuarios.push(ut)
      }
    }

    // leccion.usuario = {
    //   id: alumno_id,
    //   nombre: '',
    //   evento: 'new',
    //   hora: Date.now()
    // }
    ut.evento = 'new'
    socket.emit('TOTALES_LECCION', {conectados: leccion.usuarios.length, usuario: ut});
    socket.broadcast.emit('NEW_CONNECTION', {usuario: ut})
      




    if (+get(socket).docente == 0) {
      if (tipo == TIPO.CANVAS) {
        console.log('soy un alumno')
        // setInterval(() => {
          console.log('hola profe soy ' + mi_nombre)
          io.emit('conexion_alumno', {success: true, name: mi_nombre})
        // }, 1000)

      }
    } else {
      if (tipo == TIPO.CANVAS) {
        console.log('hola alumno soy ' + mi_nombre)
        socket.emit('conexion_docente', {success: true})

        socket.on('send_all_data_canvas', canvas_json => {
          console.log(canvas_json)
          socket.broadcast.emit('all_data_canvas', canvas_json)
        })
      }
    }
    
    //chat
  
    socket.on('CHAT', (msg) => {
      console.log(msg);
      var result = { id: get(socket).id, msg: msg.mensaje, usuario: msg.usuario/*, fecha: msg.fecha*/ }
      io.emit('CHAT', result);
    });
    socket.on('INICIAR_CLASE', res => {
      socket.broadcast.emit('INICIAR_CLASE', {success: true});
    })
    socket.on('UPDATE_ACTIVE_CONNECTION', data => {
      console.log('>>>UPDATE CONECCTION >>>')
      console.log(data)
      socket.broadcast.emit('TOTALES_LECCION', {conectados: leccion.usuarios.length, usuario: {id: data.id, evento: 'new'}});
    })
    
    socket.on('disconnect', () => {
      console.log('>>> DISSCONECT ')
      let leccionremove = buscar_leccion(leccion_id);
      if (tipo == 10) {
        leccionremove.usuarios.forEach((v, i) => {
          if (v.id == alumno_id) {
            leccionremove.usuarios.splice(i, 1)
          }
        })
        // io.emit('TOTALES_LECCION', {conectados: leccion.usuarios.length, usuario: null});
        socket.broadcast.emit('LEAVE_CONNECTION', {id: alumno_id})
      }

    })


  })
  return io;
};
function get(socket){ return socket.handshake.query; }
