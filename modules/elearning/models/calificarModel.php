<?php

class calificarModel extends Model {

    public function __construct() { parent::__construct(); }

    public function insertCalificacion($usuario, $curso, $calificacion, $comentario){
        $sql = "INSERT INTO valoracion_curso(Cur_IdCurso, Usu_IdUsuario, Val_Valor, Val_Comentario)
                VALUES({$usuario}, {$curso}, {$calificacion}, '{$comentario}')";
        $this->execQuery($sql);
    }


    public function getCalificacion($curso){
        $sql = "SELECT v.*, u.Usu_Usuario FROM valoracion_curso v 
        		INNER JOIN usuario u ON u.Usu_IdUsuario = v.Usu_IdUsuario
        		WHERE v.Cur_IdCurso = {$curso} ";
        return $this->getArray($sql);
    }
}
