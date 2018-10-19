// Menu(1);
RefreshTagUrl();

// Jhon Martinez
$("#item_modulo").click(function() {
  $(this).removeClass("active");
  $("#item_lecciones").removeClass("active"); 
  // $(this).css('font-weight', 'bold');
  $(this).addClass("active");
  $('.div_modulo').css('display', 'block');
  $('.div_lecciones').css('display', 'none');
});
$("#item_lecciones").click(function() {
  $(this).removeClass("active");
  $("#item_modulo").removeClass("active");
  // $(this).css('font-weight', 'bold');
  $(this).addClass("active");
  $('.div_lecciones').css('display', 'block');
  $('.div_modulo').css('display', 'none');
});

$("#btn_nueva_leccion").click(function(){
  if($(this).html()=="Cancelar"){
    $("#panelNuevaLeccion").hide(100);
    $('html, body').animate({
          scrollTop: $(document).height()
      }, 800);
    $(this).html("<i class='glyphicon glyphicon-book'></i> Nueva Lección");
  }else{
    $("#panelNuevaLeccion").removeClass("fade").show(200);
    $('html, body').animate({
          scrollTop: 2000
      }, 800);
    $("#inTitulo").focus();

    $(this).html("Cancelar");
  }
  $("input[name=titulo]").val("");
  $("input[name=descripcion]").val("");
});

$("#btn_guardar_leccion").click(function(e){
  e.preventDefault();
  SubmitForm($("#frm_registro"), $(this), function(data, event){
    Mensaje("Lección registrada con éxito", function(){
      location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
      // CargarPagina("gleccion/_view_lecciones_modulo", { id: $("#hidden_modulo").val() }, false, false);
    })
  });
}); 

$(".btnFinalizarReg").click(function(){
  var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();
  $("#hidden_leccion").val(IdLeccion);
  location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + IdLeccion;
  // CargarPagina("gleccion/_view_leccion", {
  //   curso: $("#hidden_curso").val(),
  //   modulo : $("#hidden_modulo").val(),
  //   leccion : IdLeccion,
  // }, false, false);
});

// $(".btnExamen").click(function(){
//   var Curso = $(this).parent().find(".hidden_IdCurso").val();
//   var Link = $("#hidden_url").val() + "examen/examens/" + Curso;
//   location.href = Link;
// });


$(".btnEliminar").click(function(){
  var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();

  $.fn.Mensaje({
    mensaje: "¿Esta seguro de eliminar esta lección?",
    tipo: "SiNo",
    funcionSi: function(){
      AsincTaks("gleccion/_eliminar_leccion", { id : IdLeccion }, function(a){
        setTimeout(function(){
            Mensaje("Se Eliminó la Lección", function(){
              location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
                // CargarPagina("gleccion/_view_lecciones_modulo", {}, false, false);
            }, "Alerta", "alert");
        }, 300); 
        // CargarPagina("gleccion/_view_lecciones_modulo", {}, false, false);
      }, null);
    }
  });
});

$(".btnDeshabilitar").click(function(){
  var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();
  ToggleEstado(IdLeccion, "0");
});
$(".btnHabilitar").click(function(){
  var IdLeccion = $(this).parent().find(".hidden_IdLeccion").val();
  ToggleEstado(IdLeccion, "1");
});

function ToggleEstado(IdLeccion, _estado){
  AsincTaks("gleccion/_estado_leccion", { id : IdLeccion, estado : _estado }, function(a){
    var result = JSON.parse(a);
    if (_estado == 1) {
      var _mensaje = "La lección ha sido Habilitado...!!!";
      var _icon = "info-sign";
    } else {
      var _mensaje = "La lección ha sido Deshabilitado...!!!";
      var _icon = "exclamation-sign";
    }
    setTimeout(function(){
      if(result.estado == 1){
        Mensaje(_mensaje, function(){
          location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
            // CargarPagina("gleccion/_view_lecciones_modulo", {}, false, false);
        }, "",_icon);
      }else{
        Mensaje(result.mensaje, null);
      }
    }, 300); 
  });
}


$("#btn_actualizar_modulo").click(function(e){
  e.preventDefault();
  SubmitForm($("#frm-act-modulo"), $(this), function(data, event){
    Mensaje("Datos actualizados", function(){
      location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val();
      // CargarPagina("gleccion/_view_lecciones_modulo", { id: $("#hidden_modulo").val() }, false, false);
    });
  });
});
