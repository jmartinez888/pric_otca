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

    protected function getTiempo($fecha_inicial)
    {
        $tiempo ="";     
        $hora_servidor=getdate();
        $fechainicial = new DateTime($fecha_inicial);
        $fechafinal = new DateTime();
        $diferencia = $fechainicial->diff($fechafinal);
        $meses = ( $diferencia->y * 12 ) + $diferencia->m;
        if($diferencia->y < 1){
            if ($meses<1) {
                if ($diferencia->d < 1) {
                    if ($diferencia->h < 1) {
                        if($diferencia->i < 1){
                            $tiempo = " un momento ";
                        }else{
                            if($diferencia->i == 1){
                                $tiempo = $diferencia->i . " minuto ";
                            }else{
                                $tiempo = $diferencia->i . " minutos ";
                            }

                        }
                    }else{
                        if($diferencia->h == 1){
                            $tiempo = $diferencia->h . " hora ";
                        }else{
                            $tiempo = $diferencia->h . " horas ";
                        }
                    }
                }else{
                    if($diferencia->d == 1){
                        $tiempo = $diferencia->d . " día ";
                    }else{
                        $tiempo = $diferencia->d . " días ";
                    }
                }
            }else{
                if($diferencia->m == 1){
                    $tiempo = $diferencia->m . " mes ";
                }else{
                    $tiempo = $diferencia->m . " meses ";
                }
            }
        }else{
            if($diferencia->y == 1){
                    $tiempo = $diferencia->y . " año ";
            }else{
                $tiempo = $diferencia->y . " años ";
            }
        }
        return $tiempo;
    }
    

}

?>
