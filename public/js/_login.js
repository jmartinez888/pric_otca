var url = $("#url").val();
$(document).on('ready', function () {
	
	$("body").on('click', "#login-form-link", function (e) {
		$("#login-form").delay(100).fadeIn(100);
 		$("#register-form").fadeOut(100);
		$('#register-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
	$("body").on('click', "#register-form-link", function (e) {
		$("#register-form").delay(100).fadeIn(100);
 		$("#login-form").fadeOut(100);
		$('#login-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});

	$("body").on('click', "#logear", function () { 
        $("#cargando").show();       
        // alert($("#usuarioLogin").val() + $("#passwordLogin").val() + $("#url").val());		
        logear($("#usuarioLogin").val(), $("#passwordLogin").val(), url, $("#hd_login_modulo").val());
        
    }); 
    $("body").on('click', "#registrar-login", function () { 
        $("#cargando").show();       
        // alert($("#usuarioLogin").val() + $("#passwordLogin").val() + $("#url").val());		
        registrarUsuarioLogin($("#nombreRegistrar").val(), $("#apellidosRegistrar").val(), 
        	$("#emailRegistrar").val(), $("#usuarioRegistrar").val(), $("#passwordRegistrar").val(),
        	url, $("#hd_login_modulo").val());
        
    }); 


	$('#modal-login').on('hidden.bs.modal', function (e) {
		// alert(url);
        var params_usu = $("#params_usu").val();
		if (params_usu) {
            if ($("#params_usu").val() == "*") {
                location.href = _root_ + url ;
            } else {
                location.href = _root_ + url + "/" + params_usu;
            }            
            
		} else {
            if ($("#params_usu").val() == "*") {
    	  		location.href = _root_ + url ;
            }
		}
	})

	$("body").on('click', "#show-pass", function () { 
        if ($('#passwordLogin').attr('type') === 'password') {
            $('#passwordLogin').attr('type', 'text');
            $('#btn_ver_clave').removeClass('glyphicon-eye-open');
            $('#btn_ver_clave').addClass('glyphicon-eye-close');
        } else {
            $('#passwordLogin').attr('type', 'password');
            $('#btn_ver_clave').removeClass('glyphicon-eye-close');
            $('#btn_ver_clave').addClass('glyphicon-eye-open');
        }
    });

	$("body").on('click', "#show-pass-registrar", function () { 
        if ($('#passwordRegistrar').attr('type') === 'password') {
            $('#passwordRegistrar').attr('type', 'text');
            $('#btn_ver_clave_registrar').removeClass('glyphicon-eye-open');
            $('#btn_ver_clave_registrar').addClass('glyphicon-eye-close');
        } else {
            $('#passwordRegistrar').attr('type', 'password');
            $('#btn_ver_clave_registrar').removeClass('glyphicon-eye-close');
            $('#btn_ver_clave_registrar').addClass('glyphicon-eye-open');
        }
    });


});

function tecla_enter_login(evento)
{
    var iAscii;
    if (evento.keyCode)
    {
        iAscii = evento.keyCode;
    }  
    if (iAscii == 13) 
    {
    	$("#cargando").show();
        logear($("#usuarioLogin").val(), $("#passwordLogin").val(), url, $("#hd_login_modulo").val());
        evento.preventDefault();
    }
   
}
function logear(usuarioLogin, passwordLogin, urlLogin, moduloLogin) {
    $.post(_root_ + 'usuarios/login/logeo/',
    {
    	usuario:usuarioLogin,
        password:passwordLogin,
        url:urlLogin,
        modulo:moduloLogin
    }, function (data) {
        $("#mensajeLogeo").html('');
        $("#cargando").hide();
        $("#mensajeLogeo").html(data);
    });
}
function registrarUsuarioLogin(nombreRegistrar, apellidoRegistrar, emailRegistrar, usuarioRegistrar, 
								passwordRegistrar, urlRegistrar, moduloRegistrar) {
    $.post(_root_ + 'usuarios/login/registrarUsuarioLogin/',
    {
    	nombre:nombreRegistrar, 
    	apellidos:apellidoRegistrar, 
    	email:emailRegistrar, 
    	usuario:usuarioRegistrar, 
    	password:passwordRegistrar, 
    	url:urlRegistrar,
    	modulo:moduloRegistrar
    }, function (data) {
        $("#mensajeLogeo").html('');
        $("#cargando").hide();
        $("#mensajeLogeo").html(data);
    });
}