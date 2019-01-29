var VISIBLE = 1;

$("#btnMinin").click(function(){
  if(VISIBLE==1){
    $("#btnMinin_Close").hide();
    $("#btnMinin_Open").show();

    $("#chat-body").hide();
    $("#chat-msn-body").hide();
    $("#chat-text-body").hide();
    $("#chat-container").css("height", "40px");
    VISIBLE = 0;
  }else{
    $("#btnMinin_Close").show();
    $("#btnMinin_Open").hide();

    $("#chat-body").show();
    $("#chat-msn-body").show();
    $("#chat-text-body").show();
    $("#chat-container").css("height", "550px");
    $("#chat-text-input").focus();
    $("#chat-msn-body").scrollTop($("#chat-msn-body").prop('scrollHeight'));
    VISIBLE = 1;
  }
});

$("#btnMinin").click();

$("#chat-text-send").click(function(){
  var input = $("#chat-text-input");
  if(input.val().length==0){
    input.focus();
    return;
  }
  $(this).prop("disabled", true);
  input.prop("disabled", true);
  var data = { usuario: USUARIO.id, curso: LMS_CURSO, leccion: LMS_LECCION, mensaje: input.val() };

  $.ajax({ url: LMS_URL + "elearning/clase/_registrar_mensaje",
    type: "post",
    data: data,
    success: function(a){
      var DATA = JSON.parse(a);
      if(DATA.estado==1){
        console.log(data);
        SOCKET_MENSAJE.send(data);
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


function AddMensaje(autor, id, fecha, mensaje){
  var usuario = "";
  ALUMNOS.forEach(function(row){
    if(row.id==id){
      usuario = row.usuario;
    }
  });
  var control = "";
  if(autor==1){
    control = '<div class="content-msn">' +
                '<div class="mensaje-me">' +
                  '<div class="mensaje-chat-text">' +
                      '<div class="sujeto-link"><div class="avatar"><img class="img-circle-msn" /></div><strong>'+ usuario +'</strong></div>' +
                      '<p class="p-mensaje">'+ mensaje +'</p>' +
                      '<p class="p-time"><small>'+ fecha +'</small></p>' +
                  '</div>' +
                '</div>' +
              '</div>';
  }else{
    control = '<div class="content-msn">' +
                '<div class="mensaje-other">' +
                '<div class="mensaje-chat-text">' +
                    '<div class="sujeto-link"><div class="avatar"><img class="img-circle-msn"/></div><strong>'+ usuario +'</strong></div>' +
                    '<p clas="p-mensaje">'+ mensaje +'</p>' +
                    '<p clas="p-time"><small>'+ fecha+'</small></p>' +
                '</div>' +
                '</div>' +
              '</div>';
  }
  $("#chat-msn-body").append(control).scrollTop($("#chat-msn-body").prop('scrollHeight'));
}


CHAT.forEach(function(row){
  if(row.usuario==USUARIO.id){
    AddMensaje(1, row.usuario, "", row.msn);
  }else{
    AddMensaje(2, row.usuario, "", row.msn);
  }
});

window.onLoadCallback = function(){
  //var INVITADOS = [];
  //var INVITADOS = "[{ id : 'vicercavi@gmail.com', invite_type : 'EMAIL' }, { id : 'jhonmartinez888@gmail.com', invite_type : 'EMAIL' }]";
                  // .push({ 'id' : 'vicercavi@gmail.com', 'invite_type' : 'EMAIL' });
  //INVITADOS.push({ 'id' : 'jhonmartinez888@gmail.com', 'invite_type' : 'EMAIL' });
  //INVITADOS.push({ 'id2' : 'saravia.lelis95@gmail.com', 'invite_type' : 'EMAIL' });
  //INVITADOS.push({ 'id' : 'rlopez2512@gmail.com', 'invite_type' : 'EMAIL' });

  gapi.hangout.render('placeholder-div1', {
    'render': 'createhangout',
    //'invites': INVITADOS,
    //'initial_apps': [{'app_id' : '184219133185', 'start_data' : 'dQw4w9WgXcQ', 'app_type' : 'ROOM_APP' }]/*,
    'initial_apps': [ { 'app_id': 'pric-195620' } ]
  });
}
