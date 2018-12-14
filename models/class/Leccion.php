<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Leccion extends Eloquent
{
  protected $table = 'leccion';
  protected $primaryKey = 'Lec_IdLeccion';
  public $timestamps = false;

  public function modulo () {
  	return $this->belongsTo('App\ModuloCurso', 'Moc_IdModuloCurso');
  }

  public function leccion_formulario () {
  	return $this->hasOne('App\LeccionFormulario', 'Lec_IdLeccion');
  }
  /**
   * [getByModulos obtener lecciones por los n módulos assignados]
   * @param  [array|string] $modulo_id []
   * @return [array]            [description]
   */
  public function scopegetByModulos ($query, $modulos_id) {
  	return $query->whereIn('Moc_IdModuloCurso', $modulos_id);
  }

  public function scopegetEncuestas ($query) {
  	return $query->where('Lec_Tipo', 10);
  }

  // public function scopeActivos () {

  // }
}
