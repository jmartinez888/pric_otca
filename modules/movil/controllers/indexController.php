<?php
class indexController extends movilController {
    private $_model;    
    public function __construct($lang, $url){
        parent::__construct($lang, $url);
        $this->_model = $this->loadModel('index');               
    }
    public function getContenidoLeccion($Lec_IdLeccion) {        
        $contenido_leccion = $this->_model->getContenidoLeccion($Lec_IdLeccion);
        $this->retornar($contenido_leccion,"contenido_leccion");                  
    }  
    public function getCursos() {                
        $cursos = $this->_model->getCursos();            
        $this->retornar($cursos,"cursos");                       
    }       
    public function getForos() {                
        $foros = $this->_model->getForos();            
        $this->retornar($foros,"foros");                  
    }
    public function getLecciones() {        
        $lecciones = $this->_model->getLecciones();
        $this->retornar($lecciones,"lecciones");                  
    }
    public function getModulos() {        
        $modulos_cursos = $this->_model->getModulos();
        $this->retornar($modulos_cursos,"modulos_cursos");                  
    }
    public function getUsuarioExistente($Usu_usuario,$Usu_DocumentoIdentidad) {        
        $usuario = $this->_model->getUsuarioPorUsuarioDni($Usu_usuario,$Usu_DocumentoIdentidad);
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
    public function getUsuario($Usu_IdUsuario) {                
        $usuario = $this->_model->getUsuarioPorId($Usu_IdUsuario);            
        $this->retornar($usuario,"usuarios");                       
    } 
    public function getUsuariosCursos($Usu_IdUsuario) {                
        $usuarios_cursos = $this->_model->getUsuariosCursos($Usu_IdUsuario);            
        $this->retornar($usuarios_cursos,"usuarios_cursos");                       
    }  
    public function iniciarSesion($Usu_usuario,$Usu_Password) {        
        $usuario = $this->_model->getUsuarioPorUsuarioPassword($Usu_usuario,$Usu_Password);
        $this->retornar($usuario,"usuario");                  
    }   
    public function insertarUsuario($Usu_Nombre,$Usu_Apellidos,$Usu_DocumentoIdentidad,$Usu_Usuario,$Usu_Password) {     
        $retorno = $this->_model->insertarUsuario($Usu_Nombre,$Usu_Apellidos,$Usu_DocumentoIdentidad,$Usu_Usuario,$Usu_Password);        
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
    public function insertarUsuarioGoogle($Usu_Usuario,$Usu_Password) {                              
        $Usu_IdUsuario = $this->_model->insertarUsuarioGoogle($Usu_Usuario,$Usu_Password);                                
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
                    'mensaje' => 'No se pudo registrar'
                )
            );
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
