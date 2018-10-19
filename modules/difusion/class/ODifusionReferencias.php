<?php

namespace App;

use Illuminate\Database\Eloquent\Model as Eloquent;
use Illuminate\Database\Capsule\Manager as DB;

class ODifusionReferencias extends Eloquent
{
  protected $table = 'ora_difusion_referencias';
  protected $primaryKey = 'ODir_IdRefDif';
  public $timestamps = false;

}
