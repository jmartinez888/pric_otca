<?php

class _gestionModuloModel extends Model {

  public function __construct() { parent::__construct(); }

  public function insertModulo($curso, $titulo, $descripcion, $dedicacion){
    $sql = "INSERT INTO modulo_curso(Cur_IdCurso, Moc_Titulo, Moc_Descripcion, Moc_TiempoDedicacion, Moc_Estado)
            VALUES({$curso}, '{$titulo}', '{$descripcion}', '{$dedicacion}', 0)";
    $this->execQuery($sql);
  }

  public function getModulos($curso, $Idi_IdIdioma = "es"){
    $sql = "SELECT Moc_IdModuloCurso,
    Cur_IdCurso,
    fn_TraducirContenido('modulo_curso','Moc_Titulo',Moc_IdModuloCurso,'$Idi_IdIdioma',Moc_Titulo) Moc_Titulo,
    fn_TraducirContenido('modulo_curso','Moc_Descripcion',Moc_IdModuloCurso,'$Idi_IdIdioma',Moc_Descripcion) Moc_Descripcion,
    fn_TraducirContenido('modulo_curso','Moc_TiempoDedicacion',Moc_IdModuloCurso,'$Idi_IdIdioma',Moc_TiempoDedicacion) Moc_TiempoDedicacion,
    Moc_Porcentaje,
    Moc_FechaReg,
    Moc_Estado,
    Row_Estado,
    fn_devolverIdioma('modulo_curso',Moc_IdModuloCurso,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma
    FROM modulo_curso WHERE Cur_IdCurso = {$curso} AND Row_Estado = 1";
    return $this->getArray($sql);
  }

  public function getModuloId($curso, $Idi_IdIdioma = "es"){
    $sql = "SELECT Moc_IdModuloCurso,
    Cur_IdCurso,
    fn_TraducirContenido('modulo_curso','Moc_Titulo',Moc_IdModuloCurso,'$Idi_IdIdioma',Moc_Titulo) Moc_Titulo,
    fn_TraducirContenido('modulo_curso','Moc_Descripcion',Moc_IdModuloCurso,'$Idi_IdIdioma',Moc_Descripcion) Moc_Descripcion,
    fn_TraducirContenido('modulo_curso','Moc_TiempoDedicacion',Moc_IdModuloCurso,'$Idi_IdIdioma',Moc_TiempoDedicacion) Moc_TiempoDedicacion,
    Moc_Porcentaje,
    Moc_FechaReg,
    Moc_Estado,
    Row_Estado,
    fn_devolverIdioma('modulo_curso',Moc_IdModuloCurso,'$Idi_IdIdioma',Idi_IdIdioma) Idi_IdIdioma
    FROM modulo_curso WHERE Moc_IdModuloCurso = {$curso} AND Row_Estado = 1";
    return $this->getArray($sql)[0];
  }
  public function getContTraducido($Cot_Tabla = "", $Cot_IdRegistro = "", $Idi_IdIdioma = "")
  {
     return $this->getContTrad($Cot_Tabla, $Cot_IdRegistro, $Idi_IdIdioma);
  }

  public function getCursoId($curso){
    $sql = "SELECT * FROM curso WHERE Cur_IdCurso = {$curso} AND Row_Estado = 1 ";
    if (isset($this->getArray($sql)[0]) && count($this->getArray($sql)) > 0) {
      return $this->getArray($sql)[0];
    } else {

    return $this->getArray($sql);
    }
  }

  public function updateEstadoModulo($mod, $estado){
    $this->execQuery("UPDATE modulo_curso SET Moc_Estado = '$estado' WHERE Moc_IdModuloCurso = $mod");
  }

  public function deleteModulo($mod){
    $this->execQuery("UPDATE modulo_curso SET Row_Estado = 0 WHERE Moc_IdModuloCurso = $mod");
  }

  public function updateModulo($id, $titulo, $descripcion, $dedicacion){
    $this->execQuery("UPDATE modulo_curso SET
                        Moc_Titulo = '{$titulo}',
                        Moc_Descripcion = '{$descripcion}',
                        Moc_TiempoDedicacion = '{$dedicacion}'
                      WHERE Moc_IdModuloCurso = $id");
  }
}
