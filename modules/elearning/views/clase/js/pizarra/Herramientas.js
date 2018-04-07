var CONTROL = $("#hiddenHerramienta");

$(document).ready(function(){
  $("#hiddenActividad").change(function(){
    var value = $(this).val();
    if(value==1){
      $("#herramientas-canvas").show();
      $("#opciones-canvas").show();
    }else{
      $("#herramientas-canvas").hide();
      $("#opciones-canvas").hide();
    }
  });
  $("#hiddenActividad").change();
  $(window).resize();
});

$("#btnLapiz").click(function(){
  $(".herr_piz").prop("disabled", false);
  $(this).prop("disabled", true);
  CONTROL.val(1);
});
$("#btnCuadrado").click(function(){
  $(".herr_piz").prop("disabled", false);
  $(this).prop("disabled", true);
  CONTROL.val(2);
});
$("#btnEtiqueta").click(function(){
  var value = $("#hiddenEtiqueta");
  if(value.val()==0){
    value.val(1);
    CONTROL.val(3);
    $(".herr_piz").prop("disabled", false);
  }else{
    RemoveMarcador();
    EnviarAccion(5, 0, 0, 0, 0, "");
    value.val(0);
    $("#btnLapiz").click();
  }
});
$("#btnTexto").click(function(){
  $(".herr_piz").prop("disabled", false);
  $(this).prop("disabled", true);
  CONTROL.val(4);
});
$("#btnBorrador").click(function(){
  $(".herr_piz").prop("disabled", false);
  $(this).prop("disabled", true);
  CONTROL.val(5);
  EnviarAccion(9, 0, 0, 0, 0, 0);
});
$("#btnImagen").click(function(){
  $(".herr_piz").prop("disabled", false);
  $(this).prop("disabled", true);
  CONTROL.val(6);

  $.ajax({ url: "https://mdn.mozillademos.org/files/224/Canvas_default_grid.png", type: "get", success: function(a){ alert("ok"); }});
});


$("#btnCaptura").click(function(){
  /*var image = document.getElementById("micanvas").toDataURL("image/png")
    .replace("image/png", "image/octet-stream");
  window.location.href = image;*/
  //Canvas2Image.saveAsPNG(document.getElementById("micanvas"), 700, 400);
//  ReImg.fromCanvas(document.getElementById("micanvas")).toPng();
});
function ClickColor(e){
  $("#hiddenEnabled").val(0);
  startColorPicker(e);
}
$("#hiddenColor").focus(function(){
  $(this).css({ "background-color": $(this).val() });
});
$("#hiddenColor").change();
$("#hiddenColor").keypress(function(e){
  return false;
});

$("#iHiddenFuente").change(function(){
  $("#hiddenFuente").val($(this).val());
});
$("#iHiddenGrosor").change(function(){
  $("#hiddenGrosor").val($(this).val());
});
