<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Capsule\Manager as DB;

class Idioma extends Eloquent
{
  use \verificarIdioma;
  protected $table = 'idioma';
  protected $primaryKey = 'Idi_IdIdioma';
  protected $keyType = 'string';
  public $timestamps = false;

  private static $USE_FORCE_LANG = false;
  private static $FORCE_LANG = '';

  public const CODE_ES = 101115;
  public const CODE_PT = 112116;
  public const CODE_EN = 101110;

  public static function activos () {
  	return self::where('Idi_Estado', 1)->get();
  }


  public static function getAllLenguajes () {
  	$files = IdiomaFiles::all();
  	return $files;
  	// $build = self::where('Idi_Estado', 1);


  }

   
  protected static function boot() {
    parent::boot();
    // exit;
    static::addGlobalScope('translate', function (Builder $builder) {
      $builder->select(
        '*',
        DB::raw("fn_TraducirContenido('idioma','Idi_Idioma',idioma.Idi_CharCode,'".self::getCurrentLang()."',idioma.Idi_Idioma)  Idi_Idioma")
        // DB::raw("fn_TraducirContenido('ora_indicadores','OInd_Descripcion',ora_indicadores.OInd_IdIndicadores,'".\Cookie::lenguaje()."',ora_indicadores.OInd_Descripcion)  OInd_Descripcion")

      );

    });
    // return self;
}

}
