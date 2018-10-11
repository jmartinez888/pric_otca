<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class ForoComentarios extends Eloquent
{
  protected $table = 'comentarios';
  protected $primaryKey = 'Com_IdComentario';
  public $timestamps = false;

  // public static function activos () {
  // 	return self::where('Idi_Estado', 1)->get();
  // }
  // public function scopeActivos () {

  // }
}
