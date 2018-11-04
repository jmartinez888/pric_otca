<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusionBanners extends Eloquent
{
  protected $table = 'ora_difusion_banner';
  protected $primaryKey = 'ODib_IdDifBanner';

  const CREATED_AT = 'ODib_CreatedAt';
  const UPDATED_AT = 'ODib_UpdatedAt';

  public function difusion () {
    return $this->belongsTo('App\ODifusion', 'ODif_IdDifusion');
  }

  public function scopeOrderParaGestor ($query) {
  	return $query->orderBy('ODib_Estado', 'desc');
  }

  public function scopeActivos ($query) {
    return $query->where('ODib_Estado', 1);
  }
  public function scopeVisibles ($query) {
    return $query->where('Row_Estado', 1);
  }
  protected $formated = [
      'id' => 'ODib_IdDifBanner',
      'difusion_id' => 'ODif_IdDifusion',
      'titulo' => 'ODib_Titulo',
      'descripcion' => 'ODib_Descripcion',
      'idioma_id' => 'Idi_IdIdioma',
      'estado_item' => 'ODib_Estado',
      'estado_row' => 'Row_Estado',
      'created_at' => 'ODib_CreatedAt',
      'updated_at' => 'ODib_updatedAt',
      'banner' => 'ODib_Banner'
  ];

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
    return $res;
  }

}
