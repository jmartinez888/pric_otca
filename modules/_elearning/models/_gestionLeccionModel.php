<?php

class _gestionLeccionModel extends Model {

  public function __construct() { parent::__construct(); }

  public function insertLeccion($modulo, $tipo, $titulo, $descripcion){
    $sql = "INSERT INTO Leccion(Mod_IdModulo, Lec_Tipo, Lec_Titulo, Lec_Descripcion, Lec_LMSEstado, Lec_Estado)
            VALUES({$modulo}, {$tipo}, '{$titulo}', '{$descripcion}', 0, 0)";
    $this->execQuery($sql);
  }

  public function getTipoLecccion($lms = ""){
    $sql = "SELECT
              C.Con_Valor as Id,
              C.Con_Descripcion as Titulo,
              (SELECT Con_Descripcion FROM Constante WHERE Con_Codigo = 4000 AND Con_Valor = C.Con_Valor) as Descripcion
            FROM Constante C
            WHERE C.Con_Codigo = 2000 AND c.Con_Codigo <> C.Con_Valor";
    if($lms == ""){
      $sql .= " AND C.Con_Valor NOT IN (4, 5)";
    }
    return $this->getArray($sql);
  }

  public function getLecciones($modulo){
    $sql = "SELECT L.*,
              C.Con_Descripcion as Tipo
            FROM Leccion L
            INNER JOIN Constante C ON C.Con_Valor = L.Lec_Tipo AND C.Con_Codigo = 2000
            WHERE L.Mod_IdModulo = {$modulo}
              AND L.Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function getLeccionId($leccion){
    $sql = "SELECT L.*,
              C.Con_Descripcion as Tipo
            FROM Leccion L
            INNER JOIN Constante C ON C.Con_Valor = L.Lec_Tipo AND C.Con_Codigo = 2000
            WHERE L.Lec_IdLeccion = {$leccion}
              AND L.Row_Estado = 1";
    return $this->getArray($sql)[0];
  }

  public function updateEstadoLeccion($leccion, $estado){
    $this->execQuery("UPDATE Leccion SET Lec_Estado = '$estado' WHERE Lec_IdLeccion = $leccion");
  }

  public function deleteLeccion($leccion){
    $this->execQuery("UPDATE Leccion SET Row_Estado = 0 WHERE Lec_IdLeccion = $leccion");
  }

  public function deleteReferencia($ref){
    $this->execQuery("UPDATE Referencia_Leccion SET Row_Estado = 0 WHERE Ref_IdReferencia = $ref");
  }

  public function insertContenido($leccion, $titulo, $contenido){
    $sql = "INSERT INTO Contenido_Leccion(Lec_IdLeccion, CL_Titulo, CL_Descripcion, CL_Estado)
            VALUES({$leccion}, '{$titulo}', '{$contenido}', 1)";
    $this->execQuery($sql);
  }

  public function insertReferencia($leccion, $titulo, $descripcion){
    $sql = "INSERT INTO Referencia_Leccion(Lec_IdLeccion, Ref_Titulo, Ref_Descripcion, Ref_Estado)
            VALUES({$leccion}, '{$titulo}', '{$descripcion}', 1)";
    $this->execQuery($sql);
  }

  public function getReferenciaLeccion($leccion){
    $sql = "SELECT * FROM Referencia_Leccion WHERE Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    return $this->getArray($sql);
  }


  public function getContenidoLeccion($leccion){
    $sql = "SELECT * FROM Contenido_Leccion WHERE Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    return $this->getArray($sql);
  }
}
