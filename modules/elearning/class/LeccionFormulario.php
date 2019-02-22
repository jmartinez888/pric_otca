<?php

namespace App;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class LeccionFormulario extends Eloquent
{
  protected $table = 'leccion_formulario';
  protected $primaryKey = 'Lef_IdLeccFrm';
  const CREATED_AT = 'Lef_CreatedAt';
  const UPDATED_AT = 'Lef_UpdatedAt';

  public function formulario () {
    //relación de uno a uno 
  	return $this->belongsTo('App\Formulario', 'Frm_IdFormulario');
  }

  public function leccion () {
    //relación de uno a uno 
  	return $this->belongsTo('App\Leccion', 'Lec_IdLeccion');
  }
  public function scopeGetByCurso ($query, $curso_id) {
    return $query->select('leccion_formulario.*')
      ->join('leccion', 'leccion.Lec_IdLeccion', 'leccion_formulario.Lec_IdLeccion')
      ->join('formulario', 'formulario.Frm_IdFormulario', 'leccion_formulario.Frm_IdFormulario')
      ->leftJoin('modulo_curso', 'modulo_curso.Moc_IdModuloCurso', 'leccion.Moc_IdModuloCurso')
      ->where('formulario.Cur_IdCurso', $curso_id);
  }
  /**
   * [findByLeccion buscar formulario por su la lección a la que está ligada, ]
   *
   * @return  [type]  [return description]
   */
  public static function findByLeccion ($leccion_id) {
  	return self::where('Lec_IdLeccion', $leccion_id)->first();
  }
}

?>