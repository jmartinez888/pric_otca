<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusionLinkInteres extends Eloquent
{
  protected $table = 'ora_difusion_link_interes';
  protected $primaryKey = 'ODli_IdDifLini';

  const CREATED_AT = 'ODli_CreatdAt';
  const UPDATED_AT = 'ODli_UpdatedAt';

  public function formatToArray () {
  	return [
  		'id' => $this->ODli_IdDifLini,
  		'titulo' => $this->ODli_Titulo,
  		'descripcion' => $this->ODli_Descripcion,
  		'url' => $this->ODli_Url,
  		'estado_item' => $this->ODli_Estado,
  		'idioma_id' => $this->Idi_IdIdioma,
  		'estado_row' => $this->Row_Estado
  	];
  }

  public function scopeActivos ($query) {
  	return $query->where('ODli_Estado', 1);
  }

}
