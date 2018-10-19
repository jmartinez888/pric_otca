$(".learn_chat_window_button").click(function(){
	var estado = $(this).find(".estado");
	var icon = $(this).find(".glyphicon");

	if(estado.val()==1){
		icon.removeClass("glyphicon-triangle-bottom").addClass("glyphicon-triangle-top");
		$(".learn_chat_content").hide();
		estado.val(0);
	}else{
		$(".learn_chat_content").show();
		icon.removeClass("glyphicon-triangle-top").addClass("glyphicon-triangle-bottom");
		estado.val(1);
	}
});
function RefreshTagUrl(){
	$("#tag-url-curso").unbind("click").click(function(){
	    var IdCurso = $("#hidden_curso").val();
	    location.href = _root_ + _modulo + "/gcurso/_view_finalizar_registro/" + IdCurso;
	    // CargarPagina("gcurso/_view_finalizar_registro", { id : IdCurso}, false, $(this));
	});
	$("#tag-url-modulo").unbind("click").click(function(){
	    var IdCurso = $("#hidden_curso").val();
	    var IdModulo = $("#hidden_modulo").val();
	    location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + IdCurso + "/" + IdModulo;
	    // CargarPagina("gleccion/_view_lecciones_modulo", { curso: IdCurso, modulo : IdModulo }, false, $(this));
	});	
	$("#tag-url-leccion").unbind("click").click(function(){
	    var IdCurso = $("#hidden_curso").val();
	    var IdModulo = $("#hidden_modulo").val();
	    var IdLeccion = $("#hidden_leccion").val();
	    location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + IdCurso + "/" + IdModulo + "/" + IdLeccion;
	    // CargarPagina("gleccion/_view_leccion", {
	    //   curso: IdCurso,
	    //   modulo : IdModulo,
	    //   leccion : IdLeccion,
	    // }, false, false);
	});
}
