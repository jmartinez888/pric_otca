<?php

namespace App;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class Alternativa extends Eloquent {
  use \verificarIdioma;
  
  protected $table = 'alternativa';
  protected $primaryKey = 'Alt_IdAlternativa';
  public $timestamps = false;
  
  private static $USE_FORCE_LANG = false;
  private static $FORCE_LANG = '';

    
  protected static function boot() {
    parent::boot();
    static::addGlobalScope('translate', function (Builder $builder) {
      $builder->select(
        '*',
        DB::raw("fn_TraducirContenido('alternativa','Alt_Etiqueta',alternativa.Alt_IdAlternativa,'".self::getCurrentLang()."',alternativa.Alt_Etiqueta)  Alt_Etiqueta")
        // DB::raw("fn_devolverIdioma('pregunta',pregunta.Pre_IdPregunta,pregunta.Idi_IdIdioma, '".self::getCurrentLang()."') Idi_IdIdiomas")
      );
    });
  }

}