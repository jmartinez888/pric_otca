<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class OIndicadores extends Eloquent
{
  protected $table = 'ora_indicadores';
  protected $primaryKey = 'OInd_IdIndicadores';
  public $timestamps = false;

}
