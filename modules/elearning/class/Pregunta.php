<?php

namespace App;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Model as Eloquent;

class Pregunta extends Eloquent {
  use \verificarIdioma;
  
  protected $table = 'pregunta';
  protected $primaryKey = 'Pre_IdPregunta';
  public $timestamps = false;
  
  private static $USE_FORCE_LANG = false;
  private static $FORCE_LANG = '';

  public function alternativas () {
  	return $this->hasMany('App\Alternativa', 'Pre_IdPregunta');
  } 
  /**
   * [getIdsAlternativas retorna solos los id de las alternativas [1,2,3,4...] ]
   *
   * @return  [type]  [return array[int]]
   */
  public function getIdsAlternativas () {
    return $this->alternativas()->select('Alt_IdAlternativa')->get()->map(function($item){
      return $item->Alt_IdAlternativa;
    });
  }

  protected static function boot() {
    parent::boot();
    static::addGlobalScope('translate', function (Builder $builder) {
      $builder->select(
        '*',
        DB::raw("fn_TraducirContenido('pregunta','Pre_Descripcion',pregunta.Pre_IdPregunta,'".self::getCurrentLang()."',pregunta.Pre_Descripcion)  Pre_Descripcion"),
        DB::raw("fn_TraducirContenido('pregunta','Pre_Descripcion2',pregunta.Pre_IdPregunta,'".self::getCurrentLang()."',pregunta.Pre_Descripcion2)  Pre_Descripcion2")
        // DB::raw("fn_devolverIdioma('pregunta',pregunta.Pre_IdPregunta,pregunta.Idi_IdIdioma, '".self::getCurrentLang()."') Idi_IdIdiomas")
      );
    });
  }

}