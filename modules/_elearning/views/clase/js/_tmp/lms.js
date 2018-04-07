console.log("as");
var me = {};
me.avatar = LMS_URL + "public/resources/perfil/rlopez2512@gmail.com.jpg";

var you = {};
you.avatar = "https://a11.t26.net/taringa/avatares/9/1/2/F/7/8/Demon_King1/48x48_5C5.jpg";

function formatAMPM(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0'+minutes : minutes;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    return strTime;
}

//-- No use time. It is a javaScript effect.
function insertChat(who, text, time){
    if (time === undefined){
        time = 0;
    }
    var control = "";
    var date = formatAMPM(new Date());

    if (who == "me"){
        control = '<li style="width:100%">' +
                        '<div class="msj macro">' +
                        '<div class="avatar"><img class="img-circle" style="width:100%;" src="'+ me.avatar +'" /></div>' +
                            '<div class="text text-l">' +
                                '<p>'+ text +'</p>' +
                                '<p><small>'+date+'</small></p>' +
                            '</div>' +
                        '</div>' +
                    '</li>';
    }else{
        control = '<li style="width:100%;">' +
                        '<div class="msj-rta macro">' +
                            '<div class="text text-r">' +
                                '<p>'+text+'</p>' +
                                '<p><small>'+date+'</small></p>' +
                            '</div>' +
                        '<div class="avatar" style="padding:0px 0px 0px 10px !important"><img class="img-circle" style="width:100%;" src="'+you.avatar+'" /></div>' +
                  '</li>';
    }
    setTimeout(
        function(){
            $(".my-chat").append(control).scrollTop($(".my-chat").prop('scrollHeight'));
        }, time);
}

function resetChat(){
    $(".my-chat").empty();
}

$(".input-chat").on("keydown", function(e){
  var texto = $(this).val();
  if (e.which == 13 && texto !== ""){
    $(this).prop("disabled", true);

    DEFAULT_MENSAJE.msn = texto;
    DEFAULT_MENSAJE.fecha = new Date().toString();
    $.ajax({ url: LMS_URL + "elearning/clase/_registrar_mensaje",
      type: "post",
      data: { usuario: USUARIO.id,
              curso: LMS_CURSO,
              leccion: LMS_LECCION,
              mensaje: DEFAULT_MENSAJE.msn },
      success: function(a){
        var DATA = JSON.parse(a);
        if(DATA.estado==1){
          SOCKET_MENSAJE.send(DEFAULT_MENSAJE);
          $(".input-chat").val('').prop("disabled", false);
        }else{
          alert("No se pudo guardar el mensaje");
        }
      }
    });

  }
});

resetChat();
