module.exports = function(app, test){
  var io = require('socket.io')(app);
  var _ = require('lodash');
  var ModLeccionAsistencia = require('../models/leccion_asistencia');
  var ModLeccionSession = require('../models/leccion_session');
  var ManagerSessions = require('../models/manager_leccion_session');

  var ModLeccionAsistenciaDetalles = require('../models/leccion_asistencia_detalles');
  var CLIENTES = [];
  var ADMIN = [];
  var TEST = test;
  var CONECTADOS = [];
  var countInterval = 0;
  //tipo = 10:chat, 2:canvas

  var TIPO = {CHAT: 10, CANVAS: 2};
  var LECCION_SESSION = [];
  // setInterval(() => {
    
  //   console.log('------------------------------------')
  //   io.of('/socket_canvas').clients((err, clients) => {
      
  //     console.log(clients)
  //   })
  //   io.of('/socket_chat').clients((err, clients) => {
  //     clients.forEach(v => {
  //       console.log(ManagerSessions.getUsuarioBySocketID(v));
  //     })
  //     console.log(clients)
      

  //   })
  //   // console.log(io)
  //   io.clients((err, clients) => {
  //     console.log('GENERAL')
  //     console.log(clients)
  //   })
  //   // console.log('INTERVAL')
  //   // console.log(countInterval++ + '\n')
  //   // console.log(ManagerSessions)
    
  //   // ManagerSessions.sessiones.forEach(v => {
  //   //   console.log(v.list_usuarios)
  //   // })
  // }, 5000)

  function buscar_leccion (leccion_id) {
    console.log(CONECTADOS)
    return CONECTADOS.find(function(v) {
      console.log(leccion_id);
      return v.leccion == leccion_id;
    })
  }
  io.of('/socket_canvas').on('connection', socket => {
    
    let mi_nombre = 'ALUMNO-' + get(socket).id
    let tipo = get(socket).tipo;
    let alumno_id = get(socket).id;
    let leccion_id = get(socket).leccion;
    let leccion_session = get(socket).leccion_session;
    let leccion_session_hash = get(socket).leccion_session_hash;
    var leccion = buscar_leccion(leccion_id);

    
    console.log('[' + (+tipo == TIPO.CANVAS ? 'CANVAS' : 'CHAT') + ' SOCKET-ID : ' + socket.id + ']')
    console.log('------------------------------------------------------------------------------');
    console.log("************USUARIO >>> [ID:" + get(socket).id + '-' + (get(socket).docente == 1 ? 'DOC' : 'ALU') + '], [TIPO:' + get(socket).tipo + "], [LECCION:" + get(socket).leccion + "]");
    console.log('[' + leccion_session_hash + '-' + leccion_session + ']')
    console.log('------------------------------------------------------------------------------');

    let nameRoom = 'ROOM-CANVAS-' + leccion_session;
    socket.join(nameRoom)
    socket.on('INIT_CANVAS', (msg) => {
      console.log(msg)
      console.log(nameRoom)
      socket.on('CONFIRMACARGACANVAS', () => {
        //solo el que ionició la clase puede enviar datos al canvas
        if (+get(socket).docente == 0) {
          console.log('soy un alumno')
          console.log('hola profe soy ' + mi_nombre)
          //el alumo informa de una al docente que se conectó
          socket.to(nameRoom).emit('conexion_alumno', {success: true, name: mi_nombre})
        } else {
          console.log('soy docente')
          console.log('hola alumno soy ' + mi_nombre)//p´rofesor
          // socket.emit('conexion_docente', {success: true})
          
          socket.on('render_img', function(msg){
            var result = { base64: msg }
            console.log(msg)
            io.emit('show_img', result);
          });
      
          socket.on('pos_cursor', (pos) => {
            // console.log(pos)
            socket.broadcast.to(nameRoom).emit('move_mouse', pos)
          })
      
          socket.on('limpiar_canvas', (pos) => {
            socket.broadcast.to(nameRoom).emit('alumnos_limpiar_canvas', pos)
          })
      
          socket.on('eliminar_objetos', (ids) => {
            socket.broadcast.to(nameRoom).emit('alumnos_eliminar_objetos', ids)
          })
          socket.on('change_object', (pos) => {
            // console.log(pos)
            socket.broadcast.to(nameRoom).emit('change_object_alumno', pos)
          })
          socket.on('create_object', (pos) => {
            // console.log(pos)
            socket.broadcast.to(nameRoom).emit('change_object_alumno', pos)
          })
  
          socket.on('send_all_data_canvas', canvas_json => {
            console.log(canvas_json)
            //solo existe en alumno
            socket.broadcast.to(nameRoom).emit('all_data_canvas', canvas_json)
          })
        }
      })
      socket.emit('SESSION_CANVAS_SUCCESS', {success: true})


    })
    socket.on('disconnect', () => {
      console.log('>>> DISSCONECT ' + (tipo == TIPO.CHAT ? 'CHAT' : 'CANVAS'))
      // let leccionremove = buscar_leccion(leccion_id);
      // if (tipo == 10) {
      //   leccionremove.usuarios.forEach((v, i) => {
      //     if (v.id == alumno_id) {
      //       leccionremove.usuarios.splice(i, 1)
      //     }
      //   })
      //   // io.emit('TOTALES_LECCION', {conectados: leccion.usuarios.length, usuario: null});
      //   socket.broadcast.emit('LEAVE_CONNECTION', {id: alumno_id})
      // }

    })
    
   

    
  })

  io.of('/socket_chat').on('connection', socket => {
    let mi_nombre = 'ALUMNO-' + get(socket).id
    let tipo = get(socket).tipob;
    
    let usuario_id = get(socket).id;
    let leccion_id = get(socket).leccion;
    let leccion_session = get(socket).leccion_session;
    let leccion_session_hash = get(socket).leccion_session_hash;
    var leccion = buscar_leccion(leccion_id);

    
    console.log('[' + (tipo == TIPO.CANVAS ? 'CANVAS' : 'CHAT') + ' SOCKET-ID : ' + socket.id + ']')
    console.log('------------------------------------------------------------------------------');
    console.log("************USUARIO >>> [ID:" + get(socket).id + '-' + (get(socket).docente == 1 ? 'DOC' : 'ALU') + '], [TIPO:' + tipo + "], [LECCION:" + get(socket).leccion + "]");
    console.log('[' + leccion_session_hash + '-' + leccion_session + ']')
    console.log('------------------------------------------------------------------------------');

    var leccion_asistencia_detalles_id = 0;
    var leccion_asistencia_id = 0;
    let nameRoom = 'ROOM-';
    socket.on('INITDATA', () => {
      ModLeccionSession.getByID(leccion_session).then(res_leccion_session => {
        if (res_leccion_session != null) {
          if (!ManagerSessions.existeSession(leccion_session))
            ManagerSessions.agregarNuevaSession(res_leccion_session);
        }
        return res_leccion_session;
      }).then(obj_less_sess => {
        if (obj_less_sess != null) {
          return ModLeccionAsistencia.registrarAsistencia(
            usuario_id, 
            leccion_id, 
            leccion_session,
            obj_less_sess
            ).then(res => {
              // console.log(res)
              if (res.success) {
                let usu = ManagerSessions.getUsuarioEnSession(usuario_id, leccion_session)
                if (usu == undefined) {
                  ManagerSessions.agregarUsuarioEnSession(leccion_session, {
                    Usu_IdUsuario: res.data_la.Usu_IdUsuario,
                    Usu_Nombre: res.data_la.Usu_Nombre,
                    IDSOCKET: socket.id,
                    Usu_Apellidos: res.data_la.Usu_Apellidos,
                    Usu_URLImage: res.data_la.Usu_URLImage,
                    Lec_IdLeccion: res.data_la.Lec_IdLeccion,
                    Les_IdLeccSess: res.data_la.Les_IdLeccSess,
                    fecha_ini_asistencia: res.data_la.Lea_Inicio,
                    Lea_Inicio: res.data_la.Lea_Inicio,
                    Lead_IdLecAsDet: res.data_lad.Lead_IdLecAsDet,
                    fecha_ini_asistencia_detalle: res.data_lad.Lead_Ingreso,
                    Lead_Ingreso: res.data_lad.Lead_Ingreso
                  })
                } else {
                  usu.Lead_IdLecAsDet = res.data_lad.Lead_IdLecAsDet;
                  usu.fecha_ini_asistencia_detalle = res.data_lad.Lead_IdLecAsDet;
                  usu.Lead_Ingreso = res.data_lad.Lead_Ingreso;
                }
                
                leccion_asistencia_detalles_id = res.data_lad.Lead_IdLecAsDet;
                leccion_asistencia_id = res.data_la.Lea_IdLeccAsis;
              }
              // resp.success = res.success;
              return {success: res.success, data: res.data_la}
          })
        } else
          return {success: false};
      }).then(procesa => {
        if (procesa.success) {
          // console.log('FINAL');
          // console.log(procesa.data)
          nameRoom += procesa.data.Les_IdLeccSess
          console.log(nameRoom);
          socket.join(nameRoom);
          //enviarme lista de usuarios actuales
          socket.emit('SESSION_SUCCESS', {usuarios: ManagerSessions.getUsuariosEnSession(procesa.data.Les_IdLeccSess, true)})
          
          // ut.evento = 'new'
          // socket.to(nameRoom).emit('TOTALES_LECCION', {conectados: leccion.usuarios.length, usuario: ut});
          //retorna conectados desde node
          //PARA EL RESTO
          socket.on('CONFIRMACARGA', msg => {
            
            
            // io.emit('NEW_CONNECTION', {usuarios: ManagerSessions.getUsuariosEnSession(procesa.data.Les_IdLeccSess, true)})
            
            // socket.on('GET_USUARIOS', msg => {
            //   console.log('GET_USUARIOS')
            //   socket.emit('NEW_CONNECTIONB', {usuarios: ManagerSessions.getUsuariosEnSession(procesa.data.Les_IdLeccSess, true)})
            // });
            let mensajes_enviados = 0;
            socket.on('CHAT_R', (msg) => {
              console.log(msg);
              var result = {
                mensajes_enviados: ++mensajes_enviados, 
                id: get(socket).id, 
                msg: msg.mensaje, 
                usuario: msg.usuario,
                data_usuario: msg.data_usuario
                /*, fecha: msg.fecha*/ }
    
              // io.to(nameRoom).emit('CHAT', result);
              console.log(nameRoom)
              socket.broadcast.to(nameRoom).emit('CHAT_E', result);
            });
            socket.on('INICIAR_CLASE', res => {
              socket.to(nameRoom).broadcast.emit('INICIAR_CLASE', {success: true});
            })
            socket.on('UPDATE_ACTIVE_CONNECTION', data => {
              console.log('>>>UPDATE CONECCTION >>>')
              console.log(data)
              socket.broadcast.to(nameRoom).emit('TOTALES_LECCION', {conectados: leccion.usuarios.length, usuario: {id: data.id, evento: 'new'}});
            })
            //enviar lista de usuario al resto de los usuario en la sessión
            socket.broadcast.to(nameRoom).emit('NEW_CONNECTION', {usuarios: ManagerSessions.getUsuariosEnSession(procesa.data.Les_IdLeccSess, true)})
          })
          
        } else {
          socket.disconnect();
        }
        
      })
    })

    //REVISAR EN LA VARIABLE LOCAL
    // if (!ManagerSessions.existeSession(leccion_session)) {
    //   ModLeccionSession.getByID(leccion_session).then(res_leccion_session => {
    //     ManagerSessions.agregarNuevaSession(res_leccion_session);
    //   })
    // } 
    
    socket.on('disconnect', () => {
      
      socket.leave(nameRoom);
      socket.leave(socket.id);
      console.log('>>> DISSCONECT ' + (+tipo == TIPO.CHAT ? 'CHAT' : 'CANVAS'))
      console.log('DISCONECT EN : ' + leccion_asistencia_detalles_id)
      if (leccion_asistencia_detalles_id != 0)
        ModLeccionAsistenciaDetalles.finalizarConexionActiva(leccion_asistencia_detalles_id);
      ManagerSessions.eliminarActivo(usuario_id, leccion_session);
      // let leccionremove = buscar_leccion(leccion_id);
      // if (tipo == 10) {
      //   leccionremove.usuarios.forEach((v, i) => {
      //     if (v.id == alumno_id) {
      //       leccionremove.usuarios.splice(i, 1)
      //     }
      //   })
      //   // io.emit('TOTALES_LECCION', {conectados: leccion.usuarios.length, usuario: null});
      if (leccion_session != 0)
        socket.broadcast.emit('LEAVE_CONNECTION', {id: usuario_id, usuarios: ManagerSessions.getUsuariosEnSession(leccion_session, true)})
      // }

    })
  
  })
  io.on('connection', socket => {
    
    console.log('>>>>>>>>>>>>>>>>>>>>>>>>>>>NORMAL CONECCTION<<<<<<<<<<<<<<<<<<<<<<<<')

    socket.on('disconnect', () => {
      console.log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>DISCONNECT NORMAL<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<')
      console.log(socket.id)
    })

  })
  return io;
};
function get(socket){ return socket.handshake.query; }
