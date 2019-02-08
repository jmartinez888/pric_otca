<?php

class leccionModel extends Model {

    public function __construct() { parent::__construct(); }

    public function validarLeccion($leccion, $modulo, $usuario){
      if($leccion==""){
        $sql = "SELECT MIN(L.Lec_IdLeccion) as Lec_IdLeccion FROM modulo_curso M
                INNER JOIN leccion L ON L.Moc_IdModuloCurso = M.Moc_IdModuloCurso
                WHERE M.Moc_IdModuloCurso = {$modulo}
                  AND M.Moc_Estado = 1 AND M.Row_Estado = 1
                  AND L.Lec_Estado = 1 AND L.Row_Estado = 1";
      }else{
        $sql = "SELECT L.Lec_IdLeccion FROM leccion L INNER JOIN
                (SELECT Moc_IdModuloCurso, Lec_IdLeccion FROM leccion WHERE Lec_IdLeccion = {$leccion} AND Moc_IdModuloCurso = {$modulo} 
                AND Lec_Estado = 1 AND Row_Estado = 1) X
                ON L.Moc_IdModuloCurso = X.Moc_IdModuloCurso AND L.Lec_IdLeccion < X.Lec_IdLeccion AND L.Lec_Estado = 1 AND L.Row_Estado = 1";
      }
      $previo = $this->getArray($sql);
      // print_r($previo);exit;
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

    public function getLeccion($leccion = "", $modulo = "", $usuario = "", $Idi_IdIdioma = "es"){
      if($leccion==""){
        if($modulo!=""){
          if($usuario != ""){
            $sql = "SELECT 
                Lec_IdLeccion,
                Moc_IdModuloCurso,
                fn_TraducirContenido('leccion','Lec_Titulo',Lec_IdLeccion,'$Idi_IdIdioma',Lec_Titulo) Lec_Titulo,
                fn_TraducirContenido('leccion','Lec_Descripcion',Lec_IdLeccion,'$Idi_IdIdioma',Lec_Descripcion) Lec_Descripcion,
                Lec_TiempoDedicacion,
                Lec_Tipo,
                Lec_FechaDesde,
                Lec_FechaHasta,
                Lec_FechaReg,
                Lec_LMSEstado,
                Lec_LMSPizarra,
                Lec_Estado,
                Row_Estado
              FROM leccion WHERE Lec_Estado = 1 AND Row_Estado = 1
            AND Lec_IdLeccion =
            (SELECT IFNULL(
              MAX(PC.Lec_IdLeccion),
              (SELECT MIN(L.Lec_IdLeccion) as Lec_IdLeccion FROM leccion L
              WHERE L.Moc_IdModuloCurso = {$modulo})
            ) as Lec_IdLeccion
            FROM leccion LE
            INNER JOIN progreso_curso PC ON PC.Lec_IdLeccion = LE.Lec_IdLeccion
            WHERE LE.Moc_IdModuloCurso = {$modulo} AND PC.Usu_IdUsuario = {$usuario}
            AND PC.Pro_Valor = 1 AND LE.Lec_Estado = 1 AND LE.Row_Estado = 1)";
          }else{
            $sql = "SELECT * FROM leccion
            WHERE Lec_IdLeccion =
            (SELECT MIN(L.Lec_IdLeccion) as Lec_IdLeccion FROM leccion L
            WHERE L.Moc_IdModuloCurso = {$modulo})
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
        $lecciones = $this->getLecciones($leccion["Moc_IdModuloCurso"]);

        $clave = array_search($leccion["Lec_IdLeccion"], array_column($lecciones, "Lec_IdLeccion"));
        $leccion["Index"] = $clave + 1;

        return $leccion;
      }else{
        return null;
      }
    }

    public function getLecciones($modulo, $usuario = "", $Idi_IdIdioma = "es"){
      $sql = "SELECT 
              Lec_IdLeccion,
                Moc_IdModuloCurso,
                fn_TraducirContenido('leccion','Lec_Titulo',Lec_IdLeccion,'$Idi_IdIdioma',Lec_Titulo) Lec_Titulo,
                fn_TraducirContenido('leccion','Lec_Descripcion',Lec_IdLeccion,'$Idi_IdIdioma',Lec_Descripcion) Lec_Descripcion,
                Lec_TiempoDedicacion,
                Lec_Tipo,
                Lec_FechaDesde,
                Lec_FechaHasta,
                Lec_FechaReg,
                Lec_LMSEstado,
                Lec_LMSPizarra,
                Lec_Estado,
                Row_Estado,
                fn_devolverIdioma('leccion',Lec_IdLeccion,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma

               FROM leccion WHERE Moc_IdModuloCurso = {$modulo}
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
    // JM
    public function getModulosClave($curso, $usuario = ""){
      $sql = "SELECT * FROM modulo_curso WHERE Cur_IdCurso = {$curso}
              AND Moc_Estado = 1 AND Row_Estado = 1
              ORDER BY Moc_IdModuloCurso ASC";
      $modulos = $this->getArray($sql);
      $resultado = array();
      foreach ($modulos as $i) {
        $clave = array_search($i["Moc_IdModuloCurso"], array_column($modulos, "Moc_IdModuloCurso"));
        $i["Index"] = $clave + 1;
        array_push($resultado, $i);
      }
      return $resultado;
    }
    // JM
    public function getLeccionUno($Moc_IdModuloCurso){
      $sql = " SELECT MIN(L.Lec_IdLeccion) as PrimerLeccion,L.* FROM leccion L
              WHERE L.Moc_IdModuloCurso = $Moc_IdModuloCurso
                AND L.Lec_Estado = 1 AND L.Row_Estado = 1 ";
            
      $resultado = $this->getArray($sql);
      return $resultado;
    }

    public function RegistrarProgreso($leccion, $usuario){ 
    
      $progreso = $this->getProgresoLeccion($leccion, $usuario);

      if($progreso["Completo"] == 0){
        $sql = " INSERT INTO progreso_curso(Lec_IdLeccion, Usu_IdUsuario, Pro_Valor)
                VALUES({$leccion}, {$usuario}, 1) ";
        $this->execQuery($sql);
      }
    }

    public function getContenido($leccion, $Idi_IdIdioma="es"){
      $sql = "SELECT c.CL_IdContenido,
      c.Lec_IdLeccion,
      fn_TraducirContenido('contenido','CL_Titulo',c.CL_IdContenido,'$Idi_IdIdioma',c.CL_Titulo) CL_Titulo,
      fn_TraducirContenido('contenido','CL_Descripcion',c.CL_IdContenido,'$Idi_IdIdioma',c.CL_Descripcion) CL_Descripcion,
      c.CL_FechaReg,
      c.CL_Estado,
      c.Row_Estado,
      fn_devolverIdioma('contenido',c.CL_IdContenido,'$Idi_IdIdioma',c.Idi_IdIdioma) Idi_IdIdioma
      FROM contenido_leccion c WHERE c.Lec_IdLeccion = {$leccion}
              AND c.CL_Estado = 1 AND c.Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getReferencias($leccion, $Idi_IdIdioma="es"){
      $sql = "SELECT Ref_IdReferencia,
      Lec_IdLeccion,
      fn_TraducirContenido('referencia_leccion','Ref_Titulo',Ref_IdReferencia,'$Idi_IdIdioma',Ref_Titulo) Ref_Titulo,
      fn_TraducirContenido('referencia_leccion','Ref_Descripcion',Ref_IdReferencia,'$Idi_IdIdioma',Ref_Descripcion) Ref_Descripcion,
      Ref_FechaReg,
      Ref_Estado,
      Row_Estado,
      fn_devolverIdioma('referencia_leccion',Ref_IdReferencia,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma
      FROM referencia_leccion
              WHERE Lec_IdLeccion = {$leccion} AND Ref_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getMateriales($leccion){
      $sql = "SELECT * FROM material_leccion
              WHERE Lec_IdLeccion = {$leccion} AND Mat_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    /* PARA EL CASO LMS*/
    public function getLeccionesLMS($curso, $Idi_IdIdioma = "es"){
      $sql = " SELECT 
                L.Lec_IdLeccion,
                L.Moc_IdModuloCurso,
                fn_TraducirContenido('leccion','Lec_Titulo',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_Titulo) Lec_Titulo,
                fn_TraducirContenido('leccion','Lec_Descripcion',L.Lec_IdLeccion,'$Idi_IdIdioma',L.Lec_Descripcion) Lec_Descripcion,
                L.Lec_TiempoDedicacion,
                L.Lec_Tipo,
                L.Lec_FechaDesde,
                L.Lec_FechaHasta,
                L.Lec_FechaReg,
                L.Lec_LMSEstado,
                L.Lec_LMSPizarra,
                L.Lec_Estado,
                L.Row_Estado

                 FROM leccion L
              INNER JOIN modulo_curso M ON L.Moc_IdModuloCurso = M.Moc_IdModuloCurso
              INNER JOIN curso C ON M.Cur_IdCurso = C.Cur_IdCurso AND C.Cur_IdCurso = {$curso}
              WHERE C.Cur_Estado = 1 AND M.Moc_Estado = 1 AND L.Lec_Estado = 1
                AND C.Row_Estado = 1 AND M.Row_Estado = 1 AND L.Row_Estado = 1
              ORDER BY L.Lec_FechaDesde ASC ";
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
