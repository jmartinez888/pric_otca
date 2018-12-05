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

    protected function timediff($fecha_inicial,$idioma){

        $tiempo ="";
        $lenguajes_date=array(
            'es' => array(
                'un_momento' => "hace un momento",
                'minuto' => "hace #date minuto",
                'minutos' => "hace #date minutos",
                'hora' => "hace #date hora",
                'horas' => "hace #date horas",
                'dia' => "hace #date día",
                'dias' => "hace #date días",
                'mes' => "hace #date mes",
                'meses' => "hace #date meses"
                 ),
            'en' => array(
                'un_momento' => "just now",
                'minuto' => "#date minute ago",
                'minutos' => "#date minutes ago",
                'hora' => "#date hour ago",
                'horas' => "#date hours ago",
                'dia' => "#date day ago",
                'dias' => "#date days ago",
                'mes' => "#date month ago",
                'meses' => "#date months ago"
                 ),
           'pt' => array(
                'un_momento' => "agora mesmo",
                'minuto' => "há #date minuto",
                'minutos' => "#date minutos atrás",
                'hora' => "há #date hora",
                'horas' => "#date horas atras",
                'dia' => "#date dia atrás",
                'dias' => "há #date dias",
                'mes' => "#date mês atrás",
                'meses' => "#date meses atras"
                 )
         );

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
                            $tiempo = $lenguajes_date[$idioma]['un_momento'];
                        }else{
                            if($diferencia->i == 1){
                                $tiempo = str_replace('#date',$diferencia->i,$lenguajes_date[$idioma]['minuto']);
                            }else{
                                $tiempo = str_replace('#date',$diferencia->i,$lenguajes_date[$idioma]['minutos']);
                            }
                        }
                    }else{
                        if($diferencia->h == 1){
                            $tiempo = str_replace('#date',$diferencia->h,$lenguajes_date[$idioma]['hora']);
                        }else{
                            $tiempo = str_replace('#date',$diferencia->h,$lenguajes_date[$idioma]['horas']);
                        }
                    }
                }else{
                    if($diferencia->d == 1){
                        $tiempo = str_replace('#date',$diferencia->d,$lenguajes_date[$idioma]['dia']);
                    }else{
                        $tiempo = str_replace('#date',$diferencia->d,$lenguajes_date[$idioma]['dias']);
                    }
                }
            }else{
                if($diferencia->m == 1){
                    $tiempo = str_replace('#date',$diferencia->m,$lenguajes_date[$idioma]['mes']);
                }else{
                    $tiempo = str_replace('#date',$diferencia->m,$lenguajes_date[$idioma]['meses']);
                }
            }
            return $tiempo;
        }        
        return str_replace('-','.',$fecha_inicial);
    }   

    protected function  shortnumber($number,$precision=1){
        
        if ($number < 900) {
        // 0 - 900
        $n_format = number_format($number, $precision);
        $suffix = '';
        } else if ($number < 900000) {
            // 0.9k-850k
            $n_format = number_format($number / 1000, $precision);
            $suffix = 'K';
        } else if ($number < 900000000) {
            // 0.9m-850m
            $n_format = number_format($number / 1000000, $precision);
            $suffix = 'M';
        } else if ($number < 900000000000) {
            // 0.9b-850b
            $n_format = number_format($number / 1000000000, $precision);
            $suffix = 'B';
        } else {
            // 0.9t+
            $n_format = number_format($number / 1000000000000, $precision);
            $suffix = 'T';
        }
      // Remove unecessary zeroes after decimal. "1.0" -> "1"; "1.00" -> "1"
      // Intentionally does not affect partials, eg "1.50" -> "1.50"
        if ( $precision > 0 ) {
            $dotzero = '.' . str_repeat( '0', $precision );
            $n_format = str_replace( $dotzero, '', $n_format );
        }
        return $n_format . $suffix;
    }

}

?>
