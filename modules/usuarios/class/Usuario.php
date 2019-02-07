<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Usuario extends Eloquent
{
  protected $table = 'usuario';
  protected $primaryKey = 'Usu_IdUsuario';
  public $timestamps = false;

  public const IMAGE_DEFAULT = 'default.png';

  // public static function activos () {
  // 	return self::where('Idi_Estado', 1)->get();
  // }
  // public function scopeActivos () {

  // }

  public function scopebuscar ($query, $target) {
    return $query->where('Usu_Nombre', 'like', "%$target%")
            ->orWhere('Usu_Apellidos', 'like', "%$target%")
            ->orWhere('Usu_Usuario', 'like', "%$target%");
  }

  public function scopepara_mencion ($query) {
    return $query->select(['Usu_IdUsuario', 'Usu_Nombre', 'Usu_Apellidos']);
  }
}
