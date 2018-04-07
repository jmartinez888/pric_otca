<?php

class examenModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getExamen($leccion){
      $sql = "SELECT * FROM examen WHERE Lec_IdLeccion = {$leccion}
              AND Exa_Estado = 1 AND Row_Estado = 1";
      $examen = $this->getArray($sql);
      if($examen!=null && count($examen)>0){
        $examen = $examen[0];
        $examen["PREGUNTAS"] = $this->getPreguntas($examen["Exa_IdExamen"], $examen["Exa_NroPreguntas"]);
        return $examen;
      }
      return null;
    }

    public function getExamenID($examen){
      $sql = "SELECT * FROM examen WHERE Exa_IdExamen = {$examen}";
      $examen = $this->getArray($sql);
      return $examen[0];
    }

    public function getPregunta($pregunta){
      $sql = "SELECT * FROM pregunta WHERE Pre_IdPregunta = {$pregunta}
              AND Pre_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getPreguntas($examen, $nro){
      $sql = "SELECT * FROM pregunta 
              WHERE Exa_IdExamen = {$examen}
              AND Pre_Estado = 1 AND Row_Estado = 1 ORDER BY RAND() LIMIT {$nro}";
      $preguntas = $this->getArray($sql);
      $resultado = array();
      $indice = 1;
      foreach ($preguntas as $i) {
        if($i["TP_IdTpoPregunta"]==1){
          $i["ALTERNATIVAS"] = $this->getAlternativas($i["Pre_IdPregunta"]);
        }
        $i["INDEX"] = $indice; $indice++;
        array_push($resultado, $i);
      }
      return $resultado;
    }

    public function getAlternativas($pregunta){
      $sql = "SELECT * FROM alternativa WHERE Pre_IdPregunta = {$pregunta}
              AND Alt_Estado = 1 AND Row_Estado = 1 ORDER BY RAND()";
      return $this->getArray($sql);
    }

    public function insertRespuesta($usuario, $pregunta, $respuesta, $intentos){
      if($intentos > 0){
        $nuevo = $intentos + 1;
        $sql = "INSERT INTO respuesta(Pre_IdPregunta, Usu_IdUsuario, Res_Descripcion, Res_Intento, Res_Estado)
        VALUES({$pregunta}, {$usuario}, '{$respuesta}', {$nuevo}, 1)";
      }else{
        $sql = "INSERT INTO respuesta(Pre_IdPregunta, Usu_IdUsuario, Res_Descripcion, Res_Intento, Res_Estado)
        VALUES({$pregunta}, {$usuario}, '{$respuesta}', 1, 1)";
      }
      $this->execQuery($sql);
    }

    public function getIntentos($examen, $usuario){
      $sql = "SELECT ifnull( MAX(R.Res_Intento), 0) INTENTOS FROM respuesta R
              INNER JOIN pregunta P ON R.Pre_IdPregunta = P.Pre_IdPregunta
              INNER JOIN examen E ON P.Exa_IdExamen = E.Exa_IdExamen
              WHERE E.Exa_IdExamen = {$examen} AND R.Usu_IdUsuario = {$usuario}
                AND E.Exa_Estado = 1 AND E.Row_Estado = 1 
                AND P.Pre_Estado = 1 AND P.Row_Estado = 1 
                AND R.Row_Estado = 1";
      $data = $this->getArray($sql);

      if($data != null && count($data) > 0 ){
        return $data[0]["INTENTOS"];
      }else{
        return 0;
      }
    }

    public function getRespuestas($usuario){
      $sql = "SELECT * FROM alternativa WHERE Pre_IdPregunta = {$pregunta}
              AND Alt_Estado = 1 AND Row_Estado = 1 ORDER BY RAND()";
      return $this->getArray($sql);
    }
}
