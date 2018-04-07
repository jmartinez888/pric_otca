var LEARN_CONTENT = $("#learn_content_main");
var LEARN_CHAT =$("#learn_chat_window");
var STYLE = { color : { principal : "#00a65a" } };

function DrawPage(html, dom = false){
	if(dom){
		dom.html(html);
	}else{
		LEARN_CONTENT.hide(100);
		LEARN_CONTENT.html(html);
		LEARN_CONTENT.show(100);
		LEARN_CONTENT.css({ display: "inline-block" });
		LEARN_CHAT.css({ position: "fixed", bottom: "0px" });
	}
	$(".content").css({ height: "auto" });
}

function AsincTaks(url, params, success, error, reintentar = false){
	url = $("#hidden_url").val() + url;

	$.ajax({
		type: "post",
		url: url,
		data: params,
		success: function(a, e){
			if (e == "success"){
				if (typeof(success) === 'function' ){
					success(a);
				}
			}else{
				if (reintentar){
					AsincTaks(url, params, success, error);
				}
				console.log("Ocurrió un error");
			}
		},
		error: function(xhr, status, error){
			console.log(xhr);
			console.log(status);
			alert(JSON.stringify(error));
			if(error && typeof(error) === 'function'){

			}
		}
	});
}

function CargarPagina(url, params, dom = false, button = false){
	if(button){
		button.prop("disabled", true);
	}
	AsincTaks(url, params, function(a){
		DrawPage(a, dom);
	}, false);
}

function SubmitForm(form, dom, success, m = false){
	var params = form.serializeArray();
	var inputs = form.find("input");
	var textareas = form.find("textarea");
	var slcs = form.find("select");
	var submitible = true;
	if(inputs.length==1){
		if(inputs.val().toString().length==0){
			inputs.focus();
			return;
		}
	}else if (inputs.length > 1){

	}
	if(textareas.length==1){
		if(textareas.val().toString().length==0){
			textareas.focus();
			return;
		}
	}else if (textareas.length > 1){

	}
	if(slcs.length==1){
		if(slcs.val() == null || slcs.val() == -1){
			slcs.focus();
			return;
		}
	}else if (slcs.length > 1){

	}
	inputs.prop("disabled", true);
	textareas.prop("disabled", true);
	slcs.prop("disabled", true);
	if(dom){ dom.prop("disabled", true); }

	var post = {};
	post.Enabled = function(){
		setTimeout(function(){
			inputs.prop("disabled", false); textareas.prop("disabled", false); slcs.prop("disabled", false);
		}, 500);
	};
	AsincTaks(form.attr('action'), params, function(e){
		if (typeof(success) === 'function' ){
			success(e, post);
		}
	}, null, false);
}

function Mensaje(mensaje, funcionCerrar){
	$.fn.Mensaje({
		tamano: "sm",
		mensaje: mensaje,
		funcionCerrar: funcionCerrar
	});
}

function InputValidate(dom, longitud){
	$(dom).keypress(function(e){
		if($(this).val().length < longitud){
			var key = e.keyCode;
		}else{
			return false;
		}
	}).on("drop",function(e){
		setTimeout(function(){
			var value = $(dom).val();
			if(value.length > longitud){
				$(dom).val(value.substring(0, longitud));
			}
		}, 30);
	}).on("paste", function(e){
		setTimeout(function(){
			var value = $(dom).val();
			if(value.length > longitud){
				$(dom).val(value.substring(0, longitud));
			}
		}, 30);
	});
}
