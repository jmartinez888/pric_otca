<?php

class examenModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getExamen($leccion){
      $sql = "SELECT * FROM Examen WHERE Lec_IdLeccion = {$leccion}
              AND Exa_Estado = 1 AND Row_Estado = 1";
      $examen = $this->getArray($sql);
      if($examen!=null && count($examen)>0){
        $examen = $examen[0];
        $examen["PREGUNTAS"] = $this->getPreguntas($examen["Exa_IdExamen"]);
        return $examen;
      }
      return null;
    }

    public function getExamenID($examen){
      $sql = "SELECT * FROM Examen WHERE Exa_IdExamen = {$examen}";
      $examen = $this->getArray($sql);
      return $examen[0];
    }

    public function getPregunta($pregunta){
      $sql = "SELECT * FROM Pregunta WHERE Pre_IdPregunta = {$pregunta}
              AND Pre_Estado = 1 AND Row_Estado = 1";
      return $this->getArray($sql);
    }

    public function getPreguntas($examen){
      $sql = "SELECT * FROM Pregunta WHERE Exa_IdExamen = {$examen}
              AND Pre_Estado = 1 AND Row_Estado = 1";
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
      $sql = "SELECT * FROM Alternativa WHERE Pre_IdPregunta = {$pregunta}
              AND Alt_Estado = 1 AND Row_Estado = 1 ORDER BY RAND()";
      return $this->getArray($sql);
    }

    public function insertRespuesta($usuario, $pregunta, $respuesta){
      $validate = $this->getArray("SELECT * FROM Respuesta WHERE Usu_IdUsuario = {$usuario}
                                   AND Pre_IdPregunta = {$pregunta} ORDER BY Res_Intento DESC LIMIT 1");
      if($validate != null && count($validate)> 0){
        $validate = $validate[0]["Res_Intento"] + 1;
        $sql = "INSERT INTO Respuesta(Pre_IdPregunta, Usu_IdUsuario, Res_Descripcion, Res_Intento)
        VALUES({$pregunta}, {$usuario}, '{$respuesta}', {$validate})";
      }else{
        $sql = "INSERT INTO Respuesta(Pre_IdPregunta, Usu_IdUsuario, Res_Descripcion, Res_Intento)
        VALUES({$pregunta}, {$usuario}, '{$respuesta}', 1)";
      }
      $this->execQuery($sql);
    }

    public function getIntentos($examen, $usuario){
      $sql = "SELECT ifnull( MAX(R.Res_Intento), 0) INTENTOS FROM Respuesta R
              INNER JOIN Pregunta P ON R.Pre_IdPregunta = P.Pre_IdPregunta
              INNER JOIN Examen E ON P.Exa_IdExamen = E.Exa_IdExamen
              WHERE E.Exa_IdExamen = {$examen} AND R.Usu_IdUsuario = {$usuario}";
      $data = $this->getArray($sql);

      if($data != null && count($data) > 0 ){
        return $data[0]["INTENTOS"];
      }else{
        return 0;
      }
    }
}
