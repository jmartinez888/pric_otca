<?php

class chatModel extends Model {

    public function __construct() { parent::__construct(); }

    public function registrarMensaje($usuario, $curso, $leccion, $mensaje){
        $sql = "INSERT INTO mensaje(Usu_IdUsuario, Cur_IdCurso, Lec_IdLeccion, Men_Descripcion)
                VALUES({$usuario}, {$curso}, {$leccion}, '{$mensaje}')";
        $this->execQuery($sql);
    }

    public function ListarChat($curso, $leccion){
      $sql = "SELECT * FROM
              (SELECT M.*, U.Usu_Usuario FROM mensaje M
              INNER JOIN usuario U ON U.Usu_IdUsuario = M.Usu_IdUsuario
              WHERE M.Cur_IdCurso = {$curso} AND M.Lec_IdLeccion = {$leccion}
                AND M.Row_Estado = 1
              ORDER BY Men_Fecha DESC
              LIMIT 200)X
              ORDER BY X.Men_Fecha ASC";
      return $this->getArray($sql);
    }
}
