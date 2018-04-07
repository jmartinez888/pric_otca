<?php

class moduloModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getModulosCurso($id, $id_usuario = ""){
        $sql = "SELECT MC.*,
              (SELECT MIN(Lec_IdLeccion) FROM leccion L
              WHERE L.Mod_IdModulo = MC.Mod_IdModulo
                AND L.Lec_Estado = 1 AND L.Row_Estado = 1) as PrimerLeccion 
            FROM modulo_curso MC WHERE MC.Cur_IdCurso = {$id} 
            AND MC.Mod_Estado = 1 AND MC.Row_Estado = 1";
            
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
                  FROM leccion L1
                LEFT JOIN progreso_curso PC1 ON PC1.Lec_IdLeccion = L1.Lec_IdLeccion
                  AND PC1.Usu_IdUsuario = {$id_usuario}
                WHERE L1.Mod_IdModulo = {$id_modulo} AND L1.Lec_Estado = 1 AND L1.Row_Estado = 1)X
              GROUP BY X.CONTADOR)Y";
      $resultado = $this->getArray($sql);
      if($resultado!=null && count($resultado) > 0){ }else{
        $resultado = array();
        array_push($resultado, array("Completo" => "0", "Porcentaje" => "0"));
      }
      return $resultado[0];
    }

    public function validarCursoModulo($curso, $modulo){
      $sql = "SELECT * FROM modulo_curso M
        INNER JOIN curso C ON C.Cur_IdCurso = M.Cur_IdCurso
        WHERE M.Cur_IdCurso = '{$curso}' AND M.Mod_IdModulo = '{$modulo}'
          AND M.Mod_Estado = 1 AND M.Row_Estado = 1 AND C.Cur_Estado = 1 AND C.Row_Estado = 1";

      $modulo = $this->getArray($sql);
      if($modulo!=null && count($modulo) >0){
        return true;
      }
      return false;
    }

    public function validarModuloUsuario($modulo, $usuario){
      $sql = "SELECT M.Mod_IdModulo FROM modulo_curso M INNER JOIN
              (SELECT Cur_IdCurso, Mod_IdModulo FROM modulo_curso
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
        $sql = "SELECT * FROM modulo_curso WHERE Mod_IdModulo = {$id}
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
        $sql = "SELECT * FROM modulo_curso WHERE Cur_IdCurso = {$id}
                AND Mod_Estado = 1 AND Row_Estado = 1 ORDER BY Mod_IdModulo";
        $modulos = $this->getArray($sql);
        $resultado = array();
        foreach ($modulos as $m) {
          $lec = "SELECT L.*, (CASE WHEN Lec_FechaHasta <= NOW() THEN 0 ELSE 1 END) as Activo
                  FROM leccion L
                  WHERE L.Mod_IdModulo = {$m['Mod_IdModulo']}";
          $m["LECCIONES"] = $this->getArray($lec);
          array_push($resultado, $m);
        }
        return $resultado;
    }

    public function getNextModulo($modulo){
      $sql = "SELECT 
                Mod_IdModulo,
                (SELECT MIN(l.Lec_IdLeccion) FROM leccion l WHERE l.Mod_IdModulo = m.Mod_IdModulo 
                AND l.Lec_Estado = 1 AND l.Row_Estado = 1) as Leccion
              FROM modulo_curso m 
              WHERE m.Mod_IdModulo =
              (SELECT MIN(Mod_IdModulo) FROM modulo_curso 
              WHERE Cur_IdCurso = (SELECT Cur_IdCurso FROM modulo_curso WHERE Mod_IdModulo = {$modulo})
                AND Mod_IdModulo > {$modulo}
                AND Mod_Estado = 1 AND Row_Estado = 1)";
      return $this->getArray($sql);
    }

    public function getModuloDatos($modulo){
      $sql = "SELECT m.Mod_IdModulo FROM modulo_curso m 
              WHERE Cur_IdCurso = 
              (SELECT Cur_IdCurso FROM modulo_curso 
              WHERE Mod_IdModulo = {$modulo})
              AND m.Mod_Estado = 1 AND m.Row_Estado = 1
              ORDER BY m.Mod_IdModulo ASC";
      $data = $this->getArray($sql);
      $indice = 0;
      $final = 0;
      for ($i = 0 ; $i < count($data); $i++) {
        if( (int)$data[$i]["Mod_IdModulo"] == $modulo ){
          $indice = $i + 1;
          if($i == (count($data)-1) ){
            $final = 1;
          }
          break;
        }
      }
      return array("INDEX" => $indice, "FINAL" => $final);
    }
}
