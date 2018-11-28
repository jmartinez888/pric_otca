<?php
/**
 * Smarty plugin
 *
 * @package    Smarty
 * @subpackage PluginsFunction
 */

/**
 * Smarty {timediff} function plugin
 * Type:     function<br>
 * Name:     timediff<br>
 * Date:     Nov 27, 2018<br>
 * Purpose:  timediff devuelve diferencia de la fecha de publicacion tipo facebook<br>
 * Params:
 * <pre>
 * - date      - fecha commpleta 
 * - lang    - idioma (opcional) por defecto (es)
 * </pre>
 * Examples:<br>
 * <pre>
 * {timediff date='2017-08-23 08:50'} -> hace 2 meses
 * {timediff date='2017-08-23 08:50' lang='en'} -> 2 month ago
 * </pre>
 *
 * @link     no tiee {shortnumber}
 *           (Smarty online manual)
 * @author   Rodofo Cardenas i<viercavi@gmail.com>
 * @version  1
 *
 * @param array                    $params   parameters
 * @param Smarty_Internal_Template $template template object
 *
 * @return string
 */
function smarty_function_timediff($params, $template){

	 $fecha_inicial = $params['date'];
     if (!empty($params['idioma']))
        $idioma=$params['idioma'];
    else 
        $idioma='es';


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