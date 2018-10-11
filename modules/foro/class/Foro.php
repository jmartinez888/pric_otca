<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class Foro extends Eloquent
{
  protected $table = 'foro';
  protected $primaryKey = 'For_IdForo';
  public $timestamps = false;

  public function scopegetByTematica ($query, $tematica_id) {
  	return $query->where('Lit_IdLineaTematica', $tematica_id);
  }

  public function comentarios () {
  	return $this->hasMany('App\ForoComentarios', 'For_IdForo');
  }

  public function autor () {
  	return $this->belongsTo('App\Usuario', 'Usu_IdUsuario');
  }

  public function miembros () {
  	return $this->hasMany('App\UsuarioForo', 'For_IdForo');
  }

  public static function funciones () {
  	return self::select(DB::raw('DISTINCT(For_Funcion) as funcion'))->get();
  }
  // public static function activos () {
  // 	return self::where('Idi_Estado', 1)->get();
  // }
  // public function scopeActivos () {

  // }
}
