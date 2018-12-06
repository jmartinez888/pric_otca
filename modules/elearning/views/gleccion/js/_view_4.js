// Menu(1);
RefreshTagUrl();

$("#btn_nueva_pizarra").click(function(){
  $("#panelNuevaPizarra").modal("show");
});

$("#btn-cargar-img-pizarra").click(function(){
  $("#panelNuevaPizarra").modal("hide");
  setTimeout(function(){
    var params = {
      route: "files/elearning/_pizarra",
      pre: $("#hidden_leccion").val()
    };
    InitUploader(function(a){
      $("#panelNuevaPizarra").modal("show");
      setTimeout(function(){
        AddImg(a);
      }, 200);
    }, params);
  }, 300);
});

function ClearAll(){
  $("#tmp_img_url").val("");
  $("#tmp_piz_x").val("");
  $("#tmp_piz_y").val("");
  $("#tmp_piz_width").val("");
  $("#tmp_piz_height").val("");
  $("#tmp_fondo_pizarra").remove();
  $("#btn-cargar-img-pizarra").show();
  $("#lb_help").hide();
}

$("#btn-cancelar-nueva-pizarra").click(function(){
  $("#panelNuevaPizarra").modal("hide");

  ClearAll();
});

function AddImg(a){
  var DATA = JSON.parse(a);
  DATA = DATA.data[0].url;
  DATA = DATA.split("\\");
  DATA = DATA[DATA.length-1];
  DATA = DATA.split("/");
  DATA = DATA[DATA.length-1];
  $("#tmp_img_url").val(DATA);
  DATA = _root_ + "/files/elearning/_pizarra/" + DATA;

  var CON = $(".contenido-pizarra");
  $("#tmp_fondo_pizarra").remove();
  CON.prepend("<img id='tmp_fondo_pizarra' src='" + DATA + "' />");

  $("#btn-cargar-img-pizarra").hide();
  $("#lb_help").show();
}

$("#btn-guardar-pizarra").click(function(){
  var validate = $("#tmp_img_url").val()+$("#tmp_piz_x").val()+$("#tmp_piz_y").val()+
    $("#tmp_piz_width").val()+$("#tmp_piz_height").val();
  if(validate.length==0){
    Mensaje("Es necesario cargar una imagen", null);
    return;
  }
  var params = {
    leccion : $("#hidden_leccion").val(),
    url: $("#tmp_img_url").val(),
    x: $("#tmp_piz_x").val(),
    y: $("#tmp_piz_y").val(),
    width: $("#tmp_piz_width").val(),
    height: $("#tmp_piz_height").val()
  };
  $.fn.Mensaje({
    mensaje: "¿Desea guardar esta pizarra?",
    tipo: "SiNo",
    funcionSi: function(){
      AsincTaks("pizarra/_registrar_pizarra", params, function(a){
        $("#panelNuevaPizarra").modal("hide");
        Mensaje("Se registró la pizarra", function(){
          location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + 
          $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();
          // CargarPagina("gleccion/_view_leccion", {
          //   curso: $("#hidden_curso").val(),
          //   modulo : $("#hidden_modulo").val(),
          //   leccion : $("#hidden_leccion").val(),
          // }, false, false);
        })
        console.log(a);
      }, false, false);
    }
  });

});

$(".btn-quitar-pizarra").click(function(){
  var BTN = $(this);
  $.fn.Mensaje({
    mensaje: "¿Desea eliminar esta pizarra?",
    tipo: "SiNo",
    funcionSi: function(){
      var Id = BTN.parent().find(".hidden_IdPizarra").val();
      AsincTaks("pizarra/_eliminar_pizarra", { id: Id }, function(a){
        Mensaje("Se eliminó la pizarra", function(){
          location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + 
          $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();
          
          // CargarPagina("gleccion/_view_leccion", {
          //   curso: $("#hidden_curso").val(),
          //   modulo : $("#hidden_modulo").val(),
          //   leccion : $("#hidden_leccion").val(),
          // }, false, false);
        })
      }, false, false);
    }
  });
});
