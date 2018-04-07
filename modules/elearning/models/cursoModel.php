<?php

class cursoModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getCurso(){
        $cursos = $this->getArray("SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
            INNER JOIN constante CC ON CC.Con_Valor = C.Mod_IdModCurso AND CC.Con_Codigo = 1000
            WHERE C.Cur_Estado = 1 AND C.Row_Estado = 1");
        $resultado = array();
        foreach ($cursos as $c) {
          if($c["Mod_IdModCurso"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function getCursoID($id){
        $cursos = $this->getArray("SELECT * FROM curso WHERE Cur_IdCurso = {$id} AND Cur_Estado = 1 AND Row_Estado = 1");
        $resultado = array();
        foreach ($cursos as $c) {
          if($c["Mod_IdModCurso"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function getCursoBusqueda($texto){
        $sql = "SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
                INNER JOIN constante CC ON CC.Con_Valor = C.Mod_IdModCurso AND CC.Con_Codigo = 1000
                WHERE (C.Cur_Titulo like '%{$texto}%'
                  OR C.Cur_Descripcion like '%{$texto}%')
                  AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Mod_IdModCurso"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function getCursoUsuario($usuario){
        $sql = "SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
                INNER JOIN constante CC ON CC.Con_Valor = C.Mod_IdModCurso AND CC.Con_Codigo = 1000
                INNER JOIN matricula_curso MC ON C.Cur_IdCurso = MC.Cur_IdCurso
                WHERE MC.Usu_IdUsuario = {$usuario} AND MC.Mat_Valor = 1
                  AND C.Cur_Estado = 1 AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Mod_IdModCurso"]==2){
            $c["Detalle"] = $this->DetalleLMS($c["Cur_IdCurso"]);
          }
          array_push($resultado, $c);
        }
        return $resultado;
    }

    public function getCursoDocente($usuario){
        $sql = "SELECT C.*, CC.Con_Descripcion as Modalidad FROM curso C
                INNER JOIN constante CC ON CC.Con_Valor = C.Mod_IdModCurso AND CC.Con_Codigo = 1000
                WHERE C.Usu_IdUsuario = {$usuario}
                  AND C.Cur_Estado = 1 AND C.Row_Estado = 1";
        $curso = $this->getArray($sql);
        $resultado = array();
        foreach ($curso as $c) {
          if($c["Mod_IdModCurso"]==2){
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
                INNER JOIN modulo_curso MC ON L1.Mod_IdModulo = MC.Mod_IdModulo
                WHERE MC.Cur_IdCurso = {$curso} AND L1.Lec_Estado = 1 AND L1.Row_Estado = 1
                  AND MC.Mod_Estado = 1 AND MC.Row_Estado = 1)X
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

    public function getResultadoExamen($examen, $usuario){
      $sql = "SELECT SUM(CORRECTAS) as CORRECTAS, SUM(INCORRECTAS) as INCORRECTAS FROM
              (SELECT
                SUM(CASE WHEN X.Respuesta = 1 THEN 1 ELSE 0 END) as CORRECTAS,
                SUM(CASE WHEN X.Respuesta = 0 THEN 1 ELSE 0 END) as INCORRECTAS
              FROM
              (SELECT
                (CASE WHEN rr.Res_Descripcion = pp.Pre_Valor THEN 1 ELSE 0 END) as Respuesta
              FROM respuesta rr
              INNER JOIN pregunta pp ON pp.Pre_IdPregunta = rr.Pre_IdPregunta
              WHERE rr.Usu_IdUsuario = '{$usuario}' AND pp.Exa_IdExamen = '{$examen}'
                AND rr.Res_Intento = 
              (SELECT ifnull(MAX(r.Res_Intento), 1) as Intento FROM respuesta r
              INNER JOIN pregunta p ON p.Pre_IdPregunta = r.Pre_IdPregunta
              WHERE r.Usu_IdUsuario = '{$usuario}' AND p.Exa_IdExamen = '{$examen}')) as X
              GROUP BY X.Respuesta)Y";
      $resultado = $this->getArray($sql);
      if( $resultado != null && count($resultado)>0){
        return $resultado[0];
      }
      return null;
    }
}
