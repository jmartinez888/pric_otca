<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Leccion extends Eloquent
{
  protected $table = 'leccion';
  protected $primaryKey = 'Lec_IdLeccion';
  public $timestamps = false;



  // public function scopeActivos () {

  // }
}
