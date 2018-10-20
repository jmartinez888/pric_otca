<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusionTipo extends Eloquent
{
  protected $table = 'ora_difusion_tipo';
  protected $primaryKey = 'ODit_IdTipoDifusion';
  public $timestamps = false;

  public function scopeActivos ($query) {
  	return $query->where('ODit_Estado', 1);
  }
  public function scopeVisibles ($query) {
  	return $query->where('Row_Estado', 1);
  }

  public function formatToArray () {
  	return [
  		'id' => $this->ODit_IdTipoDifusion,
  		'titulo' => $this->ODit_Tipo,
  		'descripcion' => $this->ODit_Descripcion,
  		'estado_item' => $this->ODit_Estado,
  		'idioma_id' => $this->Idi_IdIdioma,
  		'estado_row' => $this->Row_Estado
  	];
  }

}
