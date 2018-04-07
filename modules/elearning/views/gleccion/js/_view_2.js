Menu(1);
RefreshTagUrl();

$("#btn_nuevo_contenido").click(function(e){
  e.preventDefault();

    var Id = $("#in_id_video").val();
    var Link = $("#in_link_video").val();
    var Descripcion = $("#in_descripcion_video").val();

    if(Link.length==0 ){
      Mensaje("Ingrese datos", function(){
        $("#in_id_video").focus();
      });
      return;
    }
    $.fn.Mensaje({
      mensaje: "¿Desea actualizar los datos de la lección?",
      tipo: "SiNo",
      funcionSi: function(){

        var parmas = { id: Id, link: Link, descripcion: Descripcion};
        AsincTaks("gleccion/_actualizar_video", parmas, function(a){
          CargarPagina("gleccion/_view_leccion", {
            curso: $("#hidden_curso").val(),
            modulo : $("#hidden_modulo").val(),
            leccion : $("#hidden_leccion").val(),
          }, false, false);
        }, false, false);

      }
    });
});
