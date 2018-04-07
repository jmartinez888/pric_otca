Menu(1);
RefreshTagUrl();

$('textarea#inEditContenido').ckeditor();
$('textarea#inContenidoCon').ckeditor();
$("#btn_nuevo_contenido").click(function(){
  $("#panelNuevoContenido").modal("show");
  $("#inTituloCon").focus();
});

$("#btn_registrar_contenido").click(function(e){
  e.preventDefault();

  $.fn.Mensaje({ mensaje: "¿Desea registrar este contenido?", tipo: "SiNo",
    funcionSi: function(){
      SubmitForm($("#frm_registro_contenido"), $(this), function(data, e){
        CargarPagina("gleccion/_view_leccion", {
          curso: $("#hidden_curso").val(),
          modulo : $("#hidden_modulo").val(),
          leccion : $("#hidden_leccion").val(),
        }, false, false);
      });
    }
  });
});


$(".btnEditar").click(function(e){
  e.preventDefault();

  var Id = $(this).parent().find(".hidden_IdContenido").val();
  var Titulo = $(this).parent().find(".hidden_TituloContenido").val();
  var Contenido = $(this).parent().find(".hidden_Contenido").val();

  $("#panelEditarContenido").modal("show");
  $("#inEditTitulo").focus();
  $("#inEditId").val(Id);
  $("#inEditTitulo").val(Titulo);
  $("#inEditContenido").val(Contenido);
});

$("#btn_editar_contenido").click(function(e){
  e.preventDefault();

  $.fn.Mensaje({ mensaje: "¿Desea actualizar este contenido?", tipo: "SiNo",
    funcionSi: function(){
      SubmitForm($("#frm_modificar_contenido"), $(this), function(data, e){

        CargarPagina("gleccion/_view_leccion", {
          curso: $("#hidden_curso").val(),
          modulo : $("#hidden_modulo").val(),
          leccion : $("#hidden_leccion").val(),
        }, false, false);
      });
    }
  });
});
