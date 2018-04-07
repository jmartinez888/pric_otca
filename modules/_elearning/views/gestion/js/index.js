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
