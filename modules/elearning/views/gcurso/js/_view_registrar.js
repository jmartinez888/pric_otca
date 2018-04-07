$("#btn_inicio").click(function(){
  CargarPagina("gestion/_inicio", {}, false, $(this));
});

$("#slModalidad").change(function(){
  var id = "#ModCurso" + $(this).val();
  $(".opcion_mod").hide();
  $(id).show(100);
});

$("#btn_guardar").click(function(){
  if($("#slModalidad").val()==null || $("#slModalidad").val()==-1){
    Mensaje("Seleccione una modalidad de curso", function(){
      $("#slModalidad").focus();
    });
    return;
  }
  SubmitForm($("#frm_curso"), $(this), function(data, event){
    var DATA = JSON.parse(data);
    var ID_CURSO = DATA.mensaje.ID;
    if(DATA.estado==0){
      event.Enabled();
      $("#btn_guardar").prop("disabled", false);
    }else{
      Mensaje("Curso registrado!", function(){
        CargarPagina("gcurso/_view_finalizar_registro/", { id: ID_CURSO }, false, false);
      });
    }
  });
});

InputValidate($("input[name=curso_titulo]"), 100);
InputValidate($("textarea[name=curso_descripcion]"), 500);
