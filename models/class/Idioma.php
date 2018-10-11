<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Idioma extends Eloquent
{
  protected $table = 'idioma';
  protected $primaryKey = 'Idi_IdIdioma';
  protected $keyType = 'string';
  public $timestamps = false;


  public static function activos () {
  	return self::where('Idi_Estado', 1)->get();
  }
  // public function scopeActivos () {

  // }
}
