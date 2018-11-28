<?php

class foroController extends Controller 
{
   

    public function __construct($lang, $url) 
    {
        parent::__construct($lang, $url);
    } 
    
    public function index() 
    {      
        
    }  
    
    protected function _permiso($iFor_IdForo, $clave_permiso) {
        $this->_model_index = $this->loadModel('index');
        if (Session::get('autenticado')) {
            $_rol = $this->_model_index->getRolForo(Session::get('id_usuario'), $iFor_IdForo);
            if ($this->_acl->rol($_rol["Rol_IdRol"])) {
                $_permiso_habiltado = $this->_acl->permiso($clave_permiso);
                $_permiso_deshabilitado = $this->_model_index->getPermisos_desh_Foro(Session::get('id_usuario'), $iFor_IdForo, $clave_permiso);
                if ($_permiso_habiltado && empty($_permiso_deshabilitado)) {
                    return true;
                } else {
                    return false;
                }
            }
        }
        return false;
    }   

}

?>
