$(document).ready(() => {
  
  var chat_container = document.getElementById('chat-container')
  if (chat_container != null) {
    new Vue({
      el: chat_container,
      mixins: [typeof MIXIN_CHAT == 'object' ? MIXIN_CHAT : {}],
      data: function () {
        return {
          regexpURL: new RegExp(/^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$/),
          baseCurrentUsuario: null,
          objNotification: null,
          LANGS: {
            marcar_asistencia: 'Marcar asistencia',
            asistencia_marcada: 'Asistencia marcada'
          },
          USUARIOS_CONECTADOS: [],
          VISIBLE: 0,
          LECCION: {
            ID: 0,
            SESSION_ID: 0,
            SESSION_HASH: ''
          },
          HIDE_USERS: true,
          MSG: {
            PROPIO: 1,
            OTRO: 0
          },
          MENSAJES: [],
          TPL: {
            msg_propio: $('#msg_propio').html(),
            msg_otro: $('#msg_otro').html(),
            status_conectado: $('#status_conectado').html()
          },
          socketChat: null
        }
      },
      watch: {
        'USUARIOS_CONECTADOS': function (nv, ov) {
          this.updateUsuarioConectado();
        }
      },
      methods: {
        getCurrentUsuario: function () {
          if (this.baseCurrentUsuario == null) {
            let x = this.USUARIOS_CONECTADOS.find(v => {
              return v.usuario_id == USUARIO.id
            })
            if (x != undefined){
              this.baseCurrentUsuario = x;
              return this.baseCurrentUsuario;
            }else return null;
          } else
            return this.baseCurrentUsuario;
        },
        updateUsuarioConectado: function (dataUsuario = false) {
          // if (dataUsuario.evento == 'new') {
          //   let usu = ALUMNOS.find(v => {
          //     return v.id == dataUsuario.id
          //   })
          //   if (usu != undefined)
          //     dataUsuario.nombre = usu.usuario
          //   else
          //     dataUsuario.nombre = 'no matriculado'
      
          //   dataUsuario.fecha_hora = moment(dataUsuario.hora)
          //   let conectado = this.USUARIOS_CONECTADOS.find(c => {
          //     return c.id == dataUsuario.id
          //   })
          //   if (conectado == undefined)
          //     this.USUARIOS_CONECTADOS.push(dataUsuario)
      
          // }
          // if (dataUsuario.evento == 'disconnect') {
          //   for(var i = 0; i < this.USUARIOS_CONECTADOS.length; i++) {
          //     if (this.USUARIOS_CONECTADOS[i].id == dataUsuario.id) {
          //       this.USUARIOS_CONECTADOS.splice(i, 1)
          //       // break;
          //     }
          //   }
          // }
          let html = '';
          this.USUARIOS_CONECTADOS.forEach(v => {
            let asistencia = 1;
            let tpl = ''
            if (USUARIO.id != v.usuario_id) {
              tpl = Mustache.render(this.TPL.status_conectado, {
                usuario_id: v.usuario_id,
                asistencia: asistencia,
                faMode: asistencia == 1 ? 'check-circle' : 'circle',
                title: asistencia == 1 ? this.LANGS.asistencia_marcada : this.LANGS.marcar_asistencia,
                nombre: v.usuario_nombres + ' ' + v.usuario_apellidos,
                fecha_from_now: moment(v.inicio_asistencia).fromNow(),
                usuario_img_url: base_url('files/usuarios/img/' + v.usuario_image_url, true),
                is_docente: v.is_docente
              });
            }
            html += tpl;
          })
          $('#chat-msn-body-usuarios').html(html)
      
      
        },
        AddMensaje: function (autor, usuario_id, fecha, mensaje, usuario){
          
          let control = Mustache.render(autor == this.MSG.PROPIO ? this.TPL.msg_propio : this.TPL.msg_otro, {
            usuario: usuario.usuario_nombres + ' ' + usuario.usuario_apellidos,
            usuario_img_url: usuario.usuario_img_url,
            fecha_now: fecha.fromNow(),
            fecha_format: fecha.format('YYYY-MM-DD HH:mm:ss'),
            mensaje: mensaje
          })
          $("#chat-msn-body").append(control).scrollTop($("#chat-msn-body").prop('scrollHeight'));
        },
        onClick_chatTextSend: function (e) {
          var input = $("#chat-text-input");
          if(input.val().length==0){
            input.focus();
            return;
          }

          $(this).prop("disabled", true);

          input.prop("disabled", true);

          var data = { usuario: USUARIO.id, curso: LMS_CURSO, leccion: LMS_LECCION, mensaje: input.val(), hora: Date.now(), session_hash: this.LECCION.SESSION_HASH, data_usuario: this.getCurrentUsuario() };
          this.socketChat.emit('CHAT_R', data);

          $.ajax({ url: LMS_URL + "elearning/clase/_registrar_mensaje",
            type: "post",
            data: data,
            success: a => {
              var DATA = JSON.parse(a);
              if(DATA.estado==1){
              }else{
                console.log("No se pudo guardar el mensaje");
              }
              $("#chat-text-send").prop("disabled", false);
              $("#chat-text-input").val("").prop("disabled", false).focus();
            }
          });
          
          this.AddMensaje(this.MSG.PROPIO, USUARIO.id, moment(data.hora), data.mensaje, {
            usuario_nombres: this.getCurrentUsuario().usuario_nombres,
            usuario_apellidos: this.getCurrentUsuario().usuario_apellidos,
            usuario_img_url: base_url('files/usuarios/img/' + this.getCurrentUsuario().usuario_image_url, true)
          })
        
        },
        chatTextInput: function (e) {
          var tecla = e.keyCode;
          if(tecla==13){
            $("#chat-text-send").click();
            return true;
          }
        
        },
        onClick_btnMinin: function() {
          console.log('onClick_btnMinin')
          // if (this.VISIBLE == 0) {
            if (this.HIDE_USERS){
              $('#chat-msn-body-usuarios').removeClass('hidden')
              $('#span-chat').removeClass('hidden')
              $('#span-conectados').addClass('hidden')
              $('#chat-msn-body').hide()
              $("#chat-text-body").hide();
              this.HIDE_USERS = false
            } else {
              $('#chat-msn-body-usuarios').addClass('hidden')
              
              $('#span-conectados').removeClass('hidden')
              $('#span-chat').addClass('hidden')
              $('#chat-msn-body').show()
              $("#chat-text-body").show();
              this.HIDE_USERS = true
            }
          // }
    
        
        },
        onSocket_CHAT: function (msg) {
            console.log(msg)
            this.AddMensaje(USUARIO.id == msg.usuario ? this.MSG.PROPIO : this.MSG.OTRO, msg.id, moment(msg.hora), msg.msg, {
              usuario_nombres: msg.data_usuario.usuario_nombres,
              usuario_apellidos: msg.data_usuario.usuario_apellidos,
              usuario_img_url: base_url('files/usuarios/img/' + msg.data_usuario.usuario_image_url, true)
            });
          
          this.objNotification.pause()
          this.objNotification.play()
        
        },
        onSocket_NEW_CONNECTION: function (msg) {
          console.log(msg)
          console.log('new connection')
          if (msg != null) {
          //   msg.evento = 'new'
            this.USUARIOS_CONECTADOS = msg.usuarios;
          // this.updateUsuarioConectado(msg.usuarios)
            //this.socketChat.emit('UPDATE_ACTIVE_CONNECTION', {id: USUARIO.id, leccion: LMS_LECCION})
          }
          
        },
        onSocket_NEW_CONNECTIONB: function (msg) {
          if (msg != null) {
          //   msg.evento = 'new'
            this.USUARIOS_CONECTADOS = msg.usuarios;
          // this.updateUsuarioConectado(msg.usuarios)
            //this.socketChat.emit('UPDATE_ACTIVE_CONNECTION', {id: USUARIO.id, leccion: LMS_LECCION})
          }
          
        },
        onSocket_LEAVE_CONNECTION: function (msg) {
          
          console.log('leave connection : ' + msg.id)
          if (msg != null) {
            this.USUARIOS_CONECTADOS = msg.usuarios;
            // this.updateUsuarioConectado({id: msg.id, evento: 'disconnect'})
          }
        
        },
        onSocket_TOTALES_LECCION: function (msg) {
          
        
        }
        
      },
      created: function () {
        console.log('init chat');
        Mustache.parse(this.TPL.msg_otro);
        Mustache.parse(this.TPL.msg_propio);
        Mustache.parse(this.TPL.status_conectado);

        if (typeof PRELANG == 'object') {
          this.LANGS = PRELANG
        }
        let hs = HASH_SESSION.split('-');
        this.LECCION.ID = LMS_LECCION
        this.LECCION.SESSION_ID = hs[1]
        this.LECCION.SESSION_HASH = hs[0]
        this.socketChat = new AppSocket({query: "id=" + USUARIO.id + 
          "&cursos=" + USUARIO.curso +898 +
          "&tipob=10&leccion=" + LMS_LECCION + 
          "&docente=" + USUARIO.docente + 
          '&leccion_session=' + hs[1] + 
          '&leccion_session_hash=' + hs[0] }, base_url('socket_chat', true))
      },
      mounted: function () {
        console.log('CHAT MOUNTED')
        if (VIEW_ESPERA) {
          $('#chat-msn-body-usuarios').removeClass('hidden')
        }

        if(this.VISIBLE==1){
          $("#chat-body").hide();
          $("#chat-msn-body").hide();
          $("#chat-text-body").hide();
          // $("#chat-container").css("height", "40px");
          this.VISIBLE = 0;
        }
        
        // $('#btnMinin_Usuarios').on('click', () => {
        $('#btnMinin').on('click', this.onClick_btnMinin)   
        $("#chat-text-send").click(this.onClick_chatTextSend);
        $("#chat-text-input").keypress(this.chatTextInput);
        if (typeof this.onSubmit_registrarAsistencia == 'function') {
          $('#chat-container').on('click','.btnAsistencia', (e) => {
            this.onSubmit_registrarAsistencia({
              hash: HASH_LECCION,
              leccion_id: LMS_LECCION,
              alumno_id: e.currentTarget.dataset.usuarioId,
              docente_id: DOCENTE_ID
            })
          })
        }
        
        

        
        let firstConnection = false;                  
        this.objNotification = $('#chatAudio')[0];
        this.socketChat.init((data) => {
          
          
          if (USUARIO.docente == 0) {
            this.socketChat.on('INICIAR_CLASE', res => {
              if(res.success)
                location.reload()
            })
          } else {
            $('#btnIniciarClase').unbind('click');
            $('#btnIniciarClase').on('click', bice => {
              console.log('Iniciar')
              let frmData = new FormData()
              let hs = HASH_SESSION.split('-');
              frmData.append('docente_id', USUARIO.id)
              frmData.append('docente_id', USUARIO.id)
              frmData.append('leccion_session_espera_id', hs[0])
              frmData.append('leccion_session_espera_id_b', hs[1])
              axios.post(bice.target.dataset.url, frmData).then(response => {
                if (response.data.success) {
                  this.socketChat.emit('INICIAR_CLASE', {success: true})
                  location.reload()
                }
              })
            })
          }

          this.socketChat.on('SESSION_SUCCESS', msg => {
            console.log('SESSION_SUCCESS')
            console.log(msg)
            if (msg != null) {
              this.USUARIOS_CONECTADOS = msg.usuarios;
            
            }
            //obtener mensajes
            // let usuario = this.USUARIOS_CONECTADOS.find((row) => {
            //   return row.usuario_id == usuario_id
            // })
            axios.post(base_url('elearning/clase/obtener_mensaje_leccion_session'), parseData({
              leccion_id: this.LECCION.ID,
              hash_leccion_session: this.LECCION.SESSION_HASH
            })).then(mensajes => {
              if (mensajes.data) {
                mensajes.data.forEach(row => {
                  this.AddMensaje(row.usuario_id == USUARIO.id ? this.MSG.PROPIO : this.MSG.OTRO, row.usuario_id, moment(row.msg_fecha), decodeHTML(row.msg_descripcion), {
                    usuario_nombres: row.usuario_nombres,
                    usuario_apellidos: row.usuario_apellidos,
                    usuario_img_url: base_url('files/usuarios/img/' + row.usuario_img, true)
                  });
                });
              }
            })
            // if (!firstConnection) {
              this.socketChat.on('CHAT_E', this.onSocket_CHAT)
              this.socketChat.on('NEW_CONNECTION', this.onSocket_NEW_CONNECTION)
    
              this.socketChat.on('LEAVE_CONNECTION', this.onSocket_LEAVE_CONNECTION)
    
              this.socketChat.on('TOTALES_LECCION', this.onSocket_TOTALES_LECCION)
              
              this.socketChat.emit('CONFIRMACARGA', 'confirmado')
              firstConnection = true;
            // }
            
          })

          console.log('GET USUARIOS')
          this.socketChat.emit('INITDATA', 'solicita');

          
        })
        
        setInterval(() => {
          $('[data-time-message]').each((i, e) => {
            let timetemp  = moment(e.dataset.timeMessage)
            let now = moment()
            let show_text = '--:--'
            if (timetemp.diff(now, 'm') <= 30) {
              show_text = timetemp.fromNow()
            } else if (timetemp.diff(now, 'd') < 1) {
              show_text = timetemp.format('HH:mm')
            } else if (timetemp.diff(now, 'y') < 1){
              show_text = timetemp.format('DD/MM HH:mm')
            } else {
              show_text = timetemp.format('DD/MM/YY HH:mm')
            }
            e.innerText = show_text
          })

        }, 5000)
        
      }
    })    
  }
  




})



// window.onLoadCallback = function(){
//   //var INVITADOS = [];
//   //var INVITADOS = "[{ id : 'vicercavi@gmail.com', invite_type : 'EMAIL' }, { id : 'jhonmartinez888@gmail.com', invite_type : 'EMAIL' }]";
//                   // .push({ 'id' : 'vicercavi@gmail.com', 'invite_type' : 'EMAIL' });
//   //INVITADOS.push({ 'id' : 'jhonmartinez888@gmail.com', 'invite_type' : 'EMAIL' });
//   //INVITADOS.push({ 'id2' : 'saravia.lelis95@gmail.com', 'invite_type' : 'EMAIL' });
//   //INVITADOS.push({ 'id' : 'rlopez2512@gmail.com', 'invite_type' : 'EMAIL' });

//   gapi.hangout.render('placeholder-div1', {
//     'render': 'createhangout',
//     //'invites': INVITADOS,
//     //'initial_apps': [{'app_id' : '184219133185', 'start_data' : 'dQw4w9WgXcQ', 'app_type' : 'ROOM_APP' }]/*,
//     'initial_apps': [ { 'app_id': 'pric-195620' } ]
//   });
// }
