<?php


class cursoModel extends Model {
    protected $table = 'curso';
    protected $primaryKey = 'Cur_IdCurso';
    public $timestamps = false;


    public function __construct() {
      parent::__construct();

    }
    // public function getCurso(){
    //     $cursos = $this->getArray("SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
    //         INNER JOIN constante CC ON CC.Con_Valor = C.Moa_IdModalidad AND CC.Con_Codigo = 1000
    //         WHERE C.Cur_Estado = 1 AND C.Row_Estado = 1");
    //     $resultado = array();
    //     foreach ($cursos as $c) {
    //       if($c["Moa_IdModalidad"]==2){
    //         $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
    //       }
    //       array_push($resultado, $c);
    //     }
    //     return $resultado;
    // }

    //SOLO CON LA INSTANCIA DEL CURSO, DEBEN EXISTIR LAS VARIABLES
    public function formularios () {
      return $this->hasMany('App\Formulario', 'Cur_IdCurso');
    }
    public function getFormularioActivo () {
      return $this->formularios()->activos()->first();
    }
    //END
    public function getCursoID($id){
        $cursos = $this->getArray("SELECT * FROM curso WHERE Cur_IdCurso = {$id} AND Row_Estado = 1");
        $resultado = array();
        foreach ($cursos as $c) {
          // if($c["Moa_IdModalidad"]!=2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          // }
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function getCursoBusqueda($texto){
        $sql = "SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
                INNER JOIN constante CC ON CC.Con_Valor = C.Moa_IdModalidad AND CC.Con_Codigo = 1000
                WHERE (C.Cur_Titulo like '%{$texto}%'
                  OR C.Cur_Descripcion like '%{$texto}%')
                  AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Moa_IdModalidad"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }
    public function getCursoBusquedaMath($texto){
        $sql = "SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
                INNER JOIN constante CC ON CC.Con_Valor = C.Moa_IdModalidad AND CC.Con_Codigo = 1000
                WHERE (C.Cur_Titulo like '%{$texto}%'
                  OR C.Cur_Descripcion like '%{$texto}%')
                  AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Moa_IdModalidad"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function getCursoUsuario($usuario){
        $sql = "SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
                INNER JOIN constante CC ON CC.Con_Valor = C.Moa_IdModalidad AND CC.Con_Codigo = 1000
                INNER JOIN matricula_curso MC ON C.Cur_IdCurso = MC.Cur_IdCurso
                WHERE MC.Usu_IdUsuario = {$usuario} AND MC.Mat_Valor = 1
                  AND C.Cur_Estado = 1 AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Moa_IdModalidad"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          $c["Total"] = $this->getAnunciosCountTotal($c["Cur_IdCurso"]);
          $c["NoLeidos"] = $this->getAnunciosCountNoLeidos($usuario,$c["Cur_IdCurso"]);
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function getCursoDocente($usuario){
        $sql = "SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
                INNER JOIN constante CC ON CC.Con_Valor = C.Moa_IdModalidad AND CC.Con_Codigo = 1000
                WHERE C.Usu_IdUsuario = {$usuario}
                  AND C.Cur_Estado = 1 AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Moa_IdModalidad"]==2 || $c["Moa_IdModalidad"]!=2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function DetalleLMS($curso){
      $sql = "SELECT
                CONCAT(U.Usu_Nombre, ' ', U.Usu_Apellidos) as Docente,
                C.Cur_Vacantes,
                ifnull((SELECT COUNT(Mat_IdMatricula) FROM matricula_curso
                  WHERE Cur_IdCurso = {$curso} AND Mat_Valor=1), 0) as Matriculados
              FROM curso C
              INNER JOIN usuario  U ON U.Usu_IdUsuario = C.Usu_IdUsuario
              WHERE C.Cur_IdCurso = {$curso} AND U.Usu_Estado = 1 AND C.Cur_Estado = 1";
      return $this->getArray($sql)[0];
    }

    public function getAnunciosCountTotal($curso){
      $sql = "SELECT COUNT(*) Totales FROM anuncio_curso WHERE Cur_IdCurso=$curso AND Anc_Estado=1 AND Row_Estado=1";
      return $this->getArray($sql)[0];
    }

    public function getAnunciosCountNoLeidos($usuario,$curso){
      $sql = "SELECT COUNT(*) NoLeidos FROM anuncio_usuario anu
              INNER JOIN anuncio_curso anc ON anu.Anc_IdAnuncioCurso=anc.Anc_IdAnuncioCurso
              WHERE anu.Usu_IdUsuario=$usuario AND anu.Anu_Leido=0 AND anc.Cur_IdCurso=$curso AND anc.Anc_Estado=1 AND anc.Row_Estado=1";
      return $this->getArray($sql)[0];
    }

    public function getProgresoCurso($curso, $id_usuario){
      $sql = "SELECT
                (CASE WHEN Y.Lecciones = Y.Completos THEN 1 ELSE 0 END) as Completo,
                ROUND((Y.Completos*100/Y.Lecciones),1) as Porcentaje
              FROM
              (SELECT COUNT(X.nProgreso) as Lecciones, SUM(X.nProgreso) as Completos FROM
                (SELECT 1 as CONTADOR, (CASE WHEN PC1.Pro_IdProgreso IS NULL THEN 0
                              ELSE PC1.Pro_Valor END) as nProgreso
                  FROM leccion L1
                LEFT JOIN progreso_curso PC1 ON PC1.Lec_IdLeccion = L1.Lec_IdLeccion
                  AND PC1.Usu_IdUsuario = {$id_usuario}
                INNER JOIN modulo_curso MC ON L1.Moc_IdModuloCurso = MC.Moc_IdModuloCurso
                WHERE MC.Cur_IdCurso = {$curso} AND L1.Lec_Estado = 1 AND L1.Row_Estado = 1
                  AND MC.Moc_Estado = 1 AND MC.Row_Estado = 1)X
              GROUP BY X.CONTADOR)Y";

      $resultado = $this->getArray($sql);
      if($resultado!=null && count($resultado) > 0){ }else{
        $resultado = array();
        array_push($resultado, array("Completo" => "0", "Porcentaje" => "0"));
      }
      return $resultado[0];
    }

    public function getDetalleCurso($curso){
      $sql = "SELECT * FROM detalle_curso
              WHERE Cur_IdCurso = {$curso} AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    // public function getResultadoExamen($examen, $usuario){
    //   $sql = "SELECT SUM(CORRECTAS) as CORRECTAS, SUM(INCORRECTAS) as INCORRECTAS FROM
    //           (SELECT
    //             SUM(CASE WHEN X.Respuesta = 1 THEN 1 ELSE 0 END) as CORRECTAS,
    //             SUM(CASE WHEN X.Respuesta = 0 THEN 1 ELSE 0 END) as INCORRECTAS
    //           FROM
    //           (SELECT
    //             (CASE WHEN rr.Res_Descripcion = pp.Pre_Valor THEN 1 ELSE 0 END) as Respuesta
    //           FROM respuesta rr
    //           INNER JOIN pregunta pp ON pp.Pre_IdPregunta = rr.Pre_IdPregunta
    //           WHERE rr.Usu_IdUsuario = '{$usuario}' AND pp.Exa_IdExamen = '{$examen}'
    //             AND rr.Res_Intento =
    //           (SELECT ifnull(MAX(r.Res_Intento), 1) as Intento FROM respuesta r
    //           INNER JOIN pregunta p ON p.Pre_IdPregunta = r.Pre_IdPregunta
    //           WHERE r.Usu_IdUsuario = '{$usuario}' AND p.Exa_IdExamen = '{$examen}')) as X
    //           GROUP BY X.Respuesta)Y";
    //   $resultado = $this->getArray($sql);
    //   if( $resultado != null && count($resultado)>0){
    //     return $resultado[0];
    //   }
    //   return null;
    // }

    public function getUsuarioCurso($id){
      $sql = "SELECT * FROM usuario
              WHERE Usu_Estado = 1 AND Row_Estado = 1
              AND Usu_IdUsuario = (SELECT Usu_IdUsuario FROM curso
                                  WHERE Cur_IdCurso = {$id}
                                  AND Row_Estado = 1 AND Cur_Estado = 1)";
      return $this->getArray($sql);
    }

    public function getCursosUsuario($id){
      $sql = "SELECT * FROM curso WHERE Cur_Estado = 1 AND Row_Estado = 1 AND Usu_IdUsuario = {$id}";
      return $this->getArray($sql);
    }

    public function cursos_x_calendario($anio, $mes){
      $sql = "SELECT * FROM
              (SELECT
                1 as ESTADO,
                (SELECT C.Cur_IdCurso FROM curso c INNER JOIN modulo_curso mc on c.Cur_IdCurso = mc.Cur_IdCurso
                WHERE mc.Moc_IdModuloCurso = L.Moc_IdModuloCurso) as ID,
                (SELECT C.Cur_Titulo FROM curso c INNER JOIN modulo_curso mc on c.Cur_IdCurso = mc.Cur_IdCurso
                WHERE mc.Moc_IdModuloCurso = L.Moc_IdModuloCurso) as DET,
                HOUR(L.Lec_FechaDesde) as HORA,
                L.Lec_FechaDesde AS FECHA
              FROM leccion L WHERE Lec_IdLeccion IN
              (SELECT
                (SELECT l.Lec_IdLeccion FROM leccion l INNER JOIN modulo_curso mc ON l.Moc_IdModuloCurso = mc.Moc_IdModuloCurso
                WHERE mc.Cur_IdCurso = C.Cur_IdCurso AND mc.Moc_Estado = 1 AND mc.Row_Estado = 1 AND
                  l.Lec_Estado = 1 AND l.Row_Estado = 1 AND l.Lec_FechaDesde IS NOT NULL AND l.Lec_FechaHasta IS NOT NULL
                ORDER BY l.Lec_FechaDesde ASC LIMIT 1) as MiLeccion
              FROM curso C
              WHERE C.Cur_Estado = 1 AND C.Row_Estado = 1)
              UNION
              SELECT
                2 as ESTADO,
                (SELECT C.Cur_IdCurso FROM curso c INNER JOIN modulo_curso mc on c.Cur_IdCurso = mc.Cur_IdCurso
                WHERE mc.Moc_IdModuloCurso = L.Moc_IdModuloCurso) as ID,
                (SELECT C.Cur_Titulo FROM curso c INNER JOIN modulo_curso mc on c.Cur_IdCurso = mc.Cur_IdCurso
                WHERE mc.Moc_IdModuloCurso = L.Moc_IdModuloCurso) as DET,
                HOUR(L.Lec_FechaDesde) as HORA,
                L.Lec_FechaHasta AS FECHA
              FROM leccion L WHERE Lec_IdLeccion IN
              (SELECT
                (SELECT l.Lec_IdLeccion FROM leccion l INNER JOIN modulo_curso mc ON l.Moc_IdModuloCurso = mc.Moc_IdModuloCurso
                WHERE mc.Cur_IdCurso = C.Cur_IdCurso AND mc.Moc_Estado = 1 AND mc.Row_Estado = 1 AND
                  l.Lec_Estado = 1 AND l.Row_Estado = 1 AND l.Lec_FechaDesde IS NOT NULL AND l.Lec_FechaHasta IS NOT NULL
                ORDER BY l.Lec_FechaHasta DESC LIMIT 1) as MiLeccion
              FROM curso C
              WHERE C.Cur_Estado = 1 AND C.Row_Estado = 1))X
              WHERE MONTH(X.FECHA) = '{$mes}' AND YEAR(X.FECHA) = '{$anio}'
              ORDER BY X.FECHA";
      echo $sql; exit;
      return $this->getArray($sql);
    }

    public function calendario_curso_id($curso, $anio, $mes){
      $sql = "SELECT
                l.Lec_IdLeccion AS ID,
                DATE(l.Lec_FechaDesde) as FECHA,
                DAY(l.Lec_FechaDesde) as DIA,
                HOUR(l.Lec_FechaDesde) as HORA,
                l.Lec_Titulo as DET,
                1 as ESTADO
              FROM leccion L
              INNER JOIN modulo_curso mc ON l.Moc_IdModuloCurso = mc.Moc_IdModuloCurso
              WHERE mc.Cur_IdCurso = '{$curso}'
                AND mc.Moc_Estado = 1 AND mc.Row_Estado = 1
                AND l.Lec_Estado = 1 AND l.Row_Estado = 1
                AND MONTH(l.Lec_FechaDesde) = '{$mes}' AND YEAR(l.Lec_FechaDesde) = '{$anio}'
              ORDER BY l.Lec_FechaDesde ASC";
      return $this->getArray($sql);
    }

    public function getDuracionCurso($curso){
      $sql = "SELECT COUNT(*) as Total FROM leccion
              WHERE Moc_IdModuloCurso IN
                (SELECT Moc_IdModuloCurso FROM modulo_curso
                WHERE Cur_IdCurso = {$curso} AND Moc_Estado = 1 AND Row_Estado = 1)
              AND Row_Estado = 1 AND Lec_Estado = 1";
      $lec = $this->getArray($sql);
      if($lec!=null && count($lec)>0){
        return $lec[0];
      }else{
        return array("Total" => "0");
      }
    }




    // Jhon Martinez
    public function getCursoBusquedas($texto){
        $sql = " SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C

                INNER JOIN constante CC ON CC.Con_Valor = C.Moa_IdModalidad AND CC.Con_Codigo = 1000
                WHERE (C.Cur_Titulo like '%{$texto}%'
                  OR C.Cur_Descripcion like '%{$texto}%')
                  AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Moa_IdModalidad"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }
    //Jhon Martinez
    public function getCursosRowCount($condicion = "")
    {
        try{
            $sql = " SELECT COUNT(cr.Cur_IdCurso) AS CantidadRegistros FROM curso cr
              INNER JOIN matricula_curso mt ON cr.Cur_IdCurso = mt.Cur_IdCurso $condicion ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(cursoModel)", "getCursosRowCount", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    // Jhon Martinez
    public function getCursos($Usu_IdUsuario = false, $Texto = false){

        if ($Usu_IdUsuario) {
            $andUsuario = " AND mat.Usu_IdUsuario = " . $Usu_IdUsuario;
        } else {
            $andUsuario = " AND mat.Usu_IdUsuario = 0 ";
        }
        try{
            $sql = " SELECT   cr.Cur_IdCurso, cr.Cur_UrlBanner, cr.Cur_Titulo, cr.Cur_Descripcion, cr.Usu_IdUsuario, cr.Cur_Vacantes, cr.Cur_FechaDesde, cr.Moa_IdModalidad, CONCAT(u.Usu_Nombre,' ',u.Usu_Apellidos) AS Docente, cc.Con_Descripcion AS Modalidad, COUNT(mt.Mat_IdMatricula) AS Matriculados, (CASE WHEN AVG(vc.Val_Valor) > 0 THEN AVG(vc.Val_Valor) ELSE 0 END) AS Valoracion, (CASE WHEN cu_m.Matriculado = 1 THEN 1 ELSE 0 END) AS Inscrito FROM
                  (SELECT cur.Cur_IdCurso, 1 AS Matriculado FROM curso cur
                  INNER JOIN matricula_curso mat ON cur.Cur_IdCurso = mat.Cur_IdCurso
                  WHERE cur.Cur_Estado = 1 AND cur.Row_Estado = 1 AND mat.Mat_Valor = 1 ". $andUsuario . " ) cu_m
              RIGHT JOIN curso cr ON cu_m.Cur_IdCurso = cr.Cur_IdCurso
              INNER JOIN matricula_curso mt ON cr.Cur_IdCurso = mt.Cur_IdCurso
              INNER JOIN constante cc ON cr.Moa_IdModalidad = cc.Con_Valor AND cc.Con_Codigo = 1000
              INNER JOIN usuario u ON cr.Usu_IdUsuario = u.Usu_IdUsuario
              LEFT JOIN valoracion_curso vc ON cr.Cur_IdCurso = vc.Cur_IdCurso
              WHERE cr.Cur_Estado = 1 AND cr.Row_Estado = 1 AND mt.Mat_Valor = 1 " . $Texto . "
              GROUP BY cr.Cur_IdCurso ";
            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(cursoModel)", "getCursos", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    // Jhon Martinez
    public function getCursosPaginado($pagina = 1, $registrosXPagina = 1, $condicionActivos = "", $Usu_IdUsuario = false){

        $registroInicio = 0;
        if ($pagina > 0) {
            $registroInicio = ($pagina - 1) * $registrosXPagina;
        }

        if ($Usu_IdUsuario) {
            $andUsuario = " AND mat.Usu_IdUsuario = " . $Usu_IdUsuario;
        } else {
            $andUsuario = " AND mat.Usu_IdUsuario = 0 ";
        }

        try{
            $sql = " SELECT cur_so.*, COUNT(vc.Usu_IdUsuario) AS Valoraciones,
                    CAST((CASE WHEN AVG(vc.Val_Valor) > 0 THEN AVG(vc.Val_Valor) ELSE 0 END) AS DECIMAL(2,1)) AS Valor FROM
                    (   SELECT cr.Cur_IdCurso, cr.Cur_UrlBanner, cr.Cur_Titulo, cr.Cur_Descripcion, cr.Usu_IdUsuario, cr.Cur_Vacantes, cr.Cur_FechaDesde, cr.Moa_IdModalidad, CONCAT(u.Usu_Nombre,' ',u.Usu_Apellidos) AS Docente, cc.Con_Descripcion AS Modalidad, SUM(CASE WHEN mt.Mat_Valor = 1 THEN 1 ELSE 0 END) AS Matriculados, (CASE WHEN cu_m.Matriculado = 1 THEN 1 ELSE 0 END) AS Inscrito FROM
                            ( SELECT cur.Cur_IdCurso, 1 AS Matriculado FROM curso cur
                              INNER JOIN matricula_curso mat ON cur.Cur_IdCurso = mat.Cur_IdCurso
                              WHERE cur.Cur_Estado = 1 AND cur.Row_Estado = 1 AND mat.Mat_Valor = 1 $andUsuario ) cu_m
                        RIGHT JOIN curso cr ON cu_m.Cur_IdCurso = cr.Cur_IdCurso
                        LEFT JOIN matricula_curso mt ON cr.Cur_IdCurso = mt.Cur_IdCurso
                        INNER JOIN constante cc ON cr.Moa_IdModalidad = cc.Con_Valor AND cc.Con_Codigo = 1000
                        INNER JOIN usuario u ON cr.Usu_IdUsuario = u.Usu_IdUsuario $condicionActivos ) cur_so
                    LEFT JOIN valoracion_curso vc ON cur_so.Cur_IdCurso = vc.Cur_IdCurso
                    GROUP BY cur_so.Cur_IdCurso
                    LIMIT $registroInicio, $registrosXPagina " ;

            $result = $this->_db->prepare($sql);
            $result->execute();
            return $result->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(cursoModel)", "getCursosPaginado", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    // Jhon Martinez
    public function getConstante($cod, $valor = ""){
        try{
            $sql = " SELECT * FROM constante WHERE Con_Codigo = {$cod} ";
            if ($valor!="" ){ $sql .= " AND Con_Valor = {$valor} "; }
            $sql .= " AND Con_Estado = 1 AND Row_Estado = 1";
            return $this->getArray($sql);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(cursoModel)", "getConstante", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }
    // Jhon Martinez
    public function getParametroCurso($curso){
        try{
            $sql = " SELECT * FROM parametro_curso WHERE Cur_IdCurso = {$curso} ";
            return $this->getArray($sql);
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(cursoModel)", "getParametroCurso", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

}
