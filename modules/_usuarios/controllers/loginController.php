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
            if ($row['Usu_Estado'] != 1) {
                $this->_view->assign('_error', 'Este usuario no esta habilitado');
                Session::set('login_error', 'Este usuario no esta habilitado');
            } else {

                Session::set('autenticado', true);
                // Session::set('level', $row['Rol_IdRol']);
                Session::set('usuario', $row['Usu_Usuario']);
                Session::set('id_usuario', $row['Usu_IdUsuario']);
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
            $this->_view->assign('_errorLogin', 'El usuario no esta habilitado');
            Session::set('login_error', 'Este usuario no esta habilitado');
            $this->_view->renderizar('ajax/mensajeLoginError', false, true);
        } else {

            Session::set('autenticado', true);
            // Session::set('level', $row['Rol_IdRol']);
            Session::set('usuario', $row['Usu_Usuario']);
            Session::set('id_usuario', $row['Usu_IdUsuario']);
            Session::set('tiempo', time());

            // $this->redireccionar($url_redirec);
        }

        $this->_view->renderizar('ajax/mensajeLogin', false, true);
    }
    //Modificado JM
    public function registrarUsuarioLogin()
    {             
        $i = 0;
        $error = ""; $error1 = ""; $idUsuario = "";

        $this->_view->getLenguaje("template_frontend");
        $this->_view->getLenguaje("login_index");
        $url_redirec = $this->getSql("url");
        // $url_redirec = str_replace("*","/",$url_redirec);
        $this->_view->assign('url', $url_redirec);

        if($this->_usuarios->verificarUsuario($this->getSql('usuario'))){
            $error = ' * El usuario <b style="font-size: 1.15em;">' . $this->getAlphaNum('usuario') . '</b> ya existe. ';
            $i = 1;
        }
        
        if($this->_usuarios->verificarEmail($this->getSql('email'))){
            if($i != 0) {
                $error1 = '<br> * La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
            }else{
                $error1 = ' * La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
            }
            $i = 2;
        }

        if($i == 0)
        {
            // $random = rand(1782598471, 9999999999);
            $random = 9999999999;
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

            $idUsuario = $this->_usuarios->insertarUsuarioLogin(
                $this->getSql('nombre'),
                $this->getSql('apellidos'),
                $this->getAlphaNum('usuario'),
                $this->getSql('password'),
                $this->getSql('email'),
                $rol, 1, $random 
            );

        }
        
        if (is_array($idUsuario)) {
            if ($idUsuario[0] > 0) {
                $this->_view->assign('_mensaje', 'Usuario <b style="font-size: 1.15em;">'.$this->getAlphaNum('usuario').'</b> registrado correctamente...!!');

                $UsuarioLogeado = $this->_usuarios->getUsuario($idUsuario[0]);

                //Para que este Logeado
                Session::set('autenticado', true);
                // Session::set('level', $row['Rol_IdRol']);
                Session::set('usuario', $UsuarioLogeado["Usu_Usuario"]);
                Session::set('id_usuario', $UsuarioLogeado["Usu_IdUsuario"]);
                Session::set('tiempo', time());

                $this->_view->assign('usuario', $this->getAlphaNum('usuario'));
                $this->_view->assign('params_usu', $rol);
                //Redirige a pagina principal
                // $url_redirec = str_replace("*","/",$url_redirec);
                // $this->redireccionar($url_redirec);
            } else {
                $this->_view->assign('nombre', $this->getSql('nombre'));
                $this->_view->assign('apellidos', $this->getSql('apellidos'));
                $this->_view->assign('usuario', $this->getAlphaNum('usuario'));
                $this->_view->assign('email', $this->getSql('email'));
                $this->_view->assign('modulo', $this->getSql('modulo'));

                $this->_view->assign('_errorRegistrar', '* Error al registrar el Usuario');
                $this->_view->renderizar('ajax/mensajeLoginError', false, true);
            }
        } else {
            if($i != 0)
            {
                $this->_view->assign('nombre', $this->getSql('nombre'));
                $this->_view->assign('apellidos', $this->getSql('apellidos'));
                $this->_view->assign('usuario', $this->getAlphaNum('usuario'));
                $this->_view->assign('email', $this->getSql('email'));
                $this->_view->assign('modulo', $this->getSql('modulo'));


                $this->_view->assign('_errorRegistrar', $error . $error1 );
                $this->_view->renderizar('ajax/mensajeLoginError', false, true);
            }else{
                $this->_view->assign('nombre', $this->getSql('nombre'));
                $this->_view->assign('apellidos', $this->getSql('apellidos'));
                $this->_view->assign('usuario', $this->getAlphaNum('usuario'));
                $this->_view->assign('email', $this->getSql('email'));
                $this->_view->assign('modulo', $this->getSql('modulo'));


                $this->_view->assign('_errorRegistrar', '* Ocurrio un error al Registrar los datos');
                $this->_view->renderizar('ajax/mensajeLoginError', false, true);
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

    public function prueba(){
        $mail = new PHPMailer();
            $mail->IsSMTP();
            // $mail->CharSet="UTF-8";
            // Activamos / Desactivamos el "debug" de SMTP 
            // 0 = Apagado 
            // 1 = Mensaje de Cliente 
            // 2 = Mensaje de Cliente y Servidor 
            $mail->SMTPDebug = 0;

            // Log del debug SMTP en formato HTML 
            $mail->Debugoutput = 'html';

            $mail->Host = 'smtp.gmail.com';

            $mail->SMTPAuth = true;

            $mail->Username = 'pruebanombrea@gmail.com';
            $mail->Password = '1357902468@pna';

            $mail->SMTPSecure = 'tls'; //tls or ssl

            $mail->Port = 587; //587 or 465

            // $mail->SMTPOptions = array(
            // 'ssl' => array(
            //     'verify_peer' => false,
            //     'verify_peer_name' => false,
            //     'allow_self_signed' => true
            // ));

            $mail->Subject = 'Activar Cuenta PRIC';

            $mail->IsHTML(true);
            $mail->Body    = 'Para activar su cuenta en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/activarCuenta/1">'. BASE_URL .'usuarios/login/activarCuenta/1</a>';
            // $mail->Body    = 'Para activar su cuenta en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/activarCuenta/'.$idUsuario[0].'">'. BASE_URL .'usuarios/login/activarCuenta/'.$idUsuario[0].'</a>';
            

            $mail->SetFrom('jhonmartinez888@gmail.com', 'Jhon Martinez - Emisor');
            // $mail->FromName = 'Jhon Martinez - PRIC';
            $mail->AddAddress('jmartinezcc@hotmail.es','Jmartinez-Receptor');
            // $mail->AddReplyTo('phoenixd110@gmail.com', 'Information');



            // $mail->AltBody    = "AltBody - Poner tituloS";
           

            if($mail->send()) {
                echo 'Correo Enviado';
                } else {
                echo 'Error al enviar correo' . $mail->ErrorInfo;
            }

    }

}

?>
