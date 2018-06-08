$(document).ready(function(){
	var CALIFICACION = 0;
	var SELECTED = true;
	$(".item-calificar").click(function(){
		if(!SELECTED){ return; }
		var Contador = $(this).attr("tag");
		CALIFICACION = Contador;
	});
	$(".item-calificar").mouseover(function(){
		var Contador = $(this).attr("tag");

		for(i=0; i < $(".item-calificar").length; i++){
			var OtherTag = $(".item-calificar").eq(i).attr("tag");
			if(OtherTag > Contador){
				$(".item-calificar").eq(i).css("color", "gray");
			}else{
				$(".item-calificar").eq(i).css("color", "black");
			}
		}
	});
	$(".item-calificar").mouseleave(function(){
		for(i=0; i < $(".item-calificar").length; i++){
			var OtherTag = $(".item-calificar").eq(i).attr("tag");
			if(OtherTag > CALIFICACION){
				$(".item-calificar").eq(i).css("color", "gray");
			}else{
				$(".item-calificar").eq(i).css("color", "black");
			}
		}
	});
	$("#btnCalificar").click(function(){
		var texto = $("#txCComentario").val();
		if(CALIFICACION==0){
			$.fn.Mensaje({ 
				mensaje: "Seleccione una número (<span class='glyphicon glyphicon-heart'></span>)<br/> para su calificación" ,
				tamano: "sm", 
				funcionCerrar: function(){
					SELECTED = false;
					$(".item-calificar").css("color", "red");
					setTimeout(function(){
						$(".item-calificar").css("color", "gray");
						setTimeout(function(){
							$(".item-calificar").css("color", "red");
							setTimeout(function(){
								$(".item-calificar").css("color", "gray");
								SELECTED = true;
							}, 200);
						}, 200);
					}, 200);
				}
			});
			return;
		}
		if(texto.toString().trim()==0){
			$.fn.Mensaje({ 
				mensaje: "Ingrese un comentario a su calificación" ,
				tamano: "sm",
				funcionCerrar: function(){
					$("#txCComentario").focus();
				}
			});
			return;
		}
		$.fn.Mensaje({ 
			mensaje: "¿Desea registrar la calificación?" ,
			tamano: "sm",
			tipo: "SiNo",
			funcionSi: function(){
				$.ajax({
					url: _root_ +  "elearning/calificacion/registrar",
					data: { 
						usuario: $("#inCUsuario").val(), 
						curso: $("#inCCurso").val(), 
						calificacion: CALIFICACION, 
						comentario: $("#txCComentario").val()
					},
					type: "POST",
					success: function(a){
						var result = JSON.parse(a);
						if(result.estado == 1){
							$.fn.Mensaje({ 
								mensaje: "Se ha registrado con éxito su valoración del curso" , 
								tamano: "sm", 
								funcionCerrar: function(){
									location.reload();
								}
							});
						}else{
							$.fn.Mensaje({ 
								mensaje: "Ocurrió un error al registrar su calificación, intentelo mas tarde" , 
								tamano: "sm", 
								funcionCerrar: function(){
									location.reload();
								}
							});
						}
					}
				});
			}
		});
	});

	$.ajax({
		url: _root_ + "elearning/calificacion/get", 
		type: "POST",
		data: { curso: $("#inHiddenCurso").val() },
		success: function(a){
			var DATA = JSON.parse(a);
			if(DATA.data!=null && DATA.data.length>0){
				DATA.data.forEach(function(item){
					$("#calificaciones").append(ItemCalificacion(item.Val_Valor, item.Val_Comentario, item.Usu_Usuario));
				});
			}else{
				$("#calificaciones").html("<center>Este curso aun no tiene calificaciones</center>");
			}
		}
	});

	function ItemCalificacion(valor, comentario, usuario){
		var text = "<div class='row item-comentario'>";
		text += "<div class='col-lg-12' style='margin-top: 15px; font-size: 15px'>\"" + comentario + "\"</div>";
		text += "<div class='col-lg-3' style='margin-top: 7px'>";
		text += 	"<span class='glyphicon glyphicon-heart mini-item-calificar " + (valor>0? "active-mic": "") + "'></span>";
		text += 	"<span class='glyphicon glyphicon-heart mini-item-calificar " + (valor>1? "active-mic": "") + "'></span>";
		text += 	"<span class='glyphicon glyphicon-heart mini-item-calificar " + (valor>2? "active-mic": "") + "'></span>";
		text += 	"<span class='glyphicon glyphicon-heart mini-item-calificar " + (valor>3? "active-mic": "") + "'></span>";
		text += 	"<span class='glyphicon glyphicon-heart mini-item-calificar " + (valor>4? "active-mic": "") + "'></span>";
		text += "</div>";
		text += "<div class='col-lg-9' style='margin-top: 7px'>" + usuario + "</div>";
		text += "</div>";
		return text;
	}

	$("#btnCertificado").click(function(){
		$.ajax({
			url: _root_ + "elearning/certificado/registrar", 
			type: "POST",
			data: { curso: $("#inHiddenCurso").val() },
			success: function(a){
				$.fn.Mensaje({ 
					mensaje: "Se ha generado el certificado", tamano: "sm", 
					funcionCerrar: function(){
						location.reload();
					}
				});
			}
		});
	});
});