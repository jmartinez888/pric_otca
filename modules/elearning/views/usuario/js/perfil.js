$("#btnCambiarImg").click(function(e){
	e.preventDefault();
	var params = {
		route: "modules/elearning/views/usuario/_contenido/_perfil",
		pre: $("#hiddenUsuario").val()
	};
	InitUploader(function(a){
		var json = JSON.parse(a);
		var url = $("#hidden_url").val() + "usuario/_actualizar_img"; 
		var data = { id: $("#hiddenUsuario").val(), img: json.data[0].url };

		$.ajax({
			url: url,
			data: data,
			type: "post",
			success: function(a){
				var data = JSON.parse(a);
				$("#perfil-img").attr("src", $("#hidden_base_url").val() +
					"modules/elearning/views/usuario/_contenido/_perfil/" + data.mensaje);
			}
		});

	}, params);
});

$("#btnActualizar").click(function(e){
	e.preventDefault();
	$("#frm-actualizar").submit();
});
$(document).resize(function(){
	var Img = $(".img-perfil");
	Img.eq(0).css({ height: Img.width });
});
$(document).resize();