<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusionIndicadores extends Eloquent
{
  protected $table = 'ora_difusion_indicadores';
  protected $primaryKey = 'ODii_IdDifIndi';
  public $timestamps = false;

  public function difusion () {
  	return $this->belongsTo('App\ODifusion', 'ODif_IdDifusion');
  }

  public function indicador () {
  	return $this->belongsTo('App\OIndicadores', 'OInd_IdIndicadores');
  }

  public function formatToArray ($exclude = []) {
  	return [
			'id' => $this->ODii_IdDifIndi,
			'difusion_id' => $this->ODif_IdDifusion,
			'indicador_id' => $this->ODii_IdDifIndi,
			'descripcion' => $this->ODii_Descripcion,
			'estado_item' => $this->ODii_Estado,
			'estado_row' => $this->Row_Estado,
			'idioma_id' => $this->Idi_IdIdioma,
			'latitude' => $this->ODii_PosLatitude,
			'longitude' => $this->ODii_PosLongitude
		];
  }
}
