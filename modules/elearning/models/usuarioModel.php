<?php

class usuarioModel extends Model {

    public function __construct() { parent::__construct(); }

    public function updatePerfil($id, $institucion, $cargo, $grado, $especialidad, $perfil){
        $sql = "UPDATE usuario SET
                    Usu_InstitucionLaboral = '{$institucion}',
                    Usu_Cargo = '{$cargo}',
                    Usu_GradoAcademico = '{$grado}',
                    Usu_Especialidad = '{$especialidad}',
                    Usu_Perfil = '{$perfil}'
                WHERE Usu_IdUsuario = {$id}";
        $this->execQuery($sql);
    }

    public function updateImgUsuario($id, $img){
        $sql = "UPDATE usuario SET
                    Usu_URLImage = '{$img}'
                WHERE Usu_IdUsuario = {$id}";
        $this->execQuery($sql);
    }

    public function getUsuarioXId($id){
        $sql = "SELECT * FROM usuario 
                WHERE Usu_IdUsuario = {$id}
                    AND Usu_Estado = 1 AND Row_Estado = 1";
    	return $this->getArray($sql);
    }
}