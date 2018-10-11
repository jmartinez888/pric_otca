<?php

namespace App;

use App\Cookie;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model as Eloquent;


class ForoTematica extends Eloquent
{
  protected $table = 'linea_tematica';
  protected $primaryKey = 'Lit_IdLineaTematica';
  public $timestamps = false;

  public function foros () {
      return $this->hasMany('App\Foro', 'Lit_IdLineaTematica');
  }
  public function scopeVisibles ($query) {
    return $query->where('Row_Estado', 1);
  }
  public static function scopeActivos ($query) {
  	return $query->where('Lit_Estado', 1);
  }
 	protected static function boot() {
      parent::boot();

      static::addGlobalScope('translate', function (Builder $builder) {
      	$builder->select(
      		'*',
          DB::raw("fn_TraducirContenido('linea_tematica','Lit_Nombre',linea_tematica.Lit_IdLineaTematica,'".\Cookie::lenguaje()."',linea_tematica.Lit_Nombre) Lit_Nombre")
      		// DB::raw("fn_TraducirContenido('linea_tematica','Lit_Nombre',linea_tematica.Lit_IdLineaTematica,'".$_COOKIE['langsiigef']."',linea_tematica.Lit_Nombre) Lit_Nombre")
      	);

      });
  }
}
