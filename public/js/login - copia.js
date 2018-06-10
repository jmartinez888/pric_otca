var url = $("#url").val();
$(document).ready(function() {
	$("body").on('click', "#login-form-link", function (e) {
		$("#login-form").delay(100).fadeIn(100);
 		$("#register-form").fadeOut(100);
		$('#register-form-link').removeClass('active');                
        $('#divRecuperar').removeClass('hidden');                 
        $('#divEnvioCorreo').removeClass('hidden');
		$(this).addClass('active');    
        $('#divEnvioCorreo').addClass('hidden');    
        $('#divRecuperar').addClass('hidden');
		e.preventDefault();
	});
	$("body").on('click', "#register-form-link", function (e) {
		$("#register-form").delay(100).fadeIn(100);
 		$("#login-form").fadeOut(100);
		$('#login-form-link').removeClass('active');                
        $('#divRecuperar').removeClass('hidden');                 
        $('#divEnvioCorreo').removeClass('hidden');
		$(this).addClass('active');    
        $('#divEnvioCorreo').addClass('hidden');    
        $('#divRecuperar').addClass('hidden');
		e.preventDefault();
	});

    $("body").on('click', "#showRecPass", function () {
        $("#emailRecPass").val("");                 
        $('#divRecuperar').removeClass('hidden');                 
        $('#divEnvioCorreo').removeClass('hidden');
    }); 

    $("body").on('click', "#btnRecPass", function () { 
        $("#cargando").show();                      
        $('#divEnvioCorreo').addClass('hidden');
        $.post(_root_ + 'usuarios/login/recuperarPass',
        {
            email: $("#emailRecPass").val()
        }, function (data) {
            $("#divRecuperar").html('');
            $("#cargando").hide();
            $("#divRecuperar").html(data);
        });
        
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
        	url, $("#hd_login_modulo").val(),"");
        
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
        //Cerrar Session gmail
        gapi.auth2.getAuthInstance().signOut().then(function () {
            console.log('User signed out.');
        });
	});

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
								passwordRegistrar, urlRegistrar, moduloRegistrar, idGmailLogin) {
    
    $.post(_root_ + 'usuarios/login/registrarUsuarioLogin/',
    {
    	nombre:nombreRegistrar, 
    	apellidos:apellidoRegistrar, 
    	email:emailRegistrar, 
    	usuario:usuarioRegistrar, 
    	password:passwordRegistrar, 
    	url:urlRegistrar,
    	modulo:moduloRegistrar,
        codigo:idGmailLogin
    }, function (data) {
        $("#mensajeLogeo").html('');
        $("#cargando").hide();
        $("#mensajeLogeo").html(data);
    });


}


// Para Iniciar Session con cuenta Gmail
function renderButton() {
    gapi.signin2.render('signin2', {
      'scope': 'profile email',
      'width': 250,
      'height': 40,
      'longtitle': true,
      'theme': 'dark',
      'onsuccess': onSuccess,
      'onfailure': onFailure
    });

    gapi.signin2.render('registrar-gmail', {
      'scope': 'profile email',
      'width': 250,
      'height': 40,
      'longtitle': true,
      'theme': 'dark',
      'onsuccess': onSuccess,
      'onfailure': onFailure
    });
}
$("body").on('click', "#CerrarSession", function () { 
        
  // alert($("#usuarioLogin").val() + $("#passwordLogin").val() + $("#url").val());   
      gapi.auth2.getAuthInstance().signOut().then(function () {
        console.log('User signed out.');
      });
      window.location = _root_ + 'usuarios/login/cerrar';
});
function onSuccess(googleUser) {
// alert(_email);
    var profile = googleUser.getBasicProfile();
    registrarUsuarioLogin(profile.getGivenName(), profile.getFamilyName(), 
            profile.getEmail(), profile.getEmail(), "",
            url, $("#hd_login_modulo").val(),profile.getId());

}
function onFailure(error) {
    console.log(error);
}