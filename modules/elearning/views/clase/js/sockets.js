InitSocket(USUARIO);
var _C = $("#micanvas");
var _MC = $("#leccion-contenido");

var SOCKET_PIZARRA = SocketInstance("PIZARRA", function(){
  $("#hiddenConexion").val(1);
  $("#icon-conectado").css("background-color", "green");
}, function(){
  $("#hiddenConexion").val(0);
  $("#icon-conectado").css("background-color", "red");
}, function(msg){
  var _ctx = document.getElementById("micanvas").getContext('2d');

 // alert(JSON.stringify(msg.lec));

  switch (msg.act) {
    case 1: CanvasRecta(_ctx, msg.x1, msg.y1, msg.x2, msg.y2, msg.col); break;
    case 2: CanvasCuadro(_ctx, msg.x1, msg.y1, msg.x2, msg.y2, msg.col, msg.gr); break;
    case 3: Marcador(msg.x1, msg.y1, msg.add); break;
    case 4: CanvasTexto(_ctx, msg.x1, msg.y1, msg.gr, msg.col, msg.add); break;
    case 5: RemoveMarcador(); break;
    case 6: CanvasClear(_ctx, $("#micanvas")); break;
    case 7:
        msg.x1 += _C.offset().left - _MC.offset().left;
        msg.y1 += _C.offset().top - _MC.offset().top;
        CanvasCursor(_ctx, msg.x1, msg.y1, msg.add, 20);
        break;
    case 8: CanvasCursorOff(); break;
    case 9: CanvasBorrador(_ctx); break;
    case 100: ChangePizarra(msg.add); break;
    case 101: AddPizarra(msg.add); break;
    case 200: $("#in-link-videollamada_receive").val(msg.add); break;
  }
}, function(){});

var SOCKET_CLASE = SocketInstance("INICIO_CLASE", function(){
}, function(){
}, function(msg){
  console.log(msg);
  if(msg.estado==2){
    setTimeout(function(){
      location.reload();
    }, 3000);
  }
}, function(){});

var SOCKET_MENSAJE = SocketInstance("CHAT", function(){}, function(){}, function(msg){
  if(USUARIO.id == msg.usuario){
    AddMensaje(1, msg.id, "", msg.msg);
  }else{
    AddMensaje(2, msg.id, "", msg.msg);
  }
}, function(){});

var TOTALES_LECCION = SocketInstance("TOTALES_LECCION", function(){}, function(){}, function(msg){
  console.log(msg);
  if (msg != null)
    $('#totales_conectados').text(msg.count);
  // if(USUARIO.id == msg.usuario){
  //   AddMensaje(1, msg.id, "", msg.msg);
  // }else{
  //   AddMensaje(2, msg.id, "", msg.msg);
  // }
}, function(){});


var SOCKET_SOLICITUDES = SocketInstance("SOLI", function(){
}, function(){
}, function(msg){
  switch(msg.ope){
    case 1:
      if ( $("#hiddenDocente").val()==1){
        AddSolicitud(msg);
      }
      break;
    case 2:
      if (msg.usuario==USUARIO.id){
        $("#hiddenActividad").val(1);
      }else{
        $("#hiddenActividad").val(0);
      }
      $(window).resize();
      $("#hiddenActividad").change();
      break;
    case 3:
      if ( $("#hiddenDocente").val()==1 ){
        $("#hiddenActividad").val(1);
      }else{
        $("#hiddenActividad").val(0);
      }
      $(window).resize();
      $("#hiddenActividad").change();
      break;
  }
}, function(){});

$("#btnFinalizarClase").click(function(){
  var msg = { estado : 2};
  SOCKET_CLASE.send(msg);
});

$("#btnsolicitarPizarra").click(function(){
  var msg = { ope: 1, usuario: USUARIO.id, curso: LMS_CURSO, leccion: LMS_LECCION };
  SOCKET_SOLICITUDES.send(msg);
  $(this).hide();
});

function AddSolicitud(msg){
  var name = "";
  ALUMNOS.forEach(function(row){
    if(msg.usuario==row.id){
      name = row.usuario;
    }
  });

  $("#divSolicitudes").append("<div class='col-lg-12'>"+
    "<input hidden='hidden' value='0' class='inEstadoComp' />"+
    "<input hidden='hidden' value='" + msg.usuario + "' class='inIdUsuarioComp' />"+
    "<button class='btnSolicitudA btn btn-success'>Compartir</button> Usuario: " + name +
  "</div>");

  $(".btnSolicitudA").unbind("click").click(function(){
    var Parent = $(this).parent();
    var estado = Parent.find(".inEstadoComp");
    var usuario = Parent.find(".inIdUsuarioComp");

    if(estado.val()==0){
      var msg = { ope: 2, usuario: usuario.val(), curso: LMS_CURSO, leccion: LMS_LECCION };
      SOCKET_SOLICITUDES.send(msg);
      $(this).html("Quitar");
      estado.val(1);
    }else{
      var msg = { ope: 3, usuario: usuario.val(), curso: LMS_CURSO, leccion: LMS_LECCION };
      SOCKET_SOLICITUDES.send(msg);
      $(this).html("Compartir");
      estado.val(0);
    }
  });
}

function ChangePizarra(Pizarra){
  var Fondo = "#pizarra-fondo-" + Pizarra;
  $(".pizarra-fondo-item").hide();
  if(Pizarra!=0){
    $(Fondo).show();
  }
  $("#btnBorrarPizarra").click();
}

function AddPizarra(Pizarra){
  texto = "<div class='pizarra-mini'>"
            + "<input value='1' class='hidden_IdPizarra' hidden='hidden' />"
            +   "<img class='img-pizarra-mini' "
            +     " src='" + $("#hiddenURL").val() + "files/elearning/_pizarra/" + Pizarra + "' />"
            + "</div>";
  console.log(texto);
  $("#tmp_mini_pizarras").append(texto);
}

$("#btn-enviar-link").click(function(){
  //$("#in-link-videollamada").prop("disabled", false);
  var msg2 = { act: 200, lec: $("#hiddenLeccion").val(), add: $("#in-link-videollamada").val() };
  SOCKET_PIZARRA.send(msg2);
  //$("#in-link-videollamada").prop("disabled", true);
});

$("#btn-ir-video").click(function(){
  var data = $("#in-link-videollamada_receive").val();
  var a = document.createElement("a");
  a.target = "_blank";
  a.href = data;
  a.click();
});