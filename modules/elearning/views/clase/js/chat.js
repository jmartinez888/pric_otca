var VISIBLE = 0;
var USUARIOS_CONECTADOS = []

$(document).ready(() => {
  var TPL = {
    msg_propio: $('#msg_propio').html(),
    msg_otro: $('#msg_otro').html(),
    status_conectado: $('#status_conectado').html()
  }
  Mustache.parse(TPL.msg_otro);
  Mustache.parse(TPL.msg_propio);
  Mustache.parse(TPL.status_conectado);

  let LANGS = {
    marcar_asistencia: 'Marcar asistencia',
    asistencia_marcada: 'Asistencia marcada'
  };
  if (typeof PRELANG == 'object') {
    LANGS = PRELANG
  }
  var socketChat = new AppSocket({ query: "id=" + USUARIO.id + "&curso=" + USUARIO.curso + "&tipo=10&leccion=" + LMS_LECCION + "&docente=" + USUARIO.docente})
  if (VIEW_ESPERA) {
    $('#chat-msn-body-usuarios').removeClass('hidden')
  } else {
    if(VISIBLE==1){
      // $("#btnMinin_Close").hide();
      // $("#btnMinin_Usuarios").hide();
      // $("#btnMinin_Open").show();

      $("#chat-body").hide();
      $("#chat-msn-body").hide();
      $("#chat-text-body").hide();
      $("#chat-container").css("height", "40px");
      VISIBLE = 0;
    }
    // });
    // $("#btnMinin").click();

    // $('#btnMinin_Open').on('click', () => {

    //     // $("#btnMinin_Close").show();
    //     $("#btnMinin_Usuarios").show();
    //     $("#btnMinin_Open").hide();

    //     $("#chat-body").show();
    //     $("#chat-msn-body").show();
    //     $("#chat-text-body").show();
    //     // $("#chat-container").css("height", "550px");
    //     $("#chat-text-input").focus();
    //     $("#chat-msn-body").scrollTop($("#chat-msn-body").prop('scrollHeight'));
    //     VISIBLE = 1;
    // })
    // $('#btnMinin_Close').on('click', () => {
    //     $("#btnMinin_Close").hide();
    //     $("#btnMinin_Open").show();
    //     $("#btnMinin_Usuarios").hide();

    //     $("#chat-body").hide();
    //     $("#chat-msn-body").hide();
    //     $("#chat-text-body").hide();
    //     $("#chat-container").css("height", "40px");
    //     VISIBLE = 0;
    //     HIDE_USERS = true

    // })
    let HIDE_USERS = true;
    // $('#btnMinin_Usuarios').on('click', () => {
    $('#btnMinin').on('click', () => {
      if (VISIBLE == 0) {
        if (HIDE_USERS){
          $('#chat-msn-body-usuarios').removeClass('hidden')
          $('#span-chat').removeClass('hidden')
          $('#span-conectados').addClass('hidden')
          $('#chat-msn-body').hide()
          $("#chat-text-body").hide();
          HIDE_USERS = false
        } else {
          $('#chat-msn-body-usuarios').addClass('hidden')
          
          $('#span-conectados').removeClass('hidden')
          $('#span-chat').addClass('hidden')
          $('#chat-msn-body').show()
          $("#chat-text-body").show();
          HIDE_USERS = true
        }
      }

      // if (VISIBLE == 0) {
      //   $("#chat-body").hide();
      //   $("#chat-msn-body").hide();
      //   $("#chat-text-body").hide();
      // }
      //   $("#btnMinin_Close").hide();
      //   $("#btnMinin_Open").show();

      //   $("#chat-body").hide();
      //   $("#chat-msn-body").hide();
      //   $("#chat-text-body").hide();
      //   $("#chat-container").css("height", "40px");
      //   VISIBLE = 0;

    })
  }
  // $("#btnMinin").click(function(){



  $("#chat-text-send").click(function(){
    var input = $("#chat-text-input");
    if(input.val().length==0){
      input.focus();
      return;
    }
    $(this).prop("disabled", true);
    input.prop("disabled", true);
    var data = { usuario: USUARIO.id, curso: LMS_CURSO, leccion: LMS_LECCION, mensaje: input.val(), hora: Date.now() };

    $.ajax({ url: LMS_URL + "elearning/clase/_registrar_mensaje",
      type: "post",
      data: data,
      success: function(a){
        var DATA = JSON.parse(a);
        if(DATA.estado==1){
          console.log(data);
          socketChat.emit('CHAT', data);
        }else{
          console.log("No se pudo guardar el mensaje");
        }
        $("#chat-text-send").prop("disabled", false);
        $("#chat-text-input").val("").prop("disabled", false).focus();
      }
    });
  });

  $("#chat-text-input").keypress(function(e){
    var tecla = e.keyCode;
    if(tecla==13){
      $("#chat-text-send").click();
      return true;
    }
  });

  function updateUsuarioConectado (dataUsuario) {


    if (dataUsuario.evento == 'new') {
      let usu = ALUMNOS.find(v => {
        return v.id == dataUsuario.id
      })
      if (usu != undefined)
        dataUsuario.nombre = usu.usuario
      else
        dataUsuario.nombre = 'no matriculado'

      dataUsuario.fecha_hora = moment(dataUsuario.hora)
      let conectado = USUARIOS_CONECTADOS.find(c => {
        return c.id == dataUsuario.id
      })
      if (conectado == undefined)
        USUARIOS_CONECTADOS.push(dataUsuario)

    }
    if (dataUsuario.evento == 'disconnect') {
      for(var i = 0; i < USUARIOS_CONECTADOS.length; i++) {
        if (USUARIOS_CONECTADOS[i].id == dataUsuario.id) {
          USUARIOS_CONECTADOS.splice(i, 1)
          // break;
        }
      }

    }
    let html = '';
    USUARIOS_CONECTADOS.forEach(v => {
      let asistencia = 1;
      // let tpl = `
      //   <div class="content-msn">
      //     <div class="mensaje-me">
      //       <div class="mensaje-chat-text">
      //           <div class="sujeto-link">
      //             <div class="avatar">
      //               <i class="cursor-pointer fa fa-${asistencia == 1 ? 'check-circle' : 'circle'}" aria-hidden="true" title="${asistencia == 1 ? LANGS.asistencia_marcada : LANGS.marcar_asistencia}"></i>
      //             </div>
      //             <strong>${v.nombre}</strong>
      //           </div>
      //           <p class="p-time"><small>${v.fecha_hora.fromNow()}</small></p>
      //       </div>
      //     </div>
      //   </div>
      // `;
      let tpl = Mustache.render(TPL.status_conectado, {
        asistencia: asistencia,
        faMode: asistencia == 1 ? 'check-circle' : 'circle',
        title: asistencia == 1 ? LANGS.asistencia_marcada : LANGS.marcar_asistencia,
        nombre: v.nombre,
        fecha_from_now: v.fecha_hora.fromNow()
      });
      html += tpl;
    })
    $('#chat-msn-body-usuarios').html(html)


  }

  function AddMensaje(autor, id, fecha, mensaje){
    var usuario = "";
    ALUMNOS.forEach(function(row){
      if(row.id==id){
        usuario = row.usuario;
      }
    });
    var control = "";
    // if(autor==1){
    //   control = '<div class="content-msn">' +
    //               '<div class="mensaje-me">' +
    //                 '<div class="mensaje-chat-text">' +
    //                     '<div class="sujeto-link"><div class="avatar"><img class="img-circle-msn" /></div><strong>'+ usuario +'</strong></div>' +
    //                     '<p class="p-mensaje">'+ mensaje +'</p>' +
    //                     '<p class="p-time"><small data-time-message="' + fecha.format('YYYY-MM-DD HH:mm:ss') + '">'+ fecha.fromNow()+'</small></p>' +
    //                 '</div>' +
    //               '</div>' +
    //             '</div>';
      
    // }else{
    //   control = '<div class="content-msn">' +
    //               '<div class="mensaje-other">' +
    //               '<div class="mensaje-chat-text">' +
    //                   '<div class="sujeto-link"><div class="avatar"><img class="img-circle-msn"/></div><strong>'+ usuario +'</strong></div>' +
    //                   '<p class="p-mensaje">'+ mensaje +'</p>' +
    //                   '<p class="p-time"><small data-time-message="' + fecha.format('YYYY-MM-DD HH:mm:ss') + '">'+ fecha.fromNow()+'</small></p>' +
    //               '</div>' +
    //               '</div>' +
    //             '</div>';

    // }
    control = Mustache.render(autor == 1 ? TPL.msg_propio : TPL.msg_otro, {
      usuario: usuario,
      fecha_now: fecha.fromNow(),
      fecha_format: fecha.format('YYYY-MM-DD HH:mm:ss'),
      mensaje: mensaje
    })
    $("#chat-msn-body").append(control).scrollTop($("#chat-msn-body").prop('scrollHeight'));
  }


  CHAT.forEach(function(row){
    if(row.usuario==USUARIO.id){
      AddMensaje(1, row.usuario, moment(row.fecha), row.msn);
    }else{
      AddMensaje(2, row.usuario, moment(row.fecha), row.msn);
    }
  });

  socketChat.init(() => {
    if (USUARIO.docente == 0) {
      socketChat.on('INICIAR_CLASE', res => {
        if(res.success)
          location.reload()
      })
    } else {
      $('#btnIniciarClase').on('click', bice => {
        axios.post(bice.target.dataset.url).then(response => {
          if (response.data.success) {
            socketChat.emit('INICIAR_CLASE', {success: true})
            location.reload()
          }
        })
      })
    }
    socketChat.on('CHAT', msg => {
      console.log(msg)

      if(USUARIO.id == msg.usuario){
        AddMensaje(1, msg.id, moment(msg.hora), msg.msg);
      }else{
        $('#chatAudio')[0].play()
        AddMensaje(2, msg.id, moment(msg.hora), msg.msg);
      }
    })

    socketChat.on('NEW_CONNECTION', msg => {
      $('#chat-container').removeClass('hidden')
      console.log('new connection')
       console.log(msg);
      if (msg != null) {
        // $('#totales_conectados').text(msg.count);
        // updateUsuarioConectado(msg.usuario)
        msg.evento = 'new'
        updateUsuarioConectado(msg.usuario)
        socketChat.emit('UPDATE_ACTIVE_CONNECTION', {id: USUARIO.id, leccion: LMS_LECCION})
      }
    })

    socketChat.on('LEAVE_CONNECTION', msg => {
      console.log('leave connection : ' + msg.id)
      if (msg != null) {
        updateUsuarioConectado({id: msg.id, evento: 'disconnect'})
      }
    })

    socketChat.on('TOTALES_LECCION', msg => {
      $('#chat-container').removeClass('hidden')
      console.log('RECIBE TOTALES')
       console.log(msg);
      if (msg != null) {
        $('#totales_conectados').text(msg.conectados);
        // msg.usuario.evento = 'new'
        updateUsuarioConectado(msg.usuario)
        // socketChat.emit('UPDATE_ACTIVE_CONNECTION', {id: USUARIO.id, leccion: LMS_LECCION})
      }
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
  })
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
