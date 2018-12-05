<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class ForoComentarios extends Eloquent
{
  protected $table = 'like_foro_comentario';
  protected $primaryKey =  ['Usu_IdUsuario', 'Lfc_IdObjeto','Lfc_Objeto'];
  public $timestamps = false;
  public $incrementing = false;

  // public static function activos () {
  // 	return self::where('Idi_Estado', 1)->get();
  // }
  // public function scopeActivos () {

  // }
}
