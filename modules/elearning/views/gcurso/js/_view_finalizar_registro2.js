$(document).ready(function(){
  $(".panel-heading").css({ "cursor": "pointer" });
  $(".panel-heading").click(function(){
    var panel = $(this).parent().find(".panel-body");
    var estado = $(this).attr("tag");

    if(estado==1){
      panel.hide(300); $(this).attr("tag", 0);
    }else{
      panel.show(300); $(this).attr("tag", 1);
    }
  });
  $("#btnParams").click(function(){
    var data = {
      curso: $("#hidden_curso").val(),
      min: $("#inParMinNota").val(),
      max: $("#inParMaxNota").val()
    };
    if(data.min==null || data.min.length <= 0 || data.min==null || data.min.length <= 0 ){
      $.fn.Mensaje({ mensaje: "Ingrese ambos parametros", tamano: "sm"});
      return;
    }
    $("#inParMinNota").prop("disabled", true);
    $("#inParMaxNota").prop("disabled", true);
    $("#btnParams").prop("disabled", true);
    $.ajax({
      type: "post",
      url: _root_ + "elearning/gcurso/_reg_parametros",
      data: data,
      success: function(data){
        console.log(data);
        $.fn.Mensaje({ mensaje: "Se actualizaron los datos", tamano: "sm"});
        $("#inParMinNota").prop("disabled", false);
        $("#inParMaxNota").prop("disabled", false);
        $("#btnParams").prop("disabled", false);
      }
    });
  });
});
