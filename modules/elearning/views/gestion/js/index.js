$(document).ready(function(){
  var url_tmp_session = $("#hidden_tmp_session").val();
  if(url_tmp_session!=null && url_tmp_session.length > 0){
    CargarPagina(url_tmp_session, {});
  }else{
    CargarPagina("gestion/_view_mis_cursos", {});
  }
});

function Menu(value){
  if(value==0){
    $("#menu_docente").show();
    $("#menu_curso").hide();
  }else{
    $("#menu_docente").hide();
    $("#menu_curso").show();
  }
}
Menu(0);

function RefreshTagUrl(){
  $("#tag-url-curso").unbind("click").click(function(){
    var IdCurso = $("#hidden_curso").val();
    CargarPagina("gcurso/_view_finalizar_registro", { id : IdCurso}, false, $(this));
  });
  $("#tag-url-modulo").unbind("click").click(function(){
    var IdCurso = $("#hidden_curso").val();
    var IdModulo = $("#hidden_modulo").val();
    CargarPagina("gleccion/_view_lecciones_modulo", { curso: IdCurso, modulo : IdModulo }, false, $(this));
  });
  $("#tag-url-leccion").unbind("click").click(function(){
    var IdCurso = $("#hidden_curso").val();
    var IdModulo = $("#hidden_modulo").val();
    var IdLeccion = $("#hidden_leccion").val();
    CargarPagina("gleccion/_view_leccion", {
      curso: IdCurso,
      modulo : IdModulo,
      leccion : IdLeccion,
    }, false, false);
  });






}
