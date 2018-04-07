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


  public function updateLeccion($leccion, $titulo){
    $sql = "UPDATE Leccion SET Lec_Titulo = '{$titulo}' WHERE Lec_IdLeccion = {$leccion}";
    $this->execQuery($sql);
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

  public function getMaterialLeccion($leccion){
    $sql = "SELECT * FROM Material_Leccion WHERE Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    return $this->getArray($sql);
  }


  public function getContenidoLeccion($leccion){
    $sql = "SELECT * FROM Contenido_Leccion WHERE Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function updateContenido($id, $titulo, $contenido){
    $sql = "UPDATE Contenido_Leccion SET
              CL_Titulo = '{$titulo}',
              CL_Descripcion = '{$contenido}',
              CL_FechaReg = NOW()
            WHERE CL_IdContenido = {$id}";
    $this->execQuery($sql);
  }

  public function getLeccionesCalendario($mes, $anio, $modulo){
    $sql = "SELECT
              Lec_IdLeccion as ID,
              DAY(Lec_FechaDesde) as D,
              MONTH(Lec_FechaDesde) as M,
              YEAR(Lec_FechaDesde) as A,
              HOUR(Lec_FechaDesde) as H,
              Lec_Titulo as DET
            FROM Leccion
            WHERE YEAR(Lec_FechaDesde) = {$anio}
              AND MONTH(Lec_FechaDesde) = {$mes}
              AND Mod_IdModulo = {$modulo}
              AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function updateFechaLección($leccion, $fecha){
    $sql = "UPDATE Leccion SET
              Lec_FechaDesde ='{$fecha}',
              Lec_FechaHasta ='{$fecha}'
            WHERE Lec_IdLeccion = {$leccion}";
    $this->execQuery($sql);
    $sql = "UPDATE Modulo_Curso SET
              Mod_FechaDesde = (SELECT Lec_FechaDesde FROM Leccion
                                WHERE Mod_IdModulo = (SELECT Mod_IdModulo FROM Leccion WHERE Lec_IdLeccion = {$leccion})
                                  AND Row_Estado = 1
                                ORDER BY Lec_FechaDesde ASC LIMIT 1),
              Mod_FechaHasta = (SELECT Lec_FechaDesde FROM Leccion
                                WHERE Mod_IdModulo = (SELECT Mod_IdModulo FROM Leccion WHERE Lec_IdLeccion = {$leccion})
                                  AND Row_Estado = 1
                                ORDER BY Lec_FechaHasta DESC LIMIT 1)
            WHERE Mod_IdModulo = (SELECT Mod_IdModulo FROM Leccion WHERE Lec_IdLeccion = {$leccion})";
    $this->execQuery($sql);
    $sql = "UPDATE Curso SET
              Cur_FechaDesde = (SELECT Mod_FechaDesde FROM Modulo_Curso
                                WHERE Row_Estado = 1
                                  AND Cur_IdCurso = (SELECT Cur_IdCurso FROM Modulo_Curso
                                                      WHERE Mod_IdModulo = (SELECT Mod_IdModulo FROM Leccion
                                                                            WHERE Lec_IdLeccion = {$leccion}))
                                ORDER BY Mod_FechaDesde ASC LIMIT 1),
              Cur_FechaHasta = (SELECT Mod_FechaHasta FROM Modulo_Curso
                                WHERE Row_Estado = 1
                                  AND Cur_IdCurso = (SELECT Cur_IdCurso FROM Modulo_Curso
                                                      WHERE Mod_IdModulo = (SELECT Mod_IdModulo FROM Leccion
                                                                            WHERE Lec_IdLeccion = {$leccion}))
                                ORDER BY Mod_FechaHasta DESC LIMIT 1)
            WHERE Cur_IdCurso = (SELECT Cur_IdCurso FROM Modulo_Curso
                                WHERE Mod_IdModulo = (SELECT Mod_IdModulo FROM Leccion
                                                      WHERE Lec_IdLeccion = {$leccion}))";
    $this->execQuery($sql);
  }

  public function getDetalleLeccion2($leccion){
    $sql = "SELECT * FROM Contenido_Leccion WHERE Lec_IdLeccion = {$leccion}";
    $lec = $this->getArray($sql);

    if($lec==null || count($lec)==0){
      $sql = "INSERT INTO Contenido_Leccion(Lec_IdLeccion, CL_Titulo, CL_Descripcion, CL_FechaReg, CL_Estado, Row_Estado)
              VALUES({$leccion}, '', '', NOW(), 1, 1)";
      $this->execQuery($sql);
    }
    $sql = "SELECT * FROM Contenido_Leccion WHERE Lec_IdLeccion = {$leccion}";
    $lec = $this->getArray($sql);
    return $lec;
  }


  public function updateVideoLeccion($leccion, $link, $descripcion){
    $sql = "UPDATE Contenido_Leccion SET CL_Descripcion = '{$link}' WHERE CL_IdContenido = {$leccion}";
    $this->execQuery($sql);
    $sql = "UPDATE Leccion SET Lec_Descripcion = '{$descripcion}'
            WHERE Lec_IdLeccion = (SELECT Lec_IdLeccion
                                  FROM Contenido_Leccion WHERE CL_IdContenido = {$leccion})";
    $this->execQuery($sql);
  }

  public function insertMaterial($leccion, $url, $descripcion){
    $sql = "INSERT INTO Material_Leccion(Lec_IdLeccion, Mat_Enlace, Mat_Descripcion, Mat_FechaReg, Mat_Estado)
            VALUES({$leccion}, '{$url}', '{$descripcion}', NOW(), 1)";
    $this->execQuery($sql);
  }

  public function insertExamenLeccion($leccion, $descripcion, $intentos, $restrictivo, $porcentaje){
    $sql = "SELECT * FROM Examen WHERE Lec_IdLeccion = {$leccion}";
    $data = $this->getArray($sql);

    if($data==null || count($data)==0){
      $sql = "INSERT INTO Examen(Lec_IdLeccion, Exa_Descripcion, Exa_Intentos, Exa_Restrictivo, Exa_Porcentaje, Exa_Estado)
      VALUES({$leccion}, '{$descripcion}', {$intentos}, {$restrictivo}, $porcentaje, 1)";
      $this->execQuery($sql);
    }
    $sql = "SELECT * FROM Examen WHERE Lec_IdLeccion = {$leccion}";
    return $this->getArray($sql);
  }

  public function updateExamen($examen, $intentos, $porcentaje, $descripcion, $peso){
    $sql = "UPDATE Examen SET
              Exa_Porcentaje = '{$porcentaje}',
              Exa_Intentos = '{$intentos}',
              Exa_Descripcion = '{$descripcion}',
              Exa_Peso = '{$peso}'
            WHERE Exa_IdExamen = {$examen}";
    $this->execQuery($sql);
  }

  public function insertPregunta($leccion, $descripcion, $valor){
    $sql = "INSERT INTO Pregunta(Exa_IdExamen,
            TP_IdTpoPregunta, Pre_Descripcion, Pre_FechaReg, Pre_Valor, Pre_Estado)
            VALUES( (SELECT Exa_IdExamen FROM Examen WHERE Lec_IdLeccion = {$leccion} ), '1',
              '{$descripcion}', NOW(), '{$valor}', '1')";
    $this->execQuery($sql);
    $sql = "SELECT * FROM Pregunta
            WHERE Exa_IdExamen = (SELECT Exa_IdExamen FROM Examen WHERE Lec_IdLeccion = {$leccion})
            ORDER BY Pre_FechaReg DESC Limit 1";
    return $this->getArray($sql)[0];
  }

  public function insertAlternativa($pregunta, $valor, $descripcion){
    $sql = "INSERT INTO Alternativa(Pre_IdPregunta, Alt_Etiqueta, Alt_Valor, Alt_FechaReg, Alt_Estado)
            VALUES({$pregunta}, '{$descripcion}', {$valor}, NOW(), '1')";
    $this->execQuery($sql);
  }

  public function getAlternativas($pregunta){
    $sql = "SELECT * FROM Alternativa WHERE Pre_IdPregunta = {$pregunta} AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function getPreguntas($examen){
    $sql = "SELECT * FROM Pregunta WHERE Exa_IdExamen = {$examen} AND Row_Estado = 1";
    $preguntas = $this->getArray($sql);

    if($preguntas!=null && count($preguntas)>0){
      $resultado = array();
      foreach ($preguntas as $p) {
        $p["ALTERNATIVAS"] = $this->getAlternativas($p["Pre_IdPregunta"]);
        array_push($resultado, $p);
      }
      return $resultado;
    }
    return null;
  }

  public function deletePregunta($id){
    $sql = "UPDATE Pregunta SET Row_Estado = 0 WHERE Pre_IdPregunta = {$id}";
    $this->execQuery($sql);
  }

  public function updateEstadoPregunta($id, $estado){
    $sql = "UPDATE Pregunta SET Pre_Estado = '{$estado}' WHERE Pre_IdPregunta = {$id}";
    $this->execQuery($sql);
  }

  public function updatePregunta($pregunta, $descripcion, $valor){
    $sql = "UPDATE Pregunta SET
              Pre_Descripcion = '{$descripcion}',
              Pre_Valor = '{$valor}',
              Pre_FechaReg = NOW()
            WHERE Pre_IdPregunta = {$pregunta}";
    $this->execQuery($sql);
  }

  public function updateAlternativa($id, $descripcion){
    $sql = "UPDATE Alternativa SET Alt_Etiqueta = '{$descripcion}' WHERE Alt_IdAlternativa = {$id}";
    $this->execQuery($sql);
  }
}
