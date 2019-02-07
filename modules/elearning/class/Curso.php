<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Curso extends Eloquent {
  protected $table = 'curso';
  protected $primaryKey = 'Cur_IdCurso';
  public $timestamps = false;

  /**
   * [existeAlumno valida solo el array que se le pase]
   *
   * @return  [type]  [return description]
   */
  public static function existeAlumno ($array, $alumno_id) {
    $res = false;
    if (is_array($array)) {
      foreach ($array as $key => $value) {
        if ($value['Usu_IdUsuario'] == $alumno_id && $value['Docente'] == 0)
          return true;
      }
    }
    return $res;
  }

  public static function existeCurso ($curso_id) {
    return self::where('Cur_IdCurso', $curso_id)->count() > 0;
  }
  

}