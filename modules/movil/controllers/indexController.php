<?php
class  indexController extends movilController {
    private $_model;    
    public function __construct($lang, $url){
        parent::__construct($lang, $url);
        $this->_model = $this->loadModel('index');               
    }
     public function getCertificados($Usu_IdUsuario=0) {                
        $certificados = $this->_model->getCertificados($Usu_IdUsuario);            
        $this->retornar($certificados,"certificados");                       
    } 
    public function getContenidoLeccion($Lec_IdLeccion=0) {        
        $contenido_leccion = $this->_model->getContenidoLeccion($Lec_IdLeccion);
        $this->retornar($contenido_leccion,"contenido_leccion");                  
    }  
    public function getCursos($Usu_IdUsuario=0,$Con_Descripcion='',$Cur_Titulo='') {                
        $cursos = $this->_model->getCursos($Usu_IdUsuario,$Con_Descripcion,$Cur_Titulo);            
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
    public function getDocenteCurso($Cur_IdCurso=0){
        $usuarios = $this->_model->getDocenteCurso($Cur_IdCurso);            
        $this->retornar($usuarios,"usuarios");
    }
    public function getForos() {                
        $foros = $this->_model->getForos();            
        $this->retornar($foros,"foros");                  
    }
    public function getLecciones($Mod_IdModulo=0) {        
        $lecciones = $this->_model->getLecciones($Mod_IdModulo);
        $this->retornar($lecciones,"lecciones");                  
    }
    public function getCursosUsuario($Usu_IdUsuario=0,$Con_Descripcion='',$Cur_Titulo='') {                
        $cursos = $this->_model->getCursosUsuario($Usu_IdUsuario,$Con_Descripcion,$Cur_Titulo);            
        $this->retornar($cursos,"cursos");                       
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
    public function getUsuariosCursos($Usu_IdUsuario=0) {                
        $usuarios_cursos = $this->_model->getUsuariosCursos($Usu_IdUsuario);            
        $this->retornar($usuarios_cursos,"usuarios_cursos");                       
    }  
    public function getValoraciones($Cur_IdCurso=0) {                
        $valoraciones = $this->_model->getValoraciones($Cur_IdCurso);            
        $this->retornar($valoraciones,"valoraciones");                       
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
    public function insertarUsuario($Usu_Nombre='',$Usu_Apellidos='',$Usu_Email='',$Usu_Usuario='',$Usu_Password='') {     
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
}

?>
