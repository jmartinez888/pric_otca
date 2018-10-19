$("#btn_nuevo_curso").click(function(){
  CargarPagina("gcurso/_view_registrar", {}, false, $(this));
});

// $(".btnFinalizarReg").click(function(){
//   var IdCurso = $(this).parent().find(".hidden_IdCurso").val();
//   $("#hidden_curso").val(IdCurso);
//   CargarPagina("gcurso/_view_finalizar_registro", { id : IdCurso}, false, $(this));
// });

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

$(".btnFinalizarReg").click(function(){
  var id_curso = $(this).parent().find(".hidden_IdCurso").val();
  Link('/gcurso/_view_finalizar_registro/' + id_curso);
});
$(".btnGestion").click(function(){
  var id_curso = $(this).parent().find(".hidden_IdCurso").val();
  Link('/gestion/matriculados/' + id_curso);
  // var Link = $("#hidden_url").val() + "gestion/matriculados/" + Curso;
  // location.href = Link;
});
$(".btnAnuncios").click(function(){
  var id_curso = $(this).parent().find(".hidden_IdCurso").val();
  Link('/gestion/anuncios/' + id_curso);
  // var Link = $("#hidden_url").val() + "gestion/anuncios/" + Curso;
  // location.href = Link;
});
$(".btnCertificado").click(function(){
  var id_curso = $(this).parent().find(".hidden_IdCurso").val();
  Link('/certificado/plantilla_opcion/' + id_curso);
  // var Link = $("#hidden_url").val() + "certificado/plantilla_opcion/" + Curso;
  // location.href = Link;
});
$(".btnExamen").click(function(){
  var id_curso = $(this).parent().find(".hidden_IdCurso").val();
  Link('/examen/examens/' + id_curso);
  // var Link = $("#hidden_url").val() + "examen/examens/" + Curso;
  // location.href = Link;
});
function Link(url){
  url = _root_ + _modulo + url; 
  location.href = url;
}


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
