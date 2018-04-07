<?php

class moduloModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getModulosCurso($id, $id_usuario = ""){
        $sql = "SELECT * FROM Modulo_Curso WHERE Cur_IdCurso = {$id}
                AND Mod_Estado = 1 AND Row_Estado = 1";
        $modulos = $this->getArray($sql);

        if ($id_usuario != "" && $modulos!=null && count($modulos) >0 ){
          $valor = array();
          $estModAnt = 1;
          foreach ($modulos as $i) {
            $pro = $this->getProgresoModulo($i["Mod_IdModulo"], $id_usuario);
            $i["Completo"] = $pro["Completo"];
            $i["Porcentaje"] = $pro["Porcentaje"];
            $i["Disponible"] = $estModAnt == 1 ? 1 : $pro["Completo"] ;
            array_push($valor, $i);
            $estModAnt = $pro["Completo"];
          }
          $modulos = $valor;
        }
        return $modulos;
    }

    public function getProgresoModulo($id_modulo, $id_usuario){
      $sql = "SELECT
                (CASE WHEN Y.Lecciones = Y.Completos THEN 1 ELSE 0 END) as Completo,
                ROUND((Y.Completos*100/Y.Lecciones),1) as Porcentaje
              FROM
              (SELECT COUNT(X.nProgreso) as Lecciones, SUM(X.nProgreso) as Completos FROM
                (SELECT 1 as CONTADOR, (CASE WHEN PC1.Pro_IdProgreso IS NULL THEN 0
                              ELSE PC1.Pro_Valor END) as nProgreso
                  FROM Leccion L1
                LEFT JOIN Progreso_Curso PC1 ON PC1.Lec_IdLeccion = L1.Lec_IdLeccion
                  AND PC1.Usu_IdUsuario = {$id_usuario}
                WHERE L1.Mod_IdModulo = {$id_modulo})X
              GROUP BY X.CONTADOR)Y";
      $resultado = $this->getArray($sql);
      if($resultado!=null && count($resultado) > 0){ }else{
        $resultado = array();
        array_push($resultado, array("Completo" => "0", "Porcentaje" => "0"));
      }
      return $resultado[0];
    }

    public function validarCursoModulo($curso, $modulo){
      $sql = "SELECT * FROM Modulo_Curso M
        INNER JOIN Curso C ON C.Cur_IdCurso = M.Cur_IdCurso
        WHERE M.Cur_IdCurso = '{$curso}' AND M.Mod_IdModulo = '{$modulo}'
          AND M.Mod_Estado = 1 AND M.Row_Estado = 1 AND C.Cur_Estado = 1 AND C.Row_Estado = 1";

      $modulo = $this->getArray($sql);
      if($modulo!=null && count($modulo) >0){
        return true;
      }
      return false;
    }

    public function validarModuloUsuario($modulo, $usuario){
      $sql = "SELECT M.Mod_IdModulo FROM Modulo_Curso M INNER JOIN
              (SELECT Cur_IdCurso, Mod_IdModulo FROM Modulo_Curso
                WHERE Mod_IdModulo = {$modulo}) X
              ON M.Cur_IdCurso = X.Cur_IdCurso AND M.Mod_IdModulo < X.Mod_IdModulo
              WHERE M.Mod_Estado = 1 AND M.Row_Estado = 1";
      $modPrevio = $this->getArray($sql);
      if($modPrevio!=null && count($modPrevio)>0){
        $modPrevio = $modPrevio[0];
        $progreso = $this->getProgresoModulo($modPrevio["Mod_IdModulo"], $usuario);
        if($progreso["Completo"]>0){
          return true;
        }else{
          return false;
        }
      }else{
        return true;
      }
    }

    public function getModulo($id){
        $sql = "SELECT * FROM Modulo_Curso WHERE Mod_IdModulo = {$id}
                AND Mod_Estado = 1 AND Row_Estado = 1";
        $modulo = $this->getArray($sql);
        if($modulo!=null && count($modulo)>0){
          $modulo = $modulo[0];
          $modulos = $this->getModulosCurso($modulo["Mod_IdModulo"]);

          $clave = array_search($modulo["Mod_IdModulo"], array_column($modulos, "Mod_IdModulo"));
          $modulo["Index"] = $clave + 1;

          return $modulo;
        }else{
          return null;
        }
    }

    public function getModulosCursoLMS($id){
        $sql = "SELECT * FROM Modulo_Curso WHERE Cur_IdCurso = {$id}
                AND Mod_Estado = 1 AND Row_Estado = 1 ORDER BY Mod_IdModulo";
        $modulos = $this->getArray($sql);
        $resultado = array();
        foreach ($modulos as $m) {
          $lec = "SELECT L.*,
                  (CASE WHEN DATE(Lec_FechaHasta) < DATE(NOW()) THEN 0 ELSE (CASE WHEN DATE(Lec_FechaHasta) = DATE(NOW()) THEN 1 ELSE 2 END ) END) as Activo
                  FROM Leccion L
                  WHERE L.Mod_IdModulo = {$m['Mod_IdModulo']} ORDER BY L.Lec_IdLeccion ASC";
          $m["LECCIONES"] = $this->getArray($lec);
          array_push($resultado, $m);
        }
        return $resultado;
    }
}
