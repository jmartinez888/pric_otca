<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Leccion extends Eloquent
{
  protected $table = 'leccion';
  protected $primaryKey = 'Lec_IdLeccion';
  public $timestamps = false;

  public function leccion_formulario () {
  	return $this->hasOne('App\LeccionFormulario', 'Lec_IdLeccion');
  }



  // public function scopeActivos () {

  // }
}
