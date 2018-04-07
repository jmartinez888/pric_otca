<?php

class leccionModel extends Model {

    public function __construct() { parent::__construct(); }

    public function validarLeccion($leccion, $modulo, $usuario){
      if($leccion==""){
        $sql = "SELECT MIN(L.Lec_IdLeccion) as Lec_IdLeccion FROM modulo_curso M
                INNER JOIN leccion L ON L.Mod_IdModulo = M.Mod_IdModulo
                WHERE M.Mod_IdModulo = {$modulo}
                  AND M.Mod_Estado = 1 AND M.Row_Estado = 1
                  AND L.Lec_Estado = 1 AND L.Row_Estado = 1";
      }else{
        $sql = "SELECT L.Lec_IdLeccion FROM leccion L INNER JOIN
                (SELECT Mod_IdModulo, Lec_IdLeccion FROM leccion WHERE Lec_IdLeccion = {$leccion}
                AND Lec_Estado = 1 AND Row_Estado = 1)X
                ON L.Mod_IdModulo = X.Mod_IdModulo AND L.Lec_IdLeccion < X.Lec_IdLeccion
                  AND L.Lec_Estado = 1 AND L.Row_Estado = 1";
      }
      $previo = $this->getArray($sql);
      if($leccion==""){
        return count($previo) > 0;
      }
      if($previo!=null && count($previo)>0){
        $lecPrev = $this->getProgresoLeccion($previo[0]["Lec_IdLeccion"], $usuario);
        if($lecPrev["Completo"]==1){
          return true;
        }else{
          return false;
        }
      }else{
        return true;
      }
    }

    public function getProgresoLeccion($leccion, $usuario){
      $sql = "SELECT Pro_Valor FROM progreso_curso WHERE Lec_IdLeccion = {$leccion} AND Usu_IdUsuario = {$usuario} ";
      $resultado = $this->getArray($sql);

      $result = array();
      if($resultado!=null && count($resultado) > 0){
        array_push($result, array("Completo" => $resultado[0]["Pro_Valor"]));
      }else{
        array_push($result, array("Completo" => "0"));
      }
      return $result[0];
    }

    public function getLeccion($leccion = "", $modulo = "", $usuario = ""){
      if($leccion==""){
        if($modulo!=""){
          if($usuario != ""){
            $sql = "SELECT * FROM leccion WHERE Lec_Estado = 1 AND Row_Estado = 1
            AND Lec_IdLeccion =
            (SELECT IFNULL(
              MAX(PC.Lec_IdLeccion),
              (SELECT MIN(L.Lec_IdLeccion) as Lec_IdLeccion FROM leccion L
              WHERE L.Mod_IdModulo = {$modulo})
            ) as Lec_IdLeccion
            FROM leccion LE
            LEFT JOIN progreso_curso PC ON PC.Lec_IdLeccion = LE.Lec_IdLeccion
            WHERE LE.Mod_IdModulo = {$modulo} AND PC.Usu_IdUsuario = {$usuario}
            AND PC.Pro_Valor = 1 AND LE.Lec_Estado = 1 AND LE.Row_Estado = 1)";
          }else{
            $sql = "SELECT * FROM leccion
            WHERE Lec_IdLeccion =
            (SELECT MIN(L.Lec_IdLeccion) as Lec_IdLeccion FROM leccion L
            WHERE L.Mod_IdModulo = {$modulo})
            AND Lec_Estado = 1 AND Row_Estado = 1";
          }
        }else{
          return null;
        }
      }else{
        $sql = "SELECT * FROM leccion WHERE Lec_IdLeccion = {$leccion}
                AND Lec_Estado = 1 AND Row_Estado = 1";
      }
      $prev = $this->getArray($sql);
      
      if($prev!=null && count($prev)>0){
        $leccion = $prev[0];
        $lecciones = $this->getLecciones($leccion["Mod_IdModulo"]);

        $clave = array_search($leccion["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
        $leccion["Index"] = $clave + 1;

        return $leccion;
      }else{
        return null;
      }
    }

    public function getLecciones($modulo, $usuario = ""){
      $sql = "SELECT * FROM leccion WHERE Mod_IdModulo = {$modulo}
              AND Lec_Estado = 1 AND Row_Estado = 1
              ORDER BY Lec_IdLeccion ASC";
      $lecciones = $this->getArray($sql);
      $resultado = array();
      foreach ($lecciones as $i) {
        $clave = array_search($i["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
        $i["Index"] = $clave + 1;
        if($usuario!=""){
          $i["Progreso"] = $this->getProgresoLeccion($i["Lec_IdLeccion"], $usuario)["Completo"];
        }else{
          $i["Progreso"] = 0;
        }
        array_push($resultado, $i);
      }
      return $resultado;
    }

    public function RegistrarProgreso($leccion, $usuario){ 
    
      $progreso = $this->getProgresoLeccion($leccion, $usuario);

      if($progreso["Completo"] == 0){
        $sql = "INSERT INTO progreso_curso(Lec_IdLeccion, Usu_IdUsuario, Pro_Valor)
                VALUES({$leccion}, {$usuario}, 1)";
        $this->execQuery($sql);
      }
    }

    public function getContenido($leccion){
      $sql = "SELECT * FROM contenido_leccion WHERE Lec_IdLeccion = {$leccion}
              AND CL_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getReferencias($leccion){
      $sql = "SELECT * FROM referencia_leccion
              WHERE Lec_IdLeccion = {$leccion} AND Ref_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getMateriales($leccion){
      $sql = "SELECT * FROM material_leccion
              WHERE Lec_IdLeccion = {$leccion} AND Mat_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    /* PARA EL CASO LMS*/
    public function getLeccionesLMS($curso){
      $sql = "SELECT * FROM leccion L
              INNER JOIN modulo_curso M ON L.Mod_IdModulo = M.Mod_IdModulo
              INNER JOIN curso C ON M.Cur_IdCurso = C.Cur_IdCurso AND C.Cur_IdCurso = {$curso}
              WHERE C.Cur_Estado = 1 AND M.Mod_Estado = 1 AND L.Lec_Estado = 1
                AND C.Row_Estado = 1 AND M.Row_Estado = 1 AND L.Row_Estado = 1
              ORDER BY L.Lec_FechaDesde ASC";
      $lecciones = $this->getArray($sql);
      return $lecciones;
    }

    public function EstadoLeccionLMS($leccion, $estado){
      $sql = "UPDATE leccion SET Lec_LMSEstado = {$estado}
              WHERE Lec_IdLeccion = {$leccion} AND Lec_Estado = 1
                AND Row_Estado = 1";
      $this->execQuery($sql);
    }

    public function RegistrarPizarra($leccion, $pizarra){
      $sql = "UPDATE leccion SET Lec_LMSPizarra = {$pizarra} WHERE Lec_IdLeccion = {$leccion}";
      $this->execQuery($sql);
    }
}
