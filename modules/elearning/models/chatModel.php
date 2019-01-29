<?php

class chatModel extends Model {

    public function __construct() { parent::__construct(); }

    public function registrarMensajeConSession($usuario, $curso, $leccion, $mensaje, $session_id){
        $sql = "INSERT INTO mensaje(Usu_IdUsuario, Cur_IdCurso, Lec_IdLeccion, Men_Descripcion, Les_IdLeccSess)
                VALUES({$usuario}, {$curso}, {$leccion}, '{$mensaje}', '{$session_id}')";
        $this->execQuery($sql);
    }

    public function registrarMensaje($usuario, $curso, $leccion, $mensaje){
        $sql = "INSERT INTO mensaje(Usu_IdUsuario, Cur_IdCurso, Lec_IdLeccion, Men_Descripcion)
                VALUES({$usuario}, {$curso}, {$leccion}, '{$mensaje}')";
        $this->execQuery($sql);
    }

    public function ListarChat($curso, $leccion, $leccion_session = false){
      $sql = "SELECT * FROM
              (SELECT M.*, 
                U.Usu_Usuario,
                U.Usu_Nombre,
                U.Usu_Apellidos 
              FROM mensaje M
              INNER JOIN usuario U ON U.Usu_IdUsuario = M.Usu_IdUsuario
              WHERE M.Cur_IdCurso = {$curso} 
              AND M.Lec_IdLeccion = {$leccion}
              AND M.Row_Estado = 1";
      if ($leccion_session)
        $sql .= " AND M.Les_IdLeccSess = {$leccion_session}";
      $sql .= " ORDER BY Men_Fecha DESC
              LIMIT 200)X
              ORDER BY X.Men_Fecha ASC";
      return $this->getArray($sql);
    }

    public function ListarChat2($usuario, $curso, $leccion, $i1, $i2){
      $sql = "SELECT
                X.ID,
                (CASE WHEN X.ID1 = {$usuario} THEN 1 ELSE 2 END) as CONDICION,
                X.NOMBRE as NOMBRE1,
                '' as NOMBRE2,
                X.MENSAJE,
                0 as VISTO,
                (CASE WHEN DATE(X.FECHA) < DATE(NOW()) THEN DATE(X.FECHA) ELSE SUBSTRING(X.FECHA, 12, 5) END) as FECHA
              FROM
              (SELECT
                  M.Men_IdMensaje as ID,
                  U.Usu_IdUsuario as ID1,
                  M.Men_Descripcion as MENSAJE,
                  M.Men_Fecha as FECHA,
                  CONCAT(U.Usu_Nombre, ' ', U.Usu_Apellidos) as NOMBRE
              FROM mensaje M
              INNER JOIN usuario U ON U.Usu_IdUsuario = M.Usu_IdUsuario
              WHERE M.Cur_IdCurso = {$curso} AND M.Lec_IdLeccion = {$leccion}
                AND M.Row_Estado = 1
              ORDER BY Men_Fecha DESC
              LIMIT {$i1}, {$i2})X
              ORDER BY X.FECHA ASC";
      return $this->getArray($sql);
    }
}
