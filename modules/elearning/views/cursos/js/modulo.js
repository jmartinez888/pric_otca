$(window).resize(function(){
  var ancho = $("#frame-video").width();
  ancho = ancho * (9 / 16);
  $("#frame-video").attr("height", ancho + "px");
}); $(window).resize();

$(document).ready(function(){
  function Mensaje(texto, tamano, funcion){
    $.fn.Mensaje({ mensaje: texto, tamano: tamano, functionCerrar: funcion });  
  }  
  function Validacion(texto, tamano, funcion){
    $.fn.Mensaje({ mensaje: texto, tamano: tamano, tipo: "SiNo", functionSi: funcion });  
  }
  $("#btnExamen").click(function(){
    $("#leccion-contenido").hide(200);
    $("#panel-contenedor-pregunta").css({ display: ""});
    $("#panel-contenedor-pregunta").show(100);
    //$("#panel-titulo-leccion").hide(100);
    $("#examen-contenido").show(200);
    setTimeout(function(){
      $("#leccion-contenido").remove();
    }, 300);
  });

  $("#btnFinalizar").click(function(e){
    e.preventDefault();
    SendExamen();
  });

  function BloquearExamen(estado){
    $("#form-examen").find("input").prop("disabled", estado);
    $("#btnFinalizar").prop("disabled", estado);
  }

  function SendExamen(){
    var CONT = $(".contenedor-pregunta");
    var examen = $("#IdExamen").val();
    var resultado = [];

    for(i= 0 ; i < CONT.length ; i++){
      var IdPregunta = CONT.eq(i).find(".IdPregunta").val();
      var Respuesta = CONT.eq(i).find(".IdAlternativa:checked").val();
      if(Respuesta == undefined || Respuesta == null || isNaN(Respuesta)){
        Mensaje("Debe responder todas las preguntas", "sm", null);
        return;
      }
      var item = { IdPregunta : IdPregunta, Respuesta: Respuesta }
      resultado.push(item);
    }

    //BloquearExamen(true);
    $.ajax({
      type: "post",
      url: _root_ + "elearning/cursos/_send_examen",
      data: { data : JSON.stringify(resultado), examen: examen },
      success: function(a){
        location.reload(); return;
        var DATA = JSON.parse(a);

        $("#examen-contenido").hide(200);

        if(DATA.estado==0){
          Mensaje(DATA.mensaje, function(){
            location.href = $("#hiddenURL").val() + "elearning/cursos/curso/"  + $("#hiddenCurso").val(); 
          });
          return;
        }else{
          if (DATA.data.ESTADO == 1){
            $("#resultador-alerta").addClass("alert-success");
            $("#resultador-alerta-icon").addClass("glyphicon-exclamation-sign");
            $("#resultador-alerta").append("Aprobaste el examen con " + DATA.data.Nota + " de nota");
          }else{
            $("#resultador-alerta").addClass("alert-danger");
            $("#resultador-alerta-icon").addClass("glyphicon-exclamation-sign");
            $("#resultador-alerta").append("Reporbaste el examen con " + DATA.data.Nota + " de nota");
          }
        }
        ViewPreguntas(DATA.data.RESPUESTAS);
      }
    });
  }

  function ViewPreguntas(respuestas){
    var CONTENEDOR = $("#contenido-respuestas");
    var contenido = "";

    respuestas.forEach(function(a){
      contenido += "<div class='col-lg-12'>"+ "<div><h5>" + a.Pre_Descripcion + "</h5></div>";
      var Alternativas = a["ALTERNATIVAS"];


      Alternativas.forEach(function(e){
        if (e.Alt_Valor === a.USUARIO){
          contenido += "<div style='color: red'>" + e.Alt_Etiqueta + "(Seleccionada)</div>";
        }else if (e.Alt_Valor === a.Pre_Valor){
          contenido += "<div style='color: green'><strong>" + e.Alt_Etiqueta + " (Correcta)</strong></div>";
        }else{
          contenido += "<div>" + e.Alt_Etiqueta + "</div>";
        }
      });
      contenido += "</div>";
    });

    CONTENEDOR.append(contenido);
    $("#titulo_examen").html("Resultado de Examen");
    $("#resultados-contenido").show(200);
    setTimeout(function(){
      $("#examen-contenido").remove();
    }, 300);
  }
});
