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