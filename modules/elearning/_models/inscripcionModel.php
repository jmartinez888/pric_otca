<?php

class inscripcionModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getInscripcion($usuario, $curso){
        return $this->getArray("SELECT * FROM Matricula_Curso
          WHERE Usu_IdUsuario = '{$usuario}'
            AND Cur_IdCurso = '{$curso}' ");
    }

    public function getInscritos($curso){
      $sql = "SELECT COUNT(*) as Inscritos FROM Matricula_Curso WHERE Cur_IdCurso = {$curso} AND Mat_Valor = 1";
      $valor = $this->getArray($sql);
      if($valor!=null && count($valor)>0){
        return $valor[0]["Inscritos"];
      }else{
        return 0;
      }
    }

    public function insertarInscripcion($usuario, $curso, $estado){
      $pre = $this->getInscripcion($usuario, $curso);

      if($pre==null || count($pre)==0){
        $this->execQuery("INSERT INTO Matricula_Curso(Usu_IdUsuario, Cur_IdCurso, Mat_Valor)
                          VALUES({$usuario}, {$curso}, {$estado})");
      }
    }
}
