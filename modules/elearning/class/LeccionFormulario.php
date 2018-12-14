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
  	return $this->belongsTo('App\Formulario', 'Frm_IdFormulario');
  }

  public static function findByLeccion ($leccion_id) {
  	return self::where('Lec_IdLeccion', $leccion_id)->first();
  }
}

?>