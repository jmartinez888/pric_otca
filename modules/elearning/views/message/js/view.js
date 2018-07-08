$(window).resize(function(){
	var Caja = $(".chat_content");
	var Padre = Caja.parent();
	var ancho = Padre.width()-350;
	ancho = (ancho < 350) ? 350 : ancho;

	Caja.css({ width: ancho + "px"});
	$("#inNuevoMensaje").css({ width: (Caja.width() - 90) + "px"});

	Padre.css({"padding": "0px","position": "relative","border": "1px solid #D0D0D0"});
});

$(window).resize();
setTimeout(function(){
	$(window).resize();
}, 100);

$(document).ready(function(){
	var ALTO = $("#viewAlto");
	var CHATS = $(".chat_conv_container .item-chat");
	var Buscador = $("#inBusquedaChat");
	CargarBurbujas();

	Buscador.keyup(function(){
		var texto = $(this).val().toUpperCase();
		var length = texto.toString().length;

		if(length>0){
			$("#item-chat-busqueda").show(50);

			for(i = 0 ; i < CHATS.length ; i++){
				var Valor = CHATS.eq(i).attr("search");
				if(Valor.toUpperCase().indexOf(texto) != -1){
					CHATS.eq(i).show();
				}else{
					CHATS.eq(i).hide();
				}
			}
		}else{
			$("#item-chat-busqueda").hide(50);
			CHATS.show();
		}

	});

	CHATS.click(function(){
		var ID1 = $(this).attr("tag");
		var ID2 = $(this).attr("retag");
		var TIPO = $(this).attr("tipo");

		CHATS.removeClass("seleccionado");
		$(this).addClass("seleccionado");

		$(".chat_content__clean").hide();
		$(".chat_content__active").show();
		$(window).resize();
		setTimeout(function(){
			$("#inNuevoMensaje").focus();
		}, 100);

		$("#inID1Chat").val(ID1);
		$("#inID2Chat").val(ID2);
		$("#inTipoChat").val(TIPO);
	});


		$("#btnFullScreen").click(function(){
			var Estado = parseInt($(this).attr("tag"));
			var Cabecera1 = $("body div").eq(0);
			var Cabecera2 = $("header").parent();
			var Nav = $("nav");
			var Footer = $("footer");

			var Zona1 = $(".chat_content");
			var Zona2 = $(".chat_lateral");

			if(Estado==1){
				Cabecera1.show();
				Cabecera2.show();
				Footer.show();
				Nav.show();
				Zona1.css({"height": "600px"});
				Zona2.css({"height": "600px"});
				FixAlto(Zona1);
				$(this).attr("tag", 0);
			}else{
				Cabecera1.hide();
				Cabecera2.hide();
				Footer.hide();
				Nav.hide();
				Zona1.css({"height": "100vh"});
				Zona2.css({"height": "100vh"});
				FixAlto(Zona1);
				$(this).attr("tag", 1);
			}
		});

		function FixAlto(zona1){
			var Zona3 = $(".chat_conv_container");
			var Zona4 = $(".chat_content__active__area");
			var Zona5 = $(".chat_content__active__area__contrapeso");

			Zona3.css({ height: (zona1.height()-108) + "px"});
			Zona4.css({ height: (zona1.height()-104) + "px"});
		}

	function CargarBurbujas(){
		$.ajax({
			url: _root_ + "elearning/message/_chat_item_me",
			success: function(a, e){
				var ELEMENTO1 = a;
				$.ajax({
					url: _root_ + "elearning/message/_chat_item_others",
					success: function(a2, e){
						var ELEMENTO2 = a2;

						$("#item-view-1").html(ELEMENTO1);
						$("#item-view-2").html(ELEMENTO2);
					}
				});
			}
		});
	}
});
