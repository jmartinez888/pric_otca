<?php

class inscripcionModel extends Model {

    public function __construct() { parent::__construct(); }

    public function getInscripcion($usuario, $curso){
        try {
            return $this->getArray("SELECT * FROM matricula_curso WHERE Usu_IdUsuario = '{$usuario}' AND Cur_IdCurso = '{$curso}' ");          
        } catch (PDOException $exception) {
            $this->registrarBitacora("elearning(inscripcionModel)", "getInscripcion", "Error Model", $exception);
            return $exception->getTraceAsString();
        }
    }

    public function getInscritos($curso){
      $sql = "SELECT COUNT(*) as Inscritos FROM matricula_curso WHERE Cur_IdCurso = {$curso} AND Mat_Valor = 1";
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
        $this->execQuery(" INSERT INTO matricula_curso(Usu_IdUsuario, Cur_IdCurso, Mat_Valor)
                          VALUES({$usuario}, {$curso}, {$estado}) ");
      }
    }
}
