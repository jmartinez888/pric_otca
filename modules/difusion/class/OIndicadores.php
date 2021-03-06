<?php

namespace App;

use Illuminate\Database\Capsule\Manager as DB;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model as Eloquent;

class OIndicadores extends Eloquent
{
  use \verificarIdioma;
  protected $table = 'ora_indicadores';
  protected $primaryKey = 'OInd_IdIndicadores';
  public $timestamps = false;

  private static $USE_FORCE_LANG = false;
  private static $FORCE_LANG = '';
  public function scopeActivos ($query) {
  	return $query->where('OInd_Estado', 1);
  }
  public function scopeVisibles ($query) {
  	return $query->where('Row_Estado', 1);
  }
  
  protected $formated = [
    'id' => 'OInd_IdIndicadores',
    'titulo' => 'OInd_Titulo',
    'icono' => 'OInd_IconoPath',
    'descripcion' => 'OInd_Descripcion',
    'estado_item' => 'OInd_Estado',
    'estado_row' => 'Row_Estado',
    'idioma_id' => 'Idi_IdIdioma'
  ];

  public function scopeOrderParaGestor ($query) {
    return $query->orderBy('OInd_Estado', 'desc');
  }
  public function formatToArray ($include = [], $exclude = [], $with = []) {
    // dd($include);
    $res = [];
    if (count($include) > 0) {
      foreach ($include as $key => $value) {
        if (array_key_exists($value, $this->formated)){
          $name = $this->formated[$value];
          $res[$value] = $this->$name;
        }
      }
    } else {
      foreach ($this->formated as $key => $value) {
        if (!in_array($key, $exclude)){
          $res[$key] = $this->$value;
        }
      }
    }
    foreach ($with as $key => $value) {
        $www = null;
        if (is_array($value)) {
          $temp = $this->$value[0];
          if ($temp) {
            $incl = isset($value[1]) && is_array($value[1]) ? $value[1] : [];
            $excl = isset($value[2]) && is_array($value[2]) ? $value[2] : [];
            $with = isset($value[3]) && is_array($value[3]) ? $value[2] : [];
            $www = $temp->formatToArray($incl, $excl, $with);
          }
        } else {
          $temp = $this->$value;
          $www = $temp->formatToArray($value);
        }
        $res[$value] = $www;
      }
    return $res;
  }

  protected static function boot() {
      parent::boot();
      dump(\Cookie::get('langsiigef'));
      static::addGlobalScope('translate', function (Builder $builder) {
        
        $builder->select(
          '*',
          DB::raw("fn_TraducirContenido('ora_indicadores','OInd_Titulo',ora_indicadores.OInd_IdIndicadores,'".self::getCurrentLang()."',ora_indicadores.OInd_Titulo)  OInd_Titulo"),
          DB::raw("fn_TraducirContenido('ora_indicadores','OInd_Descripcion',ora_indicadores.OInd_IdIndicadores,'".self::getCurrentLang()."',ora_indicadores.OInd_Descripcion)  OInd_Descripcion")

        );

      });
  }


}
