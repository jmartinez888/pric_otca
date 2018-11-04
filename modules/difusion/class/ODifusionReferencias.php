<?php

namespace App;

use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model as Eloquent;

class ODifusionReferencias extends Eloquent
{
  protected $table = 'ora_difusion_referencias';
  protected $primaryKey = 'ODir_IdRefDif';
  public $timestamps = false;



  protected static function boot() {
      parent::boot();
      static::addGlobalScope('translate', function (Builder $builder) {
        $builder->select(
          '*',
          DB::raw("fn_TraducirContenido('ora_difusion_referencias','ODir_Titulo',ora_difusion_referencias.ODir_IdRefDif,'".\Cookie::lenguaje()."',ora_difusion_referencias.ODir_Titulo)  ODir_Titulo")
        );

      });
  }

}
