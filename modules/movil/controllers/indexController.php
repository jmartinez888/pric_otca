<?php
class  indexController extends movilController {
    private $_model;    
    public function __construct($lang, $url){
        parent::__construct($lang, $url);
        $this->_model = $this->loadModel('index');               
    }
    public function contenido($Lec_IdLeccion=0){
        $html = $this->_model->getContenido($Lec_IdLeccion);
            $this->_view->assign("cont_html", $html);
        $this->_view->setTemplate(LAYOUT_FRONTEND);
        $this->_view->setCss(array('modulo', 'jp-modulo'));
        $this->_view->setJs(array(//array(BASE_URL . 'modules/elearning/views/gestion/js/core/util.js'),
        'modulo'));
        $this->_view->renderizar('ajax/contenido', false, true);
    }
    public function getCertificados($Usu_IdUsuario=0) {                
        $certificados = $this->_model->getCertificados($Usu_IdUsuario);            
        $this->retornar($certificados,"certificados");                       
    } 
    public function getContenidoLeccion($Lec_IdLeccion=0) {        
        $contenido_leccion = $this->_model->getContenido($Lec_IdLeccion);
        $this->retornar($contenido_leccion,"contenido_leccion");                  
    }  
    public function getCursos($_tipo_curso=0,$Usu_IdUsuario=0,$busqueda="",
        $_mis_cursos=0) { 
        $condicion = " WHERE cr.Cur_Estado = 1 AND cr.Row_Estado = 1";
        $busqueda = str_replace('_',' ',$busqueda); 
        if($busqueda != "" && $busqueda != "xxx"){
            $condicion .= " AND cr.Cur_Titulo LIKE '%" . $busqueda . "%' AND cr.Cur_Descripcion LIKE '%" . $busqueda . "%' ";
        } 
        if ($_mis_cursos == 1) {
            $condicion .= " AND mt.Usu_IdUsuario = " . $Usu_IdUsuario;
        }
        if ($_tipo_curso > 0 && $_tipo_curso != 3) {
              $condicion .= " AND cr.Moa_IdModalidad =  $_tipo_curso";
        }
        $condicion .= " GROUP BY cr.Cur_IdCurso ";
        $cursos = $this->_model->getCursosPaginado(0,CANT_REG_PAG,$condicion,$Usu_IdUsuario);           
        $this->retornar($cursos,"cursos");                       
    }       
    public function getCursoDetalle($Cur_IdCurso=0) {                
        $curso_detalles = $this->_model->getCursoDetalle($Cur_IdCurso);            
        $this->retornar($curso_detalles,"cursoDetalle");                       
    }
    public function getCursosDocente($Usu_IdUsuario=0,$Cur_IdCurso='') {                
        $cursos = $this->_model->getCursosDocente($Usu_IdUsuario,$Cur_IdCurso);            
        $this->retornar($cursos,"cursos"); 
    }
    public function getCursosUsuario($Usu_IdUsuario=0,$Con_Descripcion='',$Cur_Titulo='') {                
        $cursos = $this->_model->getCursosUsuario($Usu_IdUsuario,$Con_Descripcion,$Cur_Titulo);            
        $this->retornar($cursos,"cursos");                       
    }                        
    public function getDocenteCurso($Cur_IdCurso=0){
        $usuarios = $this->_model->getDocenteCurso($Cur_IdCurso);            
        $this->retornar($usuarios,"usuarios");
    }
    public function getForos() {                
        $foros = $this->_model->getForos();            
        $this->retornar($foros,"foros");                  
    }
     public function getLecciones($Mod_IdModulo=0,$Usu_IdUsuario=0) {        
        $lecciones = $this->_model->getLecciones($Mod_IdModulo,$Usu_IdUsuario);
        $this->retornar($lecciones,"lecciones");                  
    }
    public function getMateriales($Lec_IdLeccion=0) {        
        $materiales_leccion = $this->_model->getMateriales($Lec_IdLeccion);
        $this->retornar($materiales_leccion,"materiales_leccion");                  
    }
    public function getModulos($Cur_IdCurso=0,$Usu_IdUsuario=0) {        
        $modulos_curso = $this->_model->getModulos($Cur_IdCurso,$Usu_IdUsuario);
        $this->retornar($modulos_curso,"modulos_curso");                  
    }
    public function getProgresoCurso($Cur_IdCurso=0,$Usu_IdUsuario=0) {                
        $progreso = $this->_model->getProgresoCurso($Cur_IdCurso, $Usu_IdUsuario);            
        $this->retornar($progreso,"progreso");                       
    } 
    public function getUsuarioExistente($Usu_usuario='',$Usu_Email='') {        
        $usuario = $this->_model->getUsuarioExistente($Usu_usuario,$Usu_Email);
        if ($usuario) {
            print json_encode(
                array(
                    'estado' => 1,
                    'mensaje' => 'Usuario ya existe'
                )
            );
        } else {            
            print json_encode(
                array(
                    'estado' => 2,
                    'mensaje' => 'No existe usuario'
                )
            );
        }
    }
    public function getUsuario($Usu_IdUsuario=0) {                
        $usuarios = $this->_model->getUsuarioPorId($Usu_IdUsuario);            
        $this->retornar($usuarios,"usuarios");                       
    } 
     public function getTiempo($fecha_inicial){
        $tiempo ="";
        $hora_servidor = $this->_model->getHora_Servidor();
        $fechainicial = new DateTime($fecha_inicial);
    
        $fechafinal = new DateTime($hora_servidor["hora_servidor"]);
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
    public function getUsuariosCursos($Usu_IdUsuario=0) {                
        $usuarios_cursos = $this->_model->getUsuariosCursos($Usu_IdUsuario);            
        $this->retornar($usuarios_cursos,"usuarios_cursos");                       
    }  
    public function getValoraciones($Cur_IdCurso=0) {                
        $valoraciones = $this->_model->getValoraciones($Cur_IdCurso); 
        if ($valoraciones) {
            $nuevasValoraciones=array(); 
            foreach ($valoraciones as $clave=>$valor) {           
                $Tiempo=$this->getTiempo($valor[3]);
                $reemplazo=array(3=>"$Tiempo", "Val_FechaReg"=>"$Tiempo");
                array_push($nuevasValoraciones, array_replace($valor, $reemplazo));
            }
            $datos["estado"] = 1;
            $datos["valoraciones"] = $nuevasValoraciones;
            print json_encode($datos);
        } else {
            print json_encode(
                array(
                "estado" => 2,
                "mensaje" => "No hay valoraciones"
            ));
        }                      
    } 
    public function iniciarSesion($Usu_usuario=0,$Usu_Password=0) {        
        $usuario = $this->_model->getUsuarioPorUsuarioPassword($Usu_usuario,$Usu_Password);
        $this->retornar($usuario,"usuario");                  
    }   
    public function insertarInscripcion($Usu_IdUsuario=0,$Cur_IdCurso=0) {     
        $retorno = $this->_model->insertarInscripcion($Usu_IdUsuario,$Cur_IdCurso);        
        if ($retorno) {
            print json_encode(
                    array(
                        'estado' => 1,
                        'mensaje' => '¡Gracias por inscribirte!'
                    )
                );
        }else{            
            print json_encode(
                array(
                    'estado' => 2,
                    'mensaje' => 'Hubo un error al inscribir'
                )
            );
        }
    }  
    public function insertarUsuario__($Usu_Nombre='',$Usu_Apellidos='',$Usu_Email='',$Usu_Usuario='',$Usu_Password='') {     
        $retorno = $this->_model->insertarUsuario($Usu_Nombre,$Usu_Apellidos,$Usu_Email,$Usu_Usuario,$Usu_Password);        
        if ($retorno) {
            print json_encode(
                    array(
                        'estado' => 1,
                        'mensaje' => 'Usuario registrado'
                    )
                );
        }else{            
            print json_encode(
                array(
                    'estado' => 2,
                    'mensaje' => 'No se pudo registrar'
                )
            );
        }
    }  
    public function insertarValoracion() { 
        $body=json_decode(file_get_contents("php://input"),true);
        $Cur_IdCurso=$body['Cur_IdCurso'];
        $Usu_IdUsuario=$body['Usu_IdUsuario'];
        $Val_Comentario=$body['Val_Comentario'];
        $Val_Valor=$body['Val_Valor'];
        $retorno = $this->_model->insertarValoracion($Cur_IdCurso,$Usu_IdUsuario,$Val_Comentario,$Val_Valor);        
        if ($retorno) {
            print json_encode(
                    array(
                        'estado' => 1,
                        'mensaje' => '¡Gracias!'
                    )
                );
        }else{            
            print json_encode(
                array(
                    'estado' => 2,
                    'mensaje' => 'No se pudo calificar'
                )
            );
        }
    }
    public function iniciarSesionGoogle($Usu_Email) {                   
        $usuario = $this->_model->getUsuarioPorEmail($Usu_Email);
        if ($usuario) {
            $datos["estado"] = 1;
            $datos["usuario"] = $usuario;
            print json_encode($datos);
        }else{
            $Usu_IdUsuario = $this->_model->insertarUsuarioGoogle($Usu_Email);                                
            if ($Usu_IdUsuario) {               
                $usuario = $this->_model->getUsuarioPorId($Usu_IdUsuario[0]);                        
                if ($usuario) {
                    $datos["estado"] = 1;
                    $datos["usuario"] = $usuario;
                     print json_encode($datos);            
                } else {            
                    print json_encode(
                        array(
                        'estado' => 2,
                        'mensaje' => 'No se pudo obtener ultimo registro'
                        )
                    );
                }
            }else{            
                print json_encode(
                    array(
                    'estado' => 3,
                    'mensaje' => 'No se pudo ingresar'
                    )
                );
            }
        }         
    } 
    public function retornar($arreglo,$nombre){        
        if ($arreglo) {
            $datos["estado"] = 1;
            $datos[$nombre] = $arreglo;
            print json_encode($datos);
        } else {
            print json_encode(
                array(
                "estado" => 2,
                "mensaje" => "No hay ".$nombre
            ));
        } 
    }


    
    //Jhon Martinez
    public function cursos(){

          // $mConstante = $this->loadModel("constante");
          $_tipo_curso = $this->getInt('_tipo_curso');
          $_mis_cursos = $this->getInt('_mis_cursos');
          $busqueda = $this->getTexto("busqueda");
          $pagina = $this->getInt('pagina');
          
          $busqueda = $this->filtrarTexto($busqueda);
          if (Session::get("autenticado")) {
              $Usu_IdUsuario = Session::get("id_usuario");
          } else {
              $Usu_IdUsuario = false;
          }
          //Filtro por Activos/Eliminados
          $condicion = " WHERE mt.Mat_Valor = 1 AND cr.Cur_Estado = 1 ";
          $soloActivos = 0;
          if (!$this->_acl->permiso('ver_eliminados')) {
              $soloActivos = 1; 
              $condicion .= " AND cr.Row_Estado = $soloActivos ";
          }
          //Filtro por Activos/Eliminados
          
          // $condicion = "";
          if($busqueda != ""){
              $condicion .= " AND cr.Cur_Titulo LIKE '%" . $busqueda . "%' AND cr.Cur_Descripcion LIKE '%" . $busqueda . "%' ";
          } 
          if ($_mis_cursos == 1) {
              $condicion .= " AND mt.Usu_IdUsuario = " . Session::get("id_usuario");
          }
          if ($_mis_cursos == 2) {
              $condicion .= " AND cr.Usu_IdUsuario = " . Session::get("id_usuario");
          }
          
          if ($_tipo_curso > 0) {
              $condicion .= " AND cr.Moa_IdModalidad =  $_tipo_curso";
          }
          
          if ($soloActivos == 0) { 
              $condicion .= " GROUP BY cr.Cur_IdCurso ORDER BY cr.Row_Estado DESC ";
          } else {
              $condicion .= " GROUP BY cr.Cur_IdCurso ";
          }

          $arrayRowCount = $this->_model->getCursosRowCount($condicion);
          $totalRegistros = $arrayRowCount['CantidadRegistros'];
          $cursos = $this->_model->getCursosPaginado(0,CANT_REG_PAG,$condicion,$Usu_IdUsuario);
    }
      
    //Jhon Martinez
    public function insertarUsuario($Usu_Nombre='',$Usu_Apellidos='',$Usu_Email='',$Usu_Usuario='',$Usu_Password='') {     
        $i=0;
        $error = ""; $error1 = ""; $idUsuario = "";
        if($this->_model->verificarUsuario($Usu_Usuario)){
            $error = ' El usuario ' . $Usu_Usuario . ' ya existe. ';
            $i=1;
        }
        
        if($this->_model->verificarEmail($Usu_Email)){
            $error1 = ' La direccion de correo ' . $Usu_Email . ' ya esta registrada. ';
            $i=2;
        }

        if($i==0)
        {
            $Usu_Codigo = rand((int)(1782598471), (int)(9999999999));
            $idUsuario = $this->_model->insertarUsuario(
                $Usu_Nombre,
                $Usu_Apellidos,
                $Usu_Email,
                $Usu_Usuario,
                $Usu_Password,
                $Usu_Codigo
            );
        }
        
        if (is_array($idUsuario)) {
            if ($idUsuario[0] > 0) {

                $Subject = 'Activar Cuenta PRIC';
                $contenido = 'Para activar su cuenta en la PRIC hacer click en el siguiente enlace: <br><a href="'. BASE_URL .'usuarios/login/activarCuenta/'.$Usu_Codigo.'/'.$Usu_Email.'">'. BASE_URL .'usuarios/login/activarCuenta/'.$Usu_Codigo.'/'.$Usu_Email.'</a>';
                $fromName = 'PRIC - Creación de Usuario';

                // Parametro ($forEmail, $forName, $Subject, $contenido, $fromName = "Proyecto PRIC")
                $Correo = new Correo();
                $SendCorreo = $Correo->enviar($Usu_Email, $Usu_Usuario, $Subject, $contenido, $fromName);
                $Usuario = $this->_model->verificarUsuario($Usu_Usuario);
                print json_encode(
                    array(
                            "estado" => 1,
                            "mensaje" => " Usuario registrado correctamente, activar su cuenta con su correo.  ", 
                            "Usuario" => $Usuario));
            } else {
                print json_encode(
                    array(
                    "estado" => 2,
                    "mensaje" => " Error al registrar el Usuario "
                ));
            }
        } else {
            if($i!=0)
            {
                print json_encode(
                    array(
                    "estado" => 2,
                    "mensaje" => $error . $error1
                ));
            }else{
                print json_encode(
                    array(
                    "estado" => 2,
                    "mensaje" => " Ocurrio un error al Registrar los datos"
                ));
            }            
        }      
    }  
}

?>
