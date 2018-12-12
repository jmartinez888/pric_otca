// Menu(1);
RefreshTagUrl();
var fr = new FileReader();
$("#btn_nueva_pizarra").click(function(){
  $("#panelNuevaPizarra").modal("show");
});
$('#file_img').on('change', (e) => {
  if (canvasview != null) {
    fr.readAsDataURL(e.target.files[0])
    fr.onload = (x) => {
      fabric.Image.fromURL(x.target.result, (o) => {
        canvasview.add(o)
        canvasview.renderAll()
      })
    }

  }
})
$('#btn-quitar-imagen').on('click', e => {
  canvasview.getActiveObjects().forEach(v => {
    canvasview.remove(v)
  })
})
$('#btn-limpiar-pizarra').on('click', e => {
  canvasview.getObjects().forEach(v => {
    canvasview.remove(v)
  })
})
$("#btn-cargar-img-pizarra").click(function(){
  $('#click_img').click()

  // $("#panelNuevaPizarra").modal("hide");
  // setTimeout(function(){
  //   var params = {
  //     route: "files/elearning/_pizarra",
  //     pre: $("#hidden_leccion").val()
  //   };
  //   InitUploader(function(a){
  //     $("#panelNuevaPizarra").modal("show");
  //     setTimeout(function(){
  //       AddImg(a);
  //     }, 200);
  //   }, params);
  // }, 300);
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
  // console.log(DATA)

  // $("#tmp_fondo_pizarra").remove();
  // CON.prepend("<img id='tmp_fondo_pizarra' src='" + DATA + "' />");

  $("#btn-cargar-img-pizarra").hide();
  $("#lb_help").show();
}

$("#btn-guardar-pizarra").click(function(){
  // var validate = $("#tmp_img_url").val()+$("#tmp_piz_x").val()+$("#tmp_piz_y").val()+
  //   $("#tmp_piz_width").val()+$("#tmp_piz_height").val();
  // if(validate.length==0){
  //   Mensaje("Es necesario cargar una imagen", null);
  //   return;
  // }
  fetch(canvasview.toDataURL('png'))
  .then(res => res.blob())
  .then(blob => {
    const file = new File([blob], "image_canvas_" + $("#hidden_leccion").val() + ".png", {type: 'image/png'})
    // let blob = new Blob([atob(image.split(',')[1])], {type: 'image/png', encoding: 'utf-8'})
    let params = new FormData()

      params.append('leccion', $("#hidden_leccion").val())
      params.append('url',$("#tmp_img_url").val())
      params.append('dataUrl',file)
      params.append('x',$("#tmp_piz_x").val())
      params.append('y',$("#tmp_piz_y").val())
      params.append('width',$("#tmp_piz_width").val())
      params.append('height',$("#tmp_piz_height").val())

    $.fn.Mensaje({
      mensaje: "¿Desea guardar esta pizarra?",
      tipo: "SiNo",
      funcionSi: function(){
        axios.post(_root_ + "elearning/pizarra/_registrar_pizarra", params).then(res => {
          if (res.data.estado == 1) {
            $("#panelNuevaPizarra").modal("hide");
            Mensaje("Se registró la pizarra", function(){
              location.href = _root_ + _modulo + "/gleccion/_view_leccion/" +
              $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();
            })
          }
        })
      }
    });
  })

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
