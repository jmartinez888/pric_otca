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
