$("#btn_nuevo_curso").click(function(){
  CargarPagina("gcurso/_view_registrar", {}, false, $(this));
});

$(".btnFinalizarReg").click(function(){
  var IdCurso = $(this).parent().find(".hidden_IdCurso").val();
  $("#hidden_curso").val(IdCurso);
  CargarPagina("gcurso/_view_finalizar_registro", { id : IdCurso}, false, $(this));
});

$(".btnEliminar").click(function(){
  var Curso = $(this).parent().find(".hidden_IdCurso").val();

  $.fn.Mensaje({
    mensaje: "¿Esta seguro de eliminar este curso?",
    tipo: "SiNo",
    funcionSi: function(){
      AsincTaks("gcurso/_eliminar_curso", { id : Curso }, function(a){
        CargarPagina("gcurso/_view_mis_cursos", {}, false, $(this));
      }, null);
    }
  });
});



$(".btnGestion").click(function(){
  var Curso = $(this).parent().find(".hidden_IdCurso").val();
  var Link = $("#hidden_url").val() + "gestion/matriculados/" + Curso;
  location.href = Link;
});

$(".btnDeshabilitar").click(function(){
  var Curso = $(this).parent().find(".hidden_IdCurso").val();
  ToggleEstado(Curso, "0");
});
$(".btnHabilitar").click(function(){
  var Curso = $(this).parent().find(".hidden_IdCurso").val();
  ToggleEstado(Curso, "1");
});

function ToggleEstado(curso, _estado){
  AsincTaks("gcurso/_estado_curso", { id : curso, estado : _estado }, function(a){
    CargarPagina("gcurso/_view_mis_cursos", {}, false, $(this));
  });
}


$("#btn_buscar").click(function(){
  SubmitForm($("#form-buscar"), $(this), function(data, event){
    DrawPage(data, false);
    $("#btn_buscar").prop("disabled", false);
  });
});

Menu(0);
