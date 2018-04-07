<?php

class _gestionCursoModel extends Model {

    public function __construct() { parent::__construct(); }

    public function validarDocenteCurso($curso, $usuario){
      $sql = "SELECT * FROM Curso WHERE Cur_IdCurso = {$curso} AND Usu_IdUsuario = {$usuario}";
      $result = $this->getArray($sql);

      if($result!=null && count($result)>0){
        return true;
      }else{
        return false;
      }
    }

    public function getMatriculados($curso){
      $sql = "SELECT * FROM Usuario U
              INNER JOIN Matricula_Curso MC ON U.Usu_IdUsuario = MC.Usu_IdUsuario
              WHERE Cur_IdCurso = {$curso}";
      return $this->getArray($sql);
    }

    public function updateMatricula($curso, $usuario, $estado){
      $sql = "UPDATE Matricula_Curso SET Mat_Valor = {$estado}
              WHERE Usu_IdUsuario = {$usuario} AND Cur_IdCurso = {$curso}";
      $this->execQuery($sql);
    }

    public function getAlumnos($curso){
      $sql = "SELECT U.Usu_IdUsuario, U.Usu_Nombre,
                U.Usu_Apellidos, U.Usu_URLImage, U.Usu_Email,
                (CASE WHEN U.Usu_IdUsuario = C.Usu_IdUsuario THEN 1 ELSE 0 END) as Docente
              FROM Usuario U
              INNER JOIN Matricula_Curso MC ON U.Usu_IdUsuario = MC.Usu_IdUsuario
              INNER JOIN Curso C ON C.Cur_IdCurso = MC.Cur_IdCurso
              WHERE C.Cur_IdCurso = {$curso} AND MC.Mat_Valor = 1
                AND U.Usu_Estado = 1 AND C.Usu_IdUsuario <> U.Usu_IdUsuario
              UNION
              SELECT U.Usu_IdUsuario, U.Usu_Nombre,
                    U.Usu_Apellidos, U.Usu_URLImage, U.Usu_Email,
                    1 as Docente
              FROM Usuario U
              INNER JOIN Curso C ON U.Usu_IdUsuario = C.Usu_IdUsuario
              WHERE C.Cur_Estado = 1 AND U.Usu_Estado = 1
                AND C.Row_Estado = 1 AND C.Cur_IdCurso = {$curso}";
      return $this->getArray($sql);
    }

    public function getLeccionActiva($id){
      $sql = "SELECT * FROM Leccion L
              INNER JOIN Modulo_Curso MC ON L.Mod_IdModulo = MC.Mod_IdModulo
              INNER JOIN Curso C ON MC.Cur_IdCurso = C.Cur_IdCurso
              WHERE L.Lec_FechaHasta < NOW()
              ORDER BY L.Lec_FechaDesde ASC LIMIT 1";
      return $this->getArray($sql);
    }


    public function getModalidadCurso() {
        $sql = "SELECT
                  C.Con_Valor as Mod_IdModCurso,
                  C.Con_Descripcion as Mod_Titulo,
                  (SELECT Con_Descripcion FROM Constante
                    WHERE Con_Codigo = 1100 AND Con_Valor = C.Con_Valor) as Mod_Descripcion
                FROM Constante C
                WHERE C.Con_Estado = 1 AND C.Row_Estado = 1
                  AND C.Con_Codigo = 1000 AND C.Con_Codigo <> C.Con_Valor";
        return $this->getArray($sql);
    }

    public function getCurso() {
        return $this->getArray("SELECT * FROM Curso WHERE Cur_Estado = 1 AND Row_Estado = 1");
    }

    public function getCursoXId($id) {
        return $this->getArray("SELECT * FROM Curso WHERE Cur_IdCurso = $id AND Row_Estado = 1")[0];
    }

    public function getCursoXDocente($id, $busqueda = "") {
        $sql = "SELECT * FROM Curso
                WHERE Usu_IdUsuario = {$id}
                  AND Row_Estado = 1";
        if( strlen($busqueda) ){
          $sql .=" AND Cur_Titulo like '%{$busqueda}%' ";
        }
        //echo $sql; exit;
        return $this->getArray($sql);
    }

    public function getCursoXRegistro($id) {
        return $this->getArray("SELECT MAX(Cur_IdCurso) as ID FROM Curso WHERE Usu_IdUsuario = $id AND Row_Estado = 1")[0];
    }

    public function getObjetivosXCurso($id, $estado) {
        $sql = "SELECT * FROM Curso_Objetivos WHERE Cur_IdCurso = $id AND CO_Estado >= $estado AND Row_Estado = 1";
        return $this->getArray($sql);
    }

    public function saveCurso($usuario, $modalidad, $titulo, $descripcion){
      $this->execQuery("INSERT INTO Curso(Usu_IdUsuario, Mod_IdModCurso, Cur_Titulo, Cur_Descripcion, Cur_Estado)
        VALUES($usuario, $modalidad, '$titulo', '$descripcion', 0)");
    }

    public function updateEstadoCurso($curso, $estado){
      $this->execQuery("UPDATE Curso SET Cur_Estado = '$estado' WHERE Cur_IdCurso = $curso");
    }


    public function deleteCurso($curso){
      $this->execQuery("UPDATE Curso SET Row_Estado = 0 WHERE Cur_IdCurso = $curso");
    }

    public function saveObjEspecifico($id, $obj){
      $this->execQuery("INSERT INTO Curso_Objetivos(Cur_IdCurso, CO_Titulo, CO_Descripcion, CO_Estado)
        VALUES($id, '$obj', '', 1)");
    }

    public function saveDetCurso($id, $titulo, $descripcion){
      $this->execQuery("INSERT INTO Detalle_Curso(Cur_IdCurso, DC_Titulo, DC_Descripcion)
        VALUES($id, '{$titulo}', '{$descripcion}')");
    }

    public function deleteObjEspecifico($id, $obj){
      $this->execQuery("UPDATE Curso_Objetivos SET Row_Estado = 0
        WHERE CO_IdObjetivo =  $id");
    }

    public function deleteDetCurso($id){
      $this->execQuery("UPDATE Detalle_Curso SET Row_Estado = 0
        WHERE DC_IdDetCurso =  $id");
    }

    public function getDetalleXCurso($id) {
        $sql = "SELECT * FROM Detalle_Curso
                WHERE Cur_IdCurso = $id
                  AND Row_Estado = 1";
        return $this->getArray($sql);
    }

    public function updateCurso($id, $titulo, $descripcion, $objgeneral, $publico, $software, $hardware, $metodologia){
      $sql = "UPDATE Curso SET
                Cur_Titulo = '{$titulo}',
                Cur_Descripcion = '{$descripcion}',
                Cur_ObjetivoGeneral = '{$objgeneral}',
                Cur_PublicoObjetivo = '{$publico}',
                Cur_Metodologia = '{$metodologia}',
                Cur_ReqHardware = '{$hardware}',
                Cur_ReqSoftware = '{$software}'
              WHERE Cur_IdCurso = {$id} ";
      $this->execQuery($sql);
    }
}
