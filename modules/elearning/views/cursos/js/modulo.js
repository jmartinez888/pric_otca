$(window).resize(function(){
  var ancho = $("#frame-video").width();
  ancho = ancho * (9 / 16);
  $("#frame-video").attr("height", ancho + "px");
}); $(window).resize();

$(document).ready(function(){
  (function ($){
      $.fn.Ventana = function (m) {
          m = m || {};
          m.id = m.id || ""; //OK
          m.titulo = m.titulo || "Ventana - Sin Titulo"; //OK
          m.funcion = m.funcion || function () { };
          m.funcionCerrar = m.funcionCerrar || function () { };
          m.tamano = m.tamano || "";
          m.cuerpo = m.cuerpo || "";
          m.mod_pric = m.mod_pric || false;
          m.icon = m.icon || "th-large";
          var cssModal = "modal-dialog";

          switch (m.tamano) {
              case "sm": cssModal += " modal-sm"; break
              case "lg": cssModal += " modal-lg"; break
              case "xl": cssModal += " modal-xl"; break
          }

          var html = "";
          html += '<div class="modal fade" id="' + m.id + '" tabindex="-5" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-focus-on="input:first">' +
                      '<div class="' + cssModal + '">' +
                         '<div class="panel panel-cmacm">' +
                             '<div class="panel-heading">' +
                                 '<span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-' + m.icon + '"></span>' +
                                      m.titulo +
                                 '<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>' +
                             '</div>' +
                             '<div class="panel-body">' + m.cuerpo +
                             '</div>' +
                         '</div>' +
                     '</div>' +
                 '</div>'

          $(html).appendTo('body');

          $("div#" + m.id).on('hidden.bs.modal', function (e)
          {
              $("div#" + m.id).remove();
              m.funcionCerrar();
          });


          if (m.mod_pric) {
              $('.modal').on('show.bs.modal', function (event) {
                  var idx = $('.modal:visible').length;
                  $(this).css('z-index', 1050 + (10 * idx));
              });

              $('.modal').on('shown.bs.modal', function (event) {
                  var idx = ($('.modal:visible').length) - 1; // raise backdrop after animation.
                  $('.modal-backdrop').not('.stacked').css('z-index', 1049 + (10 * idx));
                  $('.modal-backdrop').not('.stacked').addClass('stacked');
              });

              $('.modal').on('hide.bs.modal', function (event) {
                  var idx = ($('.modal:visible').length) - 2; // raise backdrop after animation.
                  $('.modal-backdrop').not('.stacked').css('z-index', 1049 + (10 * idx));
                  $('.modal-backdrop').not('.stacked').addClass('stacked');
              });
          }
      }
  })(jQuery);

  (function ($) {
      $.fn.Mensaje = function (m) {
          m = m || {};
          m.titulo = m.titulo || "Aviso";
          m.tamano = m.tamano || "";
          m.mensaje = m.mensaje || "";
          m.tipo = m.tipo || "Aceptar";
          m.funcionCerrar = m.funcionCerrar || function () { };
          m.funcionAceptar = m.funcionAceptar || function () { };
          m.funcionSi = m.funcionSi || function () { };
          m.funcionNo = m.funcionNo || function () { };
          m.indice = m.indice || 0;
          m.icon = m.icon || "th-large";
          m.mod_pric = m.mod_pric || false;

          var html = '<div class="row"><div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><h4 class="text-center">' + m.mensaje + '</h4></div></div>';

          switch (m.tipo) {
              case "Aceptar":
                  html = html + '<div class="row"> <div class="col-xs-3 col-sm-4 col-md-4 col-lg-4"></div> <div class="col-xs-6 col-sm-4 col-md-4 col-lg-4"> <button type="button" id="btnAceptarMen" class="btn btn-default" style="width: 100% !important">Aceptar</button> </div> <div class="col-xs-3  col-sm-4 col-md-4 col-lg-4"></div> </div>';
                  break;
              case "SiNo":
                  html = html + '<div class="row"> <div class="hidden-xs col-sm-3 col-md-3 col-lg-3"></div> <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3"> <button type="button" id="btnSiMen" class="btn btn-default" style="width: 100% !important">Si</button> </div> <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3"> <button type="button" id="btnNoMen" class="btn btn-default" style="width: 100% !important">No</button> </div> <div class="hidden-xs col-sm-3 col-md-3 col-lg-3"></div> </div>';
                  break;
          }

          $.fn.Ventana({
              id: "vntMensaje",
              titulo: m.titulo,
              tamano: m.tamano,
              cuerpo: html,
              mod_pric: m.mod_pric,
              icon: m.icon,
              funcionCerrar: m.funcionCerrar
          });

          $("#btnAceptarMen").bind("click", function () {
              $("#vntMensaje").modal('hide');
              $('#vntMensaje').on('hidden.bs.modal', function (e) {
                  m.funcionAceptar(m.indice);
              });
          });

          $("#btnSiMen").bind("click", function () {
              $("#vntMensaje").modal('hide');
              $('#vntMensaje').on('hidden.bs.modal', function (e) {
                  m.funcionSi(m.indice);
              });
          });

          $("#btnNoMen").bind("click", function () {
              m.funcionNo();
              $("#vntMensaje").modal('hide');
          });

          $('#vntMensaje').modal('show');
      }
  })(jQuery);
});

$(document).ready(function(){
  function Mensaje(texto, tamano, funcion){
    $.fn.Mensaje({ mensaje: texto, tamano: tamano, funcionCerrar: funcion });
  }
  function Validacion(texto, tamano, funcion){
    $.fn.Mensaje({ mensaje: texto, tamano: tamano, tipo: "SiNo", funcionSi: funcion });
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

  $(".btnResolverTarea").click(function(){
    var id = $(this).attr("tag");
    var tipo = $(this).attr("tipo");
    $.ajax({
      url: _root_ + "elearning/tarea/resolver",
      data: { id: id},
      type: "post",
      success: function(data){
        var tarea = JSON.parse(data);
        $("#inResTarDesc").val(tarea.data[0].Tar_Descripcion);
        $("#inResTarTit").val(tarea.data[0].Tar_Titulo);
        $("#inIdTarea").val(tarea.data[0].Tar_IdTarea);
        $("#inTipoTarea").val(tipo);
        if(tipo==1){
          $("#zonaFilesAdjuntos").hide();
        }else{
          var Files = tarea.data[0].Archivos;
          if(Files != null && Files.length > 0){
            $("#zonaFilesAdjuntos").show();
            if((tipo==2 && Files.length>0) || (tipo==3 && Files.length>4)){
              $("#btnAgregarArchivoTarea").hide();
            }else{
              $("#btnAgregarArchivoTarea").show();
            }
            LlenarArchivos(Files);
          }
        }
        $("#panelResolverTrabajo").modal("show");
      }
    });
  });

  function LlenarArchivos(files){
    var content = $("#divArcAdjTarea");
    content.html("");
    files.forEach(function(row){
        var texto = "<div class='col-lg-12 item-arch-adj'>";
        texto += "<a href='" + _root_ + "files/elearning/_tareas/" + row.Arc_Ruta +"' target='_blank'>";
        texto += row.Arc_Ruta +"</a>";
        texto += "<button class='btnElimArcAdj' tag='" + row.Arc_IdArchivo + "'><i class='glyphicon glyphicon-trash'>";
        texto += "</i></button></div>";
        content.append(texto);
    });
    $(".btnElimArcAdj").click(function(){
        var id = $(this).attr("tag");
        Validacion("¿Desea eliminar el archivo adjunto?", "sm", function(){
          $.ajax({
            url: _root_ + "elearning/tarea/_deletefile",
            data: { id: id },
            type: "post",
            success: function(data){
              Mensaje("Se ha eliminado el archivo", "sm", function(){
                location.reload();
              });
            }
          });
        });
    });
  }

  $("#btnAgregarArchivoTarea").click(function(){
    var tipo = parseInt($("#inTipoTarea").val());
    var cantidad = tipo==2 ? 1: 5;
    $("#panelResolverTrabajo").modal("hide");

    setTimeout(function(){
      var params = {
        route: "files/elearning/_tareas",
        pre: $("#inIdTarea").val(),
        validator: {
          files: cantidad,
          maxSize: 10,
          formats: "pptx,doc,docx,xls,xlsx,ppt,pdf,txt"
        }
      };

      InitUploader(function(a){
        var files = JSON.parse(a).data;
        $.ajax({
          url: _root_ + "elearning/tarea/_archivos",
          data: { id: $("#inIdTarea").val(), files: JSON.stringify(files) },
          type: "post",
          success: function(data){
            Mensaje("Se cargó el(los) archivo(s) con éxito", "sm", function(){
              location.reload();
            });
          }
        });
      }, params);
    }, 400);
  });

  $("#btn_resolver_tarea").click(function(){
    var data = {
      id: $("#inIdTarea").val(),
      titulo: $("#inResTarTit").val(),
      descripcion: $("#inResTarDesc").val()
    };
    $.ajax({
      url: _root_ + "elearning/tarea/_resolver",
      type: "post",
      data: data,
      success: function(data){
        console.log(data);
      }
    });
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
