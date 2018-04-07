<?php

class _gestionModuloModel extends Model {

  public function __construct() { parent::__construct(); }

  public function insertModulo($curso, $titulo, $descripcion){
    $sql = "INSERT INTO modulo_curso(Cur_IdCurso, Mod_Titulo, Mod_Descripcion, Mod_Estado)
            VALUES({$curso}, '{$titulo}', '{$descripcion}', 0)";
    $this->execQuery($sql);
  }

  public function getModulos($curso){
    $sql = "SELECT * FROM modulo_curso WHERE Cur_IdCurso = {$curso} AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function getModuloId($curso){
    $sql = "SELECT * FROM modulo_curso WHERE Mod_IdModulo = {$curso} AND Row_Estado = 1";
    return $this->getArray($sql)[0];
  }

  public function updateEstadoModulo($mod, $estado){
    $this->execQuery("UPDATE modulo_curso SET Mod_Estado = '$estado' WHERE Mod_IdModulo = $mod");
  }

  public function deleteModulo($mod){
    $this->execQuery("UPDATE modulo_curso SET Row_Estado = 0 WHERE Mod_IdModulo = $mod");
  }

  public function updateModulo($id, $titulo, $descripcion){
    $this->execQuery("UPDATE modulo_curso SET
                        Mod_Titulo = '{$titulo}',
                        Mod_Descripcion = '{$descripcion}'
                      WHERE Mod_IdModulo = $id");
  }
}
