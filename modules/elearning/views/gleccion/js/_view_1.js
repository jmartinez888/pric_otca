Menu(1);
RefreshTagUrl();

// Jhon Martinez
$("#item_titulo").click(function() {
  $(this).removeClass("active");
  $("#item_contenido").removeClass("active"); 
  $("#item_referencias").removeClass("active");
  $("#item_materiales").removeClass("active");
  // $(this).css('font-weight', 'bold');
  $(this).addClass("active");
  $('.div_titulo').css('display', 'block');
  $('.div_contenido').css('display', 'none');
  $('.div_referencias').css('display', 'none');
  $('.div_materiales').css('display', 'none');
});
$("#item_contenido").click(function() {
  $(this).removeClass("active");
  $("#item_titulo").removeClass("active"); 
  $("#item_referencias").removeClass("active");
  $("#item_materiales").removeClass("active");
  // $(this).css('font-weight', 'bold');
  $(this).addClass("active");
  $('.div_contenido').css('display', 'block');
  $('.div_titulo').css('display', 'none');
  $('.div_referencias').css('display', 'none');
  $('.div_materiales').css('display', 'none');
});
$("#item_referencias").click(function() {
  $(this).removeClass("active");
  $("#item_titulo").removeClass("active"); 
  $("#item_contenido").removeClass("active");
  $("#item_materiales").removeClass("active");
  // $(this).css('font-weight', 'bold');
  $(this).addClass("active");
  $('.div_referencias').css('display', 'block');
  $('.div_titulo').css('display', 'none');
  $('.div_contenido').css('display', 'none');
  $('.div_materiales').css('display', 'none');
});
$("#item_materiales").click(function() {
  $(this).removeClass("active");
  $("#item_titulo").removeClass("active"); 
  $("#item_contenido").removeClass("active");
  $("#item_referencias").removeClass("active");
  // $(this).css('font-weight', 'bold');
  $(this).addClass("active");
  $('.div_materiales').css('display', 'block');
  $('.div_titulo').css('display', 'none');
  $('.div_contenido').css('display', 'none');
  $('.div_referencias').css('display', 'none');
});
// Jhon Martinez    

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
  // alert(Contenido);
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
