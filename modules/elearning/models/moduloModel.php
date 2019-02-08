<?php

class moduloModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getModulosCurso($id, $id_usuario = "", $Idi_IdIdioma = "es"){
        $sql = "SELECT 
                MC.Moc_IdModuloCurso,
                MC.Cur_IdCurso,
                 fn_TraducirContenido('modulo_curso','Moc_Titulo', MC.Moc_IdModuloCurso,'$Idi_IdIdioma', MC.Moc_Titulo) Moc_Titulo,
                 fn_TraducirContenido('modulo_curso','Moc_Descripcion', MC.Moc_IdModuloCurso,'$Idi_IdIdioma', MC.Moc_Descripcion) Moc_Descripcion,
                 MC.Moc_TiempoDedicacion,
                 MC.Moc_Porcentaje,
                 MC.Moc_FechaReg,
                  MC.Moc_Estado,
                  MC.Row_Estado,
                 fn_devolverIdioma('modulo_curso', MC.Moc_IdModuloCurso,'$Idi_IdIdioma', MC.Idi_IdIdioma) Idi_IdIdioma
              ,
              (SELECT MIN(Lec_IdLeccion) FROM leccion L
              WHERE L.Moc_IdModuloCurso = MC.Moc_IdModuloCurso
                AND L.Lec_Estado = 1 AND L.Row_Estado = 1) as PrimerLeccion
            FROM modulo_curso MC WHERE MC.Cur_IdCurso = {$id}
            AND MC.Moc_Estado = 1 AND MC.Row_Estado = 1";

        $modulos = $this->getArray($sql);

        if ($id_usuario != "" && $modulos!=null && count($modulos) >0 ){
          $valor = array();
          $estModAnt = 1;
          foreach ($modulos as $i) {
            $pro = $this->getProgresoModulo($i["Moc_IdModuloCurso"], $id_usuario);
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
                WHERE L1.Moc_IdModuloCurso = {$id_modulo} AND L1.Lec_Estado = 1 AND L1.Row_Estado = 1)X
              GROUP BY X.CONTADOR)Y";
      $resultado = $this->getArray($sql);
      if($resultado!=null && count($resultado) > 0){ }else{
        $resultado = array();
        array_push($resultado, array("Completo" => "0", "Porcentaje" => "0"));
      }
      return $resultado[0];
    }

    public function validarCursoModulo($curso, $modulo){
      $sql = "SELECT * FROM modulo_curso m
        INNER JOIN curso C ON C.Cur_IdCurso = m.Cur_IdCurso
        WHERE m.Cur_IdCurso = '{$curso}' AND m.Moc_IdModuloCurso = '{$modulo}'
          AND m.Moc_Estado = 1 AND m.Row_Estado = 1 AND C.Cur_Estado = 1 AND C.Row_Estado = 1";

      $modulo = $this->getArray($sql);
      if($modulo!=null && count($modulo) >0){
        return true;
      }
      return false;
    }

    public function validarModuloUsuario($modulo, $usuario){
      $sql = "SELECT M.Moc_IdModuloCurso FROM modulo_curso M INNER JOIN
              (SELECT Cur_IdCurso, Moc_IdModuloCurso FROM modulo_curso
                WHERE Moc_IdModuloCurso = {$modulo}) X
              ON M.Cur_IdCurso = X.Cur_IdCurso AND M.Moc_IdModuloCurso < X.Moc_IdModuloCurso
              WHERE M.Moc_Estado = 1 AND M.Row_Estado = 1";
      $modPrevio = $this->getArray($sql);
      if($modPrevio!=null && count($modPrevio)>0){
        $modPrevio = $modPrevio[0];
        $progreso = $this->getProgresoModulo($modPrevio["Moc_IdModuloCurso"], $usuario);
        if($progreso["Completo"]>0){
          return true;
        }else{
          return false;
        }
      }else{
        return true;
      }
    }

    public function getModulo($id,$Idi_IdIdioma="es"){
        $sql = "SELECT 
                Moc_IdModuloCurso,
                Cur_IdCurso,
                 fn_TraducirContenido('modulo_curso','Moc_Titulo', Moc_IdModuloCurso,'$Idi_IdIdioma', Moc_Titulo) Moc_Titulo,
                 fn_TraducirContenido('modulo_curso','Moc_Descripcion', Moc_IdModuloCurso,'$Idi_IdIdioma', Moc_Descripcion) Moc_Descripcion,
                 Moc_TiempoDedicacion,
                 Moc_Porcentaje,
                 Moc_FechaReg,
                  Moc_Estado,
                  Row_Estado,
                 fn_devolverIdioma('modulo_curso',Moc_IdModuloCurso,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma
                 FROM modulo_curso WHERE Moc_IdModuloCurso = {$id}
                AND Moc_Estado = 1 AND Row_Estado = 1";
        $modulo = $this->getArray($sql);
        if($modulo!=null && count($modulo)>0){
          $modulo = $modulo[0];
          $modulos = $this->getModulosCurso($modulo["Moc_IdModuloCurso"]);

          $clave = array_search($modulo["Moc_IdModuloCurso"], array_column($modulos, "Moc_IdModuloCurso"));
          $modulo["Index"] = $clave + 1;

          return $modulo;
        }else{
          return null;
        }
    }

    public function getModulosCursoLMS($Cur_IdCurso, $id_usuario, $Idi_IdIdioma="es"){
        $sql = "SELECT 
                Moc_IdModuloCurso,
                Cur_IdCurso,
                 fn_TraducirContenido('modulo_curso','Moc_Titulo', Moc_IdModuloCurso,'$Idi_IdIdioma', Moc_Titulo) Moc_Titulo,
                 fn_TraducirContenido('modulo_curso','Moc_Descripcion', Moc_IdModuloCurso,'$Idi_IdIdioma', Moc_Descripcion) Moc_Descripcion,
                 Moc_TiempoDedicacion,
                 Moc_Porcentaje,
                 Moc_FechaReg,
                  Moc_Estado,
                  Row_Estado,
                 fn_devolverIdioma('modulo_curso',Moc_IdModuloCurso,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma

                FROM modulo_curso WHERE Cur_IdCurso = {$Cur_IdCurso}
                AND Moc_Estado = 1 AND Row_Estado = 1 ORDER BY Moc_IdModuloCurso";
        $modulos = $this->getArray($sql);
        $resultado = array();
        foreach ($modulos as $m) {
          if ($id_usuario>0) {
            $lec = " SELECT (CASE WHEN pro.Pro_Valor IS NULL THEN 0 ELSE pro.Pro_Valor END) AS Disponible, LEC.* FROM (SELECT L.*, (CASE WHEN Lec_FechaHasta <= NOW() THEN 0 ELSE 1 END) as Activo
                  FROM leccion L
                  WHERE L.Moc_IdModuloCurso = {$m['Moc_IdModuloCurso']}
                    AND L.Lec_Estado = 1 AND L.Row_Estado = 1) LEC
                    LEFT JOIN progreso_curso pro ON LEC.Lec_IdLeccion = pro.Lec_IdLeccion AND pro.Usu_IdUsuario = {$id_usuario} ORDER BY LEC.Lec_IdLeccion ASC ";
          } else {

              $lec = "SELECT L.*, (CASE WHEN Lec_FechaHasta <= NOW() THEN 0 ELSE 1 END) as Activo
                      FROM leccion L
                      WHERE L.Moc_IdModuloCurso = {$m['Moc_IdModuloCurso']}
                        AND L.Lec_Estado = 1 AND L.Row_Estado = 1 ORDER BY L.Lec_IdLeccion ASC ";
          }

          $m["LECCIONES"] = $this->getArray($lec);
          array_push($resultado, $m);
        }
        if ($id_usuario != "" && $resultado!=null && count($resultado) >0 ){
          $valor = array();
          $estModAnt = 1;
          foreach ($resultado as $i) {
            $pro = $this->getProgresoModulo($i["Moc_IdModuloCurso"], $id_usuario);
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

    public function getNextModulo($modulo){
      $sql = "SELECT
                Moc_IdModuloCurso,
                (SELECT MIN(l.Lec_IdLeccion) FROM leccion l WHERE l.Moc_IdModuloCurso = m.Moc_IdModuloCurso
                AND l.Lec_Estado = 1 AND l.Row_Estado = 1) as Leccion
              FROM modulo_curso m
              WHERE m.Moc_IdModuloCurso =
              (SELECT MIN(Moc_IdModuloCurso) FROM modulo_curso
              WHERE Cur_IdCurso = (SELECT Cur_IdCurso FROM modulo_curso WHERE Moc_IdModuloCurso = {$modulo})
                AND Moc_IdModuloCurso > {$modulo}
                AND Moc_Estado = 1 AND Row_Estado = 1)";
      return $this->getArray($sql);
    }

    public function getModuloDatos($modulo){
      $sql = "SELECT m.Moc_IdModuloCurso FROM modulo_curso m
              WHERE Cur_IdCurso =
              (SELECT Cur_IdCurso FROM modulo_curso
              WHERE Moc_IdModuloCurso = {$modulo})
              AND m.Moc_Estado = 1 AND m.Row_Estado = 1
              ORDER BY m.Moc_IdModuloCurso ASC";
      $data = $this->getArray($sql);
      $indice = 0;
      $final = 0;
      for ($i = 0 ; $i < count($data); $i++) {
        if( (int)$data[$i]["Moc_IdModuloCurso"] == $modulo ){
          $indice = $i + 1;
          if($i == (count($data)-1) ){
            $final = 1;
          }
          break;
        }
      }
      return array("INDEX" => $indice, "FINAL" => $final);
    }


    public function getModulosCurso_Id($id){
        $sql = "SELECT * FROM modulo_curso WHERE Cur_IdCurso = {$id}
                ORDER BY Moc_IdModuloCurso";
        return $this->getArray($sql);
    }
}
