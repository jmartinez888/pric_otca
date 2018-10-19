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

}
