// Menu(1);
RefreshTagUrl();

$("#btn_nuevo_modulo").click(function(){
  if($(this).html()=="Cancelar"){
    $("#panelNuevoModulo").hide(100);
    $('html, body').animate({
          scrollTop: $(document).height()
      }, 800);
    $(this).html("<i class='glyphicon glyphicon-book'></i> Nuevo Módulo");
  }else{
    $("#panelNuevoModulo").removeClass("fade").show(200);
    $('html, body').animate({
          scrollTop: 2000
      }, 800);
    $("#inTitulo").focus();

    $(this).html("Cancelar");
  }
  $("input[name=titulo]").val("");
  $("input[name=descripcion]").val("");
});

$("#btn_registrar_modulo").click(function(e){
  e.preventDefault();
  SubmitForm($("#frm_registro"), $(this), function(data, event){
    Mensaje("Modulo registrado con éxito", function(){
      location.href = _root_ + _modulo + "/gmodulo/_view_modulos_curso/" + $("#hidden_curso").val();
      // CargarPagina("gmodulo/_view_modulos_curso", { id: $("#hidden_curso").val() }, false, false);
    })
  });
});

$(".btnFinalizarReg").click(function(){
  var IdModulo = $(this).parent().find(".hidden_IdModulo").val();
  $("#hidden_modulo").val(IdModulo);
  location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + $("#hidden_curso").val() + "/" + IdModulo;
  // CargarPagina("gleccion/_view_lecciones_modulo", { curso: $("#hidden_curso").val(), modulo : IdModulo }, false, $(this));
});

$(".btnEliminar").click(function(){
  var IdModulo = $(this).parent().find(".hidden_IdModulo").val();

  $.fn.Mensaje({
    mensaje: "¿Esta seguro de eliminar este curso?",
    tipo: "SiNo",
    funcionSi: function(){
      AsincTaks("gmodulo/_eliminar_modulo", { id : IdModulo }, function(a){
        setTimeout(function(){
          // alert(IdModulo);
          Mensaje("El Módulo ha sido eliminado...!!!", function(){
            location.href = _root_ + _modulo + "/gmodulo/_view_modulos_curso/" + $("#hidden_curso").val();
          // CargarPagina("gmodulo/_view_modulos_curso", {}, false, false);
          });
        }, 300);  
      }, null);
    }
  });
});

$(".btnDeshabilitar").click(function(){
  var Curso = $(this).parent().find(".hidden_IdModulo").val();
  ToggleEstado(Curso, "1");
});
$(".btnHabilitar").click(function(){
  var Curso = $(this).parent().find(".hidden_IdModulo").val();
  ToggleEstado(Curso, "0");
});

function ToggleEstado(curso, _estado){
  AsincTaks("gmodulo/_estado_modulo", { id : curso, estado : _estado }, function(a){
    var result = JSON.parse(a);
    if (_estado == 1) {
      var _mensaje = "El Módulo ha sido Habilitado...!!!";
      var _icon = "info-sign";
    } else {
      var _mensaje = "El Módulo ha sido Deshabilitado...!!!";
      var _icon = "exclamation-sign";
    }
    setTimeout(function(){
      if(result.estado == 1){
        Mensaje(_mensaje, function(){
          location.href = _root_ + _modulo + "/gmodulo/_view_modulos_curso/" + $("#hidden_curso").val();
            // CargarPagina("gleccion/_view_lecciones_modulo", {}, false, false);
        }, "", _icon);
      }else{
        Mensaje(result.mensaje, null, "Alerta", "alert");
      }
    }, 300);   
  });
}
