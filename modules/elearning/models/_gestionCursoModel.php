<?php

class _gestionCursoModel extends Model {

  public function __construct() { parent::__construct(); }

  public function validarDocenteCurso($curso, $usuario){
    $sql = "SELECT * FROM curso WHERE Cur_IdCurso = {$curso} AND Usu_IdUsuario = {$usuario}";
    $result = $this->getArray($sql);

    if($result!=null && count($result)>0){
      return true;
    }else{
      return false;
    }
  }

  public function getMatriculados($curso){
    $sql = "SELECT * FROM usuario U
            INNER JOIN matricula_curso MC ON U.Usu_IdUsuario = MC.Usu_IdUsuario
            WHERE Cur_IdCurso = {$curso}";
    return $this->getArray($sql);
  }

  public function updateMatricula($curso, $usuario, $estado){
    $sql = "UPDATE matricula_curso SET Mat_Valor = {$estado}
            WHERE Usu_IdUsuario = {$usuario} AND Cur_IdCurso = {$curso}";
    $this->execQuery($sql);
  }

  public function getAlumnos($curso){
    $sql = "SELECT U.Usu_IdUsuario, U.Usu_Nombre,
              U.Usu_Apellidos, U.Usu_URLImage, U.Usu_Email,
              (CASE WHEN U.Usu_IdUsuario = C.Usu_IdUsuario THEN 1 ELSE 0 END) as Docente
            FROM usuario U
            INNER JOIN matricula_curso MC ON U.Usu_IdUsuario = MC.Usu_IdUsuario
            INNER JOIN curso C ON C.Cur_IdCurso = MC.Cur_IdCurso
            WHERE C.Cur_IdCurso = {$curso} AND MC.Mat_Valor = 1
              AND U.Usu_Estado = 1 AND C.Usu_IdUsuario <> U.Usu_IdUsuario
            UNION
            SELECT U.Usu_IdUsuario, U.Usu_Nombre,
                  U.Usu_Apellidos, U.Usu_URLImage, U.Usu_Email,
                  1 as Docente
            FROM usuario U
            INNER JOIN curso C ON U.Usu_IdUsuario = C.Usu_IdUsuario
            WHERE C.Cur_Estado = 1 AND U.Usu_Estado = 1
              AND C.Row_Estado = 1 AND C.Cur_IdCurso = {$curso}";
    return $this->getArray($sql);
  }

  public function getLeccionActiva($id){
    $sql = "SELECT * FROM leccion L
            INNER JOIN modulo_curso MC ON L.Moc_IdModuloCurso = MC.Moc_IdModuloCurso
            INNER JOIN curso C ON MC.Cur_IdCurso = C.Cur_IdCurso
            WHERE L.Lec_FechaHasta < NOW()
            ORDER BY L.Lec_FechaDesde ASC LIMIT 1";
    return $this->getArray($sql);
  }


  public function getModalidadCurso() {
      $sql = "SELECT
                C.Con_Valor as Moa_IdModalidad,
                C.Con_Descripcion as Moc_Titulo,
                (SELECT Con_Descripcion FROM constante
                  WHERE Con_Codigo = 1100 AND Con_Valor = C.Con_Valor) as Moc_Descripcion
              FROM constante C
              WHERE C.Con_Estado = 1 AND C.Row_Estado = 1
                AND C.Con_Codigo = 1000 AND C.Con_Codigo <> C.Con_Valor";
      return $this->getArray($sql);
  }

  public function getCurso() {
      return $this->getArray("SELECT * FROM curso WHERE Cur_Estado = 1 AND Row_Estado = 1");
  }

  public function getCursoXId($id) {
      $res = $this->getArray("SELECT * FROM curso WHERE Cur_IdCurso = $id AND Row_Estado = 1");
      return count($res) > 0 ? $res[0] : null;
  }
  // JMart
  public function getCursoXDocente($id, $busqueda = "") {
      $sql = "SELECT * FROM curso c
              INNER JOIN usuario u ON c.Usu_IdUsuario = u.Usu_IdUsuario
              WHERE c.Usu_IdUsuario = {$id} AND c.Row_Estado = 1 ";
      if( strlen($busqueda) ){
        $sql .=" AND Cur_Titulo like '%{$busqueda}%' AND Cur_Descripcion like '%{$busqueda}%'";
      }

      $sql .= " GROUP BY c.Cur_IdCurso ORDER BY c.Cur_FechaReg DESC ";
      //echo $sql; exit;
      return $this->getArray($sql);
  }

  // Jhon Martinez
  public function getMisCursos($Usu_IdUsuario = 0, $Busqueda = "", $soloActivos = 0)
  {
    try{
        $sql = "  SELECT cursi.*,COUNT(vc.Usu_IdUsuario) AS Valoraciones, CAST((CASE WHEN AVG(vc.Val_Valor) > 0 THEN AVG(vc.Val_Valor) ELSE 0 END) AS DECIMAL(2,1)) AS Valor FROM (
            SELECT cr.Cur_IdCurso, cr.Cur_Estado, cr.Cur_UrlBanner, cr.Cur_Titulo, cr.Cur_Descripcion, cr.Usu_IdUsuario, cr.Cur_Vacantes, cr.Cur_FechaDesde, cr.Moa_IdModalidad, CONCAT(u.Usu_Nombre,' ',u.Usu_Apellidos) AS Docente, cc.Con_Descripcion AS Modalidad,
              SUM(CASE WHEN mt.Mat_Valor = 1 THEN 1 ELSE 0 END) AS Matriculados, (CASE WHEN cu_m.Matriculado = 1 THEN 1 ELSE 0 END) AS Inscrito FROM (
              SELECT cur.Cur_IdCurso, 1 AS Matriculado FROM curso cur
                INNER JOIN matricula_curso mat ON cur.Cur_IdCurso = mat.Cur_IdCurso
                WHERE cur.Cur_Estado = 1 ";

        if ($soloActivos == 1) {
            $sql .= " AND cur.Row_Estado = $soloActivos ";
        }
        $sql .= " AND mat.Mat_Valor = 1 AND mat.Usu_IdUsuario = $Usu_IdUsuario ) cu_m
                  RIGHT JOIN curso cr ON cu_m.Cur_IdCurso = cr.Cur_IdCurso
                  INNER JOIN constante cc ON cr.Moa_IdModalidad = cc.Con_Valor AND cc.Con_Codigo = 1000
                  INNER JOIN usuario u ON cr.Usu_IdUsuario = u.Usu_IdUsuario
                  LEFT JOIN matricula_curso mt ON cr.Cur_IdCurso = mt.Cur_IdCurso ";

        if ($soloActivos == 1) {
            $sql .= " AND cr.Row_Estado = $soloActivos ";
        }
        $sql .= " GROUP BY cr.Cur_IdCurso )cursi
            LEFT JOIN valoracion_curso vc ON cursi.Cur_IdCurso = vc.Cur_IdCurso
            WHERE (cursi.Inscrito = 1 OR cursi.Usu_IdUsuario = $Usu_IdUsuario) ";
        if( strlen($Busqueda) ){
          $sql .=" AND cursi.Cur_Titulo like '%" . $Busqueda . "%' OR cursi.Cur_Descripcion like '%{$Busqueda}%' ";
        }
        $sql .= " GROUP BY cursi.Cur_IdCurso ORDER BY cursi.Inscrito ";

        $result = $this->_db->query($sql);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $exception) {
        $this->registrarBitacora("elearning(_gestionCursoModel)", "getMisCursos", "Error Model", $exception);
        return $exception->getTraceAsString();
    }
  }

  public function getCursoXRegistro($id) {
      return $this->getArray("SELECT MAX(Cur_IdCurso) as ID FROM curso WHERE Usu_IdUsuario = $id AND Row_Estado = 1")[0];
  }

  public function getObjetivosXCurso($id, $estado) {
      $sql = "SELECT * FROM curso_objetivos WHERE Cur_IdCurso = $id AND CO_Estado >= $estado AND Row_Estado = 1";
      return $this->getArray($sql);
  }

  public function saveCurso($usuario, $modalidad, $titulo, $descripcion){
    $this->execQuery("INSERT INTO curso(Usu_IdUsuario, Cur_UrlBanner, Moa_IdModalidad, Cur_Titulo, Cur_Descripcion, Cur_Estado)
      VALUES($usuario, 'default.jpg', $modalidad, '$titulo', '$descripcion', 0)");
  }

  public function updateEstadoCurso($curso, $estado){
    // $this->execQuery("UPDATE curso SET Cur_Estado = '$estado' WHERE Cur_IdCurso = $curso");
    try{
            $permiso = $this->_db->query(
                " UPDATE curso SET Cur_Estado = '$estado' WHERE Cur_IdCurso = $curso"
            );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "updateEstadoCurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
  }


  public function deleteCurso($curso){
    $this->execQuery("UPDATE curso SET Row_Estado = 0 WHERE Cur_IdCurso = $curso");
  }

  public function saveObjEspecifico($id, $obj){
    $this->execQuery("INSERT INTO curso_objetivos(Cur_IdCurso, CO_Titulo, CO_Descripcion, CO_Estado)
      VALUES($id, '$obj', '', 1)");
  }

  public function saveDetCurso($id, $titulo, $descripcion){
    $this->execQuery("INSERT INTO detalle_curso(Cur_IdCurso, DC_Titulo, DC_Descripcion)
      VALUES($id, '{$titulo}', '{$descripcion}')");
  }

  public function deleteObjEspecifico($id, $obj){
    $this->execQuery("UPDATE curso_objetivos SET Row_Estado = 0
      WHERE CO_IdObjetivo =  $id");
  }

  public function deleteDetCurso($id){
    $this->execQuery("UPDATE detalle_curso SET Row_Estado = 0
      WHERE DC_IdDetCurso =  $id");
  }

  public function getDetalleXCurso($id) {
      $sql = "SELECT * FROM detalle_curso
              WHERE Cur_IdCurso = $id
                AND Row_Estado = 1";
      return $this->getArray($sql);
  }

  public function updateCurso($id, $titulo, $descripcion, $objgeneral, $publico, $software, $hardware, $metodologia, $vacantes, $contacto){
    $sql = "UPDATE curso SET
              Cur_Titulo = '{$titulo}',
              Cur_Descripcion = '{$descripcion}',
              Cur_ObjetivoGeneral = '{$objgeneral}',
              Cur_PublicoObjetivo = '{$publico}',
              Cur_Metodologia = '{$metodologia}',
              Cur_ReqHardware = '{$hardware}',
              Cur_ReqSoftware = '{$software}',
              Cur_Vacantes = '{$vacantes}',
              Cur_Contacto = '{$contacto}'
            WHERE Cur_IdCurso = {$id} ";
    $this->execQuery($sql);
  }

  public function updateBannerCurso($curso, $banner){
    $sql = "UPDATE curso SET Cur_UrlBanner = '{$banner}' WHERE Cur_IdCurso = '{$curso}'";
    $this->execQuery($sql);
  }

  //Jhon Martinez
  public function updateVideoCurso($curso, $video){
    try {
        $sql = " UPDATE curso SET Cur_UrlVideoPresentacion = '{$video}' WHERE Cur_IdCurso = '{$curso}' ";
         // $this->execQuery($sql);
         $result = $this->_db->prepare($sql);
          $result->execute();
          return $result->rowCount(PDO::FETCH_ASSOC);
    } catch (PDOException $exception) {
        $this->registrarBitacora("elearning(_gestionCursoModel)", "updateVideoCurso", "Error Model", $exception);
        return $exception->getTraceAsString();
    }

  }


   public function getAnuncios($curso){
      $sql = "SELECT * FROM anuncio_curso
              WHERE Cur_IdCurso = {$curso}";
      return $this->getArray($sql);
    }


   public function getAnunciosRowCount($condicion = '')
    {
        try{
            $anuncios = $this->_db->query(
                " SELECT COUNT(anc.Anc_IdAnuncioCurso) AS CantidadRegistros from anuncio_curso anc $condicion "
            );
            return $anuncios->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("gestion(indexModel)", "getAnunciosRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

  public function getAnunciosCondicion($pagina,$registrosXPagina,$condicion = "")
    {
        try{
            $registroInicio = 0;
            if ($pagina > 0) {
                $registroInicio = ($pagina - 1) * $registrosXPagina;
            }

            $sql = " SELECT *, SUBSTRING(Anc_Descripcion, 1, 30) AS Anc_DescripcionRec FROM anuncio_curso anc $condicion
                LIMIT $registroInicio, $registrosXPagina ";
            $result = $this->_db->query($sql);
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getAnunciosCondicion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

  public function getAnuncio($anuncioID)
    {
        try{
            $anuncio = $this->_db->query(
                " SELECT * FROM anuncio_curso
                WHERE Anc_IdAnuncioCurso = $anuncioID"
            );
            return $anuncio->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getAnuncio", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


  // public function registrarAnuncio($titulo, $descripcion, $idCurso){
  //   $sql="INSERT INTO anuncio_curso(Anc_Titulo,Anc_Descripcion,Cur_IdCurso)
  //     VALUES('$titulo', '$descripcion','$idCurso')";
  //   return $this->getArray($sql);
  // }

  public function registrarAnuncio($titulo, $descripcion, $idCurso){
        try {
            $sql = "call s_i_anuncios(?,?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $titulo, PDO::PARAM_STR);
            $result->bindParam(2, $descripcion, PDO::PARAM_STR);
            $result->bindParam(3, $idCurso,  PDO::PARAM_INT);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "registrarAnuncio", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function registrarAnuncioUsuario($anuncio, $usuario){
        try {
            $sql = "call s_i_anuncios_usuarios(?,?)";
            $result = $this->_db->prepare($sql);
            $result->bindParam(1, $anuncio, PDO::PARAM_INT);
            $result->bindParam(2, $usuario, PDO::PARAM_INT);
            $result->execute();
            return $result->fetch();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "registrarAnuncioUsuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

  public function editarAnuncio($idAnuncioCurso, $titulo, $descripcion)
    {
        try{
            $per = $this->_db->query(
                " UPDATE anuncio_curso SET Anc_Titulo = '$titulo', Anc_Descripcion = '$descripcion'  WHERE Anc_IdAnuncioCurso = $idAnuncioCurso"
            );
            return $per->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "editarAnuncio", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

     public function cambiarEstadoLeido($idAnuncioCurso, $usuario)
    {
        try{
            $per = $this->_db->query(
                " UPDATE anuncio_usuario SET Anu_Leido=1 WHERE Usu_IdUsuario=$usuario AND Anc_IdAnuncioCurso =$idAnuncioCurso"
            );
            return $per->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "editarAnuncio", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getMatriculadosCurso($curso)
    {
        try{
            $alumnos = $this->_db->query(
                " SELECT U.Usu_IdUsuario IdUsu FROM usuario U
            INNER JOIN matricula_curso MC ON U.Usu_IdUsuario = MC.Usu_IdUsuario
            WHERE MC.Cur_IdCurso = $curso "
            );
            return $alumnos->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getMatriculadosCurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getEmailMatriculadosCurso($curso)
    {
        try{
            $alumnos = $this->_db->query(
                " SELECT U.Usu_Nombre,U.Usu_Apellidos,U.Usu_DocumentoIdentidad,U.Usu_Email FROM usuario U
            INNER JOIN matricula_curso MC ON U.Usu_IdUsuario = MC.Usu_IdUsuario
            WHERE Cur_IdCurso = $curso "
            );
            return $alumnos->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "getMatriculadosCurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function getEmail_Usuario()
    {
        try {
            $post = $this->_db->query(
                "SELECT usu_email FROM usuario");
            return $post->fetchAll();
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(usuarioModel)", "getEmail_Usuario", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }


    public function cambiarEstadoAnuncio($Per_IdPermiso, $Per_Estado)
    {
        try{
            if($Per_Estado==0)
            {

                $sql = "call s_u_cambiar_estado_anuncio(?,1)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Per_IdPermiso, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }
            if($Per_Estado==1)
            {

                $sql = "call s_u_cambiar_estado_anuncio(?,0)";
                $result = $this->_db->prepare($sql);
                $result->bindParam(1, $Per_IdPermiso, PDO::PARAM_INT);
                $result->execute();

                return $result->rowCount(PDO::FETCH_ASSOC);
            }

        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "cambiarEstadoAnuncio", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

     public function eliminarHabilitarAnuncio($Per_IdPermiso = 0,$Row_Estado = 0)
    {
        try{

            $permiso = $this->_db->query(
                " UPDATE anuncio_curso SET Row_Estado = $Row_Estado WHERE Anc_IdAnuncioCurso = $Per_IdPermiso "
                );
            return $permiso->rowCount(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(_gestionCursoModel)", "eliminarHabilitarAnuncio", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function insertParametros($curso, $min, $max){
      try{
        $data = $this->getArray("SELECT * FROM parametro_curso where Cur_IdCurso = {$curso}");
        if($data == null || count($data) == 0){
          $sql = "INSERT INTO parametro_curso (Cur_IdCurso, Par_NotaMinima, Par_NotaMaxima, Par_Estado)
                  VALUES('{$curso}','{$min}','{$max}', '1')";
        }else{
          $sql = "UPDATE parametro_curso SET
                    Par_NotaMinima = '{$min}',
                    Par_NotaMaxima = '{$max}',
                    Par_Estado = '1'
                  WHERE Cur_IdCurso ='{$curso}'";
        }
        $this->execQuery($sql);
      } catch (PDOException $exception) {
        $this->registrarBitacora("elearning(_gestionCursoModel)", "insertParametros", "Error Model", $exception);
        return $exception->getTraceAsString();
      }
    }

    public function getParametros($curso){
      try{
        $data = $this->getArray("SELECT * FROM parametro_curso where Cur_IdCurso = {$curso}");

        if($data!=null && count($data) > 0){
          return $data[0];
        }else{
          $sql = "INSERT INTO parametro_curso (Cur_IdCurso, Par_NotaMinima, Par_NotaMaxima, Par_Estado)
                  VALUES('{$curso}',0,0, '1')";
          $this->execQuery($sql);
          return $this->getParametros($curso);
        }
      } catch (PDOException $exception) {
        $this->registrarBitacora("elearning(_gestionCursoModel)", "insertParametros", "Error Model", $exception);
        return $exception->getTraceAsString();
      }
    }
}
