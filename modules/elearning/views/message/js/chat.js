$(document).ready(function(){
	var CHATS = $(".chat_conv_container .item-chat");
	var CAMPO = $("#inBusquedaCampo");

	CHATS.click(function(){
		var YO = $(this);
		var ID1 = YO.attr("tag");
		var ID2 = YO.attr("retag");
		var TIPO = YO.attr("tipo");
		var TITULO = YO.attr("titulo");
		var SUBTITULO = YO.attr("subtitulo");


		$(".chat_content__active__header__text").html(TITULO);
		$(".chat_content__active__header__subtext").html(SUBTITULO);

		if(TIPO==2){
			$(".chat_content__active__header__text").css({
				"margin-top": "9px", "font-size": "18px"
			});
		}else{
			$(".chat_content__active__header__text").css({
				"margin-top": "0px", "font-size":"15px"
			});
		}

		VerChat(TIPO, ID1, ID2, 0, 200);

		setTimeout(function(){
			YO.find(".label-news").hide(300);
		}, 500);
	});

	CAMPO.keypress(function(e){
		var Container = $("#zoneAutocomplete");
		var tecla = e.keyCode || e.which;
		if(tecla==13){
				e.preventDefault();
				SubmitForm($("#frm_busqueda_usuario"), $(this), function(data, e){
						var result = JSON.parse(data);
						if(result.data.length > 0){
								Container.html("Lista de Usuarios: <br/>");
								result.data.forEach(function(row){
										var cadena = "<div class='panel item-busqueda' tag='" + row.Usu_IdUsuario + "'>";
										cadena += row.Usu_Nombre + " " + row.Usu_Apellidos
										cadena += "</div>";
										Container.append(cadena);
								});
						}
						$(".item-busqueda").unbind("click").click(function(){
								var ID = $(this).attr("tag");
								var TIPO = 2;
								var TITULO = $(this).html();

								for(i=0; i < CHATS.length; i++){
										var id1 = CHATS.eq(i).attr("tag");
										if(id1==ID){
												CHATS.eq(i).click();
												$("#panelNuevoChat").modal("hide");
												CAMPO.val("");
												Container.html("");
												return;
										}
								}

								$(".chat_content__active__header__text").html(TITULO);
								$(".chat_content__active__header__subtext").html("");

								$(".chat_content__active__header__text").css({
									"margin-top": "0px", "font-size":"15px"
								});

								VerChat(TIPO, ID, 0, 0, 200);

								$("#panelNuevoChat").modal("hide");
								CAMPO.val("");
								Container.html("");
								$(".chat_content__clean").hide();
								$(".chat_content__active").show();
								$(window).resize();
								setTimeout(function(){
									$("#inNuevoMensaje").focus();
								}, 100);

								$("#inTipoChat").val(TIPO);
								$("#inID1Chat").val(ID);
								$("#inID2Chat").val(0);
						});
						CAMPO.prop("disabled", false);
	      });
		}
	});

	function VerChat(tipo, id1, id2, index1, index2){
		$.ajax({
			url: _root_ +  "elearning/message/CargarChat",
			type: "POST",
			data: { tipo: tipo, id1: id1, id2: id2, index1: index1, index2: index2
			},
			success: function(a,e){
				var json = JSON.parse(a);
				var conversacion = json.data;

				$(".chat_content__active__area").html("");
				$(".chat_content__active__area").html("<div class='chat_content__active__area__contrapeso'></div>");
				if(conversacion != null && conversacion.length > 0){
					if(tipo==2){
						ConversacionPeople(conversacion);
					}else{
						ConversacionGrupo(conversacion);
					}
					FixView();
				}
			}
		});
	}

	$("#inNuevoMensaje").keypress(function(e){
		var tecla = e.keyCode;
		if(tecla == 13){
			EnviarMensaje();
		}else{
			return true;
		}
	});

	$("#btnEnviarMensaje").click(function(){
		EnviarMensaje();
	});

	$("#btnNuevo").click(function(e){
		e.preventDefault();
		$("#panelNuevoChat").modal("show");
	});

	function EnviarMensaje(){
		var ID1 =  $("#inID1Chat").val();
		var ID2 =  $("#inID2Chat").val();
		var TIPO =  $("#inTipoChat").val();
		var MENSAJE =  $("#inNuevoMensaje").val();

		if(MENSAJE.trim().length==0){
			return;
		}

		$("#inNuevoMensaje").prop("disabled", true);
		$("#btnEnviarMensaje").prop("disabled", true);
		var data = { id1: ID1, id2: ID2, tipo: TIPO, mensaje: MENSAJE };
		$.ajax({
			url: _root_ + "elearning/message/save",
			type: "POST",
			data: data,
			success: function(a, e){
				VerChat(TIPO, ID1, ID2, 0, 200);
				CargarMenuLateral();

				$("#inNuevoMensaje").prop("disabled", false).val("").focus();
				$("#btnEnviarMensaje").prop("disabled", false);
			}
		});
	}

	function ConversacionGrupo(json){
		var CONTENT = $(".chat_content__active__area");
		var ME = $("#item-view-1");
		var OTHER = $("#item-view-2");
		CONTENT.html("");
		CONTENT.html("<div class='chat_content__active__area__contrapeso'></div>");

		json.forEach(function(item){
			var condicion = parseInt(item.CONDICION);
			var content = (condicion == 1 ? ME : OTHER);
			var usuario = content.find(".chat-item-usuario");
			var mensaje = content.find("#chat-item-mensaje");
			var fecha = content.find("#chat-item-fecha");

			usuario.html(item.NOMBRE1).css({cursor: "pointer"});
			mensaje.html(item.MENSAJE);
			fecha.html(item.FECHA);
			content.find(".chat-item").attr("tag", item.ID);
			CONTENT.append(content.html());
		});

		$(".chat-item-usuario").unbind("click").click(function(){
			alert("hola");
		});
	}

	function ConversacionPeople(json){
		var CONTENT = $(".chat_content__active__area");
		var ME = $("#item-view-1");
		var OTHER = $("#item-view-2");
		CONTENT.html("");
		CONTENT.html("<div class='chat_content__active__area__contrapeso'></div>");
		json.forEach(function(item){
			var condicion = parseInt(item.CONDICION);
			var content = (condicion == 1 ? ME : OTHER);
			var usuario = content.find(".chat-item-usuario");
			var mensaje = content.find("#chat-item-mensaje");
			var Opcion1 = content.find(".btnOpcionEliminar");
			var fecha = content.find("#chat-item-fecha");

			Opcion1.attr("tag", item.ID);
			usuario.html(item.NOMBRE1);
			mensaje.html(item.MENSAJE);
			fecha.html(item.FECHA);
			content.find(".chat-item").attr("tag", item.ID);

			CONTENT.append(content.html());
		});
	}

	function FixView(){
		var Burbujas = $(".chat-item-content");
		if(Burbujas.length < 6){
			var Alto = 0;
			for(i = 0; i < Burbujas.length; i++){
				Alto += Burbujas.eq(i).height() + 5;
			}
			Alto = 496 - Alto;
			Alto = (Alto < 200) ? 200 : Alto;
			$(".chat_content__active__area__contrapeso").css({ height: Alto + "px"});
		}else{
			$(".chat_content__active__area__contrapeso").css({ height: "150px"});
		}
		$(".chat_content__active__area").scrollTop($(".chat_content__active__area").prop('scrollHeight'));

		$(".btnOpcionEliminar").click(function(e){
				e.preventDefault();
				var yo = $(this);
				var tag = yo.attr("tag");
				$.fn.Mensaje({
						tamano: "sm",
						tipo: "SiNo",
						mensaje: "¿Desea eliminar este mensaje?",
						funcionSi: function(){
								EliminarMensaje(tag, yo);
						}
				});
		});
	}

	function CargarMenuLateral(){
		$.ajax({
			url: _root_ + "elearning/message/_mis_chats",
			type: "POST",
			success: function(data, e){
				var oChats = JSON.parse(data);
				if(oChats.data!=null && oChats.data.length > 0){
					var contenedor = $(".chat_conv_container");
					contenedor.html("");
					oChats.data.forEach(function(row){
						contenedor.append("<div id='item-chat-busqueda' style='display:none'><strong><div style='color: green'>BUSQUEDA</div></strong></div>");
						var oItem = "<div class='item-chat' tag='" + row.ID1 + "' retag='" + row.ID2 + "' search='" + row.TITULO + "" + row.SUBTITULO + "'";
						oItem += "titulo='" + row.TITULO + "' subtitulo='" + row.SUBTITULO + "' tipo='" + row.TIPO + "'>";
						oItem += "<img class='item-chat-item' src='" + _root_ + "modules/elearning/views/message/img/t" + row.TIPO + ".png'/>";
						oItem += "<div class='item-chat-titulo1'>" + row.TITULO + (row.TITULO.length>20?"...": "") + "</div>";
						oItem += "<div class='item-chat-fecha'>" + row.FECHA + "</div>";
						if(row.NOVISTO!=null && row.NOVISTO > 0){
								oItem += "<span class='label label-primary label-news'>" + row.NOVISTO + "</span>";
						}
						oItem += "</div>";
						contenedor.append(oItem);
					});

					CHATS.click(function(){
						alert("hola");
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
				}
			}
		});
	}

	function EliminarMensaje(id, dom){
		console.log("entramos men");
		var data = { id: id, tipo: $("#inTipoChat").val() };
		$.ajax({
			data: data,
			type: "POST",
			url: _root_ + "elearning/message/delete",
			success: function(data, e){
					var _tipo = $("#inTipoChat").val();
					var _id1 = $("#inID1Chat").val();
					var _id2 = $("#inID2Chat").val();
					VerChat(_tipo, _id1, _id2, 0, 200);
			}
		});
	}
});
