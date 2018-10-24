<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class OIndicadores extends Eloquent
{
  protected $table = 'ora_indicadores';
  protected $primaryKey = 'OInd_IdIndicadores';
  public $timestamps = false;

  public function scopeActivos ($query) {
  	return $query->where('OInd_Estado', 1);
  }
  public function scopeVisibles ($query) {
  	return $query->where('Row_Estado', 1);
  }


  public function formatToArray ($include = [], $exclude = [], $with = []) {
    return [
      'id' => $this->OInd_IdIndicadores,
      'titulo' => $this->OInd_Titulo,
      'icono' => $this->OInd_IconoPath,
      'descripcion' => $this->OInd_Descripcion,
      'estado_item' => $this->OInd_Estado,
      'estado_row' => $this->Row_Estado,
      'idioma_id' => $this->Idi_IdIdioma,
      // 'latitude' => $this->ODii_PosLatitude,
      // 'longitude' => $this->ODii_PosLongitude
    ];
  }


}
