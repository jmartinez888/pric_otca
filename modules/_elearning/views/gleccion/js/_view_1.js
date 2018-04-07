Menu(1);

$("#btn_nuevo_contenido").click(function(){
  $("#panelNuevoContenido").modal("show");
  $("#inTituloCon").focus();
});

$("#btn_registrar_contenido").click(function(e){
  e.preventDefault();

  $.fn.Mensaje({ mensaje: "¿Desea registrar este contenido?", tipo: "SiNo",
    funcionSi: function(){
      SubmitForm($("#frm_registro_contenido"), $(this), function(data, e){
        alert(data);
        /*CargarPagina("gleccion/_view_leccion", {
          curso: $("#hidden_curso").val(),
          modulo : $("#hidden_modulo").val(),
          leccion : $("#hidden_leccion").val(),
        }, false, false);*/
      });
    }
  });
});
