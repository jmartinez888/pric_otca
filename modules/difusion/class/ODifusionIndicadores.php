<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusionIndicadores extends Eloquent
{
  protected $table = 'ora_difusion_indicadores';
  protected $primaryKey = 'ODii_IdDifIndi';
  public $timestamps = false;

  protected $formated = [
      'id' => 'ODii_IdDifIndi',
      'difusion_id' => 'ODif_IdDifusion',
      'indicador_id' => 'OInd_IdIndicadores',
      'descripcion' => 'ODii_Descripcion',
      'estado_item' => 'ODii_Estado',
      'estado_row' => 'Row_Estado',
      'idioma_id' => 'Idi_IdIdioma',
      'latitude' => 'ODii_PosLatitude',
      'longitude' => 'ODii_PosLongitude'
  ];
  public function difusion () {
  	return $this->belongsTo('App\ODifusion', 'ODif_IdDifusion');
  }

  public function indicador () {
  	return $this->belongsTo('App\OIndicadores', 'OInd_IdIndicadores');
  }
  public function scopeActivos ($query) {
    return $query->where('ODii_Estado', 1);
  }
  public function scopeVisibles ($query) {
    return $query->where('Row_Estado', 1);
  }
  public function formatToArray ($include = [], $exclude = [], $with = []) {
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

    // $res = [
    //   'id' => $this->ODii_IdDifIndi,
    //   'difusion_id' => $this->ODif_IdDifusion,
    //   'indicador_id' => $this->ODii_IdDifIndi,
    //   'descripcion' => $this->ODii_Descripcion,
    //   'estado_item' => $this->ODii_Estado,
    //   'estado_row' => $this->Row_Estado,
    //   'idioma_id' => $this->Idi_IdIdioma,
    //   'latitude' => $this->ODii_PosLatitude,
    //   'longitude' => $this->ODii_PosLongitude
    // ];


    return $res;
  }

  protected static function boot() {
      parent::boot();

      static::addGlobalScope('translate', function (Builder $builder) {
        $builder->select(
          '*',
          DB::raw("fn_TraducirContenido('ora_difusion_indicadores','ODii_Descripcion',ora_difusion_indicadores.ODii_IdDifIndi,'".\Cookie::lenguaje()."',ora_difusion_indicadores.ODii_Descripcion)  ODii_Descripcion")
        );

      });
  }
}
