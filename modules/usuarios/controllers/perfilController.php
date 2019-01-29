<?php

class perfilController extends usuariosController {

    private $_perfil;

    public function __construct($lang, $url) {
        parent::__construct($lang, $url);
        $this->_perfil = $this->loadModel('perfil');
        //$this->_usuarios = $this->loadModel('index'); RODRIGO COMENTÓ ESTO
        $this->_usuarios = $this->loadModel('usuario');
    }

    public function index($idUsuario = false) {
        // $this->_acl->acceso('ver_perfil');
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        if (Session::get('id_usuario')!=$idUsuario){            
            $this->_acl->acceso('editar_usuario');
        }
        $this->_view->assign('titulo', 'Perfil');
        $this->_view->getLenguaje("index_inicio");
        $this->_view->getLenguaje("template_backend");        
        $this->_view->getLenguaje("usuarios_perfil");

        $this->_view->setJs(array('perfil'));
        $this->_view->setCss(array('perfil'));
        //echo $idUsuario;
        $usuario = $this->_perfil->getUsuario($idUsuario);
        // $this->_view->assign('rolesUsuario', $this->_usuarios->getRolesxUsuario($idUsuario));
       // print_r($usuario);


        // $id = Session::get("id_usuario");
        // $busqueda = $this->getTexto('busqueda');
        $busqueda = "";
        // $cursos = $this->curso->getCursoXDocente($id, $busqueda);
        $cursos = $this->_perfil->getMisCursos($idUsuario, $busqueda);

        //print_r($cursos); exit;
        // $this->_view->setCss(array("jm-mis-cursos"));
        // Session::set("learn_url_tmp", "gcurso/_view_mis_cursos");
        $this->_view->getLenguaje("learn");
        $this->_view->assign('cursos', $cursos);
        // $this->_view->assign('busqueda', $busqueda);
        // $this->_view->assign('curso', $this->getTexto("id"));
        // $this->_view->renderizar('ajax/_view_mis_cursos', false, true);
          
          
       // echo $usuario;                exit;
        $this->_view->assign('usuario', $usuario);
        
        $this->_view->renderizar('index','perfil');
    }
    
    public function editarPerfil($usuarioID=0) {
        // $this->_acl->acceso('editar_perfil');
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("index_inicio");
        $this->_view->getLenguaje("template_backend");
        $this->_view->getLenguaje("usuarios_perfil");
//          $this->_acl->acceso('admin');
        //$this->_view->setJs(array('index'));
        $this->_view->setCss(array('perfil'));
        ///$this->_view->setTemplate(LAYOUT_FRONTEND);
        $id = $this->filtrarInt($usuarioID);
        if (Session::get('id_usuario')!=$id){            
            $this->_acl->acceso('editar_usuario');
        }
        $condicion='';
        if ($this->botonPress("bt_guardarUsuario")) {
            $i = $this->editarUsuario($id);
            if($i==0){
                $this->redireccionar('usuarios/perfil/index/'.$id);
            }
        }
        $usu = $this->_usuarios->getUsuario($id);       
        
        $this->_view->assign('titulo', 'Editar Usuario');        
        $this->_view->assign('idusuario', $id);
        $this->_view->assign('datos', $usu);
        $this->_view->renderizar('editarPerfil');        
    }
    
    public function editarContrasena($usuarioID=0) {
       if (Session::get('id_usuario')!=$usuarioID){            
            $this->_acl->acceso('editar_usuario');
        }
        $this->validarUrlIdioma();
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->getLenguaje("index_inicio");
        $this->_view->getLenguaje("template_backend");
        $this->_view->getLenguaje("usuarios_perfil");
        //$this->_acl->acceso('admin');
        //$this->_view->setJs(array('index'));
        $this->_view->setCss(array('perfil'));
        ///$this->_view->setTemplate(LAYOUT_FRONTEND);
        $id = $this->filtrarInt($usuarioID);
        $condicion='';
        if ($this->botonPress("bt_guardarContrasena")) {
            //$i = $this->editarUsuario($id);
            $usuario = $this->_perfil->getUsuarioPass($id, $this->getSql('contrasena'));
            //print_r($usuario);exit;
            if($usuario[0] > 0 ){
                $idUsuario = $this->_usuarios->editarUsuarioClave(
                    $this->getSql('nuevaContrasena'),
                    $this->getInt('idusuario')
                );

                if ($idUsuario >0) {
                    $this->_view->assign('_mensaje', 'Contraseña cambiado correctamente...!!');
                } else {
                    $this->_view->assign('_error', 'Error al editar el Contraseña');
                }
                $this->redireccionar('usuarios/perfil/index/'.$id);
            }
        }
        
        
        $usu = $this->_usuarios->getUsuario($id);       
        
        $this->_view->assign('titulo', 'Editar Contraseña');        
        $this->_view->assign('idusuario', $id);
        $this->_view->assign('datos', $usu);
        $this->_view->renderizar('editarContrasena');        
    }
    
    public function editarUsuario()
    {   
        $i=0;
        $error = ""; $error1 = ""; 
        $usu = $this->_usuarios->verificarUsuario($this->getSql('usuario'));
        if($usu['Usu_IdUsuario']!=$this->getInt('idusuario')){
            $error = ' El usuario <b style="font-size: 1.15em;">' . $this->getSql('usuario') . '</b> ya existe. ';
            $i=1;
        }
        
        $usuEmail = $this->_usuarios->verificarEmail($this->getSql('email'));
        if($usuEmail['Usu_IdUsuario'] != $this->getInt('idusuario')){
            if($i!=0) {
                $error1 = '<br> La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
            } else {
                $error1 = ' La direccion de correo <b style="font-size: 1.15em;">' . $this->getSql('email') . '</b> ya esta registrada. ';
            }
            $i=2;
        }
        
        if($i==0){     
            $idUsuario = $this->_perfil->editarUsuarioPerfil(
                $this->getSql('nombre'),
                $this->getSql('apellidos'),
                $this->getSql('dni'),
                $this->getSql('direccion'),
                $this->getSql('telefono'),
                $this->getSql('institucion'),
                $this->getSql('cargo'),
                $usu['Usu_Usuario'],
                $this->getSql('email'),
                $this->getInt('idusuario')
            );
            if ($idUsuario) {
                $this->_view->assign('_mensaje', 'Usuario <b style="font-size: 1.15em;">'.$this->getSql('usuario').'</b> editado..!!');
            } else {                
                $this->_view->assign('_error', 'Error al editar el Usuario <b style="font-size: 1.15em;">' . $this->getSql('usuario') . '</b>. ');
            }
        }  else {
            $this->_view->assign('_error', $error.$error1);
        }
        return $i;
    }
}

?>