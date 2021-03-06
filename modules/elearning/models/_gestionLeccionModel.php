<?php

class _gestionLeccionModel extends Model {
  protected $table = 'leccion';
  protected $primaryKey = 'Lec_IdLeccion';
  public $timestamps = false;

  public function __construct() { parent::__construct(); }

  public function insertLeccion($modulo, $tipo, $titulo, $descripcion, $dedicacion){
    $sql = "INSERT INTO leccion(Moc_IdModuloCurso, Lec_Tipo, Lec_Titulo, Lec_Descripcion, Lec_TiempoDedicacion, Lec_LMSEstado, Lec_Estado) VALUES(".($modulo ?? "NULL").", {$tipo}, '{$titulo}', '{$descripcion}', '{$dedicacion}', 0, 1);
    ";
    return $this->execQuery($sql, true);
  }

  public function getTipoLecccion($lms = "", $Idi_IdIdioma = "es"){
    $sql = "SELECT
              C.Con_Valor as Id,
              fn_TraducirContenido('constante','Con_Descripcion',C.Con_IdConstante,'$Idi_IdIdioma',C.Con_Descripcion) Titulo,
              (SELECT fn_TraducirContenido('constante','Con_Descripcion',Con_IdConstante,'$Idi_IdIdioma',Con_Descripcion) Con_Descripcion FROM constante WHERE Con_Codigo = 4000 AND Con_Valor = C.Con_Valor) as Descripcion,
              fn_devolverIdioma('constante',C.Con_IdConstante,'$Idi_IdIdioma',C.Idi_IdIdioma) Idi_IdIdioma
            FROM constante C
            WHERE C.Con_Codigo = 2000 AND C.Con_Codigo <> C.Con_Valor";
    if($lms == ""){
      $sql .= " AND C.Con_Valor NOT IN (4, 5)";
    }
    return $this->getArray($sql);
  }

  public function getLecciones($modulo, $Idi_IdIdioma = "es"){
    $sql = "SELECT L.Lec_IdLeccion,
    L.Moc_IdModuloCurso,
    fn_TraducirContenido('leccion','Lec_Titulo',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_Titulo) Lec_Titulo,
    fn_TraducirContenido('leccion','Lec_Descripcion',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_Descripcion) Lec_Descripcion,
    fn_TraducirContenido('leccion','Lec_TiempoDedicacion',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_TiempoDedicacion) Lec_TiempoDedicacion,
    L.Lec_Tipo,
    L.Lec_FechaDesde,
    L.Lec_FechaHasta,
    L.Lec_FechaReg,
    L.Lec_LMSEstado,
    L.Lec_LMSPizarra,
    L.Lec_Estado,
    L.Row_Estado,
    L.Lec_Hash,
    C.Con_Descripcion as Tipo,
    fn_devolverIdioma('modulo_curso',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Idi_IdIdioma) Idi_IdIdioma  
            FROM leccion L
            INNER JOIN constante C ON C.Con_Valor = L.Lec_Tipo AND C.Con_Codigo = 2000
            WHERE L.Moc_IdModuloCurso = {$modulo}
              AND L.Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function getLeccionId($leccion, $Idi_IdIdioma = ""){
    if ($Idi_IdIdioma == "" && isset($Idi_IdIdioma)) {
        $sql = "SELECT L.*, C.Con_Descripcion as Tipo ";
    } else {
        $sql = "SELECT L.Lec_IdLeccion,
            L.Moc_IdModuloCurso,
            fn_TraducirContenido('leccion','Lec_Titulo',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_Titulo) Lec_Titulo,
            fn_TraducirContenido('leccion','Lec_Descripcion',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_Descripcion) Lec_Descripcion,
            fn_TraducirContenido('leccion','Lec_TiempoDedicacion',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_TiempoDedicacion) Lec_TiempoDedicacion,
            L.Lec_Tipo,
            L.Lec_FechaDesde,
            L.Lec_FechaHasta,
            L.Lec_FechaReg,
            L.Lec_LMSEstado,
            L.Lec_LMSPizarra,
            L.Lec_Estado,
            L.Row_Estado,
            L.Lec_Hash,
            C.Con_Descripcion as Tipo,
            fn_devolverIdioma('modulo_curso',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Idi_IdIdioma) Idi_IdIdioma ";
    }
    
      $sql .= " FROM leccion L
      INNER JOIN constante C ON C.Con_Valor = L.Lec_Tipo AND C.Con_Codigo = 2000
      WHERE L.Lec_IdLeccion = {$leccion} AND L.Row_Estado = 1";
    if (isset($this->getArray($sql)[0]) && count($this->getArray($sql)[0])) {      
        return $this->getArray($sql)[0];
    } else {
        return $this->getArray($sql);
    }
  }


  public function updateLeccion($leccion, $titulo, $descripcion, $dedicacion){
    $sql = "UPDATE leccion SET Lec_Titulo = '{$titulo}', Lec_Descripcion = '{$descripcion}', Lec_TiempoDedicacion = '{$dedicacion}'  WHERE Lec_IdLeccion = {$leccion}";
    $this->execQuery($sql);
  }

  public function updateEstadoLeccion($leccion, $estado){
    $this->execQuery("UPDATE leccion SET Lec_Estado = '$estado' WHERE Lec_IdLeccion = $leccion");
  }

  public function deleteLeccion($leccion){
    $this->execQuery("UPDATE leccion SET Row_Estado = 0 WHERE Lec_IdLeccion = $leccion");
  }

  public function deleteReferencia($ref){
    $this->execQuery("UPDATE referencia_leccion SET Row_Estado = 0 WHERE Ref_IdReferencia = $ref");
  }

  public function deleteMaterial($mat){
    $this->execQuery("UPDATE material_leccion SET Row_Estado = 0 WHERE Mat_IdMaterial = $mat");
  }

  public function insertContenido($leccion, $titulo, $contenido){
    $sql = "INSERT INTO contenido_leccion(Lec_IdLeccion, CL_Titulo, CL_Descripcion, CL_Estado)
            VALUES({$leccion}, '{$titulo}', '{$contenido}', 1)";
    $this->execQuery($sql);
  }

  public function insertReferencia($leccion, $titulo, $descripcion){
    $sql = "INSERT INTO referencia_leccion(Lec_IdLeccion, Ref_Titulo, Ref_Descripcion, Ref_Estado)
            VALUES({$leccion}, '{$titulo}', '{$descripcion}', 1)";
    $this->execQuery($sql);
  }

  public function getReferenciaLeccion($leccion, $Idi_IdIdioma = "es"){
    $sql = "SELECT Ref_IdReferencia, 
            Lec_IdLeccion, 
            fn_TraducirContenido('referencia_leccion','Ref_Titulo', Ref_IdReferencia,'$Idi_IdIdioma',Ref_Titulo) Ref_Titulo, 
            Ref_Descripcion, 
            Ref_FechaReg, 
            fn_devolverIdioma('referencia_leccion', Ref_IdReferencia,'$Idi_IdIdioma', Idi_IdIdioma) Idi_IdIdioma, 
            Ref_Estado, 
            Row_Estado
             FROM referencia_leccion WHERE Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function getMaterialLeccion($leccion){
    $sql = "SELECT * FROM material_leccion WHERE Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    return $this->getArray($sql);
  }


  public function getContenidoLeccion($leccion){
    $sql = "SELECT * FROM contenido_leccion WHERE Lec_IdLeccion = {$leccion} AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function updateContenido($id, $titulo, $contenido){
    $sql = "UPDATE contenido_leccion SET
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
            FROM leccion
            WHERE YEAR(Lec_FechaDesde) = {$anio}
              AND MONTH(Lec_FechaDesde) = {$mes}
              AND Moc_IdModuloCurso = {$modulo}
              AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function updateFechaLección($leccion, $fecha){
    $sql = "UPDATE leccion SET
              Lec_FechaDesde ='{$fecha}',
              Lec_FechaHasta ='{$fecha}'
            WHERE Lec_IdLeccion = {$leccion}";
    $this->execQuery($sql);
    $sql = "UPDATE modulo_curso SET
              Mod_FechaDesde = (SELECT Lec_FechaDesde FROM leccion
                                WHERE Moc_IdModuloCurso = (SELECT Moc_IdModuloCurso FROM leccion WHERE Lec_IdLeccion = {$leccion})
                                  AND Row_Estado = 1
                                ORDER BY Lec_FechaDesde ASC LIMIT 1),
              Mod_FechaHasta = (SELECT Lec_FechaDesde FROM Leccion
                                WHERE Moc_IdModuloCurso = (SELECT Moc_IdModuloCurso FROM leccion WHERE Lec_IdLeccion = {$leccion})
                                  AND Row_Estado = 1
                                ORDER BY Lec_FechaHasta DESC LIMIT 1)
            WHERE Moc_IdModuloCurso = (SELECT Moc_IdModuloCurso FROM leccion WHERE Lec_IdLeccion = {$leccion})";
    $this->execQuery($sql);
    $sql = "UPDATE curso SET
              Cur_FechaDesde = (SELECT Mod_FechaDesde FROM modulo_curso
                                WHERE Row_Estado = 1
                                  AND Cur_IdCurso = (SELECT Cur_IdCurso FROM modulo_curso
                                                      WHERE Moc_IdModuloCurso = (SELECT Moc_IdModuloCurso FROM leccion
                                                                            WHERE Lec_IdLeccion = {$leccion}))
                                ORDER BY Mod_FechaDesde ASC LIMIT 1),
              Cur_FechaHasta = (SELECT Mod_FechaHasta FROM modulo_curso
                                WHERE Row_Estado = 1
                                  AND Cur_IdCurso = (SELECT Cur_IdCurso FROM modulo_curso
                                                      WHERE Moc_IdModuloCurso = (SELECT Moc_IdModuloCurso FROM leccion
                                                                            WHERE Lec_IdLeccion = {$leccion}))
                                ORDER BY Mod_FechaHasta DESC LIMIT 1)
            WHERE Cur_IdCurso = (SELECT Cur_IdCurso FROM modulo_curso
                                WHERE Moc_IdModuloCurso = (SELECT Moc_IdModuloCurso FROM leccion
                                                      WHERE Lec_IdLeccion = {$leccion}))";
    $this->execQuery($sql);
  }

  public function getDetalleLeccion2($leccion){
    $sql = "SELECT * FROM contenido_leccion WHERE Lec_IdLeccion = {$leccion}";
    $lec = $this->getArray($sql);

    if($lec==null || count($lec)==0){
      $sql = "INSERT INTO contenido_leccion(Lec_IdLeccion, CL_Titulo, CL_Descripcion, CL_FechaReg, CL_Estado, Row_Estado)
              VALUES({$leccion}, '', '', NOW(), 1, 1)";
      $this->execQuery($sql);
    }
    $sql = "SELECT * FROM contenido_leccion WHERE Lec_IdLeccion = {$leccion}";
    $lec = $this->getArray($sql);
    return $lec;
  }


  public function updateVideoLeccion($leccion, $link, $descripcion){
    $sql = "UPDATE contenido_leccion SET CL_Descripcion = '{$link}' WHERE CL_IdContenido = {$leccion}";
    $this->execQuery($sql);
    $sql = "UPDATE leccion SET Lec_Descripcion = '{$descripcion}'
            WHERE Lec_IdLeccion = (SELECT Lec_IdLeccion
                                  FROM contenido_leccion WHERE CL_IdContenido = {$leccion})";
    $this->execQuery($sql);
  }

  public function insertMaterial($leccion, $url, $tipo, $descripcion){
    $sql = "INSERT INTO material_leccion(Lec_IdLeccion, Mat_Enlace, Mat_Descripcion, Mat_FechaReg, Mat_Tipo, Mat_Estado)
            VALUES({$leccion}, '{$url}', '{$descripcion}', NOW(), $tipo, 1)";
    $this->execQuery($sql);
  }

  public function insertExamenLeccion($leccion, $descripcion, $intentos, $restrictivo, $porcentaje){
    $sql = "SELECT * FROM examen WHERE Lec_IdLeccion = {$leccion}";
    $data = $this->getArray($sql);

    if($data==null || count($data)==0){
      $sql = "INSERT INTO examen(Lec_IdLeccion, Exa_Descripcion, Exa_Intentos, Exa_Restrictivo, Exa_Porcentaje, Exa_Estado)
      VALUES({$leccion}, '{$descripcion}', {$intentos}, {$restrictivo}, $porcentaje, 1)";
      $this->execQuery($sql);
    }
    $sql = "SELECT * FROM examen WHERE Lec_IdLeccion = {$leccion}";
    return $this->getArray($sql);
  }

  public function updateExamen($examen, $intentos, $porcentaje, $descripcion, $peso, $nro_preguntas){
    $sql = "UPDATE examen SET
              Exa_Porcentaje = '{$porcentaje}',
              Exa_Intentos = '{$intentos}',
              Exa_Descripcion = '{$descripcion}',
              Exa_Peso = '{$peso}',
              Exa_NroPreguntas = '{$nro_preguntas}'
            WHERE Exa_IdExamen = {$examen}";
    $this->execQuery($sql);
  }

  public function insertPregunta($leccion, $descripcion, $valor, $tipo, $descripcion2=''){
    $sql = "INSERT INTO pregunta(Exa_IdExamen,
            TP_IdTpoPregunta, Pre_Descripcion, Pre_Descripcion2, Pre_FechaReg, Pre_Valor, Pre_Tipo, Pre_Estado)
            VALUES( (SELECT Exa_IdExamen FROM examen WHERE Lec_IdLeccion = {$leccion} ), '1',
              '{$descripcion}','{$descripcion2}', NOW(), '{$valor}',{$tipo},'1')";
    $this->execQuery($sql);
    $sql = "SELECT * FROM pregunta
            WHERE Exa_IdExamen = (SELECT Exa_IdExamen FROM examen WHERE Lec_IdLeccion = {$leccion})
            ORDER BY Pre_FechaReg DESC Limit 1";
    return $this->getArray($sql)[0];
  }

  public function insertAlternativa($pregunta, $valor, $descripcion, $relacion=0){
    $sql = "INSERT INTO alternativa(Pre_IdPregunta, Alt_Etiqueta, Alt_Valor, Alt_FechaReg, Alt_Relacion, Alt_Estado)
            VALUES({$pregunta}, '{$descripcion}', {$valor}, NOW(),{$relacion}, '1')";
    $this->execQuery($sql);
  }

  public function getAlternativas($pregunta){
    $sql = "SELECT * FROM alternativa WHERE Pre_IdPregunta = {$pregunta} AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function getPreguntas($examen){
    $sql = "SELECT * FROM pregunta WHERE Exa_IdExamen = {$examen} AND Row_Estado = 1";
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
    $sql = "UPDATE pregunta SET Row_Estado = 0 WHERE Pre_IdPregunta = {$id}";
    $this->execQuery($sql);
  }

  public function updateEstadoPregunta($id, $estado){
    $sql = "UPDATE pregunta SET Pre_Estado = '{$estado}' WHERE Pre_IdPregunta = {$id}";
    $this->execQuery($sql);
  }

  public function updatePregunta($pregunta, $descripcion, $valor){
    $sql = "UPDATE pregunta SET
              Pre_Descripcion = '{$descripcion}',
              Pre_Valor = '{$valor}',
              Pre_FechaReg = NOW()
            WHERE Pre_IdPregunta = {$pregunta}";
    $this->execQuery($sql);
  }

  public function updateAlternativa($id, $descripcion){
    $sql = "UPDATE alternativa SET Alt_Etiqueta = '{$descripcion}' WHERE Alt_IdAlternativa = {$id}";
    $this->execQuery($sql);
  }

  public function ValidarPreguntasExamen($id){
    $mensaje = "";
    $sql = "SELECT * FROM examen WHERE Lec_IdLeccion = {$id} AND Exa_Estado = 1 AND Row_Estado = 1";
    $examen = $this->getArray($sql);

    if($examen == null || count($examen)==0){
      $mensaje = "Aun no se ha creado el examen de la lección";
      return $mensaje;
    }else{
      if($examen[0]["Exa_NroPreguntas"]==null || strlen($examen[0]["Exa_NroPreguntas"])==0){
        $mensaje = "Deebe configurar el número de preguntas para el examen";
        return $mensaje;
      }
      $sql = "SELECT * FROM pregunta WHERE Exa_IdExamen = {$examen[0]['Exa_IdExamen']}
              AND Pre_Estado = 1 AND Row_Estado = 1";
      $preguntas = $this->getArray($sql);

      if($preguntas == null || count($preguntas)==0){
        $mensaje = "No ha registrado ninguna pregunta en el examen";
        return $mensaje;
      }else{
        if (count($preguntas) >= $examen[0]["Exa_NroPreguntas"]){
          return "";
        }else{
          $mensaje = "Debe registrar mas preguntas en el examen o modificar el número de preguntas";
          return $mensaje;
        }
      }
    }
  }
}
