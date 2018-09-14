<?php

class loginController extends Controller {

    private $_login;

    public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_usuarios = $this->loadModel('usuario');
        $this->_login = $this->loadModel('login');
    }

    public function index($url_redirec = false) {

        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("login_index");

        if (Session::get('autenticado')) {
            $this->redireccionar();
        }
        if (Session::get('login_error')) {
            $this->_view->assign('_error', Session::get('login_error'));
            $this->_view->assign('usuario', Session::get('login_usuario'));
            Session::destroy('login_error');
            Session::destroy('usuario');
        }

        $this->_view->assign('titulo', 'Iniciar Sesión');

        if ($this->botonPress('logear')) {
            $this->_view->assign('usuario', $this->getAlphaNum('usuario'));
            Session::set('login_usuario', $this->getAlphaNum('usuario'));

            $row = $this->_login->getUsuario(
                    $this->getAlphaNum('usuario'), $this->getSql('password')
            );
            // echo($this->getAlphaNum('usuario'));exit;
            if (!$row) {
                $this->_view->assign('_error', 'Usuario y/o password incorrectos');
                Session::set('login_error', 'Usuario y/o password incorrectos');
            } else
            if ($row['Usu_Estado'] != 1 || $row['Row_Estado'] != 1) {
                if($row['Usu_Estado'] == 3){
                    $this->_view->assign('_errorLogin', 'Validar usuario, se le envio un correo con el link de validacion.');
                } else {
                    $this->_view->assign('_errorLogin', 'El usuario no esta habilitado');
                }  
                Session::set('login_error', 'Este usuario no esta habilitado');
            } else {

                Session::set('autenticado', true);
                // Session::set('level', $row['Rol_IdRol']);
                Session::set('usuario', $row['Usu_Usuario']);
                Session::set('id_usuario', $row['Usu_IdUsuario']);
                Session::set('Usu_Nombre', $row['Usu_Nombre']);
                Session::set('Usu_Apellidos', $row['Usu_Apellidos']);
                Session::set('tiempo', time());

//                if (Session::get('level') == 5) {
//                    $this->redireccionar("acl");
//                }
                // $this->_view->renderizar('ajax/mensajeLogin', false, true);

                $url_redirec = str_replace("*","/",$url_redirec);
                $this->redireccionar($url_redirec);
            }
        } 

        $this->_view->renderizar('index', 'login');    
    }

    public function logeo() {

        // $this->validarUrlIdioma();
        $this->_view->getLenguaje("template_frontend");
        $this->_view->getLenguaje("login_index");
        $url_redirec = $this->getSql("url");
        // $url_redirec = str_replace("*","/",$url_redirec);
        $this->_view->assign('url', $url_redirec);

        if (Session::get('autenticado')) {
            $this->redireccionar();
        }
        if (Session::get('login_error')) {
            $this->_view->assign('_errorLogin', Session::get('login_error'));
            $this->_view->assign('usuario', Session::get('login_usuario'));
            Session::destroy('login_error');
            Session::destroy('usuario');
        }

        // $this->_view->assign('titulo', 'Iniciar Sesión');
        $this->_view->assign('usuario', $this->getAlphaNum('usuario'));
        Session::set('login_usuario', $this->getAlphaNum('usuario'));

        $row = $this->_login->getUsuario(
            $this->getAlphaNum('usuario'), $this->getSql('password')
        );

        if (!$row) {
            $this->_view->assign('_errorLogin', 'Usuario y/o password incorrectos');
            Session::set('login_error', 'Usuario y/o password incorrectos');
            $this->_view->renderizar('ajax/mensajeLoginError', false, true);
        } else
        if ($row['Usu_Estado'] != 1 || $row['Row_Estado'] != 1) {
            if($row['Usu_Estado'] == 3){
                $this->_view->assign('_errorLogin', 'Validar usuario, se le envio un correo con el link de validacion.');
            } else {
                $this->_view->assign('_errorLogin', 'El usuario no esta habilitado');
            }                
            Session::set('login_error', 'Este usuario no esta habilitado');
            $this->_view->renderizar('ajax/mensajeLoginError', false, true);
        } else {

            Session::set('autenticado', true);
            // Session::set('level', $row['Rol_IdRol']);
            Session::set('usuario', $row['Usu_Usuario']);
            Session::set('id_usuario', $row['Usu_IdUsuario']);
            Session::set('Usu_Nombre', $row['Usu_Nombre']);
            Session::set('Usu_Apellidos', $row['Usu_Apellidos']);
            Session::set('tiempo', time());

            // $this->redireccionar($url_redirec);
        }

        $this->_view->renderizar('ajax/mensajeLogin', false, true);
    }
    //Modificado JM
    public function registrarUsuarioLogin()
    {             
        // echo $Email_Gmail;
        $i = 0;
        $error = ""; $error1 = ""; $idUsuario = "";

        $this->_view->getLenguaje("template_frontend");
        $this->_view->getLenguaje("login_index");
        $url_redirec = $this->getSql("url");
        // $url_redirec = str_replace("*","/",$url_redirec);
        $this->_view->assign('url', $url_redirec);

            
        $Usu_Codigo = $this->getSql('codigo');
        // echo $Usu_Codigo;
        $TipoRegistro = 2;
        if ($Usu_Codigo <= 0 || empty($Usu_Codigo)) {
            $TipoRegistro = 1;
            $Usu_Codigo = rand((int)(1782598471), (int)(9999999999));
        }
        $Usu_Nombre = $this->getSql('nombre');
        $Usu_Apellido = $this->getSql('apellidos');    
        $Usu_Email = $this->getSql('email');
        $Usu_Usuario = $this->getSql('usuario');
        $Usu_Password = $this->getSql('password');
        // echo $Usu_Email."/".$Usu_Codigo;
        
        if ($this->getSql('modulo') == "foro" ) {
            $rol = "participante_foro";
        } else {
            if ($this->getSql('modulo') == "elearning") {
                $rol = "alumno";
            } else {
                if ($this->getSql('modulo') == "") {
                    $rol = "";
                }
            }
        }

        $ArrayUsuario = $this->_usuarios->verificarEmailCodigo($Usu_Email,$Usu_Codigo);
        // print_r($ArrayUsuario); echo count($ArrayUsuario);
        if(!empty($ArrayUsuario) && count($ArrayUsuario)>0){
            //Para que este Logeado
            Session::set('autenticado', true);
            // Session::set('level', $row['Rol_IdRol']);
            Session::set('usuario', $ArrayUsuario["Usu_Usuario"]);
            Session::set('id_usuario', $ArrayUsuario["Usu_IdUsuario"]);
            Session::set('tiempo', time());

            $this->_view->assign('usuario', $Usu_Usuario);
            $this->_view->assign('params_usu', $rol);
        } else {

            if($this->_usuarios->verificarUsuario($Usu_Usuario)){
                $error = ' * El usuario <b style="font-size: 1.15em;">' . $Usu_Usuario . '</b> ya existe. ';
                $i = 1;
            }
            
            if($this->_usuarios->verificarEmail($Usu_Email)){
                if($i != 0) {
                    $error1 = '<br> * La direccion de correo <b style="font-size: 1.15em;">' . $Usu_Email . '</b> ya esta registrada. ';
                }else{
                    $error1 = ' * La direccion de correo <b style="font-size: 1.15em;">' . $Usu_Email . '</b> ya esta registrada. ';
                }
                $i = 2;
            }

            if($i == 0)
            {
                // $random = rand(1782598471, 9999999999);
                
                $idUsuario = $this->_usuarios->insertarUsuarioLogin(
                    $Usu_Nombre,
                    $Usu_Apellido,
                    $Usu_Usuario,
                    $Usu_Password,
                    $Usu_Email,
                    $rol, 3, $Usu_Codigo 
                );
                // echo "Codigo::".$Usu_Codigo;
                // print_r($idUsuario);
                // $mail = new PHPMailer();
        
                // $mail->isSMTP();
                // $mail->SMTPAuth = true;
                // $mail->SMTPSecure = 'tls';
                // $mail->Host = 'smtp.gmail.com';
                // $mail->Port = 587;
                
                // $mail->Username = 'jhonmartinez888@gmail.com'; //Correo de donde enviaremos los correos
                // $mail->Password = 'susanyjhon1234567890'; // Password de la cuenta de envío
                
                // $mail->setFrom('jhonmartinez888@gmail.com', 'Emisor');
                // $mail->addAddress('jmartinezcc@hotmail.es', 'Receptor'); //Correo receptor
                
                
                // $mail->Subject = 'Activar Cuenta PRIC';
                // $mail->Body    = 'Para activar su cuenta en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/activarCuenta/'.$idUsuario[0].'">'. BASE_URL .'usuarios/login/activarCuenta/'.$idUsuario[0].'</a>';
                // $mail->IsHTML(true);
                
                // if($mail->send()) {
                //     echo 'Correo Enviado';
                //     } else {
                //     echo 'Error al enviar correo';
                // }


                
            }
        
            if (is_array($idUsuario)) {
                if ($idUsuario[0] > 0) {
                    if ($TipoRegistro == 1) {
                        $this->_view->assign('_mensaje', 'Usuario <b style="font-size: 1.15em;">'.$this->getAlphaNum('usuario').'</b> registrado correctamente, activar su cuenta con su correo <b style="font-size: 1.15em;">'.$this->getSql('email').'</b>');

                        // $UsuarioLogeado = $this->_usuarios->getUsuario($idUsuario[0]);

                        // //Para que este Logeado
                        // Session::set('autenticado', true);
                        // // Session::set('level', $row['Rol_IdRol']);
                        // Session::set('usuario', $UsuarioLogeado["Usu_Usuario"]);
                        // Session::set('id_usuario', $UsuarioLogeado["Usu_IdUsuario"]);
                        // Session::set('tiempo', time());

                        // $mail = new PHPMailer();
                        // $mail->IsSMTP();
                        // // $mail->CharSet="UTF-8";
                        // // Activamos / Desactivamos el "debug" de SMTP 
                        // // 0 = Apagado 
                        // // 1 = Mensaje de Cliente 
                        // // 2 = Mensaje de Cliente y Servidor 
                        // $mail->SMTPDebug = 0;
                        // // Log del debug SMTP en formato HTML 
                        // $mail->Debugoutput = 'html';
                        // $mail->Host = 'smtp.gmail.com';
                        // $mail->SMTPAuth = true;
                        // $mail->Username = 'pruebanombrea@gmail.com';
                        // $mail->Password = '1357902468@pna';
                        // $mail->SMTPSecure = 'tls'; //tls or ssl
                        // $mail->Port = 587; //587 or 465

                        // $mail->Subject = 'Activar Cuenta PRIC';

                        // $mail->IsHTML(true);
                        // $mail->Body    = 'Para activar su cuenta en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/activarCuenta/'.$Usu_Codigo.'/'.$Usu_Email.'">'. BASE_URL .'usuarios/login/activarCuenta/'.$Usu_Codigo.'/'.$Usu_Email.'</a>';
                        
                        // $mail->SetFrom('jhonmartinez888@gmail.com', 'PRIC - Emisor');
                        // // $mail->FromName = 'Jhon Martinez - PRIC';
                        // $mail->AddAddress($Usu_Email, $Usu_Usuario);
                        // // $mail->AddReplyTo('phoenixd110@gmail.com', 'Information');
                        // // $mail->AltBody    = "AltBody - Poner tituloS";
                        // $mail->send();
                        // // if($mail->send()) {
                        // //     echo 'Correo Enviado';
                        // //     } else {
                        // //     echo 'Error al enviar correo' . $mail->ErrorInfo;
                        // // }

                        $Subject = 'Activar Cuenta PRIC';
                        $contenido = 'Para activar su cuenta en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/activarCuenta/'.$Usu_Codigo.'/'.$Usu_Email.'">'. BASE_URL .'usuarios/login/activarCuenta/'.$Usu_Codigo.'/'.$Usu_Email.'</a>';
                        $fromName = 'PRIC - Creación de Usuario';

                        // Parametro ($forEmail, $forName, $Subject, $contenido, $fromName = "Proyecto PRIC")
                        $Correo = new Correo();
                        $SendCorreo = $Correo->enviar($Usu_Email, $Usu_Usuario, $Subject, $contenido, $fromName);
                        // echo($SendCorreo);
                        // if($this->mail->send()) {
                        //     echo 'Correo Enviado';
                        //     } else {
                        //     echo 'Error al enviar correo' . $this->mail->ErrorInfo;
                        // }

                    } else {
                        $UsuarioLogeado = $this->_usuarios->getUsuario($idUsuario[0]);
                        //Para que este Logeado
                        Session::set('autenticado', true);
                        // Session::set('level', $row['Rol_IdRol']);
                        Session::set('usuario', $UsuarioLogeado["Usu_Usuario"]);
                        Session::set('id_usuario', $UsuarioLogeado["Usu_IdUsuario"]);
                        Session::set('tiempo', time());
                    }
                    
                        
                    $this->_view->assign('usuario', $Usu_Usuario);
                    $this->_view->assign('params_usu', $rol);


                    //Redirige a pagina principal
                    // $url_redirec = str_replace("*","/",$url_redirec);
                    // $this->redireccionar($url_redirec);
                } else {
                    $this->_view->assign('nombre', $Usu_Nombre);
                    $this->_view->assign('apellidos', $Usu_Apellido);
                    $this->_view->assign('usuario', $Usu_Usuario);
                    $this->_view->assign('email', $Usu_Email);
                    $this->_view->assign('modulo', $this->getSql('modulo'));

                    $this->_view->assign('_errorRegistrar', '* Error al registrar el Usuario');
                    $this->_view->renderizar('ajax/mensajeLoginError', false, true);
                }
            } else {
                if($i != 0)
                {

                    if ($TipoRegistro == 1) {

                        $this->_view->assign('nombre', $Usu_Nombre);
                        $this->_view->assign('apellidos', $Usu_Apellido);
                        $this->_view->assign('usuario', $Usu_Usuario);
                        $this->_view->assign('email', $Usu_Email);
                        $this->_view->assign('modulo', $this->getSql('modulo'));
                    } else {

                        $this->_view->assign('nombre', "");
                        $this->_view->assign('apellidos', "");
                        $this->_view->assign('usuario', "");
                        $this->_view->assign('email', "");
                        $this->_view->assign('modulo', "");
                    }

                    $this->_view->assign('_errorRegistrar', $error . $error1 );
                    $this->_view->renderizar('ajax/mensajeLoginError', false, true);
                }else{
                    $this->_view->assign('nombre', $Usu_Nombre);
                    $this->_view->assign('apellidos', $Usu_Apellido);
                    $this->_view->assign('usuario', $Usu_Usuario);
                    $this->_view->assign('email', $Usu_Email);
                    $this->_view->assign('modulo', $this->getSql('modulo'));

                    $this->_view->assign('_errorRegistrar', '* Ocurrio un error al Registrar los datos');
                    $this->_view->renderizar('ajax/mensajeLoginError', false, true);
                }            
            }    
        }

        $this->_view->renderizar('ajax/mensajeLogin', false, true);
    }

    public function cerrar() {
        $this->validarUrlIdioma();
        $this->_view->getLenguaje("index_inicio");

        Session::destroy();
        $this->redireccionar();
    }

    public function activarCuenta($Usu_Codigo = false, $Usu_Email = false){

        $this->_view->setTemplate(LAYOUT_FRONTEND);

        if(!$this->filtrarInt($Usu_Codigo)){            
            $this->_view->assign('_error', 'Error parametro ID ..!!');
            $this->_view->renderizar('index');
            exit;
        }  


        $ArrayUsuario = $this->_usuarios->verificarEmailCodigo($Usu_Email,$Usu_Codigo);

        $this->_usuarios->cambiarEstadoUsuario($ArrayUsuario["Usu_IdUsuario"], 3);

        // $UsuarioLogeado = $this->_usuarios->getUsuario($idUsuario);
        //Para que este Logeado
        Session::set('autenticado', true);
        // Session::set('level', $row['Rol_IdRol']);
        Session::set('usuario', $ArrayUsuario["Usu_Usuario"]);
        Session::set('id_usuario', $ArrayUsuario["Usu_IdUsuario"]);
        Session::set('tiempo', time());

        $this->_view->assign('usuario', $ArrayUsuario["Usu_Usuario"]);
        $this->_view->renderizar('activarCuenta', 'login');
    }

    public function recuperarPass($Usu_Codigo = false, $Usu_Email = false){

        // En php.ini
        // Habilitar las extensiones:   
        // Dynamic Extensions --> extension=php_openssl.dll
        // Module Settings--> extension=php_openssl.dll
        // Llamar al certificado:
        // [openssl] .->
        // openssl.cafile="C:\xampp\apache\bin\curl-ca-bundle.crt"

        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if ($this->botonPress('btn-cambiar-pass')) {
            $EditPass = $this->_usuarios->editarUsuarioClave($this->getSql('passwordCambiar'), $this->getSql('Usu_IdUsuario'));
            if ($EditPass > 0) {
                $this->_usuarios->recuperarPass($this->getSql('Usu_IdUsuario'),0);
                $this->_view->assign('modificado', 1);
                $this->_view->assign('_mensaje', 'Se modificó correctamente su contraseña.');
                $this->_view->renderizar('recuperarCuenta', 'login');
                // $this->redireccionar();
            } else {
                $this->_view->assign('_error', 'Error al modificar cantraseña intentelo nuevamente...!!');
                $this->_view->renderizar('recuperarCuenta', 'login');
            }
        }  else {
            if ($Usu_Codigo && $Usu_Email) {

                $ArrayUsuario = $this->_usuarios->verificarEmailCodigo($Usu_Email,$Usu_Codigo);
                if ($ArrayUsuario['Usu_RecuperarPass'] == 1) {
                    
                    $this->_view->assign('Usu_IdUsuario', $ArrayUsuario["Usu_IdUsuario"]);

                } else {
                    $this->_view->assign('_error', 'Error el link de modificar cantraseña ya fue utilizado, le recomendamos volver a solicitar cambio de contraseña...!!');
                }
                $this->_view->renderizar('recuperarCuenta', 'login');
            } else {
               
            
                $Usu_Email = $this->getSql('email');

                $Usuario = $this->_usuarios->verificarEmail($Usu_Email);
                // print_r($Usuario);
                // $mail = new PHPMailer();
                // $mail->IsSMTP();
                // // $mail->CharSet="UTF-8";
                // // Activamos / Desactivamos el "debug" de SMTP 
                // // 0 = Apagado 
                // // 1 = Mensaje de Cliente 
                // // 2 = Mensaje de Cliente y Servidor 
                // $mail->SMTPDebug = 0;

                // // Log del debug SMTP en formato HTML 
                // $mail->Debugoutput = 'html';

                // $mail->Host = 'smtp.gmail.com';

                // $mail->SMTPAuth = true;

                // $mail->Username = 'pruebanombrea@gmail.com';
                // $mail->Password = '1357902468@pna';

                // $mail->SMTPSecure = 'tls'; //tls or ssl

                // $mail->Port = 587; //587 or 465

                // // $mail->SMTPOptions = array(
                // // 'ssl' => array(
                // //     'verify_peer' => false,
                // //     'verify_peer_name' => false,
                // //     'allow_self_signed' => true
                // // ));

                // $mail->Subject = 'Resuperar Cuenta PRIC';

                // $mail->IsHTML(true);
                // $mail->Body    = 'Estimado usuario <b>'.$Usuario['Usu_Usuario'].'</b>, para cambiar su contraseña en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/recuperarPass/'.$Usuario['Usu_Codigo'].'/'.$Usuario['Usu_Email'].'">'. BASE_URL .'usuarios/login/recuperarPass/'.$Usuario['Usu_Codigo'].'/'.$Usuario['Usu_Email'].'</a>';
                // // $mail->Body    = 'Para activar su cuenta en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/activarCuenta/'.$idUsuario[0].'">'. BASE_URL .'usuarios/login/activarCuenta/'.$idUsuario[0].'</a>';
                

                // $mail->SetFrom('jhonmartinez888@gmail.com', 'PRIC - Emisor');
                // // $mail->FromName = 'Jhon Martinez - PRIC';
                // $mail->AddAddress($Usuario['Usu_Email'], $Usuario['Usu_Usuario']);
                // // $mail->AddReplyTo('phoenixd110@gmail.com', 'Information');

                $Subject = 'Recuperar Cuenta PRIC';
                $contenido = 'Estimado usuario <b>'.$Usuario['Usu_Usuario'].'</b>, para cambiar su contraseña en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/recuperarPass/'.$Usuario['Usu_Codigo'].'/'.$Usuario['Usu_Email'].'">'. BASE_URL .'usuarios/login/recuperarPass/'.$Usuario['Usu_Codigo'].'/'.$Usuario['Usu_Email'].'</a>';
                $fromName = 'PRIC - Recuperar Clave';

                // Parametro ($forEmail, $forName, $Subject, $contenido, $fromName = "Proyecto PRIC")
                $Correo = new Correo();
                $SendCorreo = $Correo->enviar($Usuario['Usu_Email'], $Usuario['Usu_Usuario'], $Subject, $contenido, $fromName);
                // echo($SendCorreo);

                if($SendCorreo) {
                    // echo 'Correo Enviado';
                    $this->_usuarios->recuperarPass($Usuario["Usu_IdUsuario"],1);
                } else {
                    // echo 'Error al enviar correo' . $mail->ErrorInfo;
                }

                // $mail->AltBody    = "AltBody - Poner tituloS";
                // $mail->send();

                $this->_view->assign('email', $Usuario['Usu_Email']);
                $this->_view->renderizar('ajax/divRecPass', false, true);
            }
            
        }     
    }
}

?>
